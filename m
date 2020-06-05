Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182EA1EFE7B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 19:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgFERGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 13:06:47 -0400
Received: from sonic301-21.consmr.mail.sg3.yahoo.com ([106.10.242.84]:41846
        "EHLO sonic301-21.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbgFERGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 13:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591376800; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=PI1kQDgmmd1ZCZ/UtYVRZanCoyv7PXcBjlaSDI/43Rwmw12xrWFCxFJVTxbb7NUGcPl2M88nuhXWAXRjFX2l8LA360OgQ4U70fL7cb6EQ6D9qcw/X/IPA8JLxJiO/yk36cDgOK2O+U8PtFYWkv5rHtNNbWytab0ZFQTqAkwnQtClrsXjWR9/TLRbG0089Boi7r7f8rsInhSYqlEmwRBZR0MSCda1DQ4PkPGssYYCPdi+u7NitEmZ/icjfkPlg0OSFJcjeA7lN+6fVWRypk2/YGrQFo0HcRLpypNYBD6c6UuGrWxSsVA4uRLQv8CkWsGdmd6rX15qzgSTPkNRxLQlMQ==
X-YMail-OSG: JtuyPrsVM1keWEVUKXlQ0f5jBZU6YSFG5n_CbflFuU9Pfr8IXXYzIjAHGtc4RwD
 8u07TIi3zMV4TxCKuRkDaHfKhSV9VwGlf5SrJeRudvwmN1uMersdMgMpHmFZHAJ_zkIUxGKFZ4u6
 enTIQgzlWn_Nj_p.m4IE65aRuu7EPGaO0GVxtBlsOErT0wQ4y5fFOnbO9gp9j.DQfcoVCGE6Hv9F
 IuuFxD2aOZXqLxaR6HA530nMhukiQfViE7C6pf.hxMwxFN0s.jzyjVIvCRoFz3jVx8vOEB5UGmjf
 KycomQZRe52fmN4ISOHWtBA6vTR.L4bsHtDOVKios2Y7WG6QYKQPig3yioae.lhboBsDYIMY.m33
 rTa1YcSlGIui5EHTMqmlSmiRqpcwCmxYnJxBIqvzLYe7EOU7Ovs.LP3l049QACpkle9oZR9n2RY_
 Ou1nBEsDt9Qs6TQUPCk7uz2p0uiUS9D7l.Ehf7YqIEvDiVa3DjEkR1KsO_ZV3w4VXeoLwCC5RnPz
 W6m3FcEet1jdJRVvuOliO__Gb5yh0zJwaleLCN10WBZaJ2yVHY2snmTPTZ2ZmX6TaRXKOdbAyUfv
 4akPyjHGIFsnqj5G3zQW_8ILrD_EQ_XJP9ErYZgk3gvl11X4RiYy2bT7S7WkMHWg9IeBLaGXG_6s
 sh43.WYYI1PiM8ub8aX8YOSovFiu41mZXqexhhXCsiccFruQyFN7oOBKYK56p3gwzux.wusjPt.u
 xUMuD.8.jpzdxMbjYijWihGzn3.1CpUsm4FjOPTQfSdWtjiGHSGgxXrqxGYw5uwlxNjJrI62Al2D
 XPJ3.rR2Q174pN7G9WULNLqtmE0EJt1g8Z973RB1F3JoxtbDZ2DN1OwOdY7ZkV7qsIiloN0OOGeF
 4so5oC5_DUlbY7ij2yUOMhknN3PVHssG0Nke2sPSIdfzvm_cWAEA9q4br4ti96PqEXWe9aoJyGuq
 qsxDXIDh.BgFysNnJxuC0rT.4vMZ47pqAQ3EvRe.OkIsHIW8C6ICZjjTbHbbQELnHv8W9jBm_Uwc
 DTwvFquflOrfj_npuUIq4QiHY_hM0w.TwcTNh.rniqwwHbbRj_uIkP75dMV3_mpn6P8uopDH6A88
 OrSf5kOSnM6YAUqn.STj2Pv7ht7BHeS7msFwpSI9I4IIpV49aqNNvl5QpqreQLN.QGSmuHykHly7
 _M03Uw5BqSPvSrmOr8qAskyH8lK7HgH4oHhUhBGIAHGA158esvxcMb1WXl7tOfpSNrpRcPF5MVPO
 nVjE5AV82UxnFLyoRKa8gURz3KutaGlo.CqpPyfGjBUcJU0XU.KfoqB4uixKIh5bAWhWHcnmSBJa
 Fz_o-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.sg3.yahoo.com with HTTP; Fri, 5 Jun 2020 17:06:40 +0000
Date:   Fri, 5 Jun 2020 17:06:36 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrsminaabrunel2@gmail.com>
Reply-To: smrsminaabrunel63@gmail.com
Message-ID: <1637124243.1895722.1591376796684@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1637124243.1895722.1591376796684.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16037 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36
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
