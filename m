Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE372566F1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 12:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgH2KzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 06:55:23 -0400
Received: from sonic314-20.consmr.mail.ne1.yahoo.com ([66.163.189.146]:34368
        "EHLO sonic314-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727952AbgH2KvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598698264; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=p080v+CJ0aq5B30zd7V3YJFhnSwghbDQiO3m5S7N4UBsZDBLse+UsXLjDY9zD7H140WgegF6WlP7Emf/KOuTpmsSHo7MutBK5sb6rpAuvZGZnLOAEFJJBUx/su2g14llR55ge6u01/6l5fuof77EcPZA823aeiObDFuZ4ntwK08zC5c3ySb8K8IUQapP11NUAkQ3KdDM8TGF2uhJIJeoqcfPp4W0z5k+ttdbBQhPuJt5y3jMUWiUiSiT5eBlo3Tk1XxwANA/OSvuVooSJ3c7xpLVogem9sitWNoAXNkWAxXb64PdQLy0QARBqDNcvpy6NAm3gC0C/J8RdW58niX7Tg==
X-YMail-OSG: CCpDFJUVM1lfV7CyiGzedkFslOlJkTryzvD1WexmOcP981nJtGvDHm2QBb2UGpb
 u7iJG4aXEsTTO.vfNEZ8gjrZ6GTXf9d2G804rlZ_FbsHB.15N5eFV0HInfoskX6ciZQ_BlbbZqy0
 45rrYABQgglWsjkeVWRSqQrHBM_Qc2rJdzT.hAszd9KJmSGDahZSUzoFTyOsz7d2RH1oVatKCR98
 DvDuir13WV2FsNk5VUCfTZ4.LE0_aZt8pnxcPfYLilW49SPVOtSIL94TsePo9N83eL8FpP.2RtlK
 d0QobPc7x3Z49srETQ9wVIr1TC6h7gzhSus7GRnsoT7o.y4cxx_YlgdfIALyqWdRW7uxEpDbsW2Z
 MTRu78vr7yG6fubLuhpym13MguLh5KwQBzAH0b1tziKuhi_q_kPB141g7MUNwmO.sE1SaetVt3Vu
 fyTWwU6hpXGHdpmSapMU8Wi1HJWf5wNcexRSjym8ViJ7oii6Pn8KUd__.BUxVakwq2hS7H3TTwr8
 _3kYh3ec.gjmxE2j8W6rfUjbNtOKo2BcDXxSpyT0JoxoNqyz0MR8MOQ5tgGFH.7Fk_3TM646_yz2
 2Wqqd6IWCr0ggjez0XQdXx1ddbqwRvpVEP5a8YH_VF_jkKbbxfChy4W6aU8NVgxgfU_pCBA1wIA2
 eBci9BYm.QkfGchirdq_VKjuEAjeJZ.qJjT1lR5.n5vkTBf7h.KvcOoyiY7noiTm..dViW7hptnJ
 .m8oXvKHIJ7ZZhd.2Se1TPZbvcwPuvTSxhVpltyFJE3gAt9hoNHj9gG2TYhZSGDZU6WqUO1ua1WU
 vSj2NJk_nUm2Hi9Uy9faQ5s6gEUeVW3JZVil7fxbOZ.iySQc88Jf3.Vjp2uuKuDvhoagcp8dySks
 8UH64bSMD6DWIlT.cN_pHcGdSwlHuCXCmlvKiLxgUvCR507y2Uou_rjjPzWBrDLnYvHbNEcy5LCv
 oPtv0kq_WxqodiPeneQm3BBqatDMc4_TjRvDB.MpZ05b4dKNPh2nN1YeACgNSGOYgWpwUTNXSFz_
 7uostub4W83r.otQMPAgpBdFQ56._b913SJrNnmM77Pc31HOlF72JagKM6lh0jneSBAHbN8tBNSY
 nIUWUivjuK0ljUJuTkS4ak.Kwac0pLFqHfILW9yYMWz6Vux_8X7eHbp9psCXcL3R5bvhamw3e3SH
 nYynHbEoG_JvEFNc9c5SEr0cbRfFguzroXTMayyHuDLcVxHQvkPtOqxfksj2nOaAo5npOhQwyHFl
 fScGIp0aE5JUyo4jMiH.QS8g6IzrAPJvDbx5ZJBXYE11S8wF2VWqmx9FYgBu.NhfLf6ZGKhZWhZh
 8mEkJb9snbYjN_DNiGn0USPiesP_Wl9pRy97zPjgAc3koHkwURD4iX2ZcqPzIkdr1RNTEJkTg.qx
 SufVcACwy9waxAK7Lljy7AcMmCEhzMGBWQy.qBB3wgw3NOz914IIIHQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Sat, 29 Aug 2020 10:51:04 +0000
Date:   Sat, 29 Aug 2020 10:51:04 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrsminaabrunel2@gmail.com>
Reply-To: mrsminaabrunel653@gmail.com
Message-ID: <1508740726.102031.1598698264369@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1508740726.102031.1598698264369.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politicians who owns a small=
 gold company in Burkina Faso; He died of Leprosy and Radesyge, in year Feb=
ruary 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Milli=
on Euro) Eight million, Five hundred thousand Euros in a bank in Ouagadougo=
u the capital city of of Burkina in West Africa. The money was from the sal=
e of his company and death benefits payment and entitlements of my deceased=
 husband by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
