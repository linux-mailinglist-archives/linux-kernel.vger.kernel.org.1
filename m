Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB1321304E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 02:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgGCACF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 20:02:05 -0400
Received: from sonic311-32.consmr.mail.ir2.yahoo.com ([77.238.176.164]:35717
        "EHLO sonic311-32.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbgGCACF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 20:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1593734523; bh=q1Er/SdqxATomBDx27mJAnsQxxrJWpCL+Y8MaW3053A=; h=Date:From:Reply-To:Subject:References:From:Subject; b=beIagRvrFD6bb2q0xrh9wbMoPE7LtMdVXH7RR5Pie1nLdmIGBrAD5hHuuMPKUZA2INASWnfOt451jIafA7N3/omrNOK3ZPsBxK4mWSzi0VPw7FpwULyoZPnD0i0APUMZz2Zt/LcJlEEAxK+CcStKT5fA7XrBfBNl603OboX3Svu6QV9nR/Vx6R7LBadFL3gTKaXZh4c1/Z7tiX2br3rVApa6X70MfZBykjKdVZZqsk5JOMrLJqXHs2ukBFGMY53+wfBI0RSP+e5YvOXEBEeIkxRRQtGhBZIau3fx1SxKLX85DVpQSNCR81MRiJkvSvYiJGCi7YpnSVECQ2mW7rrYpQ==
X-YMail-OSG: Q6IU1oIVM1lM4AJkNdC_DLJhLmb1MzD0zGaj.yxR7ADMRT75SavEjtTLPQvgoo8
 wJCZCvHxLPhulNjacktNeEBA7FuUJn0fA_dzBKrOiLo7Otu.T_3xjz1ZlQA7AnJ7GiwhxiifWM6n
 nLI.j61ovmv7bynUjeS4hjmluvFDkeoGCR3_Pf_c3ZAZLdh6BSDReoW3r3ATEQIWkK8SgZRO4Eox
 Mecs5N9tWSsWEL7GhxqG7I3J7bw5xIUDZYYw.NvfKIxRXlR7zqUnBLSDqmeNqXVnZ3rxO3PoMIp0
 Wsu4Cd7sgpDW9UyemUXOfBXxl4zBJIxQdeslvmQFSZlsVm0oA00aRxyPFneX1eXfhnS.PdaHz8h1
 CnP0UcAAgqFO4n4vqMCYZWuWNR64X1T7uAIf8GYVlk77Ny_ijaLjuDtdR6NewnL88HJwK1rSHZCz
 qFD6p4gj_mRWKWRQQjkxdyHxxfa3KfGqX4fxZ_Ud6Cq7ytUMUkLosf9Mxz4vG4kiLzDJPVd3qOYl
 pk2uUr1fmMUL4cxw1M04vvUtpsH.KWJDTp3K2p2G6LtVB8W7yyxcwKpS_.n_OuoQZIgo1LevdKQV
 RlWc5ivkSg_ET2slNlI5xBBvqwSNAQEuEVwFYRFZmBePEUG6ynTYPEw6L6UakkhlDN5VE_4VAMMy
 91tYhLL_0a2rpTnAc2Cgqq56djD_KfPnpq0iLflxi4QP5FfXJqV2zVf69cX1325QuosW34_XigcM
 tlXK_7iiV9IvconYCkl5MKgCBKjQG1.k62KlLPnAWu0aIHkQ_Jl8qoWM3f8l1Igp9Evo6Bhfr3um
 94LQMYoS2Z6vBecmB_._tVAP3Jp9_B8BlJfStzU5q_lmu9fr3ujUkrkvBd4wFMOudFloBnui.7CW
 6JeqCV4blQYOlflq.Cyi0VjtY0RYumWiT9lV4E0I_Allxa9Y9_GQgiEHmxoqk2k1YHxvW3BSprLM
 EbF2oOqtD_AW3Gu_Lb96rULNeA0G9aWMdIvDg9zdu_rvFSuo8nHHcjtiI1wN9S5LdTNO_AUlDbQC
 sQef6qfUA39RVZKfEz311smo0r7rCOJAHMPZZGQbMyPqLkyzOH7f4lSbsM3fOTCnJxEVkfAWUTvi
 DF98oQdHv6ltJqwSGPA8nttVmeqEhM9A0ArdC1pR3.Tl8RzaDvnFxAmhfalJLQVad9bSfwkcgYrp
 YDM8SgskGKNZrMrNeNSllv3WcbdefrflqylPdLzSFif3.BzmtbwroxD_BuFpzr39urgpVXQkXO4h
 2bC9RbIUqaFL5Qqpp.YLjyM0lG2sjLheHKqLp0DH4XDZbyfaByG3_8hhHugMGNU7.kcDa6rV16XA
 QYw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ir2.yahoo.com with HTTP; Fri, 3 Jul 2020 00:02:03 +0000
Date:   Fri, 3 Jul 2020 00:02:00 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrs.mainaabrunel126@gmail.com>
Reply-To: mrs.minaa.brunel703@gmail.com
Message-ID: <2000857227.3187920.1593734520542@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <2000857227.3187920.1593734520542.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16197 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:77.0) Gecko/20100101 Firefox/77.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politician who owns a small =
gold company in Burkina Faso; He died of Leprosy and Radesyge, in the year =
February 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Mi=
llion Euro) Eight million, Five hundred thousand Euros in a bank in Rome th=
e capital city of Italy in Southern Europe. The money was from the sale of =
his company and death benefits payment and entitlements of my deceased husb=
and by his company.

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
