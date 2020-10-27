Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A44429CAE8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1832042AbgJ0VGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:06:53 -0400
Received: from sonic306-21.consmr.mail.gq1.yahoo.com ([98.137.68.84]:38463
        "EHLO sonic306-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2444392AbgJ0VGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603832810; bh=Qq7tXFcXNhGuWybLMOWEtmwD88VFV1tmAG2FEKAJUfI=; h=Date:From:Reply-To:Subject:References:From:Subject; b=k4gk2PrvVddslWtFPRDEnbX8jhUGDvx+pfVjhR5Il3Z9WRGuK9yCmOPwe9vZjcJIKykIp/QG9rODSy0cs4CeXsVU3MJHQeakgOwYerQCbhdT2fQvNY0HtMegrYBtVQs2BCCvH+6AqWAbI3LOFhituH2YJKS4AEoIKSCOwbCrorMveRG5/QkMkIBhwj1Ji6fE4J7TBGhlD6952g9UqLYhZg5JzHUkeCZuBpS1WuVmbNOERGyHKWntZ0Hy8WWxt5YMA/fPjFCIDqdBMywWuKTClBwHkYYCne9rV7OPuR+QsCmvtrHvcbOyS3U8A7RZcWUoQMDymkddRT6qkq67Z8jyNg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603832810; bh=fd3nl8AXGE8W3PTUnVlgTF0l0T53il9LFa2HAJCRXax=; h=Date:From:Subject; b=qAdrY3CBlyiy9C4of+LHLlmwXPX+B78EDv3KLGAF0aafpnB88AP8YAyxIj0CKyUMAM8n8bfO4NPNmQ3v5+Uzi0XBbfDp6VIV4ZZSoNSeKTB6eOgQUpkpxsyUn3dB2E1d1WNNbDeJjNWbNAT5SB9ZI1atVUMdX3NosaVmklTayg7magBPEE0h4o0INRPbnXbSYCNLLyK9GzD5hPgYaGaI01K+4aHrLV/NUnuTMUCdkPb3IdYwhBfXSvcwmv+/jb0wmJYc+RAZLhcQws8bquf0xi1+HZ+msev7mUjvwDVsqyX+i+sH05vRcVDfa9L9s4kO7+ycc7+/+GvyMKdq1ZKoKQ==
X-YMail-OSG: XHLdyrEVM1lg_UN7LlVXlvbPslh.nHJeSSEPuSqJeOD_rqIyWypSZAAT_PwuHp8
 2Cbg5B2gwxKLLb_mFZsMYmTNxcYxVuA4X_MaydvEVyBNsNeFNHtYzDYTz1ajyOQo5nRj0mXCEnEm
 GqYbjUf_5ZAjK6XHo7MkYceCSrTGWEMKYqVWj3CnY8x069UVO6peJxuwaI8aO2Tz.2iPMN_D.wkI
 yppfT7RN.l4AVwHdkLSonuZxKO46t_6u9shXiSl5es1wdI2eq3hiuirCgQ58mOIVEv6W5mJCygnA
 GPt8o3nP9F3JwKGCqCeScdjdrT7.3wMRzCT35E0ixUQ95_UPcGM3oGTGtNAcHVmsvzjo8d_xyitr
 efkPHEgQyYN8qkW_Rs0tm5RQc0QdluO4O8v_6kfqvzJWO15nQbdmfM_oXkiSdzxXYKP_G266MIua
 pgsRvNGRiCkCprpF.ESU5mAZPs0T9Me1rsZVdUQGkxkUKgHm0skRKC8bNGR1PBiR5INI.umaxVVu
 LHPauaR7yEfuTWe.mzPQrcsDenX4UGLlHBfVkmw3uPkgNz7r44lzv8_hLTRNdabn6oF3WmC8Lwrm
 _IytqISi5TjvU5ZwZgyUSdK3amisc6Qs.QB5mDcolpS1KDDo15H45Fa2QBcgrxdIxhIIuXRf_XFm
 uoTnnRkkYUk1XyA1H.q_UgMT2j9VMET68xVVACtnWBSuG9ec4oHnK9oj9aY_VRMlhWdfC3H34pFy
 OHLJ6AKsytxKcZlIqWZ9BvTQiod.tkJE5FCjnSHUghG2sxyh5vcEKk7KpjISarmL0Q7V6dkAgLc_
 DzUrnCqXMcvcJ0ouFjMdnWgIuM_mAkTbX5eronVx36ba9hHYaqiYHYDv.cuXG55ayAqj8I957BSi
 nAtB4uqKB12R8EsieaBr7O82KNHhsw_RRXlrM9PkB26Hqku4boW_WgA79oRIWIEmtRE1bpfF9eSk
 VUJNseLfpzONIMknZFboWLB5tkMaRxahbx8M0d3ABdJwGA5E8VHiLM.ZTEvsTITCqYWB89d2Aw6D
 MeZaM583oESxMC5XtLvSAfeCiSRNPf.AHxX_RwZ4OBk.j5oGyfdGgmRp8I0EFLMRKN2U_bJhQc1y
 hZnsuejFcpjzwW8YoV7KUWOWPjlVPWUvlD5V4SJCQ1y79usF347KsmNRDXS7DTc_i3jFp9FeBgY0
 UL.CK35i0wTu.jcYCaJE8cRDCAWtJuamNH0YOAJYcSbfSAXFrxEkXbq3n12MDPdMDG671tLEGMYC
 yYGKqq6o14NMkgR7ErSPW1B5BC_DIx_1tkaAP8eDA60NQfdBxaZ.IBiNAaDGOXEs5ZO5xlDwkdMt
 Tp6zlBQfozk.tZf0wU90zKs.tJjDh2zNf7o.tZmCUTBN2.sg41_USJzarWfIOBAiZh0EJEAO6uDm
 8w8m3wjbE7pu8DrBZ81rEbfhIql3efoIjaN2leN97DZYrr0rfP.Zq60N5NXJN4GrT1QUxVY.Nh4K
 oXQiS06QmdimzdKUvgcTm2HYklgZTLlFGCscJpnIUpk2jviRMQ89s_uExwgWio5RnBwHOmbpR_r1
 bcxNwDacggQ27ey_89qInmfdfANTel2HfIbf6o4rBkaKNPYsH2TIFYKjlgVJtkQCR1YTPCnabgm1
 Q7SSBfblr90oq_7mD6JrBys3tz2bw2.QyOf0uL9nveMW_f2kBh694gaBl2E6c3hx8_Wxy6gwUkNy
 tBsAjSbpyRLPW3Abd38TEmwAoBEyEIMsntv0WIFhMbL.ONmJbMby2OMU6zW7N_2OeiPQZPczWkO5
 mPGPUxNHUzF26LWz6IYclzUNGhVNrPfa.7m7glD5zv6An5AAQncniF5rtnJu9wT468ZA9DiKvZzx
 3dJiozidokukgGeMph5FvxrQ6K4hgqKc7wGmgpHvwU5yCoXFZspyOfuMhynX3e3VRVb4R3YgjNnE
 xKYIUD.dybFz3LTtqdKVLBifTky5FmhoUMfGayVS3gfP8MQ8Hnc3oxAOaakuebS25Q3C8oSgjBcv
 qy4dbbLB0BMGyj1RGWXq3x9hS7ijl9nwIeHnBViWtxVwLad5gscxENMT_u1ZdrOsC330DGIsvBIp
 inkHj5ek4vUzNh0PLpYtn3fBFjD3Gp9dhUcXrfW_JpclfrWjJpJhAoJTvRZtPafNWGD8u6qvqnD4
 LOSqLwLHr421gNTDTRHJzljbgEAZrhzfO4Bc1BdOATBXOKwhbHhyOlW3dSEirSi.oSR.rE5eVOoc
 wmUTnzRVBGj55jE0nAJ_K9YID4L4ZczV4VBMn3J8pY3QynxbeQXgrEDSgdS6KXxSgXGhvW9YtqrH
 hp2kWx0OJ7C5.gODEUbxY5EGpIDB.tRqfJu8_NXu0oTL7OMBYgLEX2Ptz_oETtdaLLyXNn9xCGXO
 R8oxIfU6Uwa5BxurroHgPuGWF6_Hlt8WU2ylirYeeY4AfIIZGk6CS4N3iDc5Xm.RNfFwQ8TIF8yc
 XypZ8ti.39u9Ltlk_3jEf_cyFcgYnQZ9lVNq67h1FnfYQRwGopl3agxsPlR.WipmAcAQfwcQv3JQ
 b5b0u2H_L1BUogtLsM0l2pJz4lG_DmXPYParsUXYpXYK4OX54GCBmKhcx4mOE73pQgZGqzhgty8_
 Sxhk1wpys7SoNfEm7NxuLc3y6U6viGw1sOaC2yR6dlp03BdrolVlsO1fqBWpGfCN58.OnTLiRScC
 WYEJ3DFN_jE3k6WXPwTzSOs2vlnSjsgfaaMrSIJf3o9JxZlKiNT.xf5Cj05aPhtJ7yKU6kn99Xwy
 Rk3z6S533r.oPkHuHRbiyIsBT9AITcAuxBgZT3nq2FXjbySLgMimRGxE4QnL84Cm9Vor1KC0wp3y
 BzyWpaphdOSwY_elc2IXiQzw7HxkHttR8eMBckXfXghhIl09NIvTun1bo4RS2r0OS43q0xcugtdG
 vLG2wSbeuql3w4oPyjFTWBH4ZCbmyYZSZB80SQ_J9dnoWMHfZ4crrp5lwa4kyUyrGCL9f3Nun9za
 8eC4AMyaZiY76BNkw8tpvWQ8dV1RiHE0ATzw1RuQTuS__Cc_.q3XD3gN8w169_w0cDzYyzCwpQhE
 vrJToLSZaeMM8MPqx.Sn.InnzoDVSDZgoujZn3N0RgbZvbm5n7tvYtGPzkJ36t1OEPzYOu5HRC2A
 JzHndsbKOJKNRXgtrBjo5wyVSdB5xIjD9NNaX7HtM2N6Ut9wVrxQBgVAeNipkbnrca3XiofKAnyr
 2dWMT8y5mLy9jjq8KQlBRPAeZUNKR9YtUR_K6fxmJUjx_G.e5lDrkO77AUhUIN.cXv5zVXyiNR32
 Et8iUSBvEqBd8MX8AfAxeU4Njc0vr9eQFMib1fq3jxRakn246kUvc3kYXDbGJNh2t2WXqPORbUj9
 gKEuAQguON7N7OF.kXRbK9kWAXjTPo4uo5T66kF_8TXnn35WqNMYIbCp_fuyKyZ56MWe63inUiiO
 KdO6kWOZi3pz4x1b.V.8U2psy5O0sIn7nvK3JceuBkWCaou1uKgNqt2RkvJ6jf5Vxx14HPPm2Dyn
 Dz7hqY98JpU7o1tIchzHD2lOhjm2URn_YMfXQCZj10ziO9FFwc8_DtH26L3mh9._FitQzc6C1kB4
 WA54trNGhBtsXzIrtHX_cY_fFWBQtC6p0AOS.4aaqtXrD0Ja6Zym.eofLKNt8KtjFAl8QVuxnJT5
 _ujrmGhZG4fAN6qLuSAuUwGVIWmDTaBfgzYrZg84f55PNbXDykqbUJN0VVUb12ZYZmZz9oYl58Rm
 9nsKRdOH_Tt_LVt4f2FuBZLvDU2X_rgRaISndwMJdJoPW9kgnRYHhLS6KIUG5UudJzB4RlGaakpx
 gOjCSP64YzA.0mlWB0OS_Netotq25iJG9ZovAFFUpSgqv2ZjfveAQTec4oCv6E3QXbEM81RWhuR7
 Hu6sfu52fwdRHEqcob1P.97HbeygAa3n.2LV_5c8_41yK9SIf7IQNYB1gw6s269wp0oo_9jNY5M1
 YaiCEYOtom5xXbhahsrFr2EST2pZT4zLpR6APD97Rms4hFIkbSscmuYgEm3kokK1b22AIUYvRWBq
 7O4lda7LlaOrC0BLHWrab5Rrb6MBEcc.YXW9EBhrSEALW.XzB5ZotBC4UdSCILb8DIG0A8dV3QjW
 UmH6cOm2bSiWkNLP9Gp3IRRTKv_.wwThOJ9fazFm50Nt40SBkIh6KBmnmTLGt4nuavTdSBIBJ17J
 Xyd9gflVTr3.cBlK_7EA7EQ1lEZHb16VaY7EUYbEAHPdMLJPFTCj52Laad0SZEf_VTteWwdIF6PJ
 vdeJjzxKI31AMuUiyImhgw3f0nSOuV72tgkuugYBdHIGyrD3ioTG_4C5U80QOFWPVK9gSW7S6s_a
 FJC0wkQB3nOIQ8tm.ulI9Si1X_7vFFtupGxBLh7AiccC1ufJtqa5kC1HnAy1LXdqevOatDXCGyrX
 ukDvez22.xOfbvXH9Du1utjtxvMCu97QUvyj4UVVtulUOmfA3YCykfjwt5FuWsmZAZTTFq.U0hBy
 wi4c6._pj_6eOdERhw7ldIHSN.A31dhz08GNwyRmZACfNvYGRAOrU2pgxkRFtMrzcPdj8XoIA5Ye
 oRcmUrTUztqF36nozlZpNlUWLxx6PaK3xq4zguOUbxSY1tocUFttG4fQF3ha0po3v0JCB1NH.qbM
 WzruBFdPRhbj2fDWnUfOLwE5EtXK.zORgNnAbGy6blIwwureWeaeg_MY4EDDaXW_70Fq72WK5wKu
 L28bjmEqu327VeC78gGBkr0R6T.I5DafurDCJD.AUm0P0ma9DnvUTS5AoQrKOKlBGFYp1PNnV3PE
 4U1jA4nN.snHxcD0vQNOJ_6GZ8UHHcfv_kdRhikfwM7h5n3HsBltWKeJxxufyZoTYd6Zyy_l9hwy
 wdtviWoIaUjyjwIxcrRYzNAba_tvldEhDKv3.0Q0GqtWdtlUGWme7kCL4FzI4kKkmf36G9piY9R6
 LyvSdqgDrwsOCn2n5yFHZQQ8R30NlXGKNY1Z8CH9BwUd2XAn_hGO310ocZBS6.AVvC5hkrATfDuH
 ab0Fxab1oSXD6KnS0kkDALhcnKCHLuDYYmc575DfwMGeMm_mD6pTp2KTi.yrPlxHNMtytB0M1R8i
 5Wz13EeT4Vtm7rhSdcaFVz4NshUsLht37ATCYTq4LcKHCclgvb1wSaZGiCJSPH9gL3GTGCqKxv8k
 hBC2I_tKMe6yjEEytJ52xx2MuQnUibKw7jZisDkJRdw8C7gaL94CuPpU3wfUJsBHfBDbPIFMB7Dv
 vaelBDJksGxkPMqCGrtrYQLyWD9LehyXG4_YWji9MfKTLWkh4lrttPPIAVljBmWaBIZKCffhde01
 0wesH2Gb9DU_YSdxjlnxFHnpKYLaD6FrDUrqKqNMkfQmWKUdBf7t6byV3RATzg_z7E7QKMBdI8yU
 9fz7.iktlOmFYkY04_n.CnprEHNntZVYf7sZiGfhsaWSubKLlBaVS7R1Ix5630shDF0vzizPC3jp
 4oVU5hjax95b17HAxU_Tz.G6DBwVTXCTNU2v4ER9zbbO7Iz1ktW.cvJZznygOz0wMq3hJi9SJdvW
 PKJsF7IQnMwIhdP.6BodJQpaJn.RymWe4M2pUCF8UxbX7EctJQt8dAxKByfTcjLwv9NumXnTCwiQ
 94D9pQVgTvqSyCCDjF4RbimH2DvN9QM.j0cWT6nyRUYHSHAcdcL.JcjVGBwQpoCVRXlXfUhUeUdm
 MtWVR6LfBizlEBkz3CCtCrgSg_X9zIVJxwJ7m2lfrR1byrAaECrmQg0mDWgcczR_o7wtPI9aVGfG
 mbrC3oGUVfC77YeYk4AxLfqc7NO7JTtpZXGeA6pvLEkAHw3fqDOJWmvkbl5W3W___bolCAma.Vwh
 ZP7GnnE2qWszb1Ve_Hh02uRNi.Vvhjtu_NpYgcEns6e_lUuLIljE5EzUZQAylyk2MeAX0vUjNHGU
 LYS4FIbvdCb0BLuZrK4tKspeCfaJomynV9R4QhN8XqYbAuqX1wzvLTCcxCCHJhgJOTEoY4TAKFex
 oQBrgwo9mUiGIv5UrLsW6e_kZ0F2wCu4EqAzXBR6UoeXDKT5II1UxHIe3mrl2jVlfm03YmunpRHA
 7OTo.AvGoFK8AppiTe9OEWelprQ8j51Onx4BznI5Rm2.IfaKtS8peRM4kgAp0Y833ERQ_O0exhls
 _7jjrmq0xKP_kg.WhGE_JcTUc3Fu22PF_XkuEoiJXrrKDFRHReNpYmB.YoBSmWks6YZj8GkIfHw7
 XyAyqXNpaquNGFxz.YeLWiZTYJyZ.lCPI4gbtu9hNnf9DFruRSxM0mihY9NMMJvufaCyPrmM8j0E
 pXeBt2FEuy8tBX_QVyO2oDRgd5NyHER2XXVf9lCUCzi1HITkH.HiVS3IPIwz28pbma8aH2mfp_MM
 X502b9b_8vKEuavhZMIriaXg77T4bIBRRQRL9ZSEpGKE9N6KqXtCaewBT3qUNpZ8H59zcZakoaAZ
 nrP1Jk9nzMHk0AQMd_QnXXoHbwlmcPPUWCDOsellYJaXV9BDFUmcFZD55t7t8Zh2t3.vLhy.GyiU
 Py4Lm0KHWlQIrL5c_OVYibc2hsfFiH0e7sl6bgyFPsiX0OV15kSc3c75LqWZ9tMh5qmKvX1DZBt.
 P11Z48a1dWAZ39xr8_PyjgpAperWVxzgNmOziJJaSsp_mF5nenFSibn2peczuPwYuKK9PfHKgs3j
 yi3RhSjvoK55Kue6P1yYp.0RQGkuZoOfwsSv7WpZ38OASwkCRxvVqglGGQfgULMmV2toqRvBtyhN
 IaG.sxP1CYeuL9rKrSMY5knIzLDrz1TvIvGq1U0VOdq2Xg2a1pj2dQ7hb1852eHWRubMPucaSgY.
 Uc_ZWuv86VUizlXQg5EijA_MPsc.daZL0iSAdBG3pqEmK1Uk1WmjVWI61XGQac7iN5zAQxtgaKGb
 uhZ3CniYzo_EzGq5vQLEApNAlBjZWZ4H4vZGtafYFVZ8g.Yc6DYE0qhK2UlqWukj9NWtZD6nl743
 fErwPgFpdSyG.3eV.oOXO0TCgDX.WJn6mAj1uAILjctJLiq4ZdA6rHZaYBRVnhUAlW9s_syYcGes
 ja0d8GLdyOeRZPDPkz3p0Sh99mlXEUQTdh5_n_G7kj5WXjp239yM5UP0rQlcTO.1scX77_tzXHWX
 m5rHm3FFJST0UiRcnhgGptXKnb3XOYtpLcpRSEAElD9_OUWYCjYETZW6hl39CvPg93zJ60BoxK2S
 t8LqKAHH8cW9mjg7T1lMmaQDw6xI7UEKpi.a7E06Ua0Avgu_a9PRsP5aJRuM2CETkB4RUpyTrU5U
 RXR7k93dsQpoStgTooHc.JN_rFNBoK9RR5mJ4JMfrK343FdmQEE_GYjuONle01i_UfmXgdQxdpOq
 iY4H0U9vt4evQgHyaQXrfsxEZtXE2A3kKFYyiUjgaxSmGdYF2OSoFMcvDiGC0hXBFBv2UTjTYXjT
 2wvI302HQDrWl1hBt9SbUmnTt6AHzQXuC7ZP1h5_s5_MG_GQuob7unSjGnkCjexRQsXTMDkm_H29
 jwpMpIUX46q8a4q3eLWKHKz9sMhegXx1qz_p0tACP1yLXPE74pO56wtM4zg.tW4knOvAxTM9CyY0
 ohkqXn53dRoU0sG22g.S.mG.7xQNlxR8YL1rab6C7aH.vTDFQYtucpKptXo2x5rPFDDo6WRPQrJ8
 PXWHOrQWKcjZTuOLHquS3A3gFNudUbRXK6JePxoWjaAWy7M.Qgn5MVG0z.KOO6PeGKy2y14ozpzE
 rmzPQOIyZiLVGTu_4UhGWo7nKmjRJJAEnUpOAc9IByA5ZeS9DliOmQ7iFavKpoBqGhjnax6K2i7J
 RoTeyexIoU4WjF76_LFdF7Ua6koD.hm6i_VvD3yC1wYTt80o7laKufx3sfcaA6eSoAUHPDBs7l4z
 6hb6m7LF0DtJszs2.lGMSH0UPgNAUUS8RekKJ5ZkjQSejd3rGXVEzI7vgGadKvlQv4rh_Bkz0P4B
 hCcCFzTSFYiMZz3Aq2.EDVqXqOVRi9fx4qEKNYdEqSHx80gECnGve8uHq1z2p_.REtBxRL1BvHOa
 59gg6H1QkGRrJKcMm8aCNhlz0fOUHL1OM9V8iBzkQMMS8oWEC0mjRx5qMDlKcCVKjbDAsWoVUCVf
 1665vk1boaxGP.qDLlbKdlby4LjiZs7h1i0IPDCPGsZwe8tqIqQWXjwb9_YrGaCLZ6lRqyihLnHX
 p3C1SyFGayh9iN1LlB5uP_bX2gXkQlVuUwKaV3ov2Cfl0eFQ6kC.vCJndDVjNTnY0IJ2c_p5WcEQ
 AoQBsghMV98v2RkS_H.Q16CzP7LeDRPa6wJ8EEPMqCSirR43BN2KohlicIrSiDMr.N1XwT7YjUcd
 xZx6plnbg3fACKQXHQzSMjF5MszQHY2rIIP_szJL2.ZeKijC.0ovgw2bxHRNCuiVto7wLPqHsTz9
 DP4JdaprcVcbQHQFj5.GHmqBqHeK6JJBuJjqwMkD65dwWebdmrU3Zn0HkPRrg.X42WXxFCl6_Orn
 sMqrF7FHn4SLKYJTi26QzF4Soznp7BCPp2phvs4w3thUBnoqUHjVcuYHoL9tte2QqqdphnLpoKeQ
 XH9aCjh3_hZqWxp4wnykUDn8LgeaGG9563rZyMmbQCEDNiyjIZhKCvtUFSTENxKl.t.Bweqp352k
 XYoOjifLSRg23BELd.x.aOyh8RQY4EMC7gLXAPRip2ejwwd.Bxc3U9KE53OoYDsN9WUJ38ryPP1e
 Psk36lHzDh0Y3t7H7niLgN.lJRhBjX7p.frdZkqNQDuyNCTNBbqB8RljOBo1h9rSrQsxRTlSzgZc
 yGubI9updUHU2NYe4SVGKRjHXeDmFlzpM4uv4V6tM.GPvS77EoChDvXwraKOoy0i7JmnR3ZLKH06
 b_M8y7FZDp6tQu8Na3wmzzkqV_lEW_zyrybeDyFABqAvj7J1kiL0Zn1oFIl9MYkF_X0tQXPVB4Vz
 gyyobd21wRshshvsefvBP1GNcT7des2RE25ZA_L_7W0Ed7VVtGah0D9DyAQP655p_b0sIk.FugS0
 qeIpylCZ_8n4ovK3lsU7aIqdTslocU3e1cYkisxIjSVu_eiuSbZaKMG4JtrVGdUQCyxsfVcXiOr3
 9kBf.8vtJgRVhcMzqvaT2xyabQjliiAygi30RBGSLhCc1IATbEHEhLz8qCjpdzsWbxWdbaROEMWV
 6YBQwiZgx5KHebGP3Pjor4gmJ63QVl9Z1rKBKx0Ug7f1VTv7iC07zfTCW4qBjBq7L7WJ_NDvBbk4
 ATuzWgs8VPBc46rQ4XdDHwVA.Hwve8xTR6VXrx3g0zRzw7ScwkZe_2X2LAz84MCG9ulsImqALaNI
 2UIdAorncuPFTyDN_.Vq.3Ho_0sqJjAMQ7O7Isezxo6.vigEBEXRf.dd9s16.n_DJwbxCJUt_XJB
 StALaI.y6.sxEiP2UJkYY.FTmI7UXPOC4HoUorudkHLzR4KW5NDGT2VlVz0nIBGXpSzkyCtvlKX1
 n8SUaiXcALwAEmrNwvp.TZLH3yuu1676dNuvZLWJobNhhMH3gv.Tj9YM_r4w8g0XKjRnIhWVP1qr
 qMdS9jYmM41iI5MVAon5iZBS4gyi8HdqCg5.3QULPHpF3dJaxXZJe0x970h4YLSriopfQBOJ.pHQ
 YU9LGO2b0jwyWifPZIRFX3ghyy6fsf28pUo8kSlFy6HZoTwzttaM3.QRcDLLJiy3xTsEgqleDB7g
 YHewfbcov1pFINqYI8aMw.dcA8GyBV0tz.n5mR7PbSN_BllefmQ3zHz0hss9GivYpvvM.9.7WrXo
 mCLG.kmuXRw6Y1Atspz4jbP3Zs17UgvxjsKF2Vm7oe9fcDHvMvDhM4a.7RJKLMye9BB7DZHjGvyl
 O6hpT57l.6yuU4mvNPdo0dnZCHVOPv2jF1XoZm1Bry3sFLsVxE_J91464jBWGLar077Js0H9wpOq
 wYtUbiFuozq0K6GFl_u23g3oeQebSdUfNJwodm6Y1uxRPVU.btBzZz6wHHgrH6mJXRDCfI0vPPAP
 dzqFxdrvexgKff62BZM8Xn0YOTXCxIb887G5CSmEI3p0srWIL_YNaeBJxQfUUpQH2uHAwNDF6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Tue, 27 Oct 2020 21:06:50 +0000
Date:   Tue, 27 Oct 2020 21:06:44 +0000 (UTC)
From:   David Jackson <dgdg41599@gmail.com>
Reply-To: davide.jackson@representative.com
Message-ID: <563947557.3306392.1603832804660@mail.yahoo.com>
Subject: Re: Good Morning.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <563947557.3306392.1603832804660.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



INDICATING THIS CODE (FRBNYATM-2020) YOUR FUND ($10.5MILLION)

OFFICIAL NOTICE: this is to notify you that Series of meetings have been held since last week with the Secretary General of the United Nations, which ended yesterday been Thursday 22st Dated of October 2020,It is obvious that you have not received your fund which is now in the amount of $10.5Million) as a compensation award to you, due to past corrupt Governmental Officials who almost held your fund to themselves for their selfish reasons and some individuals who have taken advantage of your fund all in an attempt to swindle your fund which has led to unnecessary delay in the receipt and so many losses from your end.

