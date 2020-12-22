Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD39C2E0E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 19:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgLVSoa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Dec 2020 13:44:30 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:20188 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725967AbgLVSo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 13:44:29 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-216-NzeuVMnNNqCo6nmnfbI2nQ-1; Tue, 22 Dec 2020 18:42:50 +0000
X-MC-Unique: NzeuVMnNNqCo6nmnfbI2nQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 22 Dec 2020 18:42:49 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 22 Dec 2020 18:42:49 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'qianjun.kernel@gmail.com'" <qianjun.kernel@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] mm:improve the performance during fork
Thread-Topic: [PATCH 1/1] mm:improve the performance during fork
Thread-Index: AQHW2FzhXFuZ8KmDFkCjkZcJPkqDtKoDcq7g
Date:   Tue, 22 Dec 2020 18:42:49 +0000
Message-ID: <eb9eaaa40c6643179d20a6067865c283@AcuMS.aculab.com>
References: <20201222121904.50845-1-qianjun.kernel@gmail.com>
In-Reply-To: <20201222121904.50845-1-qianjun.kernel@gmail.com>
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

From: qianjun
> Sent: 22 December 2020 12:19
> 
> In our project, Many business delays come from fork, so
> we started looking for the reason why fork is time-consuming.
> I used the ftrace with function_graph to trace the fork, found
> that the vm_normal_page will be called tens of thousands and
> the execution time of this vm_normal_page function is only a
> few nanoseconds. And the vm_normal_page is not a inline function.
> So I think if the function is inline style, it maybe reduce the
> call time overhead.

Beware of taking timings from ftrace function trace.
The cost of the tracing is significant.

You can get sensible numbers if you only trace very specific
functions.
Slightly annoyingly the output format changes if you enable
the function exit trace - useful for the timestamp.
ISTR it is possible to get the process id traced if you fiddle
with enough options.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

