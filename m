Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391AD293653
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732491AbgJTIAa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 20 Oct 2020 04:00:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:42501 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727414AbgJTIA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:00:29 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-182-3UZfjS2sNXmKBFCHRrRCaw-1; Tue, 20 Oct 2020 09:00:26 +0100
X-MC-Unique: 3UZfjS2sNXmKBFCHRrRCaw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 20 Oct 2020 09:00:19 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 20 Oct 2020 09:00:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>, kernel test robot <lkp@intel.com>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: RE: lib/crypto/chacha.c:65:1: warning: the frame size of 1604 bytes
 is larger than 1024 bytes
Thread-Topic: lib/crypto/chacha.c:65:1: warning: the frame size of 1604 bytes
 is larger than 1024 bytes
Thread-Index: AQHWpi8k7bm61YvdGUSnOFfVI7UcramgIItA
Date:   Tue, 20 Oct 2020 08:00:19 +0000
Message-ID: <c5af8f26bcb3468eb777bb8a8c8258d6@AcuMS.aculab.com>
References: <202010190356.fgwA7zzR-lkp@intel.com>
 <80f9a6c79771167d119b2990910fe273c3901df0.camel@perches.com>
In-Reply-To: <80f9a6c79771167d119b2990910fe273c3901df0.camel@perches.com>
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

From: Joe Perches
> Sent: 19 October 2020 16:47
> On Mon, 2020-10-19 at 03:13 +0800, kernel test robot wrote:
> > Hi Ard,
> >
> > First bad commit (maybe != root cause):
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   9d9af1007bc08971953ae915d88dc9bb21344b53
> > commit: 5fb8ef25803ef33e2eb60b626435828b937bed75 crypto: chacha - move existing library code into
> lib/crypto
> > date:   11 months ago
> > config: i386-randconfig-r023-20201019 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> > reproduce (this is a W=1 build):
> >         #
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5fb8ef25803ef33e2eb60b62
> 6435828b937bed75
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 5fb8ef25803ef33e2eb60b626435828b937bed75
> >         # save the attached .config to linux build tree
> >         make W=1 ARCH=i386
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    lib/crypto/chacha.c: In function 'chacha_permute':
> > > > lib/crypto/chacha.c:65:1: warning: the frame size of 1604 bytes is larger than 1024 bytes [-
> Wframe-larger-than=]
> >       65 | }
> >          | ^
> >
> > vim +65 lib/crypto/chacha.c
> 
> This seems to come from function tracing overhead.

Are you sure?
I've not got the x86 object, but the x86-64 version caches the 16 x[]
values (from the parameter) in registers.
The 32 bit cpu doesn't have enough registers, but gcc tends to
compile assuming an infinite number.
So it may have spilled lots of virtual registers to different
stack locations - instead of writing the values to their 'target'
address.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

