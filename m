Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484DD22932F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 10:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgGVIMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 04:12:47 -0400
Received: from sonic307-56.consmr.mail.ne1.yahoo.com ([66.163.190.31]:39436
        "EHLO sonic307-56.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbgGVIMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595405566; bh=UXgtDsRN7lwk5hslMhDS77KoWasIDbV8j6zhJXeW8ys=; h=Date:From:Reply-To:Subject:References:From:Subject; b=cQEMQ8NYsEhxyB2SnNeo6uPWsNRUUQduRlgbkgFGVWtyDyRVD7+cEQYbZwmVjX10a8weePgXm+ems7Jrpvrr77wLkLBcnsNQWOEBORU0QeWHcOJvmDmjqJdfn/cn7xx/TdAnBzPRVurKJXHua6YV63irSj/EEo0hm6tggmWynQw6LyvdPw0xvpbMkurwWhIJ+XbH5rJt1Odp3WijimrzLiavmVus9ohf3BUBmL3IOIkB7KS2WBjPZrrvxAOPvivyPzYKVm0oihE5GWI3UxL0k460a/OlmuQgRfjLMIhBI1K0YjyTJbwjO3O9fPjaQo8uYb9IYcrZ2KhxImkACsBHNQ==
X-YMail-OSG: 5Qr8WqkVM1n0YbKiziZ6vWNBaPWb3th377KYcMN6R75kHy8QWElFpjs3WEeLU63
 Qq8qV99iuyf9w7m8FHy5Hltb3Kq166VYI8F.glEUdeZ8037xPVdxBHnpS7Y9g7CuZMZnv3p6K_fP
 JHv8oBXMatsZk9qQ6HaS7zE6PTFZXUIE6i8S9y9ppp0.u4mmE.ycdKCC41JvgoneiwMuXTF_wu1q
 BWXwigEEXzaUFoxrikbK6qd7t8HOj38h6m_4gzau0njZY7d5Q3kRD9uc1qFKLV5bKUNCdce20KXO
 r3ROr3VAJrxUiZQUBCSMZml7ee.4W2myhTsbVtnm7PMRdBYOK_zzQw1_Ke8DvWKx_94GJ47bxzRR
 q3dv4mOD7Ava5sNG1KPJ_ovlVx6xJyK6WGJUajbAkMI9ffHTtQxV3sM1oWhQM8pDPdgwGJiSxbTx
 ygQ.pffiOEzyCI_F4KKlrEHRkqgS1TU48M_tTjZ1tAzV5GYtdhpDT8A84BJO71cimZbP_toQ4HiL
 UXGRqBs7b3gCCpsEXAdakc8HCjbyiUIPhO1uXma6PX2TkAm6INnxsoBgnDMsISwXd5uCsBpy93Tg
 Dj7.aPUwulndPKrWOasmjdbbk5sP1dmAC.Bi.rzX_V_FCZxVX4mF.7xdpgqgdK8WwWXnyK1T0Csl
 tKfETMeKFDcpi0tGoiQRchQbTe4Ls.jdsl_RDSJ2YRv7OK2ixjcsGRJgJNcBDOn5yoNqJWCEEAjF
 KXIFpak90w_sK1MdVUko1qNIQNuA5.f0qBa4MYbG8f6sWfytZkHEUnaClUyYBsW14fJ2ITCPw8Hy
 Fhy3w5l1dyG_We2au6v4xGEHyI_NaIUYinLzFJQ6PvKtjleZ_8bXfFh1l4ZLSYWUTCvdfrR.s8FY
 QRNc_fysmBXDwtfFWPbQPLey3XvpWNjndO4jBtA15WUXT18IGaHlKtLfX36k0XWLtQffIHVJw1CJ
 7XdN8OwxLqnpxT5iTC5kM0OAr9CQJbFVoKrd2vpugXwZu0n0Hl2ABZBgkfmELv6IZsMfmcKWAQjT
 KQxF29RoMpD_JQ4CmJF_Kjj4heWVwivxHVEsrjeJ_uu3RnlGIlZWJexsNfL9eRAyd2wc2cB6aqdD
 _FtivWRG1GXTbfI_btfBycyWSHL8e8T9t4FijuRlABVtcPse8_n9IFtaBowvIeT0.T.Ak8txa7Pm
 mIWXzY_CE8ln92dEArUlUauxasyJ1mRV5p.3uVUmEsvKFdhamlj8PMwiq2iUTH_rAucvCcb6OFpO
 l95KhcI588Jn0K5_xpi4DZQXzE.CAUj1UuiFestFbs8QMmcOtiCoj.DGTi_WDeyU3J_0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Jul 2020 08:12:46 +0000
Date:   Wed, 22 Jul 2020 08:12:42 +0000 (UTC)
From:   Miss Abibatu Ali <abibatuali01@gmail.com>
Reply-To: abibatu22ali@gmail.com
Message-ID: <1429572067.5352444.1595405562160@mail.yahoo.com>
Subject: Hello
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1429572067.5352444.1595405562160.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:78.0) Gecko/20100101 Firefox/78.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear.Friend
I am Mrs. Abibatu. I am sending this brief letter to solicit
your partnership to transfer a sum of 11.9 Million Dollars into your
reliable account as my business partner. However, it's my urgent need
for foreign partner that made me to contact you for this transaction.
Further details of the transfer will be forwarded to you if you are
ready to assist me.
Best Regards.
Mrs.Abibatu Ali
