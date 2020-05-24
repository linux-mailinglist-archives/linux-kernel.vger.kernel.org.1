Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF3A1DFD86
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 09:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgEXHXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 03:23:08 -0400
Received: from sonic304-21.consmr.mail.ir2.yahoo.com ([77.238.179.146]:36433
        "EHLO sonic304-21.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726331AbgEXHXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 03:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1590304985; bh=Sq0m1vvm2SZTihycyLIp46MmEaT+M4u+5ZuM67ujUHw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=rh6eTGVy7HTShdzErON3/nnCgmZljjcPI1x8e5ez21ntfPYXzJwd+X19X6mIjOgFqT9In7ovUP53MqIRcygrp5fggmnvi0AxjQD8Q4b+0VzotQ50QTBlL80p2i5eq4MF679uOVcwMtcpGFz9H6JxvYXCYB08O18FAqqWdnLGyNlSJ7TrKKnlFg7P+Ag5Nhd+dvU0HemMug8M036dorZcR/LG0WlkMaDXsKhXUQE6jVudntNXsXQ0oDQ8BoIgKbOPUJKzsBnTseCETNMl7bkh18iFW6RD2aeXICDG0B0+JOzNBCtJfCquem1LrhNrmBFiK/HskhscW1ue/GUQk4vlgA==
X-YMail-OSG: pqxvxHQVM1kMLxrEweZC.O3nGfGh7o51M9g1dMJABviSc2J_ThaBq_4axNxfd3u
 curVuix5O1sv0EHex8aADZ01Vb5BB951X99pi8ixRoXmEZoMcOKpnHweW0mNP8ocFxTdBguuoNt_
 ONqemvJHJJUODVHmyhCqLDeHwvi7mLtiMmgqmMuPCFm7DU7WYnIKAGA_UzLKcoGBDa0SPqFwHN3F
 62b.ArNRQ8Y4Pf_vrk1vjhcekYx8WuqttIgixyiukm5zniiabCghQdoj0EyJrfqsMLLhVJMdNBCT
 MA1QYIFfIWzAMiX1a_vzeX02kOP95hJ2euXy_dYfgKcZ85kbDi5gKp74fusrs2yVP5AE0GcGOnLv
 EUcrqwYTq4zfFP3iVO6Lk1c1isTQdcz9qGgYdPmfIcqYNtIKIIK0z6z6WKSS6f3nuJx8JeIxlL6f
 X.oKnaRpB_p6qtObB488_oqP.dkGSAnMPGuPsGUsyX9fCcGX9rosclj00_vxjx1UNtMjJhzB4imt
 KeHUJHB.9JWkIk66yk5qO1M8pJCKssT1BpRQWKnhptvvl3qg.HJpLpZ_VjKplO_5BsuelhDTPgt3
 kawweCfIVqtIOarvk58JE8D7WkT.jEnxXVojbYc9OPEQHD26uStS6USCOZmFqmxxpZ1M3xpxIkfM
 sptEr7K.9J1Yr1rTEDBblZqd12tAAb2XNIO1qN7xS12TsQYacbQ_7Dp6QLoWVcDS.xdS6Ebr1ruu
 vpnS3Pmz36ItKeueIMvTHF3ge_XwHPI.k9GBKXPqBXDX0g22YTZcy7Yn8nyNu8ahw_cw_n9T2ag4
 2n_jLOfFsU1KV5QyGUIDDu97Ym3VCQ2EIfLbuQm6aJuXh7thcegxHnVr4I1ZcbwXbuQp8pIADqqS
 GUkcJGUW0NwQ2XLVhvNF7TLj.LwnM.Kza_Mw_GdlSPuZa.YQktvW1man_P8wlEo6XUNh4l2eevVY
 djXLB47nmh2mK.BDJJEA.ruMuEoNpvUyAjmygloq6U0YoVJjHrz.okT_alIvGXkFSSxHWmfhcWWo
 ETL1Fi5rT1kXcsFSHU4gRx21TNqUKaapE9DFfHzzMM4D.mRgtZFYLudCfeG2MgoET8iEHHhzgRLI
 r4Ld6KA8SwbWYarOqFeMrxTtappnw9qBGby_IGHMcqj.N1PRGNDsA2uwQHhblAWuBMMXWYtET3fD
 QEQUN1qSQny_Yest.EvRux1VCLKyvNO25Gvx72fKB_CSmYqXS4UPmQE9Ze4slGcfU7MHF_J4avn1
 u1.Clivfl3BnmB1mTzO6opg8yg12m4lUtjs6s1xHXPb_h6OU2QLKZzUGa9f_sUjMhseWw
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Sun, 24 May 2020 07:23:05 +0000
Date:   Sun, 24 May 2020 07:23:01 +0000 (UTC)
From:   "Mrs.A.Mina" <brunel.m@aol.com>
Reply-To: brunelmrsminaa@gmail.com
Message-ID: <328082788.4275567.1590304981546@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <328082788.4275567.1590304981546.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15960 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:76.0) Gecko/20100101 Firefox/76.0
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
on Euro) Eight million, Five hundred thousand Euros in a bank in Rome the c=
apital city of Italy in Southern Europe. The money was from the sale of his=
 company and death benefits payment and entitlements of my deceased husband=
 by his company.

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
