package com.example.repositories;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.example.dataViews.KeuanganDataView;
import com.example.dataViews.PenjualanDataUMKView;
import com.example.datas.KeuanganData;
import com.example.datas.PenjualanDataUMK;
import com.example.datas.ProdukData;

public interface umkRepository {
    List<ProdukData> findProduk(String umk);

    List<ProdukData> findProduk(String umk, String filter);

    List<PenjualanDataUMK> findPenjualan(String umk, Date start, Date end);

    List<KeuanganData> findKeuangan(String umk, Date start, Date end);

    List<PenjualanDataUMKView> findPenjualanView(String umk, Date start, Date end);

    List<KeuanganDataView> findKeuanganView(String umk, Date start, Date end);

    // will add another parameter here
    void editProfile(String nohpEdit, String namaUMK, String namaPem, String email, String alamat, String deskripsi,
            String nohp, MultipartFile profilePic) throws IOException;

    void editProduk(String namaProdukEdit, String deskripsi, double harga, String namaProduk, MultipartFile productPic)
            throws IOException;

    void TambahProduk(String namaProduk, String deskripsi, String satuan, double harga, String nohp,
            MultipartFile productPic) throws IOException;
}