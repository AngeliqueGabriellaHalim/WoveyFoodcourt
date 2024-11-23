import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Scanner;

public class KodeDBJava {
    public static void main(String[] args) throws Exception {

        String dbURL = "jdbc:sqlserver://DESKTOP-HQMLOCE\\SQLEXPRESS:1433;Database=TugasBesar;encrypt=true; trustServerCertificate=true; integratedSecurity=true";
        String tanggal = new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime());
        Connection con = DriverManager.getConnection(dbURL);
        Statement st = con.createStatement();
        ResultSet res;
        Scanner sc = new Scanner(System.in);

        while (true){//agar selalu kembali ke halaman login
            System.out.println("┌────────────────┐\n│     Log in     │\n└────────────────┘");
            System.out.print("No HP: ");
            String noHp = sc.next();
            
            String loginAs = cekAdminAtauUMK(noHp, st);
            
            res = login(noHp, loginAs, st);
    
            if(!res.isBeforeFirst()){//jika tidak ada di tabel maka belum terdaftar dan pasti UMK karena admin tidak dapat daftar
                System.out.println("\n[No HP tidak terdaftar, melanjutkan ke pendaftaran]\n");
                System.out.println("┌─────────────────────┐\n│     Pendaftaran     │\n└─────────────────────┘");
    
                System.out.print("Nama UMK: ");
                sc.nextLine();
                String namaUMK = sc.nextLine();
                System.out.print("Deskripsi: ");
                String deskripsiUsaha = sc.nextLine();
                System.out.print("Logo: ");
                String logo = sc.nextLine();
                System.out.print("Alamat: ");
                String alamat = sc.nextLine();
                System.out.print("Nama Pemilik: ");
                String namaPemilik = sc.nextLine();
                printKota();
                System.out.print("ID Kota: ");
                int idKota = sc.nextInt();
    
                daftarUMK(noHp, namaUMK, deskripsiUsaha, logo, alamat, namaPemilik, idKota, tanggal, st);
                daftar(tanggal, st);
            }
    
            else{//jika ada di tabel
                boolean lanjutkan = true;
                while (lanjutkan){//loop untuk tetap berada di menu

                    if(loginAs.equals("UMK")){//jika umk
                        int status = cekStatus(noHp, st);
    
                        if (status == 0){
                            System.out.println("\n[Tunggu verifikasi admin]\n");
                            lanjutkan = false;
                        }
                        else if (status == -1){
                            System.out.println("\n[Pendaftaran ditolak admin]\n");

                            //tambahan

                            lanjutkan = false;
                        }
                        else{
                            System.out.println("┌──────────────┐\n│     Menu     │\n└──────────────┘\n- Tambahkan produk (1)\n- Tambahkan transaksi (2)\n- Lihat laporan keuangan (3)\n- Lihat laporan penjualan produk (4)\n- Log out (5)");
                            int aksi = sc.nextInt();
                            
                            if(aksi == 1){
                                System.out.print("Nama: ");
                                sc.nextLine();
                                String nama = sc.nextLine();
                                
                                System.out.print("Deskripsi: ");
                                String deskripsi = sc.nextLine();
                                
                                System.out.print("Foto: ");
                                String foto = sc.nextLine();
                                
                                System.out.print("Satuan: ");
                                String satuan = sc.nextLine();
                                
                                System.out.print("Harga: ");
                                int harga = sc.nextInt();
                                
                                insertProduk(noHp, nama, deskripsi, foto, satuan, harga, st);
                            }
                            else if (aksi == 2){
                                System.out.println("┌───────────────────┐\n│     Transaksi     │\n└───────────────────┘\n- Setor modal (1)\n- Penjualan produk (2)\n- Pengeluaran operasional (3)\n- Penarikan modal (4)\n- Back (5)");
    
                                int jenisTransaksi = sc.nextInt();
                                if (jenisTransaksi == 5)
                                    continue;
                                int idTransaksi = insertTransaksiAndGetId(jenisTransaksi, noHp, st);
                                int nominal = 0;
        
                                if(jenisTransaksi == 2){
                                    String lanjut = "";
                                    sc.nextLine();
    
                                    while(!lanjut.equalsIgnoreCase("x")){
                                        System.out.print("Nama produk: ");
                                        String namaProd = sc.nextLine();
                                        if(checkProdukAvailable(noHp, namaProd, idTransaksi, st) != 1)
                                            continue;
                                        System.out.print("Kuantitas: ");
                                        int quant = sc.nextInt();
                                        
                                        nominal += insertIntoNotaGetNominal(noHp, namaProd, quant, idTransaksi, st);
        
                                        System.out.println("[Enter untuk lanjut, x untuk berhenti]");
                                        sc.nextLine();
                                        lanjut = sc.nextLine();
                                    }
                                    updateTransaksi(nominal, tanggal, idTransaksi, st);
                                    updateSaldo(jenisTransaksi, nominal, noHp, st);
                                }

                                else if (jenisTransaksi == 3 || jenisTransaksi == 4){
                                    System.out.println("\n[Saldo sekarang: " + getSaldo(noHp, st)+"]");
                                    System.out.println("[Transaksi tidak boleh melebihi saldo]\n");
                                    System.out.print("Nominal: ");
                                    nominal = sc.nextInt();
                                    sc.nextLine();
                                    updateTransaksi(nominal, tanggal, idTransaksi, st);
                                    updateSaldo(jenisTransaksi, nominal, noHp, st);
                                    System.out.println("[Saldo sekarang: " + getSaldo(noHp, st)+"]\n");

                                }
                                else if(jenisTransaksi == 1){
                                    System.out.println("\n[Saldo sekarang: " + getSaldo(noHp, st)+"]");
                                    System.out.print("Nominal: ");
                                    nominal = sc.nextInt();
                                    sc.nextLine();
                                    updateTransaksi(nominal, tanggal, idTransaksi, st);
                                    updateSaldo(jenisTransaksi, nominal, noHp, st);
                                    System.out.println("[Saldo sekarang: " + getSaldo(noHp, st)+"]\n");
                                }
                                
                            }
                            else if (aksi == 3){
                                System.out.print("Tanggal awal [yyyymmdd]: ");
                                String tanggalAwal = sc.next();
                                System.out.print("Tanggal akhir [yyyymmdd]: ");
                                String tanggalAkhir = sc.next();
                            

                                lihatLaporanTransaksi(noHp, tanggalAwal, tanggalAkhir, st);
                            }
                            else if (aksi == 4){
                                System.out.print("Tanggal awal [yyyymmdd]: ");
                                String tanggalAwal = sc.next();
                                System.out.print("Tanggal akhir [yyyymmdd]: ");
                                String tanggalAkhir = sc.next();
                                lihatLaporanProduk(noHp, tanggalAwal, tanggalAkhir, st);
                            }
                            else
                                lanjutkan = false;
                        }
                    }
                    
                    else{ //jika admin
                        System.out.println("┌──────────────────────────┐\n│    Menu Administrator    │\n└──────────────────────────┘\n- Melihat UMK yang sudah terdaftar (1)\n- Verifikasi pendaftaran (2)\n- Melihat daftar produk yang paling laku (3)\n- Melihat UMK yang paling banyak melakukan transaksi (4)\n- Log out (5)");
                        int aksi = sc.nextInt();
    
                        if (aksi == 1)
                            lihatUMKTerdaftar(st);
                        else if (aksi == 2){
        
                            int idPendaftaran = lihatUMKBelumTerdaftar(st);

                            if (idPendaftaran != 0) {
                                int pilihan = sc.nextInt();
                                
                                if (pilihan == 2 || pilihan == 1){
                                    verifUMK(pilihan, idPendaftaran, noHp, st);
                                }
                            }
                        }
                        else if (aksi == 3){
                            System.out.print("Banyak produk: ");
                            int n = sc.nextInt();
                            lihatNProduLaku(n, st);
                        }
                        else if (aksi == 4){
                            System.out.print("Banyak UMK: ");
                            int n = sc.nextInt();
                            lihatNUMK(n, st);
                        }
                        else
                            lanjutkan = false;
                    }
                }
            }
        }
    }


    public static String cekAdminAtauUMK (String noHp, Statement st) throws SQLException{
        String queryCekDaftar = "select NoHP from Administrator where NoHP = '" + noHp +"'";
        ResultSet res = st.executeQuery(queryCekDaftar);

        String login = "UMK";
        if(res.isBeforeFirst())
            login = "Administrator";

        return login;
    }

    public static ResultSet login (String noHp, String login, Statement st) throws SQLException{
        String queryLogin = "select NoHP from " + login + " where NoHP = '" + noHp +"'";
        ResultSet res = st.executeQuery(queryLogin);
        return res;
    }

    public static void daftarUMK (String noHp, String namaUMK, String deskripsiUsaha, String logo,  String alamat, String namaPemilik, int idKota, String tanggal, Statement st) throws SQLException{
        String queryUMK = "INSERT INTO UMK (NoHP, NamaUMK, Deskripsi, Logo, Alamat, NamaPemilik, IdKota, Status, Tanggal, Saldo) VALUES ('" + noHp + "','" + namaUMK + "','" + deskripsiUsaha + "','" + logo  + "','"  + alamat  + "','" + namaPemilik + "'," + idKota +", 'Belum diverifikasi','" + tanggal +"', 0);";
        st.execute(queryUMK);
    }

    public static void daftar (String tanggal, Statement st) throws SQLException{
        String queryPendaftaran = "INSERT INTO Pendaftaran (Tanggal, Status)VALUES ('" + tanggal + "','Belum diverifikasi');";
        st.execute(queryPendaftaran);
        System.out.println("\n[Pendaftaran berhasil]\n");  
    }

    public static int cekStatus (String noHp, Statement st) throws SQLException{
        String queryStatus = "SELECT Status from UMK where NoHp = '"+ noHp +"'";
        ResultSet res = st.executeQuery(queryStatus);
        String status = "";

        while (res.next())
            status = res.getString("Status");
        if(status.equalsIgnoreCase("Belum diverifikasi")){
            return 0;
        }
        else if(status.equalsIgnoreCase("Ditolak")){
            return -1;
        }
        else
            return 1;
    }

    public static void insertProduk (String noHp, String nama, String deskripsi, String foto, String satuan, int harga, Statement st) throws SQLException {
        String queryProduk = "INSERT INTO Produk (Nama, Deskripsi, Foto, Satuan, Harga) VALUES ('" +nama+"', '"+deskripsi+"', '"+foto+"', '"+satuan+"', "+harga+");";
        st.execute(queryProduk);

        String queryProdukUMK = "INSERT INTO ProdukUMK (NoHpUMK) VALUES ('" + noHp + "');";
        st.execute(queryProdukUMK);

        System.out.println("\n[Produk berhasil ditambahkan]\n");
    }

    public static int insertTransaksiAndGetId (int jenisTransaksi, String noHp, Statement st) throws SQLException{
        String queryTrans = "INSERT INTO Transaksi (IdJenis, NoHpUMK) VALUES (" +jenisTransaksi +",'" + noHp +"');";
        st.execute(queryTrans);
        
        String queryGetTrans = "SELECT TOP 1 IdTransaksi from Transaksi order by IdTransaksi desc";
        ResultSet res = st.executeQuery(queryGetTrans);
        int idTransaksi = 0;
        while (res.next())
            idTransaksi = res.getInt("IdTransaksi");
        
        return idTransaksi;
    }

    public static int checkProdukAvailable (String noHp, String namaProduk, int idTransaksi, Statement st) throws SQLException{
        String queryIdProduk = "SELECT IdProduk from Produk where Nama = '" + namaProduk + "'";
        ResultSet res = st.executeQuery(queryIdProduk);
        if (!res.isBeforeFirst()){
            System.out.println("\n[Produk tidak ditemukan]\n");
            return -1;
        }
        int idProduk = 0;
        while (res.next())
            idProduk = res.getInt("IdProduk");

        String noHpUMK2 = "";
        String cekProdukUMK = "select NoHpUMK from ProdukUMK where IdProduk = " + idProduk;
        ResultSet noHpUMK = st.executeQuery(cekProdukUMK);
        while(noHpUMK.next())
            noHpUMK2 = noHpUMK.getString("NoHpUMK");

        if(!noHp.equals(noHpUMK2)){
            System.out.println("\n[Produk bukan milik UMK ini]\n");
            return 0;
        }
        return 1;
    }

    public static int insertIntoNotaGetNominal (String noHp, String namaProduk, int quant,int idTransaksi, Statement st) throws SQLException{

        int nominal = 0;
        String queryIdProduk = "SELECT IdProduk from Produk where Nama = '" + namaProduk + "'";
        ResultSet res = st.executeQuery(queryIdProduk);
        if (!res.isBeforeFirst()){
            return 0;
        }
        int idProduk = 0;
        while (res.next())
            idProduk = res.getInt("IdProduk");

        String noHpUMK2 = "";
        String cekProdukUMK = "select NoHpUMK from ProdukUMK where IdProduk = " + idProduk;
        ResultSet noHpUMK = st.executeQuery(cekProdukUMK);
        while(noHpUMK.next())
            noHpUMK2 = noHpUMK.getString("NoHpUMK");

        if(!noHp.equals(noHpUMK2)){
            return 0;
        }

        String queryHarga = "SELECT Harga from Produk where IdProduk = " + idProduk;
        res = st.executeQuery(queryHarga);

        while (res.next())
            nominal += res.getInt("Harga")*quant; 

        String queryNota = "INSERT INTO Nota values (" + idTransaksi + "," + idProduk + "," + quant+ ");";
        st.execute(queryNota);

        return nominal;
        
    }

    public static void updateTransaksi (int nominal, String tanggal, int idTransaksi, Statement st) throws SQLException{

        String queryUpdateTrans = "UPDATE Transaksi SET Nominal = " + nominal +", Tanggal = '" + tanggal +"' where IdTransaksi = "+idTransaksi;
        st.execute(queryUpdateTrans);
        System.out.println("\n[Transaksi berhasil ditambahkan]");
    }


    public static void updateSaldo (int jenisTransaksi, int nominal, String noHp, Statement st) throws SQLException{
        int nominalSaldo = 0;
        if (jenisTransaksi == 3 || jenisTransaksi == 4){
            nominal = nominal*-1;
        }
        String getSaldo = "select Saldo from UMK where NoHp = '" + noHp + "'";
        ResultSet saldoAwal = st.executeQuery(getSaldo);
        while(saldoAwal.next())
            nominalSaldo = saldoAwal.getInt("Saldo");
        nominalSaldo =  nominalSaldo + nominal;
        String updateSaldo = "update UMK set Saldo = "+nominalSaldo+" where NoHp = '" +noHp + "'";
        st.execute(updateSaldo);
    }

    public static int getSaldo (String noHp, Statement st) throws SQLException{
        int saldo = 0;
        String query = "select Saldo from UMK where NoHp = '" + noHp+"'";
        ResultSet res = st.executeQuery(query);
        while (res.next()) {
            saldo = res.getInt("Saldo");
        }
        return saldo;
    }

    public static void lihatLaporanTransaksi (String noHp, String tanggalAwal, String tanggalAkhir, Statement st) throws SQLException{
        String saldoSekarang = "select Saldo from UMK where NoHp = '"+noHp+"'";
        ResultSet res = st.executeQuery(saldoSekarang);
        int nominalSaldo = 0;
        while (res.next()){
            nominalSaldo = res.getInt("Saldo");
        }

        String transaksiTanggal = "SELECT Transaksi.IdJenis, Jenis, Nominal, Tanggal FROM Transaksi join JenisTransaksi on Transaksi.IdJenis = JenisTransaksi.IdJenis WHERE NoHpUMK = '"+noHp+"' AND Tanggal >= '"+tanggalAwal+"' AND Tanggal <= '"+tanggalAkhir+"'";
        res = st.executeQuery(transaksiTanggal);

        System.out.println("\n┌──────────────────────────────────────────────────────────────┐");
        System.out.printf("│ Saldo sekarang: %-45d│\n", nominalSaldo);
        System.out.println("├──────────────────────────────────────────────────────────────┤");
        System.out.println("│     Jenis Transaksi               Nominal         Tanggal    │");

        //\n│ Saldo: Rp. %-40d│
        int min = 1;
        int nominalAkhir = 0;
        int idx = 1;
        while(res.next()){
            int idJenis = res.getInt("IdJenis");
            String jenis = res.getString("Jenis");
            int nominal = res.getInt("Nominal");
            String tanggal = res.getString("Tanggal");

            if(idJenis == 3 || idJenis == 4)
                min = -1;
            else
                min = 1;

            nominalAkhir += nominal*min;

            System.out.printf("│ %2d. %-23s %13d %18s │\n", idx, jenis, nominal, tanggal);
            idx++;
        }
        char plusMin = '+';
        if(nominalAkhir < 0){
            nominalAkhir = nominalAkhir*-1;
            plusMin = '-';
        }

        System.out.println("├──────────────────────────────────────────────────────────────┤");
        System.out.printf("│ Summary: %c%-51d│\n", plusMin, nominalAkhir, nominalSaldo);
        System.out.println("└──────────────────────────────────────────────────────────────┘\n");
    }

    public static void lihatLaporanProduk (String noHp, String tanggalAwal, String tanggalAkhir, Statement st) throws SQLException {

        String listProdukUMK2 = "SELECT DataProduk.IdProduk, DataProduk.Nama, DataProduk.[Akumulasi Jumlah],Produk.Harga, Produk.Harga*DataProduk.[Akumulasi Jumlah] as 'Total', DataProduk.Tanggal FROM (SELECT Produk.IdProduk, Produk.Nama, SUM(Nota.Kuantitas) as 'Akumulasi Jumlah', dataTransaksi.Tanggal from (SELECT * FROM Transaksi WHERE NoHpUMK='"+noHp+"' AND IdJenis=2) as dataTransaksi INNER JOIN Nota ON Nota.IdTransaksi=dataTransaksi.IdTransaksi INNER JOIN Produk ON Produk.IdProduk=Nota.IdProduk WHERE Tanggal >= '"+tanggalAwal+"' AND Tanggal <= '"+tanggalAkhir+"' GROUP BY Produk.IdProduk, dataTransaksi.Tanggal, Produk.Nama) as DataProduk INNER JOIN Produk ON Produk.IdProduk=DataProduk.IdProduk";
        ResultSet res2 = st.executeQuery(listProdukUMK2);

        String listProdukUMK = "SELECT dataTransaksi.IdTransaksi, Produk.IdProduk,Produk.Nama, Nota.Kuantitas, Produk.Harga as 'Harga Satuan', Produk.Harga*Nota.Kuantitas as 'Total', dataTransaksi.Tanggal from (SELECT * FROM Transaksi WHERE NoHpUMK= '"+noHp+"' AND IdJenis=2) as dataTransaksi INNER JOIN Nota  ON Nota.IdTransaksi=dataTransaksi.IdTransaksi INNER JOIN Produk ON Produk.IdProduk=Nota.IdProduk WHERE Tanggal >= '"+tanggalAwal+"' AND Tanggal <= '"+tanggalAkhir+"'";
        //ResultSet res = st.executeQuery(listProdukUMK);

        System.out.println("\n┌────────────────────────────────────────────────────────────────────────────────────────┐");
        System.out.printf("│ Laporan Produk%-72s │\n", "");
        System.out.println("├────────────────────────────────────────────────────────────────────────────────────────┤");
        System.out.printf("│     Nama produk         Terjual       Harga Satuan         Total            Tanggal    │\n", "");


        int idx = 1;
        while(res2.next()){
            String nama = res2.getString("Nama");
            int kuant = res2.getInt("Akumulasi Jumlah");
            int hargaSatuan = res2.getInt("Harga");
            int total = res2.getInt("Total");
            String tanggal = res2.getString("Tanggal");

            System.out.printf("│ %2d. %-15s %11d %18d %13d %10s %s │\n", idx, nama, kuant, hargaSatuan, total, "", tanggal);
            idx++;
        }

        System.out.println("└────────────────────────────────────────────────────────────────────────────────────────┘\n");


    }


    //fitur admin

    public static void lihatUMKTerdaftar (Statement st) throws SQLException{
        String noHp;
        String namaUMK;
        String desk;
        String logo;
        String alamat;
        String namaPemilik;
        int idkota;
        int idPendaftaran = 0;
        String status;
        String tanggal;

        String queryUMKValid = "SELECT * FROM UMK WHERE Status = 'Valid'";
        ResultSet res = st.executeQuery(queryUMKValid);

        if(!res.isBeforeFirst())
            System.out.println("\n[List kosong]");
        
        System.out.println("\n┌─────────────────────────────────────────────────────────────────────────────────────────────────────┐");
        System.out.printf("│ List UMK Terdaftar%-82s│\n", "");
        while (res.next()) {
            System.out.println("├─────────────────────────────────────────────────────────────────────────────────────────────────────┤");
            noHp = res.getString("NoHp");
            namaUMK = res.getString("NamaUMK");
            desk = res.getString("Deskripsi");
            logo = res.getString("Logo");
            alamat = res.getString("Alamat");
            namaPemilik = res.getString("NamaPemilik");
            idkota = res.getInt("IdKota");
            idPendaftaran = res.getInt("IdPendaftaran");
            status = res.getString("Status");
            tanggal = res.getString("Tanggal");
            
            System.out.printf("│ No HP          : %-83s│\n│ Nama UMK       : %-83s│\n│ Deskripsi      : %-83s│\n│ Logo           : %-83s│\n│ Alamat         : %-83s│\n│ Nama Pemilik   : %-83s│\n│ Id Kota        : %-83d│\n│ Id Pendaftaran : %-83d│\n│ Status         : %-83s│\n│ Tanggal        : %-83s│\n",
            noHp, namaUMK, desk, logo, alamat, namaPemilik, idkota, idPendaftaran, status, tanggal);
            
        }
        System.out.println("└─────────────────────────────────────────────────────────────────────────────────────────────────────┘\n");

    }

    public static int lihatUMKBelumTerdaftar (Statement st) throws SQLException{
        String noHp;
        String namaUMK;
        String desk;
        String logo;
        String alamat;
        String namaPemilik;
        int idkota;
        int idPendaftaran = 0;
        String status;
        String tanggal;
    
        String queryVerifUMK = "SELECT TOP 1 * from UMK where Status = 'Belum diverifikasi' order by IdPendaftaran";
        ResultSet res = st.executeQuery(queryVerifUMK);
        
        if(!res.isBeforeFirst()){
            System.out.println("\n[Tidak ada pendaftaran]\n");
            return 0;
        }

        System.out.println("\n┌─────────────────────────────────────────────────────────────────────────────────────────────────────┐");
        System.out.printf("│ Verifikasi Pendaftaran %-77s│\n", "");
        System.out.println("├─────────────────────────────────────────────────────────────────────────────────────────────────────┤");

        while(res.next()){
            noHp = res.getString("NoHp");
            namaUMK = res.getString("NamaUMK");
            desk = res.getString("Deskripsi");
            logo = res.getString("Logo");
            alamat = res.getString("Alamat");
            namaPemilik = res.getString("NamaPemilik");
            idkota = res.getInt("IdKota");
            idPendaftaran = res.getInt("IdPendaftaran");
            status = res.getString("Status");
            tanggal = res.getString("Tanggal");
            
            System.out.printf("│ No HP          : %-83s│\n│ Nama UMK       : %-83s│\n│ Deskripsi      : %-83s│\n│ Logo           : %-83s│\n│ Alamat         : %-83s│\n│ Nama Pemilik   : %-83s│\n│ Id Kota        : %-83d│\n│ Id Pendaftaran : %-83d│\n│ Status         : %-83s│\n│ Tanggal        : %-83s│\n",
            noHp, namaUMK, desk, logo, alamat, namaPemilik, idkota, idPendaftaran, status, tanggal);
        }
        System.out.println("└─────────────────────────────────────────────────────────────────────────────────────────────────────┘");

        System.out.println("- Verifikasi (1)\n- Tolak (2)\n- Back (3)");


        return idPendaftaran;
    }

    public static void verifUMK (int pilihan, int idPendaftaran, String noHp, Statement st) throws SQLException{
        if(pilihan == 1){
            String queryValidasiUMK = "UPDATE UMK SET Status = 'Valid' where IdPendaftaran = "+ idPendaftaran;
            st.execute(queryValidasiUMK);

            String queryValidasiPendaftaran = "UPDATE Pendaftaran SET Status = 'Valid', NoHpAdmin = '" + noHp + "' where IdPendaftaran = "+ idPendaftaran;
            st.execute(queryValidasiPendaftaran);

            System.out.println("\n[Pendaftaran berhasil diverifikasi]\n");
        }

        else if (pilihan == 2){
            String queryTolakUMK = "UPDATE UMK SET Status = 'Ditolak' where IdPendaftaran = "+ idPendaftaran;
            st.execute(queryTolakUMK);

            String queryTolakPendaftaran = "UPDATE Pendaftaran SET Status = 'Ditolak', NoHpAdmin = '" + noHp + "' where IdPendaftaran = "+ idPendaftaran;
            st.execute(queryTolakPendaftaran);

            System.out.println("\n[Pendaftaran berhasil ditolak]\n");
        }
    }

    public static void lihatNProduLaku (int n, Statement st) throws SQLException{
        String quearyProdLaku = "SELECT UMK.NoHp, UMK.NamaUMK, Produk.Nama as IdProduk, himpProdukLaku.Kuantitas as Kuantitas FROM (SELECT TOP "+n+"  IdProduk as IdProduk, SUM(Kuantitas) as Kuantitas FROM Nota GROUP BY IdProduk ORDER BY SUM(Kuantitas) DESC) as himpProdukLaku INNER JOIN Produk ON Produk.IdProduk = himpProdukLaku.IdProduk INNER JOIN ProdukUMK ON ProdukUMK.IdProduk = himpProdukLaku.IdProduk INNER JOIN UMK ON UMK.NoHp = ProdukUMK.NoHpUMK ORDER BY himpProdukLaku.Kuantitas DESC";
        ResultSet prodLaku = st.executeQuery(quearyProdLaku);

        if(!prodLaku.isBeforeFirst()){
            System.out.println("\n[Tidak ada produk terjual]\n");
            return;
        }

        String namaProduk;
        int kuantitas;
        String namaUMK;
        String noHpUMK;
        System.out.println("\n┌──────────────────────────────────────────────────────────────────────┐");
        System.out.printf("│ Top %2d produk paling laku%-44s│\n", n, "");
        System.out.println("├──────────────────────────────────────────────────────────────────────┤");
        System.out.println("│     Nama Produk        Terjual        UMK                  NoHp      │");



        int idx = 1;
        while(prodLaku.next()){

            namaProduk = prodLaku.getString("IdProduk");
            kuantitas = prodLaku.getInt("Kuantitas");
            namaUMK = prodLaku.getString("NamaUMK");
            noHpUMK = prodLaku.getString("NoHp");

            
            System.out.printf("│ %2d. %-18s %7d        %-20s %-10s│\n", idx,
            namaProduk, kuantitas, namaUMK, noHpUMK);
            idx++;
        }
        System.out.println("└──────────────────────────────────────────────────────────────────────┘\n");

    }

    public static void lihatNUMK(int n, Statement st) throws SQLException{
        String quearyUmkTrans = "SELECT TOP "+n+" UMK.NamaUMK,COUNT(IdTransaksi) as 'Jumlah Transaksi',  SUM(Nominal) as 'Total Transaksi' FROM Transaksi INNER JOIN JenisTransaksi ON JenisTransaksi.IdJenis = Transaksi.IdJenis INNER JOIN UMK ON Transaksi.NoHpUMK = UMK.NoHp WHERE JenisTransaksi.Jenis = 'Penjualan Produk' GROUP BY UMK.NamaUMK ORDER BY COUNT(IdTransaksi) DESC";
        ResultSet umkTrans = st.executeQuery(quearyUmkTrans);

        if(!umkTrans.isBeforeFirst()){
            System.out.println("\n[Tidak ada UMK yang melakukan transaksi]\n");
            return;
        }

        String namaUMKK;
        int banyakPenjualan;
        int totalHarga;

        System.out.println("\n┌─────────────────────────────────────────────────────────────┐");
        System.out.printf("│ Top %2d UMK terlaris%-41s│\n", n, "");
        System.out.println("├─────────────────────────────────────────────────────────────┤");
        System.out.println("│     Nama UMK               Transaksi        Total Harga     │");


        int idx = 1;
        while(umkTrans.next()){

            namaUMKK = umkTrans.getString("NamaUMK");
            banyakPenjualan = umkTrans.getInt("Jumlah Transaksi");
            totalHarga = umkTrans.getInt("Total Transaksi");
            
            System.out.printf("│ %2d. %-30s %-9d %10d     │\n", idx,
            namaUMKK, banyakPenjualan, totalHarga);
            idx++;
        }
        System.out.println("└─────────────────────────────────────────────────────────────┘\n");

    }

    public static void printKota(){
        String kota = "┌───────────────────────────────────────────────────────────────────────────────────────────────┐\n│ List Kota                                                                                     │\n├───────────────────────────────────────────────────────────────────────────────────────────────┤\n│ 1. Banda Aceh           2. Langsa               3. Lhokseumawe          4. Sabang             │\n│ 5. Subulussalam         6. Medan                7. Binjai               8. Tebing Tinggi      │\n│ 9. Pematang Siantar     10. Tanjungbalai        11. Sibolga             12. Padang Sidempuan  │\n│ 13. Gunungsitoli        14. Padang              15. Bukittinggi         16. Padang Panjang    │\n│ 17. Pariaman            18. Payakumbuh          19. Sawahlunto          20. Solok             │\n│ 21. Pekanbaru           22. Dumai               23. Jambi               24. Sungai Penuh      │\n│ 25. Palembang           26. Pagar Alam          27. Lubuklinggau        28. Prabumulih        │\n│ 29. Bengkulu            30. Bandar Lampung      31. Metro               32. Pangkal Pinang    │\n│ 33. Tanjung Pinang      34. Batam               35. Jakarta Pusat       36. Jakarta Utara     │\n│ 37. Jakarta Barat       38. Jakarta Selatan     39. Jakarta Timur       40. Bandung           │\n│ 41. Bogor               42. Cimahi              43. Depok               44. Sukabumi          │\n│ 45. Tasikmalaya         46. Banjar              47. Semarang            48. Surakarta (Solo)  │\n│ 49. Salatiga            50. Pekalongan          51. Magelang            52. Tegal             │\n│ 53. Yogyakarta          54. Surabaya            55. Malang              56. Kediri            │\n│ 57. Madiun              58. Mojokerto           59. Blitar              60. Pasuruan          │\n│ 61. Probolinggo         62. Batu                63. Serang              64. Cilegon           │\n│ 65. Tangerang Selatan   66. Tangerang           67. Denpasar            68. Mataram           │\n│ 69. Bima                70. Kupang              71. Pontianak           72. Singkawang        │\n│ 73. Palangka Raya       74. Banjarmasin         75. Banjarbaru          76. Samarinda         │\n│ 77. Balikpapan          78. Bontang             79. Tarakan             80. Manado            │\n│ 81. Bitung              82. Tomohon             83. Kotamobagu          84. Palu              │\n│ 85. Makassar            86. Parepare            87. Palopo              88. Kendari           │\n│ 89. Baubau              90. Gorontalo           91. Mamuju              92. Ambon             │\n│ 93. Tual                94. Ternate             95. Tidore Kepulauan    96. Jayapura          │\n│ 97. Manokwari           98. Sorong              99. Nabire              100. Wamena           │\n└───────────────────────────────────────────────────────────────────────────────────────────────┘\n";

        System.out.print(kota);

    }
}