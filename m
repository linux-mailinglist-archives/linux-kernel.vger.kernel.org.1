Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015EA2B0A9E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgKLQpx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Nov 2020 11:45:53 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:56672 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728440AbgKLQpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:45:51 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-3-aKrBW9CZMZ2uIiRcSGeriw-1;
 Thu, 12 Nov 2020 16:45:47 +0000
X-MC-Unique: aKrBW9CZMZ2uIiRcSGeriw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 12 Nov 2020 16:45:46 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 12 Nov 2020 16:45:46 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Petr Mladek' <pmladek@suse.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
CC:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sergey.senozhatsky@gmail.com" <sergey.senozhatsky@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: RE: [PATCH] lib: vsprintf: Avoid 32-bit truncation in vsscanf number
 parsing
Thread-Topic: [PATCH] lib: vsprintf: Avoid 32-bit truncation in vsscanf number
 parsing
Thread-Index: AQHWuREitk877znmAUizKKe6Yw5Ch6nEsaVg
Date:   Thu, 12 Nov 2020 16:45:46 +0000
Message-ID: <1fd034ae48b342429896120cefee91d9@AcuMS.aculab.com>
References: <20201112111759.16377-1-rf@opensource.cirrus.com>
 <20201112161746.GH20201@alley>
In-Reply-To: <20201112161746.GH20201@alley>
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

From: Petr Mladek
> Sent: 12 November 2020 16:18
> 
> Adding other vsprintf maintainers and reviewes into CC.
> 
> On Thu 2020-11-12 11:17:59, Richard Fitzgerald wrote:
> > Number conversion in vsscanf converts a whole string of digits and then
> > extracts the field width part from the converted value. The maximum run
> > of digits is limited by overflow. Conversion was using either
> > simple_strto[u]l or simple_strto[u]ll based on the 'L' qualifier. This
> > created a difference in truncation between builds where long is 32-bit
> > and builds where it is 64-bit. This especially affects parsing a run of
> > contiguous digits into separate fields - the maximum length of the run
> > is 16 digits if long is 64-bit but only 8 digits if long is 32-bits.
> > For example a conversion "%6x%6x" would convert both fields correctly if
> > long is 64-bit but not if long is 32-bit.

If %6x%6x works one might expect %6x%6x%6x to also work.

> I might be just slow today. But it took me really long time to
> understand what exactly is the problem and how it is caused.
> The description is nicely detailed but somehow cryptic.
> 
> My understanding is that there is a bug when parsing numbers
> with a limited width like the above mentioned "%6x%6x".
> 
> The problem is how the width is handled:
> 
>  1. The width is ignored in the 1st step. The entire number
>     is read using simple_strto[u]l[l] functions.
> 
>  2. The width limit is achieved by dividing the result from
>     the first step until it fits the width.
> 
> It gives wrong result when there was an overflow in the 1st step.
> The high bits were lost even when the limited number would
> not overflow.

What happens if there are leading zeros on the hex input?
From the description I think 'something terrible happens'.
(Well, horribly unexpected anyway.)

I'd also expect strtoull() to 'eat' all the digits that exist,
not stop when the value got too large.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