The National Central Bureau of Interpol enhanced by the United Nations and Federal Bureau of Investigation FBI have successfully finalize to boost the exercise of clearing all foreign debts owed to you who have been found not to have received their Compensation Awards. Now, how would you like to receive your payment? Because we have two Method of payment which is by Check or by ATM card. ATM Card: We will be issuing you a custom pin based ATM card which you will use to withdraw up to $20,000.00 per day from any ATM machine that has the Master Card Logo on it and the card have to be renewed in 3 years time which is 2023? Also with the ATM card you will be able to transfer your funds to your local bank account. Even if you do not have a bank account, the ATM card comes with a handbook or manual to enlighten you about how to use it.

Check: A Cashier Check will be issued in your name and you will deposit it in your Bank for it to be cleared within three Working Days. Your payment would be sent to you via any of your preferred option above and would be mailed to you via Post office, because we have signed a contract with Post office which should expire on October 31st), You will only need to pay $185.00 Only instead of $285. So, if you pay before October (31st). 2020, you will save $100 USD Take note that you will have to stop communication with every other person if you have been in contact with any. Also remember that all you will ever have to spend is $185 nothing more! Nothing less! And we guarantee the receipt of your fund to be successfully delivered to you within the next 48hrs after confirmation receipt of DHL fee of $185 usd).

