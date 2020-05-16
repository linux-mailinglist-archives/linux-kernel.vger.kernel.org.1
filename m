Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9641D63C1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 21:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgEPTT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 15:19:26 -0400
Received: from sonic303-22.consmr.mail.ne1.yahoo.com ([66.163.188.148]:33973
        "EHLO sonic303-22.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbgEPTT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 15:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589656764; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=eTMwstm6FbpEbuHEzkUkjzcaE2uo8cwgDin/zh4McmGxs91UckCkTU/emP4IJBwNfXBi2gwA/NeCy0b5L1Nn8VPVC+fD+zaQSXC2i4ehwGJf5TO/iLRBYleEBmUucYpetaPrs8uxxToYOsr6APmfBXHbWZk1nNSGnBStXSxs8THv7dln5MdQhPRj+Am4jl0/sxXOsJoSElDoSPfIPf96mizZ817e8AJQBPdx/iKtF1y9q24qncIN22vxjukbCiCst3587TBiq1MdW7OXhmwn+wyiOUBZhtGhFe05QqTiGTMK6k4ZEJctoPN4KvJ7s87xr63JYn64ZFP9Z5a91bM5LA==
X-YMail-OSG: sHMFjtgVM1nF1c4Lok8Uo5Ohhe1J0V5dr.CbK7qlVqkh9fk5N7cQ30w3erqlWyi
 P6j_A34NACr.DamOiYV5u.uHnVo9IEQjLYz3YBIrnTAcBfFDY9rXP.tLcQXzDW8SE4_S12VX9Hvl
 99Lxp51sGF_czz97gbgUfS_ElXeP9XaB0DCB8EO5mQBJLRlVxHTIUtsuUUkWRZ4BSwBiAYSgCxKv
 yyi8PsM03IiNg2eAdqpMD6yozfhjsqS55UBEnOLeqVHC3L9vKhcYDV9ilayQdbMyeIVkLokHXuyt
 I_.WV1kdBiUJ08QoUl5m6Xg2WgvoH0HppX5uI3ufsHFaGUrgruWHBO0mN2EdtvtmuaNqR49gG_OQ
 fqp8l3jA3OkRVmzCTHskcMQDme5M3hvHCjOqIzKW7QjNJZ8aPYpJ90RZ12FViT8tcahl6AXhyohC
 G26t4QQto6j2UFz2Fn_XP6xfDdHXm4Ct5sUryxxibGJALL21KfsjIt1lzmLoieZnRZtY69Hf.B5r
 3kRKF01EqElFvoi5teJ9dIHHtP0cPUObE0NDyvExKlHUUUW_1EDq2rsFGyMnORYWzePUk97NA1eg
 RQtFf6xGDSOzMO7WP6F_EIc2AYk.vGSDL2kRIIUQ4GmF7jwgdnBi8u1QFLct9iakkMV4DIzLcQvu
 d.B3OlYTE.b__awuxcLZTAcg1FSdhuC9lPY883MldUZzsi8ESXs9junYsAXNWbHv0vZkm68_aOYJ
 tvd45C.BTVuljW6zEvJ5Uz_v.XySZqggXlzIUG7pZsOQqjN6ObdUJq5GnyNHwo6o9uU6OaqUtaE2
 OofQfIuov2eiAZBFtkEEAE.C0Nd1_OJKL5MfNsDHI2zNSRcLfTOmwS3N8qO1EdAJY8FcSb4fDwgN
 I.0l_u1wdplw__XbxzD62MI9xGosrR9faVZYIfDr47LMb_5VrwX.yYJXZVLlu94NwNNPljO1QeQp
 yvIdrMXV7Si0QglzXqQV1QiU5GB3SYRgzW4dHz_son2xjI_jMNXZ8o2NLPoe2.CJhCqved2WLSQC
 LmJGPoFdXFBWrmf2TCblIKkOUv_smQAyLSxBV4qMHnApks.a_OyGM36UPLFcvvPtWy4hPwTJ.j.Z
 fTdrOaYJ_o8LmnpfFaTEsxyoTOARsbqmkCP2BF.JWLoBjEL74EzBBLGlzi8TSA6GtmSa2nq2mqD5
 kR_M86bKxz27Bdi48fK7XzpqZAg3Rh1op.7qNAHWgl0ZLIblnnWYtZRVB9NhqfSOQKm82o81Lpd8
 J7omf3IuUqA2h35.SnffBMe.dUDEwCqaHuqGwJjtSqNnHjswC3xjRsujEsqlKelXjeaoi
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 May 2020 19:19:24 +0000
Date:   Sat, 16 May 2020 19:19:19 +0000 (UTC)
From:   " Mrs. Mina A. Brunel" <mrsminaabrunel2334@gmail.com>
Reply-To: bmrsminaa232@gmail.com
Message-ID: <1133959927.204678.1589656759720@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1133959927.204678.1589656759720.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15960 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36
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
