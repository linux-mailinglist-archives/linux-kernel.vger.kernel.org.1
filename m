Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C423235452
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 22:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHAUpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 16:45:54 -0400
Received: from sonic303-25.consmr.mail.gq1.yahoo.com ([98.137.64.206]:33262
        "EHLO sonic303-25.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726477AbgHAUpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 16:45:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596314753; bh=VtUxGDBjyfGdsQeBqenW1hisHw8QwvSOHMelfpM/MA4=; h=Date:From:Reply-To:Subject:References:From:Subject; b=aDtoPMMoun28R97aT2WlTNJVUVp8WiXLcVv+2FwPiKrZXxYf5K9ElRSNGbomw+uvX3YgVwdUmq4f0+8PiL6xdIbEPVXVydejUub1l1oqH+ubPSsqvHPqYma2OXil4pNynJ0prR9N8qRb5wo/eDJZi0R5ZRh1eofOD2H8C7PrbFw2b/CaxtGinL2d5/p+FaLsm8WFAsuIr+8bW1cU+ww88kjCouGcsRNEbu8P9PbUxdMmdd/r6Mzy1Ohk2MFNdNtcEhEp2SEW8SLgcZwpTF5zNbjq7AC8UYz3RE7zzKZyczgs27cT6PF+Uyfhy4EMzm9lAcITPa3eJHX4Ng9HUlQsFQ==
X-YMail-OSG: 3bMagNgVM1nSEZVq8mVt4YDVq4sG3XFK4E2xABIXAZhFOOHEDneMjKoCB46qCuo
 7IwUrnVhPyX4EXEeAUcyWE30q10nbWjd8E9NoPDbY_1ijhuuFq5OKrdhQihWirOIhEdf.ox56Ih4
 o0Amh3Mr8dusY58vRPGxyXveb0wgIjVFXNwMIPxgPUWDqBYUuQOTDTiUJGEvvSK_5jnICzBYtzUZ
 fzc29vsvfwbK0gZCAT8s7PxZJdh0BZ8zSXNMAeteVQWzSVkFDeklo1HjlDNk8nWvXR_uCN2qyPbD
 sZ4LLiAEjYhxhs1xlAcWelymc5_aMuSQAZ99Ba7ZLwcZNTQN4JGlEdY2NgUZSiz68igpklffzkA3
 RIL20UBkb75f57LJcYBICvMifyEi35tzQwokOaymxroNk7UtPJGdDDSZhwiJrgdbnOhv5fYHipd9
 NjfXaqoSso32OAPdqBE6TR_2cFSJ2VNN8MgH2ScIol8wR9vDEEVCDa8j.bQz5yTf1wWCDoshJKaY
 kPNAFzedA7SFVx3KNfwfqLLqW3CJA83BwStICdGLqwH141QHGbWZ5ld3Mz_6tb1oz6f3VprSI7P.
 Gs.RxwhOSTLUQVx6EOSw4nM10qZ5poeZBlaYNWzliw2uFLQS1l59hNyvOj_4jkdo85KKhqwS8XP5
 t.vE0tAVYXL8MyX6zWwRgI_KZPCGGb2bAaH6gki2T8WS7VS.nt76rwJ0o5Iuisif7a8B7sMcgJxx
 SSxShJ4v6spK7hTMMAemnwJoljRC7tt.m67F3EXgy3.Hc0OQYRWVPtQyJ1zV7G3E9YACWnT3QFZ4
 LfMsjKF1DoLFYGLfXjkl60VDx3Y.m23TqkteVMbe1BN28.K80LdcYJFJ9bbNv8dIaICvZdHrIe8l
 53C.hrG_wkxkoMjlWSvIxs6mvlwJ3_KUU0EDXDKS2PUJC1b.QTtBKvbzzGUsRTTlpVrTO48qv._Z
 UH8yd3zBqT4JTVbodtpy4asLb_AVbRhgreG7ufTD2CVaSswElSCaKoAJVcP0d2Dl1iIXNBSEFG75
 gjKB9vGPhhwZlmQroY0oxUBmaYD2cK5biq5btXohjCiyoN8qQRnVr229QLtZnz.GlPyyDeyQu18o
 Vh2aUeiowTMlmo0erHmuI44oxlZDzmUh_8LIETjfFSlmF.3PGb5GBvit_fEgx7Mr1oogWhemvQNg
 d4xYx51wcTu6mftVqKMwnWpCUnSHk.KVOkJ4USVSrUIWt4..eToRnH3RugUm2jkfgjJR5Tn5QYlI
 zrKdKUDqtghkyb846JXEg.r6KVi2oaPgg4JW5P840iknykqtJ9QGZFQguVNJ0HY94lOWR
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Sat, 1 Aug 2020 20:45:53 +0000
Date:   Sat, 1 Aug 2020 20:45:48 +0000 (UTC)
From:   "Mr. Ali Zango." <mhizamhashim3@gmail.com>
Reply-To: mr.ali.zango@gmail.com
Message-ID: <1690533100.223922.1596314748101@mail.yahoo.com>
Subject: WAITING FOR YOUR URGENT RESPONSE!!!
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1690533100.223922.1596314748101.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16397 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I am Mr.Ali Zango Working with a reputable bank here in Burkina Faso as the manager in audit department. During our last banking audits we discovered an abandoned account belongs to one of our deceased customer, late Mr.Hamid Amine Razzaq, a billionaire businessman.

Meanwhile, before i contacted you i have done personal investigation in locating any of his relatives who knows about the account, but i came out unsuccessful. I am writing to request your assistance in transferring the sum of 10.500.000.00 (Ten million Five Hundred Thousand Dollars) into your account.

I decided to contact you to act as his foreign business partner so that my bank will accord you the recognition and have the fund transfer into your account.

However, i will give you full details on how the business will be executed and also note that you will have 40% of the above mentioned if you agree to handle this business with me while 50% will be for me and 10% for any expenses that may arise on the process.

I am expecting to read from you soon.
Best Regards
Mr. Ali Zango.
mr.ali.zango@gmail.com