Note: Everything has been taken care of, including Tax, Custom Paper and Clearance Duty. So, all you will ever need to pay is 185. If you have be block to send through Ria or world Remit, Just use the $185 and Buy Itunes Card and SCRATCH it and send us Number, Then we can get the $185 either the ITUNES CARD OR GOOGLE PLAY $185. ok
Kindly get back to us as well with the MTCN and also be advice to reconfirm your full Delivery Address to avoid any Wrong Delivery of package. Apply Your Claims Promptly: For immediate release of your fund valued at $10.5Million) to you, you should contact our correspondent.

Your Full Name: _________________________
Your House Address: ______________________ ___
Home/Cell/Phone Number: ___________________
Choose ONE Preferable Payment Method (Visa ATM Card OR Cashier Check):______

Your package will be sent to you within 2 working days upon Confirmation receipt of DHL fee of 185.00. We are so sure of everything and we are giving you a 100% Money back guarantee if you do not receive payment/ package within the next 48hrs after you have made the payment for shipping. Note That Because Of Impostors, We Hereby Issued You Our Code Of Conduct, Which Is (FRBNYATM-2020) So You Have To Indicate This Code When replying back to us By Using It As Your Subject.

Thanks for Banking with Federal Reserve Bank New York while we looking forward to serving you better.
Thanks and God bless you

Yours in Service,
Mr.David Jackson
