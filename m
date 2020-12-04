Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9045E2CE593
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgLDCM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:12:59 -0500
Received: from sonic305-3.consmr.mail.bf2.yahoo.com ([74.6.133.42]:38098 "EHLO
        sonic305-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbgLDCM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1607047931; bh=0uheJ2Ma86lRYmOGjKZPL53KWrgqYym3ZYzfEsoGXLY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=PCNA3O6vM4nOnlcfdi1P/YnUt4mRZZL4mhcxkDA/PPPwg1YcyFEQvMCpoNJbf/drlux0tjUE4sGx+IoDaY4LIl2qCsmDTlH/MIrcUiR4Aq6SkQdnKgToxPxN3TE3ZbVYzgAkoXP9d1Wo//2ki/ZTPkOa8S+cRQ7s0KSODqIPmMTotl3rHzjL87uDsuTQLTNXEIpoaCAP2WQkUF0NRFbKQ6hDJzwpEWS8Jmxdeb2GI4Njr1mc1kE9zxymrtJajoMk+abhsuzQQ6xxvMXmNWxCscO+3Mw6LhtAqZRgkffo9FWkDLhRQWcSuZOBEa6zX8GyXE+6nIX2puHid9JhpadFwQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1607047931; bh=QMN71CYmroTE/GyQSQakuKSmRz3+6UaVSd/Z7ce5MsK=; h=Date:From:Subject:From:Subject; b=JX6s0bwkn6LFN0tM3b5xh+bL81Q3RKDuCXRnm+bvfE7qRfjpSbsaIjwmn9k1v4mM3stbHQmtcZXKQ+7MC9rFDVA5XUBpUBQSPIjJtDmmJOuaY3aF8ygo3bbHEDjZVw7A5mOAOsEoefBLojV2MO0sKAY83998QjV+Zl5l7VcjefKiaF6tO7zU613CTgV54D4rlxt127Pizc2ZI0WtlO+fe0VCXC7Z+Ck0KOu5AvKgAMy7W2hCEh18OQtwHxe/VZXiKVxpgrYsEeWDfW1j/6KUl5ZgYn8dwTJj7dJ3Dcx0Iq4OhXuiTmkGBzPOhxT23B9HggUNGA5sW2gUaplfygTutw==
X-YMail-OSG: kjkQDWEVM1n4f8esdyJ7BPXty3CzRsbzPRXNwXDaSxL7fQ2vXwQXqXXLAn0p1ru
 ucNCI0FI0Aenz87hijvhYX_h2WqzUKIb9cbIHARuq_frT7ue1HH_4yYPQEpy5D2mwpawtDCYD1fx
 m7MSsa.WutKYkv.1AkerVblQ1rUdJCIu35o8OAZM7sVAPotWKZFTZHrNqQyJFly.6kAjafdmPeq.
 lP8poka6PXRHoLL53lB4.ipSTpvrMATan3mGndtIqrcWf1QEBaJ8IKeoaEDo1fjNj4.FwU.bploj
 15lWKNW4LOwUcglQLen0u0gBuNMvAWtwdlce7DqG7FzTVoLubCGsXDIeys1RfyMtKrfNPk505nic
 TfOBkwgpWUYSWw.3T9UXwqVUZPBeufk95_roOTOq4pJve0ZaYVankOexZtlVJnKuYjKP0d5Wg2Mq
 hdLS3SE3E_D2_4Cb3MmakBvK5Ol3jVIf9xyAVqzprVTpgUGEFkrcd_oUd2KFtILZincn9WHAlSqs
 UeH9BTeTjwRpDTrhG9BzMDnYCitpzLhRSEi4O_GpSPPfyyDRd80AnpTb5rNz1vyr4oQhATBlhexS
 3T1WnFAlzgkSCACKUiyVit__79zMj1THWLpTreA0t3.MpvzCYegM4bsUNVH8m8zD..NQWJ11yuQH
 04c0zQyVvVJgOVwIgiYcm_9sVLRNeS75CcuLE2FEaGzubXtth_REUn51GhC7HF4HAWbNg5KTidlo
 upIW9HRhvveIyCeFQ3X1LDEOV2TqSDJgB82ezSGNPk8bt3ffcjWCimhzvvpmK9uhrP1g8ge4wuM.
 LmlKNXcwBvVmqOKRdTlSBcQ9Yc50k_oxUOShXiFJsag7bp9oR06Eufl0Vk8B6DXRJFtXUsQmjyZJ
 bteOy6nsaSuc9d8YbrXFtppsMilf_Ms5_PGBSDD714_c9t5c9g7lpO0peaxRawib5v.S5.qgMavW
 eRrfqXf7lHZjEb1saEKSg3sMEbrizAm4cEmGFU4fWgdPRfIJjLFyPANDXpdnWtdhC6TIzRR8mgLF
 mhGZXVOfST8GRbL_TxTuhIBIR5CoGeavX83TL6iqkrethzVhHGhlex2aYMHcdxguXHDosOc6JIo3
 q5_vR1yIEWWS80cLYeYv4ZqP_Mxzn.MgU_l6u3wWMKePvehT8J06AcHTpQCiC9gssypJp3ScH_WY
 ohuFUvW_Bg.3B7kWYHl4m0aE_wlJ7lvHBkrNQ.gc_2QE.mF8cPqz02fJkir6nSjtP8y85yFOn0m4
 T.4ydXrMB1_s1Ead.lwLLest9NIQ_qI_Ig76L0JG3eO.3efgkOEpuVNpkqyEVLrQt.27ufyV3T6i
 NbdRaopDXBQ9FOuHtX0kq0guKxjrSI9a3tokWb2V2kAU9J1FotwATQAIhz4RwF6sMg__d4Vtn7v7
 O4v3PDVBO0ISlTZPD77XhNF52ddo6d9vGpCg8oM0pYsE0ut6xoQSZDq0enGpl5OzsuGvz7aXUuKf
 nPnP4gQixvQA4ruoWjAlH19zSDZ.o7jKcT.h0NwBUT.5Aus03ywyWGafaKlw00cDZEOhEJRFtuk2
 ywGHN5kLxklwCD7a52y8BFZAI29JEDHQ1KWNW.MJ_dbOO4qkPwcFjmCpBuHwCT.nQbLM3zSV8Wxa
 kTv7SuUiQfirSxdUGfKyTHXaUOdSgsdQITMqL4l3axi3N4uS8_siD41yYYEza2nSVBtpLYTgLomq
 2VN6k1nlhqQRroJjB4HdljyTGzEPt_NMAYUysLd87Ww.mSKdw3jA4oo.N1n76aVO4AvTNJ2LxRZH
 CP36TgmmB_WVuNRSjnSx0qi4hn848jBH8Dnz83Sc0WTTnBquo.Bmw0_238v8TMHJ4jUwZpjPgZhB
 sMzhP7roeT5lyetAKYn4hVlkAtZEhZKrAk8RJUmrDB2fc0WZwXsh83FSkljYj.lsNQXUZ..OAqvM
 XwXncEnHlyr7eSWcBCJs15UXjn.6gB4C2qfASbxcVYxBe9T93SS1JCMHEZ_SsOhr5k_Tk3K9itDY
 HcSr2bHfKQJlv_bwb6l6.SNOM6roUPk1uumJQ5n7S93kp3tMJPuamxJX_lnOMvSKLxcktIv.sV42
 qkA7an6ItAFNJE2c7V.ExyBFDXLx.l_6JGoCuS0OHqOZCBIDRZz5_VjuE0x5uIutQ_T9.7vPCdtt
 6Hw4VWnqAnuaiNxa0yxdRm4mTiVs_kD85cAhiFmTD8.Kh1PeK6NoxH7a7OY18ENdn4CLQJKyC5W9
 7CAtPoJ9fTS9MJhUZH4oy5YkEbGSjVxUkisSkviAqpd8QyaC6icVsGeKgvY8mfi9LhyE.bk2aE4x
 pucKUNI1uVg89eT3fXBbks_yGWNXIE0txn2L5E9dr4f7mRFaUXiGbYOHvwek9anMZ3xV68fJfSUz
 ipCzbGCJUg6Mnzg1fWqShv48Qr3xSAk5c97Yp2rTGOIWewIBWJKZcbXDrKf9AVJbAyAWlB1K7WtY
 hq.nz49EiRLukfgf8Z6ydDhssvEkr14wVTeGl0__lVbYxfniFDO09CbwZZ7aazPOy1cHsZhlV6L8
 3PKOL2yucnlZOMPqji_jj7tnXqGoTx1Rg6BuP4tbk9KuXiv0rooREmckwbWxR.JSPfOCTPFM6KRl
 6X8ecVV.8vwDV1Zc8bu7lrMCCAAJzUQ7tqCzUXyELoGma03iWQb3UaBrmkIIfymVREhExKRdp1Vo
 V.Z9zPxrIS3AIztUVhLDDX4jI_xlwJMPWGBRLdaYtTRoIC3sqZwSTefC8HiinMIgRLCUP.TkaPT5
 7WgTkoaB5ssll15QepxhBSq3F.RKxTPNOfGlu5dDA53ikG0fy1U9GkLSSm72da_9JIzCBp8PAaY1
 QlEh0nk.ECxEfyj7S0cz23Ga2sHI595BjS12WX8oFVxZiPhnVzps_LyFPAHDQMBNWt.HXZdk7IxI
 CjRpH1Qn0o9J6DA1fD26ierEOM_3.h8Xlx7VjcrQDHMjvRW.ZnMZyJf44md.l9d9cd0GmHlUaLly
 1qqciocBHox5RFbMwHJMIEPWe4MM4DtrPQMRx4ZgZOJysUN1ICTY6t.KjI7T51X8VThdC1uSfk5k
 7hyrmYJkpcNir_D_5gxcSn7DONz1yTpNut21rLOEGoxJM.WuoFkhtzXs0fnV6oFUmZE5V.Vo_8bx
 pXJ0U8Sr5zbc4JppPwvonGwMWyfPqJ8IBHed6fMBcc4.zl5U42g0vabo8wCb.8cl0C1HFmTTP_D8
 L_BoTwyjUl05OFXIM7uBlwCHbzgBjCjmYksT0eEuAnAdUJILe17VkCcLRcyr0rDR6SmF798gb.zT
 jR4o4VYNQxkgU.kkfbSTVKtPHtMkYIzfCO3tMQb0i_ZD5Y6BfON.jH_jtWl.rk3SxgQkBkeM9A1L
 J_ZiEuB46AapYoSyZ1cYeZk6RF5qdbc6GCxDLkUejF8PmfjvnhM3EjFKHY.6jhI64H0h6UTRyixL
 _Z9qFGDwkP6._X2LdclmPh9ebWbcb5ZeBoih1wZWFWHoL0_cAmB0R8zp9v7MUHyzyXPXJsJ7Xaou
 3UqPOTsFyI_rJxD16WBrigz0rNc7rmRMXiwFmu80MeTlKn9suloJuO1wIg264f2bXOZcITBP1XLZ
 pTZ7MG3YGLUv07.xteAowtCIhyN9TbsaTqIxw6cZP3_wZOABoHZ6wZyNLMhVSYmd_oGOKVDUg_uv
 9i2_LbHNmqkE7WVyjBph9rSmGwlqAZuxL6hlP39rT7pb64pzMl0EK5mTOAlQk_0I0qHuVo_oweUr
 LM82uigzi88fjI3DZqaHRcYO44Fm.IQx.d2CpxTh97SFHjP5h.FzaOkiJa91a3v4mcXMiPuur2Po
 _kvnr8QZmAZ74g.Czx6DJR65t0N4b5Y147OWAUt.lFHfITJrVWQPxioqi4oy6d15fM21YpnOSrbv
 frsMHFHTM1ZbezfiqhfCn6qaW36_AkMWsyMUJ6btp4OKuGXMUfUkL_65eki3zfnEZDxGP_zuFJ7Z
 3FUQHnaROI9.w6cGmgdXso4uY5M4NQDfK39JN5rRvKwikjxytK5wqFeTr2BDYzi0ZYjsUCDQUO8R
 cE0H5nPIPufY6VwuAsS9s7FnvXPiN9BcJ94Ah9zIl3lPLHQrUHvL7BdQu2DyK9mzuAB.IUWy5q9F
 r6ftcZ_OnGxuimwkAhVq0suWuhi1SVMjalMD7CwJ0H3n6CZc6vPVEJgC_RHN.w_ZqAtktO9VdHGH
 RQ4r5Oq7VvipUpdGBg_KwdD4T4SO0wEGrNXNce65mg81c4ZAjXgzZJJ5R6D_AfyBwMC0H06wK2D5
 RHs.H4ganPzXCnbLJaFZJORWZ5zAB8jraJ1v_XFjnKRIEbVFy1yBD00nTwhZED64DqNqzLuxsQGx
 KzznVCdr1nXJKmEYYT5rNxE2_ajFTb_0.uElFBZK6zR2f9fW8.Ccfcm7NNrAKJ3eYGeLHFZXQgEH
 m1ee_CT5KhWKQVfq4wLilEZoJZs3kql6Ddf2kdvxEvoCBnWJveslYhgXE5WDoRtSj96PPWMt9VfD
 nwaMg0LQrcZQmVpdLYaOqle5BSFIj8YMNuq1snW..rwAPNYP_LlekWBt_UxrgV6N27AN8JJG8qlW
 H2lBq7sBZMMxyWcxZ8fiS4Jw3cDEOrhijF5Y8H9kF51vEnQ.dsz8_2qLsMgxrFVATL3I9voVCKcp
 gt_e1JsVkemDUgwdAU4NAQixgMbeFmzzwZQVOipt4mNqxw9FA0xZcpb._Yme2SjmPNMC0cbpHp3d
 KBgOm2Pa0gKP9JBJzjlkpZ1d5r_cexffoqNU5MECXfWTUJG4VMLa5X4SjzqqVTWfqNtidqyGVyTU
 mwds4.fwfZCZ71fndlDlIEfV9GCcQmGEuGHYaIzS5QBedET1p7pah166zdt8pPga9jkY.zdf514o
 KgVtNt64O69lOA_geY8T.0ViIf0llzR8s0weU0prGeP.O.AFCg.Cyw7V4Yrc0wAhhjGOmch7zezQ
 XPQ0DbDe4lRIxM3kTm2qVWK7LfBNVzDLXv1SYp76zfN4MlTdvr1.FUh0QRgmE3if3mWy61AitUqP
 noqlTYOfxb4v_xCCdeMjuiFro_7qEWjsJIfHekDrG3MWBK54vdlETFhJKBD7dsPWqtF3HtSPz2fb
 1z5xP2KmqKjkcdBgLkF1VJ3yd1ZntrqDMl9W46tcfbP8sM4EzAdveKvjS7CmwtXEJjReNxe2Yul4
 asXImHVx2.8YUb3ORtFibdLzjEI46xPqYKIz6MlEtRIz9vCNDtAg.gIjUmjxyR4_O57EvHqWDM5F
 luGoPCQ3UK2LxhGvncDPpIsjPnbHvQvmMbIBdQPlcjcs4X7BlkEpEUi4UT1kirOgqqzBdiTisl9s
 5lCe36w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Fri, 4 Dec 2020 02:12:11 +0000
Date:   Fri, 4 Dec 2020 02:12:07 +0000 (UTC)
From:   Rabiu Usman <rabiuusman@barid.com>
Reply-To: rabiuusman64@hotmail.com
Message-ID: <868866490.2735621.1607047927901@mail.yahoo.com>
Subject: TREAT AS URGENT PLEASE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <868866490.2735621.1607047927901.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.17111 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend

Greetings,

How are you doing today?

I came across your e-mail contact prior a private search while in need of your assistance. My name is Rabiu Usman I work with the department of Audit and accounting manager here in the Bank of Africa, There is this fund that was keep in my custody years ago and I need your assistance for the transferring of this fund to your bank account for both of us benefit for life time investment and the amount is (US $18,500. Million Dollars).

I have every inquiry details to make the bank believe you and release the fund to your bank account in within 7 banking working days with your full co-operation with me after success Note 40% for you while
60% for me after success of the transfer of the funds to your bank account.

Below information is what I need from you so we can be reaching each other,
1) Full name ...
2) Private telephone number....,
Receiver Country..,
Occupation..,

THANKS.
MR. RABIU USMAN.
