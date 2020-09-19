Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A013D270E35
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 15:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgISNuq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Sep 2020 09:50:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:49513 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726159AbgISNuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 09:50:46 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-217-sBKr2MWsPJyQWXL4zt-j_w-1; Sat, 19 Sep 2020 14:50:42 +0100
X-MC-Unique: sBKr2MWsPJyQWXL4zt-j_w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 19 Sep 2020 14:50:41 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 19 Sep 2020 14:50:41 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Samuel Holland' <samuel@sholland.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] powerpc: Select HAVE_FUTEX_CMPXCHG
Thread-Topic: [PATCH] powerpc: Select HAVE_FUTEX_CMPXCHG
Thread-Index: AQHWjjP8ICmOrEPCtEqSzubXo06uGalv9oPA
Date:   Sat, 19 Sep 2020 13:50:41 +0000
Message-ID: <7c3e299f9c134eab9ba1e6d07a77f7b6@AcuMS.aculab.com>
References: <20200919032009.8346-1-samuel@sholland.org>
In-Reply-To: <20200919032009.8346-1-samuel@sholland.org>
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

From: Samuel Holland
> Sent: 19 September 2020 04:20
> 
> On powerpc, access_ok() succeeds for the NULL pointer. This breaks the
> dynamic check in futex_detect_cmpxchg(), which expects -EFAULT. As a
> result, robust futex operations are not functional on powerpc.

access_ok(NULL, sane_count) will succeed on all (maybe most) architectures.
All access_ok() does is check that kernel addresses aren't referenced.
(access_ok(kernel_adress, 0) is also likely to succeed.)

It is the access to user-address 0 that is expected to fault.
If this isn't faulting something else is wrong.

Historically (at least pre-elf, if not before) user programs
were linked to address zero - so the page was mapped.
(Linux may be too new to actually require it.)
Not sure what 'wine' requires for win-32 execuatbles.

ISTR there are also some 'crazy' ARM? cpu that read the interrupt
vectors from address 0 in user-space.

So assuming:

static void __init futex_detect_cmpxchg(void)
{
#ifndef CONFIG_HAVE_FUTEX_CMPXCHG
        u32 curval;

        /*
         * This will fail and we want it. Some arch implementations do
         * runtime detection of the futex_atomic_cmpxchg_inatomic()
         * functionality. We want to know that before we call in any
         * of the complex code paths. Also we want to prevent
         * registration of robust lists in that case. NULL is
         * guaranteed to fault and we get -EFAULT on functional
         * implementation, the non-functional ones will return
         * -ENOSYS.
         */
        if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) == -EFAULT)
                futex_cmpxchg_enabled = 1;
#endif
}

will fail -EFAULT because user address 0 is invalid seems hopeful.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

