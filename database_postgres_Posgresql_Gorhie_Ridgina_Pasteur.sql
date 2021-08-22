PGDMP     #                    y           postgres    13.4    13.4     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    13442    postgres    DATABASE     l   CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE postgres;
                postgres    false            �           0    0    DATABASE postgres    COMMENT     N   COMMENT ON DATABASE postgres IS 'default administrative connection database';
                   postgres    false    3032                        3079    16384 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                   false            �           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                        false    2            �            1259    24583    commune    TABLE     �   CREATE TABLE public.commune (
    index bigint,
    commune_id text,
    commune text,
    departement_id text,
    population bigint
);
    DROP TABLE public.commune;
       public         heap    postgres    false            �            1259    16415    covid    TABLE       CREATE TABLE public.covid (
    index bigint NOT NULL,
    cas_suspects bigint NOT NULL,
    cas_confirmes bigint NOT NULL,
    deces bigint NOT NULL,
    taux_de_letalite double precision NOT NULL,
    "Date_Id" text NOT NULL,
    departement_id text NOT NULL
);
    DROP TABLE public.covid;
       public         heap    postgres    false            �            1259    16408 
   date_table    TABLE     �   CREATE TABLE public.date_table (
    index bigint NOT NULL,
    date timestamp without time zone NOT NULL,
    "Date_Id" text NOT NULL,
    month bigint NOT NULL,
    year bigint NOT NULL,
    "Quater" bigint NOT NULL,
    week bigint NOT NULL
);
    DROP TABLE public.date_table;
       public         heap    postgres    false            �            1259    16429    departement    TABLE     �   CREATE TABLE public.departement (
    index bigint NOT NULL,
    departement_id text NOT NULL,
    departement text NOT NULL
);
    DROP TABLE public.departement;
       public         heap    postgres    false            �            1259    16422    mga    TABLE     l   CREATE TABLE public.mga (
    index bigint NOT NULL,
    mga bigint NOT NULL,
    mga_type text NOT NULL
);
    DROP TABLE public.mga;
       public         heap    postgres    false            �            1259    24576    spa    TABLE     �   CREATE TABLE public.spa (
    level_0 bigint,
    index bigint,
    commune_id text,
    facdesc_1 text,
    facdesc text,
    mga bigint,
    service_laboratory double precision,
    num_beds double precision,
    ambulance double precision
);
    DROP TABLE public.spa;
       public         heap    postgres    false            �          0    24583    commune 
   TABLE DATA           Y   COPY public.commune (index, commune_id, commune, departement_id, population) FROM stdin;
    public          postgres    false    206   �        �          0    16415    covid 
   TABLE DATA           w   COPY public.covid (index, cas_suspects, cas_confirmes, deces, taux_de_letalite, "Date_Id", departement_id) FROM stdin;
    public          postgres    false    202   �)       �          0    16408 
   date_table 
   TABLE DATA           Y   COPY public.date_table (index, date, "Date_Id", month, year, "Quater", week) FROM stdin;
    public          postgres    false    201   �+       �          0    16429    departement 
   TABLE DATA           I   COPY public.departement (index, departement_id, departement) FROM stdin;
    public          postgres    false    204   x,       �          0    16422    mga 
   TABLE DATA           3   COPY public.mga (index, mga, mga_type) FROM stdin;
    public          postgres    false    203   -       �          0    24576    spa 
   TABLE DATA           {   COPY public.spa (level_0, index, commune_id, facdesc_1, facdesc, mga, service_laboratory, num_beds, ambulance) FROM stdin;
    public          postgres    false    205   `-       ?           2606    16481    covid covid_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.covid
    ADD CONSTRAINT covid_pkey PRIMARY KEY (index);
 :   ALTER TABLE ONLY public.covid DROP CONSTRAINT covid_pkey;
       public            postgres    false    202            <           2606    16483    date_table date_table_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.date_table
    ADD CONSTRAINT date_table_pkey PRIMARY KEY ("Date_Id");
 D   ALTER TABLE ONLY public.date_table DROP CONSTRAINT date_table_pkey;
       public            postgres    false    201            E           2606    16439    departement departement_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.departement
    ADD CONSTRAINT departement_pkey PRIMARY KEY (departement_id);
 F   ALTER TABLE ONLY public.departement DROP CONSTRAINT departement_pkey;
       public            postgres    false    204            C           2606    16446    mga mga_pkey 
   CONSTRAINT     K   ALTER TABLE ONLY public.mga
    ADD CONSTRAINT mga_pkey PRIMARY KEY (mga);
 6   ALTER TABLE ONLY public.mga DROP CONSTRAINT mga_pkey;
       public            postgres    false    203            H           1259    24589    ix_commune_index    INDEX     E   CREATE INDEX ix_commune_index ON public.commune USING btree (index);
 $   DROP INDEX public.ix_commune_index;
       public            postgres    false    206            @           1259    16421    ix_covid_index    INDEX     A   CREATE INDEX ix_covid_index ON public.covid USING btree (index);
 "   DROP INDEX public.ix_covid_index;
       public            postgres    false    202            =           1259    16414    ix_date_table_index    INDEX     K   CREATE INDEX ix_date_table_index ON public.date_table USING btree (index);
 '   DROP INDEX public.ix_date_table_index;
       public            postgres    false    201            F           1259    16435    ix_departement_index    INDEX     M   CREATE INDEX ix_departement_index ON public.departement USING btree (index);
 (   DROP INDEX public.ix_departement_index;
       public            postgres    false    204            A           1259    16428    ix_mga_index    INDEX     =   CREATE INDEX ix_mga_index ON public.mga USING btree (index);
     DROP INDEX public.ix_mga_index;
       public            postgres    false    203            G           1259    24582    ix_spa_level_0    INDEX     A   CREATE INDEX ix_spa_level_0 ON public.spa USING btree (level_0);
 "   DROP INDEX public.ix_spa_level_0;
       public            postgres    false    205            I           2606    16484    covid Date_Id_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.covid
    ADD CONSTRAINT "Date_Id_fk" FOREIGN KEY ("Date_Id") REFERENCES public.date_table("Date_Id") NOT VALID;
 <   ALTER TABLE ONLY public.covid DROP CONSTRAINT "Date_Id_fk";
       public          postgres    false    201    202    2876            J           2606    16489    covid departement_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.covid
    ADD CONSTRAINT departement_id FOREIGN KEY (departement_id) REFERENCES public.departement(departement_id) NOT VALID;
 >   ALTER TABLE ONLY public.covid DROP CONSTRAINT departement_id;
       public          postgres    false    202    2885    204            �   �  x�mW�v�8]�_�]V5#�ɥ����I{��fêRlͨD�>���}APNr�ī � ..���C'�l���v����ԗ_���F
�N�yۏ����Di��m��I�����f��wZh6��_�<��XO7.Xe�a�����S����^�.�F�|��e�z��Zi��蛛a��/y쇑�ZE�����t��ꫜ�A�P��ds���4U�2�h-"U	{=|��ew���JȎ=4"K��G颗VHFM��f�����r����[�V��sB2�Z5O�����V!��x!B��Ҵ>�bཷ���6�M�'�����m����C���q��m�>O���&��W'�dD،����|JOix}��s�dL�B��i��5 �($cj����mj?�����7�{F��<L+9�'�d���� 9������t�KZU���1
%٨�Oi��V�Y�J��*�O`���w�	���4����P�}5K�Q�R�[��0���J��	eو�g מ��=gD5.���* *�����-A�赒ByvP\:퇼6^hd�{hTĐ+4
�Qy*����p7�����<�n���c֡��O���
-�C5�����~�h��ɣ�b���<�s�Vd@E��xNsu�������|f�y�({ �#����A��Ж}t�i9����;|^`Ԉ��Է����۷?�ڳ�Bƞ��
���F9A��>=?%.<%	��.�7������91�F7�i�}j.`�MaGz��S�*���3�T�pZ�0׏��(T��[���8U�W���+m^F�?��X�(0F�I�α~n��s����`�����e�˒*��fb��y��\���
�=Eu;��=L�����C5芹��yXm%5Xu>=1���;�m\�ۖ�tA����R� ���=�z��J�
k،Z�H�o3H}Xv-N(���Ü��4"D���Se�+M��F��ֳ�������qw1�_6�����Nydc�4�D�Q�t�A9k�p�`!�y8�X�Z8��/�aj1YNO[��8W`�H����[0�R`h�٬�wx��']��vg؆��nY{�V�X���`g�c^�.�j�]��;�K�~�=JY8����+h�xW��4��VEџ���F�/�A5?M.D�%8G���:��)=��D(j�?(�eI#X����n�Y��3u�'����
Ly�Ӱ�CQt'<cj��T_����[��Zt5.>o���.���ׇh��޹�i��4��3Զ@���8�v�_�v$@�帋��EM�H� �\���(��l�E�����::������8�/�id�'E(CK������cj `L��b�ڞ߼c��@�����������Aj�M�B�M4J>�zz8 L�vU&0^��4F�f� ^ �*��~	Q ��"�G���@՞�L�B	������B%�H/I^.mQ"�tr�J�c;��?����;PY�l��y��c�=�%�ܢb#q���pG4���5;Xdxj�=�hMD�F��2����^�� �X��n��m���a+�c{e���)�~���G5=���!KI�Uk���G�0Tk�9	RDFn��v�۰�t�2Mv�&������0D�3�1��HH���Q#��@�v���dԥ�^��I�w�$M�,�u��*�����Ĉ�{���az�t\�%�BePѰTW���H*�5<V̸����S������0ξ�&hiO	�]`�j����%w�L��*���Qӑ�M�ג��Fʼ���:�I�YzTz�:�O=��%����o�5���k=����P1oӥoI���5���x�	�B痹�-�Ɣ����@�T��x0ve����r��˞e�<zE�P#װ������i=�ī'�
��������P���Lw>��D �@'���-�����D��Hbj��~c�[ZH^W"�3@^�x�'`����ڇ����t�(���vU�f�+1��t\����7�=Ҩ�����C9f5-��IEe ~��a�B8K�d"�=B����a?GEM>�}LS��>f���~�e�A����3��(L�+K�u��7�?�ϥ����(�e����-^��㼻A�ClȲ���'�H�2`ƈ���e��y�c�����T��ܰG�eI�sH�P|��9p%eu�c}�"�G�t`5D�����!�e���~W�߹��� 育怯hg���[^� 
Ќ�sx��������o�j=      �   :  x�m�Ar#1е8LJ�s�Y���1��iPe���%�tڞC}��Ó�Եǟ�s�K�j����~=HƲo�+X�tp\V��:�Y���)Y��C>d��.ß��tQ��IN�;_Z2�5�w�ϰ���c_y.~�B��˰/��v�0`��u�~��[Ga�j}}s'��8ĳN�0=�MMY�����n���v�]�ZEΩ�v7(@s�_.!��;�|����~ŋdV ����R�I�A D� Bv�����5�x�@H� �+��|!�)��@��!�Pm���V!�S����!B���g�`@윬_ �+bK�`@���& v�W.���
1���$�ΊrY#ds䟟�~����rU�	�ɚt�	���r��i���0�� ¼B 1�(��T�O�>��k�|] *9����)'ߵ)&��4��s~��M�Ԧ��1[�@�X�i�i�i�iȰ���<&�����q~:��9���-a�h�8����[tV�p@~.��:2��|����p��'� ���E���������=z^      �   m   x�e���0Dѳ�"80xI-鿎H>��9|��@P�� ���A1��,R؈��Dg��t%�m/e�)#Puʉr��T�@�Ӗh��Né&��N������D{��ID�Hn      �   �   x�-���0Dg�G�@vZ�v��S�XX���,I����I����Ӄ��e0p_]��eWMQ�!�퐩�T���cT�ީ��Yup�Q�/%[W��\{����0�$�\2��<�&;&�ݶI��	�1.M      �   D   x�3�4�,(M��L�2�4�,(�,K,IU���S((�O�,�2�4��g�d�č9M��y)
PSb���� ���      �      x���[�%����Y��
�o���	�چ�2���_��� 3��O&���Rَ���K2�ɴƚ߾Y���������_?�����=g��Մ�_��o�����~����O���?�������/~���O~��/~�����#��?���/_���_?��~���?~�v�p!������/����/��us��&�,dH_?$���B\#8I&���m�m�Q���m�)�|��j��a��-��dc��>��Z�=���/�$�������_.Q|�P�@+���Ѹ�]��Kƥ���ﯿ��˟��^���Ȭ:�;�5X�.�m �q������C�J�	�}x4����֭i�5��)9~��G�o��C�?�a|�P��O�_�f+偗������HZ�R�/�>��r�j|]!���]i?a (딴�Tf'�EܘHi�U@6<��ᖆ��Ƙ���k�"��L����2`�߀��B1ac@;�Mq9��1��)� �Z� 7�fO�&a�6#<�U0V�*l�HnJW�g���6'O)b2�5�1Rp�}F�F�P����M�P�����ؚh����»���n��,�|� %���J8��a��>tG2�f�ܾ��GĂ!�x�wL&&}?�~��y������-�|�SM���"�dg��&���ᦘ�؍��$o����:n�<��`Ҕ�#�Ld���ˤ��}�}���5�4fl��&m"�9�IŤ��R5���\�&oi��pz?G��ɻ�]���3ڇL���T����[���K䈑���%9�����R ,>r1y��c ������bM��m�M[h~Tni�l��M�$JD�`���[��)��)]ES.G��&��$S.�ֵ��kU�)����jS>c,Ք�a����ZS7F�S"D@�1
�~��?L�o��Lx�.M�.�BV�ԥ!���\��?i��:���Y�ae]���\��efݤ^��jjg&�LUβ�k?��Un�Sm��&�_9Z���l�zG4l��Y�+Qo�h�u#ꢳ��?�ӭ4�}6��g�Q�-�:��U��l�9�|��߷�b�+��iY
w��Þ���~U��D��`���%�+o� �S��G� �ۀ���8���NGca�bw@|�y�g�U���K��U�1➞0�9�1�$�8]�f�Ẓ�<'�6`=�գ6~֗*�O+U��@�o ��`��0~.��&*G"����q�;hk���q�B4����<�ȓ�)ph��qd�Z 7�%��|�y���g3�&#Urߗ���Ñ,�l7p8)�nCi s!J�ǰ��faI���}g�����ZY�	�@褃λMRv������v�� P�OA��"���H@J[�G`�6�u��9d�Y�k#�o��G֦ݰ�!2�ȑE�~�9WF�~�K��2���:&����w�ę�NF�5R#K-�F
d���T�R� ���X��	���H�(�!�8��=��M�D�m� �ȃ���2ndBtu8��F:D��,]�Si��Q?�7�%��q.�Y:I-�����E���:�����?����=�᷶l���]OhȞ�x�i��6�g`�s�"�F�=��m�| ǞQ��`g�ܗ�y}�2��e+�����v.&����Oh��E��	�+����R�{
~-��>�
Qh�䞏f{`Z�����ur��9�cvoBun{SP������w��a�{	�U�\O���A����*����	?W�[ψ��Gh��Q9���
�=[�.Qk�
w=��� mז� �'W��U`Ϯx�x�o�������˚=�l܂v��*{�[��pt+�]�VNSl=��F��Lʮ'�P=�rS���v�#NϘ�y�J�Er��F�{�d�
���0	�#�}6�'LTU�Rq��{�DU��M��x[WPj�<~z���ð�}����@��$o����sA�ț~6�c���%�k$�V�����G��]�;�)����KV��=�	��KV��1�9�nc�<�1�GC��kn׎�0�t�~kJ6����&���Q��=���m/+���?X͙����K|��ӵ)�O���,�כ���J��2r���Mzv卧'/S �=�4��D{���ٕp��<��kϭ�y�Z���8�i��wt�
 �gX�d����=Ţz�
y��{�E��8��ek�A- מ}	������=�~ԯ�Pr-�$@ٳ,o<�ա���=ՙ��O��������R��?�	��n��Ph##�9<�&1S	��|
�����'M���ն�yU=]B��D��z���'��zR����$"��UAI&8b����Xz+��Y�rV=)B;�H}V=[�r�R$>���^�,���rm;��@��^vk&{VF]��	��|��S�07����H-/�Ht�Q	�LN�.�[� xO��G�Q[��"��Q��xG�7�V��O��.'��sM ��u���'�	z{Z������������{��ƞ�&�Q����Zpss�"�̍ʑ�8��3~���M�QT��g�<w�~9��$A�on�p��$so>^�̇����w]�g�"��Yi�{�"�?;X�^�R$K���[;�A�$zGR���K�D멿5I�䝣5Yp�'�%�]�Ω����<5i������;RC��Ȓ�ڻ����](;u��@\~�x�5�~���~����enJC�庁��IU�n���(w�3���+~�Lm�
.+Gwm/D|5�{L������Ni%t5�w���j�{:���7���i����] 8����%,�\"�M���ɨ�$`���i��4ˢ=J%i��7��?<�ɳ,>9� ٔE{��M��?o��ə,��&Hf�]K��<?� %e��IZ)g��U������<��ƅ���������Zb��o���Q~��m���$8���Z $Ih��bp@L2:O'�,�HF㝧��NhX�$��or��H��~"A,��C��Iz«���%��I~�����û�$=�UJ�X:>( I�w��(έ���(t%�},�D�2k�Z���+�<���*t���]��+��W�O���W��<�ѡ]հ{b��$���r#��t���K3�HIG���=ߐ%Iݓ_<�<I:��mf ȓ��n?��(I��:���Cx��xs?��VF@K�� र�}��$�*�D�㛉�t�����@u�9�^)0IyxzxT�ms
�����Q�ٟ�Yr�����}�����9�񥛱�ur>D���8"P��wt�o� ��S�M�9�Ϙ��֋�$%�VM"����<D�'�����yϮdv˔x����!VI/l?�J~a��n&%�n���啜AP�muRg��2OǨ��;$0����U�`������:k³�3(�V߄紝AYvzOg�f ���x�9��N �@3O�<G�/.w4��M`N��>�jSb�P�����Ot��J�R3&وp��{B`������������]�"8�\CP-D�!�PP�5��p�ْP�G�Po6*,
l��G
ae�E(�G�A��nh���H�7`Oslߤ+�N��N��%=��ѓpc��A��C��p�ż�+zMr{�Z�WA�$�M
�X�W���
�*�>���$��s�v�ȸ�%��YۣQ��dt��X�V@*لp�x>���;׽Zp��囝핣5E)5G��n�5Z����$Ϡ�䎺C����R�OdHR�<����l�!�L���ȝI΢��7�1��a�I���~q�Η��E1$i����jH�l�SY�&$y�ণ>9�h���laV#�V�ٟ�b�G��hq�m��i��='�$g���B>�l-�۽Մ�$sA�LȁIN��� �@��&f���C4Q4��H��޾Ē$f��=�)��~!�$D�$Ʉ�}���Iƀ��M�<��%�����PtT8H2AW�cqJ�H6�&�hi�"9��y/(P�����8C�H���}?�@�I2�J�\!'I���@R��%��YÜ�W D�����פ��"*�    ������f�^�  D�'���?���O7+��������21'��/[��O��V�0�B|�s�3W�߰�����{ԾoA��� ��^��K�/\PGKs���U�̉�O��󩙃9Q���G�,�I��m��@N��w���C;7<͇�$?��®tЉƿ�	Љ�Uɠ��j<F��J�.��+������d� Q��mO�Td���a'Q�����3�T��;�#DXR�(���{�(����Ip�ӿ���]�$HJ�+]��d�M�+�OG���>i^��0���'�L*zd�)gy2�ȝ��Q�)�nn?ʃ�e?���?���Ay�D�a�T��e���p��[ ��BNzGC����w�l݆K��2<=m�ܚD�zU��Cj�G�A� 5�������[d��y�a
@���|lբ�Dl��.�j�Q�f8���/�N���W���Qӣ��_�m��Ҝ���D�Y�ZoU� ������Y���)%�QQ����՛o}�'T�����V�U�A@R�$m-q+�i8���|�����v�`��a�k����������Y���]�w͜O��?�&����L}:ޮ��h��Ћ��D����"6��ۗ�l1Q�娿��=�j�H��>�����"-�U����>���z���u��L���`0�L�؃	��	&�&D7e�Ш":4��ǉv>Bpp8�2b���ð�E��������Gϟ�����me��@�a��B����J�.�@��ٓ_	�4�Z[�ʇ7���龁#�U�`K�x{-�QPp$
��} G"A/ڃ����!r3"4ߙ��?5D��|_���.rrTm,yy2��Y��L`E$���*�&(�B&P(�PPB��P�HSJ��0�)&c	�P���'�X픟����3��o�J���W5{2�������J@������4���=��n�<-��OG?�����/�a8z*��P��hܵ_������8k�s4�w�W�`���Ϋ��Sk
P�e^Z	����]�%�`�&G̫��7��''�^�y��\�y��:�	�u	X����vw]V�Ik 'p�5ᅽp1�ӊy�0����ľ-I��Ri�P�}�J�J�}U��F�%f�[��(�s[gp$�pRߪ��け����eTZ{g`$:rZ�`�XD3�3?�ZD^��/�g}�^T����h��6ji��A�H���4jQ@�(�w��P^x2q+�Р/��t�6���w�Q	W���bG����&H%>�H%=�H%?�,�â]��[b,�^y��鸐/VPT�p4Qљ���t���i\*����ѓ�t_5O����Vp$�pz�o��(ihף�
�DN+�}��I�w|,V�&��' (��]Nd+@qX����M֚$���ɮ���!�m}�!Yo���:G�Àd�I"4�g�Lhd��%�,���#�F�l���G�$�D�N��K�\6I��w�����D����n�S5I4����D�N��"��Y7��V�F�R���I�m��\Q������ �DO*m�L��69@*2���X�%FE?O�Kw�]��"�'��&��	$����'�{o�D���yZ��h�$�{^���G�$�z~�ݫ}���G�$�����_�/�@Nt�;�����̉��kg~r��a»�DW׵�9ay@'��];��u���ڨ1Hl�2�Ogy@��'�
vV�6��	��U��?��B�H;�75�G���4t��7��E��8{�1�P����(���)Ҟ�����+�+Gk�� ܅Ν&�?������~2v��.�/��D~f���(<���c����H�%V��9'�(=�WԹ����(�2�70$�#�~^Y4%,��������ǌR#"�g�a�j#��]��F��G��E{�#�~^9�" �>�E흎�Gt����(E�#�}V]Pp>\�|�՟u�	 ~a?O�H4���>?�"��ҽ����wO<��zD���UVV�X���o� ��i�%�BIt��^���78���9Z���nq"���)�8���쇎��J�{Г:=[�%��S�zOC�Om��p4�z2��~fd�SE9���SD���9�����*s|(6����W�T�TD��t�5F�VD��7)�q�-e�"�|�I��<�.g~���.�|Vg��(Q��(�9�W�-�pY�,-o
p񽨗h�@Y���'�RD���Éh)"��܆��Dɟ5��5�^���V	�f�~��t�^_��ش�
�D�_#�����R_���JzGg�R�\�ȭ�;`��&;!�ϸ�@\���|^� �v�4�q�G�@���h�i�Z��}`Ϛ����g�M����/r���Es�{
�O!�E`���E4Yd�2��<�d���6Y4�����>�l��"�e���,b��'D�Y��>�Ϛ8�Iٹ�h޿�h�E�ѹ4@J��r�n8	�D������xͻ�"�`�ewͻ��2�d�D��?��V�"y�?׍�U"l��[�3^�,�uQoLn�|W��ssK�ّ`>{?���"^gf~�1�4�� �|\�W�ă������<���<�L]Wv�d�X����F����?x�E����g�����ݼ
�"9�?y�h�,��}K�y���",�
z��H����OO�E���&|�q�Ω�Ȉ�<��̪Ȅ��!;��=��Ed�bF������	�"2��=��)/� ��{t?���d�W�,ދ��MB�S���Ꮈ T���*6c�������W�9���?���臹n�j�4�9�+Gkr�8;�V�G�tbGger�@'�a+���<��� �<��Ӡ޽�7]�PD��+�s���{ݓ���D�y��	��wԶ5��D�k��I�HT�;���D�5u{��wV1B��μKa@���F�V��rh~�^��'�s�-��������,��y�ʹϜ�ȼU��% V�"�.>���{o/rh��DT�E� Ed^}�\�zĩY�^�5�i�����|g?����D^p�+ ��ܾ���o��z���IQߒR[�P����Hv���2�����R��#ج����`�v&V�cLT��P���PT�ُ{�s5�ݟP��5�H��yż��[���*�����)֚b���{^�.u�k��{��C=�x�/6�b�;�X2�N;��>�b�=N�}2�.�w�Ϧ�i���/��i���M�����:�I��څ]}�Qi���u��_s��4mt�䣤��&��~g���Fi
)��^(M!���P��&���E8k$����m� KC��:+�Ҧ�����^���a�P�`�rl��-�ro?v%���s������Dx�fh˶�����)>�˾=�
�x�e������e�o�/�^yZ��
��e�IA��eP��L������'ݔ �|���`(аׯ3J BA���Qj ���W�� �B�ٟ/Y V���;�"�'QR����QR�j�Ρ�y�U��l�E�W���㹅 �H�����"�.�,��֩ƈ��u����1Dp�W[��v�"�:���0�9�"��s���"P%�)%��P���d+�����f�f�]��L�}r�1~���Uh�E`,���9iFp,Ҳ��-~�%d���z�؊�E��9W���E��;�VJ�Xdj��Aq�"`o{�"`o{ߢ`;姘:�	|�����"pѶu���>p��ݳ�a�SJ�"����q�8��E�n0,B������R�����P�#�[4tm�ΆʀX�u]����2;�a޵��Ck�"�k��>�e ,����9�d ,����IS�"��?����e��r <_�α����O \�wA�Z3uO�S�]���	��� �\�^6���	���0�ŁxIW�����Y@��tEz���@.Im���Y�x�;A�\�P*�[Ѵ���a�$|�QS+ ���N�K�C���_ᕆ����W�q�{��qM{�
O �  XtT�\���1ޭ
�k��?p\�8�e�֚j;�?d}�����(w����X�7�z�����ڰS?ߢ�j�T�Q�y�gCESm���<$Sm�*����l��po	\�Sm��$���ڪw4��ꀶ�{��n���ܕ�u����U�?��XU>��v4<=ı}��:��d��)}��ٯ���n�������d{=��XW���9`�V��c��۬��@�L��m}<��mO��	���������Kρp��_�R=���q���ꁷ�Kκ�.��'a	5��� m�	�8l��#�	�x|�U;j���w�ö����N5s��o*l5P�7�OkɃd���˓�6���/��?@�Z���K��߇W�O������YJ������@#�[�������$��]�]]�I�/�f�Ǳ~�%�6�������T%��EOt����,'��J�'˂|%ŧ�t��J�/�^�s��WraO,�dK�/�I�5m���&��dK�/<?ۼ��d�BV_��h���s��c�Q#���_��ִ!�u	����^���orzOa�Rk���1o3�m�M�T2x���;{j�b"����	(�KW<�-���x���)����6 eZ�f^�K�i��v���^>��m�����|���	�X2��}���A^��Ws��^��Y��auod�@/;ȶ<����m}��f����l��	L��˖��Ԇ�X�ƕZg�
h-N��l�\��O ��O��S y�wt��Y y�����*@Y�h^�Ѿ>��,y4�\���dɢ�����n�Z��$����p+h���+�X����s�oxt�@��y�`����ܻo�Ϋt����IW]��҅��]�]M�8����[����q�������&�k�zI1�W۳X�)��m�i,���׾�i?~[���i?�����L��d�x|�6����V�����L�����N�ɦ�`_*�Ë�b���Bc] 7մ����p�Rw�A���)=?�	3%�	/L�����6�a�%+�Wn=�1s*٧��xmF��uN�θ7��T��yǜ�|���Y��SW��5|1�n:���O�v�w��3���k�����dѣw�/���_f���k��C�-�aP{�H5��֑A��-�{�-�(�!��l���ol�}��8�:ʵ�
��l{*h'��A;0��J�9��5�EVE�Zx}S�������j�l�     