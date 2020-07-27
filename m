Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5A422E91B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 11:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgG0JhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 05:37:10 -0400
Received: from sonic308-1.consmr.mail.bf2.yahoo.com ([74.6.130.40]:36000 "EHLO
        sonic308-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726139AbgG0JhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595842628; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=thyV7b+3pkFv6qGzZR4NwDaj5l8v5IAWsLAI/raZ3iONUKMp8GWKSaSFXhxmze0Up3JKvF3npZ0LTU6Te7yThbd4ON+SrTT4Eh5O7sLU7fL5Pga7GMZ9WzgMWDn4I7bWc5DY0ULH4kMr2yKM4ln8DInha/ZUNi03oi/IygFK0J2jRn/gx1oegE35WPSg71eGuxsWZ+tkWhSck1+ZU0hQ8+gbcgGk7ZXz49Gv4VuVAQL6y8DXRqJpagiTQqCwUKtikxgqQh5XAIn33hwsLvwH5uU1Ul1kjdWzL/Ikbd/w0qvGxCETvkM/ian7ddZEuNEB0u8Qy0nfKaJFsxo280zUtQ==
X-YMail-OSG: RtetLQ8VM1ktqbUTxEm2Yx.CfQLpgATugY2425UYgr6obh5B1e2LoLS.3YSH7JN
 sNMZ.ot.2HA8UrHXYbH3uKrLnTxYupKvtWOfFi1255cJqQ8_pWahgTRI12MJfPaoW4KiKEe3l5Kr
 ZAZCgCRIcEX3hafjD8vDfTS33TiFnVEe9VTrDIMSDkhLg.CiyXS2HNm3jnpuUBcCkeuuZzOqgpib
 xIJIAwSflsscfZrorVc7n4Ci6014U84..DVkfRa9_JEwFIg9i_9kVUuuc4kc5_Gk80_Mio6zIv4l
 8C12Y6MIfAwgETYCTo5fcWsheOrT.96TrrIFmrZ7lWZBCBjXyC9lzIUZjbblT3xu.B_LnJ3HZ9Ti
 jWhEhkuFpBtZfRGcS8hKVLz3JF3Bk_2f3TuXjALRMT88uk7M8DQD0ggfmUP_XRq8dIBjlFhwwZeR
 CNmCeCifm0hRBnRVFqpMjTO89Sfi_.OxPWmRjCaA3RPPo0fAcfOXVlu9g8B8ZrH5lY1lcedB9iIV
 AjL.L2JAE2PI8JDHBjEjhxYL5z3txK5_czBRSqUPLr0BX_8mGXvVEFoXUXlDRwOOnrR9hS5tKSYZ
 1lY91rHC56iC94c_FuHABHw11Hl3vyT.FzNVgeoSJNCDrIsIe38bE_2.TV1OUJq4IP56fA6Ig_jK
 vt3FhRhNSlspGR.5Gg8b.mquXI_nSa7fEsw8yMmYPEr2oqUiKIDDs4J8AaOjE0EfO7_HToI.1iEj
 tLHaMbO53bavJ96TO1RTT2GnXsmbeS7JrDTT4m7SrKQ7TA0uzBcZ4P1aDwmDgP0AbzK5r7fEHist
 4ClwJb21_lhkjjLrO7Mu5cLIm_S3ydrnNnck3LfJggH5iBe6Rm7_AU8Up5mTDbu.NYqCFinsGWIN
 aactwdT8E8hSTE3QB9151untNo81mmser833ejYrpAod.7ch2kvmgM9BmTNcmvoPyzQQOtl5EuMG
 UmaWazK5zwqtFaJjP9I1paGTg3Dh818tJ0eRIzlbD.J3TsMYZTK91rNcklgY4F6P.jUPqv1i7YGo
 opIc.yAgTJvEO9p3YCeFfWOiiINgyf3pdyOCHtar_FYHJeoK5_ueBG60660slLsJ6DVhmc0T67Pw
 hqLg4r91HycimPv3GSIUaa2AkmSUMv_JOk1_qq.ti3u4nBBuzOexvuh51tMzBtiarNV9NZd_Bf6k
 4yn3G07nsnMtf6KaxjlAgz5MmpzEHH_co6.NXuUpneJb8odFC3GGX0_up5zEYX4g.YNkoR90SuoJ
 3wAuUISV3r.SP7C9wxxbQMmG4uLFvIGqavlcn060qFFkqMfkjnMwXh1wHgs_Wc2Hp3BrJTt1xr6I
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Mon, 27 Jul 2020 09:37:08 +0000
Date:   Mon, 27 Jul 2020 09:37:05 +0000 (UTC)
From:   "Mrs. Anna H. Bruun" <mrsannah913@gmail.com>
Reply-To: mrsminaabrunel653@gmail.com
Message-ID: <191360427.5326963.1595842625074@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <191360427.5326963.1595842625074.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
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
