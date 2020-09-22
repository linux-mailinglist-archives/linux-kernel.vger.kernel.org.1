Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEC1273D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 10:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgIVIZX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Sep 2020 04:25:23 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:59157 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726483AbgIVIZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 04:25:22 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-270-9fh_TmIGPISoYV_R6FKa3Q-1; Tue, 22 Sep 2020 09:25:17 +0100
X-MC-Unique: 9fh_TmIGPISoYV_R6FKa3Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 22 Sep 2020 09:25:17 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 22 Sep 2020 09:25:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Douglas Anderson' <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Jackie Liu <liuyun01@kylinos.cn>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: crypto: Add an option to assume NEON XOR is the
 fastest
Thread-Topic: [PATCH] arm64: crypto: Add an option to assume NEON XOR is the
 fastest
Thread-Index: AQHWkHcHE1jYu6mlnE2o6p0iKGZtLql0UjZw
Date:   Tue, 22 Sep 2020 08:25:17 +0000
Message-ID: <ad9108e155ba4245a2005e9212a7d2b5@AcuMS.aculab.com>
References: <20200921172603.1.Id9450c1d3deef17718bd5368580a3c44895209ee@changeid>
In-Reply-To: <20200921172603.1.Id9450c1d3deef17718bd5368580a3c44895209ee@changeid>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson
> Sent: 22 September 2020 01:26
> 
> On every boot time we see messages like this:
> 
> [    0.025360] calling  calibrate_xor_blocks+0x0/0x134 @ 1
> [    0.025363] xor: measuring software checksum speed
> [    0.035351]    8regs     :  3952.000 MB/sec
> [    0.045384]    32regs    :  4860.000 MB/sec
> [    0.055418]    arm64_neon:  5900.000 MB/sec
> [    0.055423] xor: using function: arm64_neon (5900.000 MB/sec)
> [    0.055433] initcall calibrate_xor_blocks+0x0/0x134 returned 0 after 29296 usecs
> 
> As you can see, we spend 30 ms on every boot re-confirming that, yet
> again, the arm64_neon implementation is the fastest way to do XOR.
> ...and the above is on a system with HZ=1000.  Due to the way the
> testing happens, if we have HZ defined to something slower it'll take
> much longer.  HZ=100 means we spend 300 ms on every boot re-confirming
> a fact that will be the same for every bootup.

Can't the code use a TSC (or similar high-res counter) to
see how long it takes to process a short 'hot cache' block?
That wouldn't take long at all.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

