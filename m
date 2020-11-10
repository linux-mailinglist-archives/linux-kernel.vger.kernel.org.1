Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F122AD5F3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgKJMQm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Nov 2020 07:16:42 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:24712 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbgKJMQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:16:41 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-216-ep7CIZcmM6mQ50C-RJpcMQ-1; Tue, 10 Nov 2020 12:16:37 +0000
X-MC-Unique: ep7CIZcmM6mQ50C-RJpcMQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 10 Nov 2020 12:16:37 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 10 Nov 2020 12:16:37 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Chao Yu' <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: RE: [f2fs-dev] [PATCH] f2fs: compress: support chksum
Thread-Topic: [f2fs-dev] [PATCH] f2fs: compress: support chksum
Thread-Index: AQHWtyqj1VtcccaQGU+ZRA66ANZtT6nBRPmg
Date:   Tue, 10 Nov 2020 12:16:37 +0000
Message-ID: <db1d478cda6642d1b08c3435e84944d9@AcuMS.aculab.com>
References: <20201102122333.76667-1-yuchao0@huawei.com>
 <20201102163123.GD529594@google.com>
 <756e482c-b638-1c09-3868-ae45d33ed2c2@huawei.com>
 <6b5bce0e-c967-b9cf-3544-a8e65595059c@huawei.com>
 <20201106211247.GA1474936@google.com>
 <908682bb-486c-222f-bea7-43fc961ef1b0@huawei.com>
 <20201109170625.GB2129970@google.com>
 <3417aea5-ace8-74be-ec26-f491dddea676@huawei.com>
 <20201110042353.GB1598246@google.com>
 <513c56d7-cefd-37a8-efdf-fa1ac8c2a1d3@huawei.com>
In-Reply-To: <513c56d7-cefd-37a8-efdf-fa1ac8c2a1d3@huawei.com>
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
> Sent: 10 November 2020 06:28
...
> Actually, I think the both results are the same, inode chksum doesn't match inode
> metadata, like current case that cluster chksum doesn't match cluster data, it
> doesn't matter how it becomes mismatched.
> 
> And also, in those inode corrupted cases, there should be some cases that hacker
> or fuzz tester injects random data in chksum intentionally, or bit-flipping happed
> on chksum value in inode, inode metadata (except inode chksum) is integrated though,
> we can not distinguish such cases from case of inode metadata (except inode chksum)
> corruption.

If you reverse the crc algotithm on the checksum error bits and get a
pattern with a small number of adjacent ones then that would be a burst
error that would generate the observed crc error.

So if you have a 32bit crc on an 8k byte buffer there are 64k bit positions
so (IIRC from my university days) you can fix an assumed 16 bit error burst.
That would be a bit dangerous through.
OTOH if you find an 8-bit error pattern you could assume (and fix)
a single byte corruption.

Whether that is worth doing depends on any assumed mechanisms
for generating corruptions.

I don't know of any ethernet hardware that uses the 32bit crc
to fix very short burst errors (or even single bit errors)
even though it could be done and burst errors are quite likely.
(Below Ge speeds.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

