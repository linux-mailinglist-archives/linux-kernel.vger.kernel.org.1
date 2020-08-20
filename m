Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3581C24B6BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 12:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731185AbgHTKkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 06:40:19 -0400
Received: from sonic308-1.consmr.mail.bf2.yahoo.com ([74.6.130.40]:39570 "EHLO
        sonic308-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729755AbgHTKkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597920003; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=pJy2XubKsq09AY4iPdPzk1tRvVH9mu5584Fa1ioMdxxei6CX/DIGYGfQpTTcOuXVXLZItH59IsNbnqmjLw8pRpAnvVSIDhX82ow1cfxMrBYqx04Upvlg6Pfgxz5x0ubW6PbbzXRYCJJG/jx2wOpNqMivRTozSmTS9eFJVM7pjUUQy/qCjHW46PxS3LoasgSAmR5tNDIYcdK/R3mRvhqXsL5Ny62Y8AN8XHgHzfN7O2IhKSOHQudeUjo5F0jErMameKKtkFZg59BjJzf6rhtLhQ6g7sqh14NaNlgLjZrypr3tPV5Mudmcur4HEpaJ48InUQxzRP4efRHJHr5R1hRzeQ==
X-YMail-OSG: hw_fF6wVM1nPrD1semydnWJqdEYX6GmxIMhSihpH5571JTndp3VWOtgLKsPy0xw
 PFY40ea86_1Ce.wgHOGP87keVgqtyuD.5qzfpv4Yb2r91c2Fp4pHgzFEl9YdlGeucfssh0lUnEa6
 JFqGvtN8OFDxToJZ_Oa6Hq8d8ED7Pxfd3a87uKuPV_bnbcU0y5bRkIXfKqUIBUNf6EEobuOLIsWn
 A8q4FyMd3y4URUSwFMZj43akXZBCE_CW6Aw6Fx_jLR0EVPAjrUZktY9TI9Z03QqWJN9o4Qhrc2..
 tm91SVzB00Ox_j_KSvaAByXZpADRPRsIUayrvzymIZSBTF_10UO0ATE3oj3ysHixBobLC9Sv417M
 AbIYTtjgKugHyr4myXztJpCNKtaWSNooFbSiTImO_TZuqK3OxSmwrTXe0_RaG64KKxwOlu9e5NJj
 LRwwfOlwJgZVyGR3AUGLXjLQSba2xb9cokQQEXzPqIpxf6vFc92H2zPyxUOTvhf3oY1wmRo_hscz
 Iw0Q38tV4mbbI4ZWHe9PjRoh93dO_DEA9lyGjc7c1gKX1.BLNaxiHa3WVL0ugvAA9DvxLejV9Mpg
 AfMPI1SFqSzWEJ0fOdeF7.qeYrrTm5PiGbpiG8VITq6RtlNAww.MgFS837QK5mLBCvIEWI2plCFG
 4nY8YS9OHz6WwaIUH3zMAdytGAKCYCnj6eG1DPmx_lzt4v6xvJQHieC.dIfVYlr_.2qD1DqQo8zO
 hzvpBt.tBGw8yS.jfoR8Tmu0AUPq61oOApsryea0NqQv3TpG4EHRwW2k9G9SqohA5jH37DstbbxP
 jw4UGbmb4nYblQEGK9yWBk01dIH73F3yk33tjNxBVTxoRBsi1VD1NRlUTWZ9kdXqF149vmy.Hey2
 4hzKhWNIcGALEw3xTL.Yo1DU6Nv.B6R9MQlVkR_Uc.7nRX._YyRLgGofoC2vzPqzQm0NQoiZ1gcz
 krjOtZ6r5QWBUXj1JUjnX7bBT7Jcte9fiGsm7qJaf177HNwWoIt5.Y6XQu2Ech6o5ojkkW1Z5L8X
 d4goAe0r.JGuxZqY1fNsVCM9jTuyxVyQbAuEkIIeNfXULt7UXtfJmAyMjsX9EBfXJVLjU22q6B7d
 _BlKutpCdQy23Y7WkbATbN_abQDZ1lUJj_aQvcEX.zjdywbHqe3mherLDMJeI6JCkuZsSZEuliXj
 A0F5e3z1HfysFJi8GoamZ1C4EqmPVB8SkSaYYqkYsJEP1PIgFS94yIWaanxXqePVVAS8QkNJsL.a
 vEusXyCnisRqwT5vq35k1EOIw3Ty71HoSmH7irnwB7Ro3YBwJwcGpsI9d1Hk0MeLtlSXEaCZWWbw
 f.3PXg9WgAtN0QMzHreJ93vzzs_2T0P9ingM3KwfMFmt.GdVAHN8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Thu, 20 Aug 2020 10:40:03 +0000
Date:   Thu, 20 Aug 2020 10:39:58 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrs.minaaaliyahbrunel0001@gmail.com>
Reply-To: mrsminaabrunel373@gmail.com
Message-ID: <1094794777.3657800.1597919998832@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1094794777.3657800.1597919998832.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:79.0) Gecko/20100101 Firefox/79.0
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
