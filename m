Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE0B1B5583
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 09:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgDWHVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 03:21:15 -0400
Received: from sonic305-19.consmr.mail.sg3.yahoo.com ([106.10.241.82]:40360
        "EHLO sonic305-19.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbgDWHVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587626471; bh=YdDyVS9QBRPCiN2YYZ/cryZSa6YEXSJJY6ujWZ06LZ8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=KbyIYTCCL6VRgIshDBRGHW3jgVcXFWaIZGmXQLV7QJ3fBl2vQLQ/THI3r+T8hkrcB6XIioWgP/0KPtee+IW/exsCkigGVAxITO7B5u2yva8f9Sl3M3Q1mKiQyZAuHWZ2xSdw0wsPf+ZcJC1dsjMmtabyAfI6uQ0JKTcxWwUFojfEKeB+lFjdn1dx4dZ5/Bpi1GUrYTLmduWv+GWd+pDJ6tLfbTVVEmCNKMcUXoi7mJguIHABTfiQGp4sdXzKl/C/5H5lzRiHRhbYefrcKfythOOS29euAb95KntcDRvMeeLE6Lhf73fKGMnwEkaI7weKeCZohkpoCO1z/8VpvXes6g==
X-YMail-OSG: 1MY5A7wVM1mFS5MPmeRCxxkoA_60fnU6Ch1liJ5J9XRci2RoPbz2_iUU.J36dt.
 qn3Qvk0CKsAAR2Y8cz7fuIk4CLG_JAlUbnzXP238wW8gjrSsNPzPUeTZwlaLjdXOpllt4sOBFmIx
 UHkQWJj1z9yAl9wUmFUQoFw2JnyTnkylOiU85QQi7zQuVsUS6WzmdKm8lEC4Gl0n479ssDHEq53.
 PDqJYMuCGU3k0_rbGNwHUSZq8yxQ.AtAxCH8qGMrTiyqJ1qaZs15C_9VOCfNa2RMdXbDuNHLSjx.
 Hi6_3Nn408Jzk41L44itbtZAT3QRkoLH6SMs4tLKnc_iuqU7ivhLZzoS10YeVbVi0D2q4ISH1f1y
 6graRd3fRhS7Tn1kYl_aTIKimoeTu3Azi2vkAvGJaaJ.QvqCLU9HUfeaV_Lydu397nJfnDHgFBpt
 p6N4y.waCeE6pwtRc0B_sd6Pvw8dhFKjO2XArqHvf6YchIEwRKrYoxs8lTxf2NKGjkRJrb28y8W7
 3BfO8Lv6T0eOaS.oGq8si0Xgmi3BHMD3zvJPL5tqydoHmVqj4pzVbZjet8lAGPNCNZT.yGhrRxBH
 uRzUmlPw5al.AFz.rEnYC6C_7CVZt_Bg.EqEk9g8_qL4C2TRvxmcPpvsriLRlIz_5JgypMzj7ZV2
 Wbo3TopmfHTc3dw0Wsu0H1B5QiFrTRu3qHQIe4LitYT.NP2b.LQk9lmWnQEV.KGg.rAlW69nkAea
 0wpyFbXMN2Rw_jap3vBCTh1zQDnymctbwB_dA59ZMiInt9duMyfyEGQNp.lnD6o5jCHuQQyLyu8q
 qqNjOHEZZc5zWHmabFFRqs_ee8NTsigWoCiCNGQU8omBuc_uash0rPJ.cWLKRYzWh6DAVkbq3WNq
 .qd3_ZuaPdmuif5KtQMcPgKZJ8V63j69ZJQfDatdepKUY93jbW8cME7Gj5c0VnR.orxImXYSb_Va
 YWS2a_yeQk7YRK_nFYK6nTV2Y8H3LTUEjbplMfZRpNVlp76yq0T55DN5EzVmugF4jz8JYmk4nHl5
 n7QtmM2W42kFn.P2r4bmW0yJO0380sG9motQ3qlcQQmB407cAjqWAyll50bZVq_mQw0qonduNAYa
 0nRY.clKPVZcL1x.3xizSY7RPWyGO3ZM.ThGK1Gh5P4jmQXM95lJmaN7hTVb7MZQC_01sCdGkABj
 RCxKl7XJjTAf6xOx7J95HJ8Yw4yEMo9gYoAtMY6tYvrrrpUlxIWYmypQCUsXeCvU0y5iRvmPbB94
 J6T1YDuQ0Cp0w_74buzOYXvEu8tedsiLgLQLxeiwD_dzqx9fQd.f2rBvHveIJazWwtobLhXVSzoT
 2HFP7C7nTXBTmDuHYK.5Gs5qT
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.sg3.yahoo.com with HTTP; Thu, 23 Apr 2020 07:21:11 +0000
Date:   Thu, 23 Apr 2020 07:21:10 +0000 (UTC)
From:   Mr Moussa Dauda <mrmoussadauda@gmail.com>
Reply-To: mrmoussadaudaa@gmail.com
Message-ID: <810952952.177480.1587626470064@mail.yahoo.com>
Subject: I await your urgent response immediately.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <810952952.177480.1587626470064.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15756 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Good Friend,

Good Day,

I am Mr. Moussa Dauda, Director In charge of Auditing and accounting department of Bank Of Africa, BOA, I hope that you will not betray or expose this trust and confident that i am about to repose on you for the mutual benefit of our both families.

I need your urgent assistance in transferring the sum of TEN MILLION FIVE HUNDRED THOUSAND UNITED STATES DOLLARS, U$10,500.000.00, immediately to your account anywhere you chose.

This is a very highly secret, i will like you to please keep this proposal as a top secret or delete it if you are not interested, upon receipt of your reply, i will send to you more details about this business deal.

I will also direct you on how this deal will be done without any problem; you must understand that this is 100% free from risk.

Therefore my questions are:

1. Can you handle this project?
2. Can I give you this trust?
If yes, get back to me immediately.

Try and get back to me with this my private email address ( mrmoussadaudaa@gmail.com )

I will be waiting to hear from you immediately.

Regards
Mr. Moussa Dauda.
