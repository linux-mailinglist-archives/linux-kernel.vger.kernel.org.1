Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076E02666D1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgIKRdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:33:45 -0400
Received: from sonic315-13.consmr.mail.bf2.yahoo.com ([74.6.134.123]:45396
        "EHLO sonic315-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgIKRdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599845585; bh=k1yl2EIxSlw7hhqSSNsyo3JWxJqHL9iqJXZc99K49Wc=; h=Date:From:Reply-To:Subject:References:From:Subject; b=hf1jEbSQGxKUDpCJygi7hq/Fj0IT7odOdr//QUh9JFqw+d6xQHiFZxJud+k4ybjUp1m+YUEZdZayo0XToXAEMs54pVMWnZW4Y4oEc11gMPp4eYvh/tZk2dxjZGgnpHw1sZotFRICRG97hThQxiD/5FfhLO+O0gZ7cR7fDXoR8w1QMsXLZojjtZX+RQuZkS8VyOC8AhbSRPGD5/5l/0VKbiNqIoU9Uz4HHkEoahcFq9d1nLgSyYsQrWnqtZ7nNvlOgb7a0CZ40R6sSDgcwIGqOpuzD9nxBsrGFK4CLNV7SkReYOeveLs0TRZ2JVq5Y43VmOTcQbiWKZWB9D/ARVdEfg==
X-YMail-OSG: rgUERqwVM1m3WYYftnmZA0QDMjU6EJbnzebMBsZ.DUuyZxTwF8pgwcdyO5eNdAR
 Jb9aFhCyqpm3KqXvAVNA.363.Cl7vYGChMJ4omn.TVxbDbvniqOTf92z28h1DkD68nOcQm97ZKtq
 sSedN9FdFgK6T72MyAwyWSHD8L.JlVzttny89EgdezME39s4tkqA7P..ruP0OnnfrfvaUYKUc9B3
 dXxV4pn4BimMtjS8kY.JpS91g.QKgDbOm8QkdDqc2GvYR0qN9AxBCVbDedoeOLFUEW.eTE0LalCH
 .tUNvXqxuZvMt1l_bQ0v6D88Jn0TxzGQEQ9DGRNQqpNLxNgfPrdWxGjazm2n7S3eA.qpdUPwXyfJ
 .UwqaDaVv0AldxF43jF4zi4mZ6u5pxFk0nfZ56J2LCVbiCDljDv6dA_PCSzU5fX0eXXwzS.IcdnH
 PDhP4B3eeOrvZ2GeDCR.r12C28a8meOvrENOKzXNMbekG5kluWhYEF92mKV2KIU1OGgYa2LRa80V
 KkJyrCh_bDBBT4OJisdXWZjzlc1NkD7E12ctvn2yeDXYOtLnwnwdcWW6yy_o3.yJYT811cLZDLHe
 73WpHmyWitHF44OEKany2zX1U0WdE4zwYYEeQiRq0cyipLCG0VwHPiBE8Dx55nAj1iFEahRSPQSN
 dlhNe6GXSQjusZ0M4igXCewFhRtgkFPI4cq14xDpqTLMVM5IlEarmDQz3Gob4kFSKCGKVhbSBBdS
 Fg00sYdr4hJ_8vBEBZWh5Ndf8bbPAWeoy1wIgvLY6ORJRUA8ldO2x5BvDmlNOWEpfYd_XPJ3IMLl
 51AM323eatw6jMQMBIKLnNIH89OzzpFu0U.D_IU.ELAOWWwfNB0.LQuULKsilhZZgsriBohpqFwQ
 xbFIdGESCTTxzyOvtCsbgN5Q0rIpmqTQYRAnOBAqTvQNV.wyE27UPkrL.usT1VLAmyacn.IRycOw
 ZZ2FVyAcoIeJbSl1X7GX7qweYE.U9iWWl0zSmbTCLqtrkBxpjmRjn47NPY_bpVC9F9KCsgo8PnZu
 26isJv75JSm2KK9Hs.RwyYzU2mE4CmWVdBcRjGHXdVRpiU4_U_fGqhztdyKZ.PsfrAs6mMtBtxn8
 1IIJPNPaepFlc.OKYVGPFzc.9mmUiqvHyNJcJ21pj7BMDEyVNcYvE6bULjal28a2PItabeqcZ9o_
 ZVzSeJwuHWAZUgbrbto6.7VWmmBigTwV6GXA_DEapCIR7j8NPHL05bF8U1hE4fZr82P4Woc7kft.
 GhW5vVQNqZDsKjdCE1bMNkdWzafmcilRzxXAYJMlfatV5XpVthrkSHIBoq4BKdaTvoBp_6p.V88j
 86YkDhAVB7NHIDr3BRk_1Ut2hObHpzc_l9PeBoMRaJhlfe6VChoKwoL5djXzSi9_bP0yvNe1HOGp
 gvQnPenbJRvEUR1.dpWTdfQ7oEeaENJHrYdIUwNyzs5ZlkyrNJFlTzIVs3scjS06g0.qeofX61j7
 KTHPAyD0T8f8A
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Fri, 11 Sep 2020 17:33:05 +0000
Date:   Fri, 11 Sep 2020 17:33:01 +0000 (UTC)
From:   Aisha Gaddafi <gaddafia972@gmail.com>
Reply-To: aishagaddafi0dr@gmail.com
Message-ID: <297073077.1160240.1599845581286@mail.yahoo.com>
Subject: I WANT TO INVEST IN YOUR COUNTRY
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <297073077.1160240.1599845581286.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 5.1; rv:52.0) Gecko/20100101 Firefox/52.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



I WANT TO INVEST IN YOUR COUNTRY

Dear Friend (Assalamu Alaikum),

Please after reading this mail try and make sure you reply and contact me with this my private email address: {aaisihagaddafi@gmail.com}

I came across your e-mail contact prior a private search while in need of your assistance. My name is Aisha Al-Qaddafi a single Mother and a Widow with three Children. I am the only biological Daughter of late Libyan President (Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand United State Dollar ($27.500.000.00 ) and i need a trusted investment Manager/Partner because of my current refugee status, however, I am interested in you for investment project assistance in your country, may be from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent to enable me provide you more information about the investment funds.

Please after reading this mail try and make sure you reply and contact me with this my private email address: {aaisihagaddafi@gmail.com}

so that I will see your mail and reply you without delaying, please note once again that it is necessary that you reply me through this my private email address: { aaisihagaddafi@gmail.com } if you really want me to see your respond and interest concerning this transaction


Best Regards
Mrs Aisha Al-Qaddafi
