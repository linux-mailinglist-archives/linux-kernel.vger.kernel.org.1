Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBC52E94A4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 13:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbhADMSf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Jan 2021 07:18:35 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:23205 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726236AbhADMSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 07:18:35 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-161-e-HVRhClO9mndLuADFhIAA-1; Mon, 04 Jan 2021 12:16:56 +0000
X-MC-Unique: e-HVRhClO9mndLuADFhIAA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 4 Jan 2021 12:16:56 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 4 Jan 2021 12:16:56 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: in_compat_syscall() on x86
Thread-Topic: in_compat_syscall() on x86
Thread-Index: Adbikf8I52+Fp/HYSH2MXxqk00t/Og==
Date:   Mon, 4 Jan 2021 12:16:56 +0000
Message-ID: <e817cfdc2df3433bb7fb357db89d4d48@AcuMS.aculab.com>
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

On x86 in_compat_syscall() is defined as:
    in_ia32_syscall() || in_x32_syscall()

Now in_ia32_syscall() is a simple check of the TS_COMPAT flag.
However in_x32_syscall() is a horrid beast that has to indirect
through to the original %eax value (ie the syscall number) and
check for a bit there.

So on a kernel with x32 support (probably most distro kernels)
the in_compat_syscall() check is rather more expensive than
one might expect.

It would be muck better if both checks could be done together.
I think this would require the syscall entry code to set a
value in both the 64bit and x32 entry paths.
(Can a process make both 64bit and x32 system calls?)

To do this sensible (probably) requires a byte be allocated
to hold the syscall type - rather than using flag bits
in the 'status' field.

Apart from the syscall entry, the exec code seems to change
the syscall type to that of the binary being executed.
I didn't spot anything else that changes the fields.

But I failed to find the full list of allocated bits for
the 'status' field.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

