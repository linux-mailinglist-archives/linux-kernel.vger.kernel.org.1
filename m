Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4593A2A42E9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgKCKfW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Nov 2020 05:35:22 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:60260 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725988AbgKCKfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:35:19 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-233-2rsIwucwNt6IOklb3brp3w-1; Tue, 03 Nov 2020 10:35:14 +0000
X-MC-Unique: 2rsIwucwNt6IOklb3brp3w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 3 Nov 2020 10:35:13 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 3 Nov 2020 10:35:13 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Chao Yu' <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: RE: [f2fs-dev] [PATCH] f2fs: compress: support chksum
Thread-Topic: [f2fs-dev] [PATCH] f2fs: compress: support chksum
Thread-Index: AQHWsYo6GU/sZ9yvlUirgmcRS3PqXKm2M3MA
Date:   Tue, 3 Nov 2020 10:35:13 +0000
Message-ID: <aa11afd31edb42979c03d2a27ed9e850@AcuMS.aculab.com>
References: <20201102122333.76667-1-yuchao0@huawei.com>
 <20201102163123.GD529594@google.com>
 <756e482c-b638-1c09-3868-ae45d33ed2c2@huawei.com>
 <6b5bce0e-c967-b9cf-3544-a8e65595059c@huawei.com>
In-Reply-To: <6b5bce0e-c967-b9cf-3544-a8e65595059c@huawei.com>
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

From: Chao Yu
> Sent: 03 November 2020 02:37
...
> >> Do we need to change fsck.f2fs to recover this?
> 
> However, we don't know which one is correct, compressed data or chksum value?
> if compressed data was corrupted, repairing chksum value doesn't help.
> 
> Or how about adding chksum values for both raw data and compressed data.

What errors are you trying to detect?

If there are errors in the data then 'fixing' the checksum is pointless.
(You've got garbage data - might as well not have the checksum).

If you are worried about the implementation of the compression
algorithm then a checksum of the raw data is needed.

If you want to try error correcting burst errors in the compressed
data then a crc of the compressed data can be used for error correction.

OTOH the most likely error is that the file meta-data and data sector
weren't both committed to disk when the system crashed.
In which case the checksum has done its job and the file is corrupt.
fsck should probably move the file to 'lost+found' for manual checking.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

