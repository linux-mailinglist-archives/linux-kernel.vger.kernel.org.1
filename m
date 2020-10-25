Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB6F297FDB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 03:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766671AbgJYCCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 22:02:23 -0400
Received: from sonic301-20.consmr.mail.ir2.yahoo.com ([77.238.176.97]:39311
        "EHLO sonic301-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731970AbgJYCCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 22:02:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603591323; bh=fGEdRHdSxtgHrEYIUKjDRsORG6E5FHY7stN2gc/nk+M=; h=Date:From:Reply-To:Subject:References:From:Subject; b=ABPuCe1BZmPNm7/UEfUJODUVg6nHhvtTDp0d3SoePylyL2s77WI61A2renaJ1cGrdS2xy04GUlOZV4W5Io7PvK8ZLYPS6SVOZXlQ1RnnLOsYvm96GIX7qKxA6HCQ6CMhCRi9HWiL8pVgQX7ew2x5wBm8IX0QcS6IkNf1iNV4sj/Pt2XP7YxBMh984zQMzwCZFs9za9B8aH7o7HFWqMAqIFWtiZKCrlO2Z4G4z4HOrO1CFfTJCAXc1GoLISKfTMwnEJr3YVBT2dN0iHag9GYBDGgtvisN/Mx1p8kzqZVO0NUBlOw7B9Zb6Zi8YmGYXE+0fACW0OhXWTs1wSH7UysORg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603591323; bh=8LbZnPDVQKKbMM4xJ9YqvI9+B+DA+1QoooxGCh1q17i=; h=Date:From:Subject; b=duhMCPw2Y5oZc3dd1vjoeieJDoayi+hQBxL4fKKIYdhk5A8Zb/OB8ByJzcK4P1ee2qDPk6YTo0MnBvaN1cv4BQZ8vs/J7SoNfQIItrGbtPRDhN6hyRl3KIYzcJTuWvUQpVgGFJIUPM6C0aCm7OaB4I1M+uHzAfm5Cocuft1UvC4GiI4Qgq4OZotZANGLGC7ye5QC5Dt63FxE/v78S2n5fzz/4sahRjfX8cRKGg600GfzGjd1u6CD0Ec2B3JYIyefC8bNko9lRs8YHyeVSNJCQD3SIzjfkt16Vy4Uu+cgRJvJgHQNZJBr1W7/aiMQc8L73MYk27UC+Styf+nEb1JEKQ==
X-YMail-OSG: 2jWNxBYVM1l5MHg4oDH.QDwsd4ju0CXS3Nt7zXPKwitxbUhWGrUslWFyzZH_3xF
 rmFSBpOxdXKn56kyj8q216swrWTTlY83dJR34yuQyi82IUU8.fdZ3aFk9zBD_pUa41d3sUJZLv57
 B_.rWgArdNPk.vQHebL9A7d3Lvh5oiXeYz.vcwj5FHzMT0XqfUXN.ktHSA4u2Xjcux5wzHeqLu4h
 rSdDKTvIIkipcgrW2bSIhFh1PXzfr31GKgzFdRqxwFvCoOSEBfDXQxtr0qJRDl7ZtEw3czxoJJtW
 5U66aiyRl5IZ1TV_qCSVEXScWHhQULlYvBxFujUJYArgAAvIelaX_ileDKitra79OqqBfr4XeGVT
 5XfYQuhCx.LjluTv8YDcpaSIyiU4Wz0Wbc3jzcF1RDWJcng_0hJWCHt9Yy0vgeAwqzuW6cY2ZDBo
 GigFs1ElXe2v0OvAYxpky.wwLKR_VNWG1KgCy.GOMUcTPFAMwg7qwqyz0pl6HojfF4xymWH4JjZq
 yw6Se2nw_zq2kBhl3kH2Yho0UWAkuN0DvbglaC2i9VYE9qZjOtKLjbaWM9M9Asdzx3I2oE5c6vYx
 pF4SyDWL2QOy6.jqHmY1W7IMz9waes7oJtcWQ68z5oFBlv82y5UJPE5CMz01WlFatk6z1Fji0IY5
 SYEW5u9GoFnAfz0PSkVneiOx3MVQH_ADyQ9feMD0vqNFo0LdDT_Vv8zFZRFpgX_WZg_s_aKih2ct
 vHZZ6cvdN5RdCRXdn2uGx4sOzN_5rs.F7DAG1HqQmvENTq6ZFdafejI3eMqpxhgI3IfaIC5cj_Qx
 H1jW1BmAMGiPpFbgOvlFlf0f4yzUHqyyYDZb5U0W_y_acg5iEH.qLQSNEsyV6oWAo.FLwhrCiDen
 9uyK022ARiNdzwE4CK9Ylbv89ZwM48wvPeCTFctY5O1SiJPx4RfuIqE5gWgYfC4eYVdEAbs4QRT2
 V29A97gz0yTu16khLfbhC5.Abzh_9YQlJlz23ECVyjwTKdFTaW.7yvO8SyaSBYE_1WJbNaGCsj5W
 qTcRuY.OpMRLuK6VXgPyckaf.H.aYKguGgZ4aNXza6yQAdYKqWTfrLnmQMXCzhCGZKDYmAoLidNx
 9ZVk1ZsUxmPvJgezVE.jSBIAg3hbDg8Mxf5olnLgbWIZLXNgplV8Yvxb9dAMvo9jE249jCVaVMON
 w_Ipmr37JNTxggOc.l_yAJBpIeXhI6KFygsCe.68m6QIu7M_qKN5jcDZohP6EZ_WZ2I9sq4p8aGQ
 0kxRKxfRoJ37FJvv0xeW2EtxfrhAbAF0VFzZlTYG9mX8795gzoD6UTDcsbU.mq426ayDrO1htGvm
 zVcSC2KvYt.GzkTr1VHPOEN2e_aJ7ztcbhM.TR.piDlmIaRuh_o50HJXW7BISQi3sql.DEZqr2TF
 G0g3nUIZ5w1obdaqkbqdkROMgxxLosPfNiLtCTks_RVX.ilqmIfJWSZOKGey2XuPyWRCgqgHIlSI
 06MCW1MNdXId_ymxwjbxO4mXNZ.D2d_0fWFBmdNYbZGL18EiJKxdR1o7fdpL8XccnknFQ1T7z2Lo
 i5KA0hJC9_M.ch51EcM7hAR0F2LE298cFV5RqwiBNngp4pHJpwlP0y61tkV4SSOm34wAXF20rRwb
 DosSH2kBwoDb.bt2Ydks4r1Y.RdX.LzzNrBUqFcjp47MDnLr0RWSXM5dIyH_u9TLYQwBgizwgzOm
 tQe7ymu0ELFiXYMNrdfeh_UB2CRKphrN9uNpyOj9ErTrTGbLFbsxxy8xgUjMI9KAm8H7VJW_Anq.
 nCewXf9pTFKdm0O8TWS7VwN4khnz693.z8vm9paOgWRkjbYPeuqghYVxr20vi5s39Ont3IiOYRg2
 p8rqk1GNX6q93PFMMyXZMw0cX909zijMvmgTTEDW45XrSPK..NTlao7RK77AK9F3yTAWAn.ufjB9
 cqDlaqaVS9Dmd_mE5S7brKCElh2taOoR.k6iq5UlRuJBfDjHP02Ap1DE18Y4OCkosy9VX1nmmWNW
 Qkz_fi2vdyJn7_dUleCY9Usr3cFHSSMWyEG5z3Y8gGYAJUEIhE3cdM6tLHXenBQumo9lYblTEjcQ
 RjqnTvOWD3JmhFGH7KiJNRt0eXh9L8VtoKmeVHSezN21paYnkky5XTPxAxpuc5vZ_Glc2E2mBeea
 rleNZjsNgSkqiq77WjVtIMiN5du0efOKvB9GPUVND7E4ku_TH0APhrQozjfDBZpFqO789zLlJCg8
 pPLQ92ho3bXluZ8aPQ8M3yj0iRc8qjWqfpR4T5ddsMi.qdzvGYuJep6F7CCSpdlbNaLjcNYWrjSS
 djgYBUBT.JxrdruPJCjBDJ.Yt7Sqz8SaBtkMBctBn5nFHTH8MrHGWURthbN2xbVjv6O04kfbO2lN
 ZC1p6uvJvUDrYC.h3ZsnMJZSTT8UgrkdVvNBbBUddGasz9NyzePvbGkZoGgOsF4mPW_eNZ.jzkC4
 .2QUyl8Irp3KkLxmH6XKcgG1IeKOCKbzX8pWKmVSTJvdbUQHuVZ23xCfge78I1chWX6jx9kYWHdS
 BlcmSLkBNrUgW2pkdlYVGtW8DVEN6tL5GZkEvnGqGe8h9fcN.6ZHkd.EuVwh7jwE3qcFYB8MwKPh
 U5NZEDq1ygf3yHKp867ivdmBNhp4zWGD1LIT_07TRIJl5ZVjnxtbFUvMdctIlgg32RiolgyUu_rZ
 2c4McF7hhOf_tWfJpb6tLZF860WPcJgQbM9LH2uUbi89I6CagyvhU7WDUe9BlJnI83wMppZcXitR
 wJXOHteLlu_nwmtJc6Ppglud6ofBobTvZG4RsWulYbskhQn6Q11zFhHmHLiRDg6S8Dy6XmwYPvUl
 argXmRTOtvI.kkna4SYq1_Znn4_nqOqJ2nMHyUL0DBbxU2wKunEb9G1ApO08D8xrdDrUkGyVp_tm
 J65apvB1umubeCvIK0VGI14zR7396oqragIP0buYLlz9hZh9A6gu0qG4DvDoqwCs6ip0aIQl8SmZ
 WYJxz71nEigPlh2omxNGC3Kg6DTIPTyMr.CwgcEF62yX3M5_1vNw7ejmWeQHOEuzRxrJTJYBd8BV
 4kswCQbwoWGX8Xyaeo_UqjtnkosPZLVxGxChY7.RsfWxCxDd1mE2Johu4BI_WOatpJkM54qfkcMs
 5PwvnQVeXanDjE8l.M6PfoE173.WCWdk1kJJ0b4XSZGxK3iM5HiYPkit7UkdZQx.83xXDXGfssda
 Zq9q5pQAN4IrXYwABmNccorEHU1QVlZetPRyrx4ii4ONn5Z97TO_HSPesIs3_SC_qfigHTKEy_EI
 f67MwfDj5N_XY9VzL8MB0i2hsN9_7ZHtC48b2L5BOMiVdWzHoi0ppbal6m_oiIq3udpJ3URRfmGs
 Euus3NB4RoEeecuJ6Wj0CIwyDAvtpRC0lgXN9IwgC1VMUMifyhlAQakwtXGN_j7hHM0Gb9Q2kVEQ
 qXyKIOVbngpj.deD23JVTiSsU4vAKDgFHrKOoSA9lR9fEzSAlWGGRQ_WkSbyf5z.geT12rmzsV7P
 _eAz6IKa8Ef.p8zYp.9wgHfbqYdrnehf1rtPul.aHR_5QpLpJxioCNMcLDxEUk7ZOBxkCcUgCidE
 vt_mgjma9s7sp3zuZuLKrpldZrmtTIm2n4KysBEgBOR31rI44Hs7pfYzrDfgPSE_MN76_lOyQMvj
 RaFVGN.WsjCBN33lHXbPDqnzyE6QDzfzSoXbcsun2eunyShI_n4QA4vsmYYsfKxq65Q6k9v9dLCY
 8GGtTm6QRLleGtF8s9lDf_IVdVdIzW4Xgdde7ASg5lJxCaigx5KZ7BCAW.ieMZIwldq1lkKBORkX
 etP0t.bQwv0U7scxaMuQzgoqiSSP3JtrQpqulj_ap_t5zbnvcJjDvYRtntWZAmijFQflITuCaneB
 mq2U7AV8bGLG_IEIV9aOYod7v9S8tvgcdAyQQ6gPpZgAck3cEgRjGy9ELOX3t8PW1zbqy64hgXVb
 0it2VtG4LC5_oOImxuWbTZ.vLyLfSUifwXV5woG.hTtCS9akU7P0ERKmDUVP_1STAPzQCmHpN9A6
 UD7GxlC4ai4dG3EduCKMTQPDt_20Z5Vvapbx4RHiNUdpT6rHer9d1XravKUdS8GBBkiGaNwIlVnO
 6Sh.DWymHwGBoqnamtgmxIe9o9FtHqWFAU9gvsNeJW0AbybiyIDpiR8zdpvZ6SN_Lp.KeKQ_G.fI
 uhitflD5q2OBqiqM6JSxC_Qt6w9JUJst8FO9asyd7Zu3wG_Ota_BFhFHV9MELRrHKhbbNO5cJCgS
 YqVxndH8FijIta6RUDGQtpsI80hb2DRK0X_nOtxIUH59wj3m3K4GV.kauEMvEmTWLl3n3QdTT9gT
 Ao_HFLkdiNvelnUzJkfySvpuoj5ktCGdUwlFLdWVZaINoli7e4dt5OKOaNoPiUBpnbIbK7zZwNsF
 nVoRNuZOYXAVJhNWkPLM6G7zjI3cqxLsoxSVIU2peipZuqEUlPyOjvdPkbppxYZFoE.9.O93sG1w
 kD_XA6b8Hmvc.k7JjBU.OYw2L5PS0AZ6lOIVTO0NCjJ7RNDHr0pFM4MWGBppl1Qch7HsJHdRx2Aw
 AwFbxoanPMoGprlyDYG2YZCiMlNu000DV0BaUTYw6gKQD5pp_YDY4LCbo4t2yqDa1xhQC4Rv.hFi
 XKgoaG2k43dlMZvJKzAxU6H0skSvWYL9BqOJEsYn0Ughgtkj64sRkoJj.e9JHtYXei9kfEi7jeSV
 qGNSdibweJhY4Tq69EQwKL1s41CjAYG3rgzUaUPHSC6QrvZln0rlFAs0zFBhQJIXtlzgJ8VlqdlJ
 Rrpo1inkYoRzr0ReiRlYbSxzK9hU5zPCaKhHxMWLv7CbY8GSPunebRqenQctA5jMsZxSYLrIAk47
 hjNyEGJguGaZrsmXOE1pd5ircchtGSvW1EdlntjTdAPGLT1bjC7ouSImJTIHxwMv_dQn3hud0Tv1
 FqMuYoZxthDKK14o2WviJUlL1mRcx5e5Gk8CNa91ToAUSrSIuevjT8HWWCv3DRMaN1tPX8xYgyU.
 ERY2Aw1GfJ7Gw0rpSVsK4DCDfEh.rdK0tIG4dq5npE0oyL6Qeau4sHhjFQMKJrOueCv5WW9faldX
 VuG7_LjHSTG5nRp4UJUN5pxs2FsStx8pbzM5EnaThkY7daBe9pmyRcmu6yfpiPnQQyf7bqXMRQPX
 YdW1d2EsgNFFa7Sqc3x8jVzTBZBCLzSkxQ84fiVQGypg2njSjjjENq39QiyIda6wdDVA5l.qRY_1
 TLu6A6phEToriQ0mnsybCZu0VRMHeR9bDzR022YzD49MJ_7vZA7bWciE5CqQAdW2f45XOqt8sqjx
 G8exFuDp_LvhBNCNtKSVqYAJaWXDyYeP5.fyAs1RWcSAcNk_wf2lHQqVurJsczqKUnAxc2xsS80J
 I27.HzcijXebcjSGSrgN0k6QAxNusaBMEmN8JXdqb0rD5WjMC06wk3iOPjaajA9URyVl_5c7h.Rp
 QXh6FeEjvShreBBP0r1N_EeuCtO3pbsLFrefhogTTfAhdWJMfiTl3sm.QPB6HP0N1XN3DxCqGz9G
 Qya4EwEg-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sun, 25 Oct 2020 02:02:03 +0000
Date:   Sun, 25 Oct 2020 02:02:00 +0000 (UTC)
From:   Katie Brianna Taylor <katiebtaylor8@gmail.com>
Reply-To: katiebtaylor85@gmail.com
Message-ID: <198470473.4783469.1603591320515@mail.yahoo.com>
Subject: Greetings,With due respect
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <198470473.4783469.1603591320515.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Greetings

I am Katie Brianna Taylor and I am American soldier attached to the UN peacekeeping force in Afghanistan. I am the commanding officer of the third Battalion soldier regime. As you may know, everyday there are several cases of insurgent attacks and suicide bombs going on here. We have managed to move funds belonging to some demised persons who were attacked and killed through these attacks.

The total amount is US$196 Million dollars in cash, which we shared among ourselves and I got US$8.5 million dollars as my own share of the fund.

Now my mission here in Afghanistan will expire in the middle of next month for me to leave this camp and if I do not ship out the fund; I might end up losing it, because as an army officer, we have no right to take anything from the War zone, nor we are allowed to make calls or to make financial transactions.

I want to move this money to you, so that you can help keep my share for me until when I shall come over to meet you. I will take 70%, while you take 30%. No strings attached! Just to help me move it out of Afghanistan; which is a war zone right now.

I plan on using Diplomatic courier and shipping the money out in a wrapped big envelope, using diplomatic immunity.

If you are interested, I will send you the full details.
Can I trust you for this?

Please signify your interest including your most confidential telephone/fax numbers, home address, city with identity card or passport picture.

Note that this business is risk free.

The wrapped envelope can be placed in a box or briefcase and shipped out to reach you within 72 hours. Please If you are Interested in assisting, kindly reply through this my PRIVATE and CONFIDENTIAL Email (katiebtaylor85@gmail.com) for further details.

PLEASE, TREAT THIS PROPOSAL AS TOP SECRET.
Regards,
Sergeant Katie B. Taylor.
