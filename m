Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC1D2B9A3D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgKSR5M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Nov 2020 12:57:12 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:29926 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728451AbgKSR5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:57:11 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-194-1fE0Cy52OzOiF703RXrXFQ-1; Thu, 19 Nov 2020 17:57:07 +0000
X-MC-Unique: 1fE0Cy52OzOiF703RXrXFQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 19 Nov 2020 17:57:06 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 19 Nov 2020 17:57:06 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rich Felker' <dalias@libc.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
CC:     "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Florian Weimer <fw@deneb.enyo.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Gofman <gofmanp@gmail.com>
Subject: RE: Kernel prctl feature for syscall interception and emulation
Thread-Topic: Kernel prctl feature for syscall interception and emulation
Thread-Index: AQHWvps8vCklDp4dlUSnkfZ/iVi4VanPuwKQ
Date:   Thu, 19 Nov 2020 17:57:06 +0000
Message-ID: <d3734f734fbb4c3bacc8234be39f31be@AcuMS.aculab.com>
References: <873616v6g9.fsf@collabora.com>
 <20201119151317.GF534@brightrain.aerifal.cx> <87h7pltj9p.fsf@collabora.com>
 <20201119162801.GH534@brightrain.aerifal.cx> <87eekpmeux.fsf@collabora.com>
 <20201119173938.GJ534@brightrain.aerifal.cx>
In-Reply-To: <20201119173938.GJ534@brightrain.aerifal.cx>
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

> > The Windows code is not completely loaded at initialization time.  It
> > also has dynamic libraries loaded later.  yes, wine knows the memory
> > regions, but there is no guarantee there is a small number of segments
> > or that the full picture is known at any given moment.
> 
> Yes, I didn't mean it was known statically at init time (although
> maybe it can be; see below) just that all the code doing the loading
> is under Wine's control (vs having system dynamic linker doing stuff
> it can't reliably see, which is the case with host libraries).

Since wine must itself make the mmap() system calls that make memory
executable can't it arrange for windows code and linux code to be
above/below some critical address?

IIRC 32bit windows has the user/kernel split at 2G, so all the
linux code could be shoe-horned into the top 1GB.

A similar boundary could be picked for 64bit code.

This would probably require flags to mmap() to map above/below
the specified address (is there a flag for the 2G boundary
these days - wine used to do very horrid things).
It might also need a special elf interpreter to load the
wine code itself high.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

