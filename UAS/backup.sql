PGDMP  	                     }            BasisDataUTS    17.2    17.2     #           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            $           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            %           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            &           1262    16387    BasisDataUTS    DATABASE     �   CREATE DATABASE "BasisDataUTS" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Indonesia.1252';
    DROP DATABASE "BasisDataUTS";
                     postgres    false            �            1259    16403    barang    TABLE     �   CREATE TABLE public.barang (
    id_brng character varying(10) NOT NULL,
    nama_brng character varying(255) NOT NULL,
    harga_satuan_brng character varying(20) NOT NULL
);
    DROP TABLE public.barang;
       public         heap r       postgres    false            �            1259    16408    transaksi_barang    TABLE     �   CREATE TABLE public.transaksi_barang (
    id_transaksi character varying(10) NOT NULL,
    id_brng character varying(10) NOT NULL,
    qty_brng integer
);
 $   DROP TABLE public.transaksi_barang;
       public         heap r       postgres    false                      0    16403    barang 
   TABLE DATA           G   COPY public.barang (id_brng, nama_brng, harga_satuan_brng) FROM stdin;
    public               postgres    false    217   6                  0    16408    transaksi_barang 
   TABLE DATA           K   COPY public.transaksi_barang (id_transaksi, id_brng, qty_brng) FROM stdin;
    public               postgres    false    218   �       �           2606    16407    barang barang_pkey 
   CONSTRAINT     U   ALTER TABLE ONLY public.barang
    ADD CONSTRAINT barang_pkey PRIMARY KEY (id_brng);
 <   ALTER TABLE ONLY public.barang DROP CONSTRAINT barang_pkey;
       public                 postgres    false    217            �           2606    16412 &   transaksi_barang transaksi_barang_pkey 
   CONSTRAINT     w   ALTER TABLE ONLY public.transaksi_barang
    ADD CONSTRAINT transaksi_barang_pkey PRIMARY KEY (id_transaksi, id_brng);
 P   ALTER TABLE ONLY public.transaksi_barang DROP CONSTRAINT transaksi_barang_pkey;
       public                 postgres    false    218    218            �           2606    16413 0   transaksi_barang transaksi_barang_kode_brng_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transaksi_barang
    ADD CONSTRAINT transaksi_barang_kode_brng_fkey FOREIGN KEY (id_brng) REFERENCES public.barang(id_brng);
 Z   ALTER TABLE ONLY public.transaksi_barang DROP CONSTRAINT transaksi_barang_kode_brng_fkey;
       public               postgres    false    218    217    4746               A  x�}�Ms�0���+��6�P�b��Ȉ�:�	�FL�������=��˾����h/�0q���k��9l���sf ���v�����F0��;L�t�?b�F]�ٮ6;�W2�1$�b�8F�`)3-j�Ζ�mw�yô�ļ��g&ry��� /R�z�$��7�շJ�`87��c^��a)�A��j!�&�`�#��&��~�ؔ���^?�(Ƨ�)��5v��9�J���_i��i8��9��z��1�/�{�J����0�a���U-��G'\��%+K�OhVa]�6Z9���%�k[�˯�u�O_��          V   x�=�;
�0��:{�ݼ[;���B��o��0����R����X��O���!	�(��*�B��Ji�F��/�,t�7y ��*^     