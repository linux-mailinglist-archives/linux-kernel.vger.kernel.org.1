Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7ED28FC38
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 03:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbgJPBZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 21:25:35 -0400
Received: from sonic311-25.consmr.mail.ne1.yahoo.com ([66.163.188.206]:45895
        "EHLO sonic311-25.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388752AbgJPBZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 21:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602811534; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=O4SOTwggkxbGZRCEBQdYM4Y5ia8xrLY2dPObp7VBWQz3g/TJrsLpVfru/Zwbm5h8MMWxnWQFEOYKsaqWCQoWiANnxbK1629a3om50b2BzfwJldnN6YkEyDmYyWutzfhxDwg8hGrdvCoXmBkqEYUm986tLFiJIXkzUjgmuQliktcRZaIE7NZ3JHQb9B/gaL/MhvW+42MJmfeVso02kTRu74uv2CUyXNZSKNKQew73naIxDziU7uRGRbHiwP2KiLvALvDl3ksxs94SgutoOYSynpiDbJXCAtL5BLMtEDTGvEe2piguwd/2n13cnC5javZr29p49S1TVChi2bxxWCcMzg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602811534; bh=4CzD1PkLeZNZ6pR1FA98gdpP9o5pnmlxrKVENHEcDAB=; h=Date:From:Subject; b=jybkmuIf/DYZEGodEXdpOQKpTh7ywnYXnS8HiuO8wSgLwZnOlAECOPDYzzCMZu797lMTmdzylb7z8VEL/aiS4TEIF9CETa634zc5CkX9VeFcQ/fUHrMTDWhA8wHJnSQfYJlCY5tEu4b6RPJpwhrwrS2YqymHVdqre81XttVh8kDR1NKul/CmxeTD1UyW13kToW+2AcVHivmDaXMAxQVBmCkYh2sHdYK/K+346cHMnvvgEEmYLQdnign3Hn4mrMSGo5oDJVS4kCLxbWjtxDNw+PFyhaC9kyU1PJiJft+jAz0BTCDUNeiW4hNA6voEp2KKFrH3cAvRnuln9+4XoYKXGQ==
X-YMail-OSG: gUgardcVM1m5so9aIgfN3QL.M8K3f64v7Jna3yJqQoHFn4UxfIdmwu76ufHlhVC
 EjduGyPQWolpp7WzqLM2dPS1ySIByqUnOCC7xNSnpoZAXubgz0v7DluQhp4lpFYyypDugML9mWu3
 fJSmFA_0H.hoQ_B33COYzmC6lzU3J2P2BdyxIur2rAe4vKuUjDeQa9keyhBJbz40MyhobncjuRGN
 hZWX8e3IiR2f.PwiU_VJBpJH9xoH5sdlpKOQH4E4dolyGik1yrfTPRGcOUHmv1sfK8Lh30o.Smhf
 c.vQ3eqWv3jryPUSxEi4Yqq6FVflkzAbWEv1dgHsosRmDxj4wnvANvY6Dpc3C_SEG0QdeeqAp1xG
 dHaHwk.T1CRdFPQIKLPMRlPeoucVAX_OYYRxV.5DFABffQbRCc8xW79yZFMaXdQ96QAA_bX7z5Pf
 if0VdYuImBdhsLNae.1wWhrWXmvebhyxKi_1wkjhGNGhRcXxtbpth1G4_mslKmgmOBhOujHNOwWK
 O_op_sQ6wsdvnL3aMnNnEl_lhk59r2nQ_SvUYWTkjPe8hVK7RdIPEGtwFlAZfejS7KS21S43g.ui
 MOTw2gcCERylo0E38G70reUooSgfHnHxNDVJqSgml3_mG7202lXJJRb0RZyzWpR1CwewAQ3rRJbq
 m.Hk2CGCoJ0WID.G92RAEDbhAfPiPN1cmBB4j6ad2gZvxtiZ0lNoJoPEdm4qZkPHZL4hxUAvcGra
 ahaYKMhfAkKy6gtCiCcIOwltLzdNEAKjOIrz7b4fl3aGU958GbTJ54F1NbRxadXNJ.wwjBX4NuuH
 HpThlmHIuPjpYKbami4CKAWpGBVPWVhE7jlquIAspp.FGYQjh2hrWWb031PcpyMRQ3sEHaVc19My
 wAmFS7R2k0gs6MYSAgNFYfM9v0K6xAVedkibK.t5iLioBN2K8CDo8oKoaemR14Qp1ZnB0xIelxGT
 LW3lHfr2c3imGNVLgdFCnRb6rLOV6sGjB1Q8qxKHAGuMd1gTp_Q6b2nLwLLhMiTbnld1CWrPlIgg
 9fWYQRzhpsEfolMCj4DjRfQsQcauaoWPikz28h4LrIVezovr1AMA.sUXAdc0MTkBqJdcdNwjWHXz
 JOR80W9zfZA6nU_8eZ7W_ApCJWc3vgvxIaw3zVAsMTPxnkQnW9gZZtm0u_ACGWRKWf.UPZgpMYMn
 ca5a0rmXGxkrvY.LimnA6I4ILL_M9qeKmIQh71EzpDJdKQ6I2BRnQzY9CcSjHyyDgOUgj8oSsw4r
 k0nfGb5wzcT0E2ZsrXdN.oeK0GP1RpqWVbSdcXOknV5msG77jb9MEf3MT09ziso9aIXk5l_orjJb
 PPxrsN8GgV6zLbMjrq1.gJ8P7Aphry5KBaEyu7wYr.CnUs5cfb7Wt5SB_vOsQatcfxYQt.W4.BqA
 PH5GLSvKog5Zn7pHMbI_a.5MJpveg0C0SqbQj2DdsOefdeP6h
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Oct 2020 01:25:34 +0000
Date:   Fri, 16 Oct 2020 01:25:29 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <brunelminaa@gmail.com>
Reply-To: mrsminaabrunel643@gmail.com
Message-ID: <63239677.31209.1602811529963@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <63239677.31209.1602811529963.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
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
