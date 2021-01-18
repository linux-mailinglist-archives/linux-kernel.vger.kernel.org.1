Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD732FA283
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392632AbhAROFb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 Jan 2021 09:05:31 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:52645 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392622AbhAROE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:04:56 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-175-xOhOvC86NguXJNtyDtvyUg-1; Mon, 18 Jan 2021 14:03:08 +0000
X-MC-Unique: xOhOvC86NguXJNtyDtvyUg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 18 Jan 2021 14:03:07 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 18 Jan 2021 14:03:07 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        =?iso-8859-2?Q?Krzysztof_Ol=EAdzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH 1/4] x86/fpu: Add kernel_fpu_begin_mask() to selectively
 initialize state
Thread-Topic: [PATCH 1/4] x86/fpu: Add kernel_fpu_begin_mask() to selectively
 initialize state
Thread-Index: AQHW7WJaj1C/G8lQukGQKbQ/ZO1Lg6otaOUA
Date:   Mon, 18 Jan 2021 14:03:07 +0000
Message-ID: <71144eab31a34dc7add39655a289f8a8@AcuMS.aculab.com>
References: <cover.1610950681.git.luto@kernel.org>
 <a9630f17c5bcafbfe297a0828c7b6c78b0f6dcbe.1610950681.git.luto@kernel.org>
In-Reply-To: <a9630f17c5bcafbfe297a0828c7b6c78b0f6dcbe.1610950681.git.luto@kernel.org>
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
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski
> Sent: 18 January 2021 06:21
> 
> Currently, requesting kernel FPU access doesn't distinguish which parts of
> the extended ("FPU") state are needed.  This is nice for simplicity, but
> there are a few cases in which it's suboptimal:
> 
>  - The vast majority of in-kernel FPU users want XMM/YMM/ZMM state but do
>    not use legacy 387 state.  These users want MXCSR initialized but don't
>    care about the FPU control word.  Skipping FNINIT would save time.
>    (Empirically, FNINIT is several times slower than LDMXCSR.)
> 
>  - Code that wants MMX doesn't want need MXCSR or FCW initialized.
>    _mmx_memcpy(), for example, can run before CR4.OSFXSR gets set, and
>    initializing MXCSR will fail.
> 
>  - Any future in-kernel users of XFD (eXtended Feature Disable)-capable
>    dynamic states will need special handling.
> 
> This patch adds a more specific API that allows callers specify exactly
> what they want.

Is it worth returning whether the required fpu feature is available?
Or, maybe optionally, available cheaply?

There are also code fragments that really just want one or two
[xyx]mm registers to speed something up.
For instance PCIe reads can be a lot faster if a wide register
can be used.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

