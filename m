Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60332ECDE7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbhAGKdL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Jan 2021 05:33:11 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:29472 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbhAGKdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:33:10 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-6-SCUAd1AEPyGpzrF_WGAUQw-1;
 Thu, 07 Jan 2021 10:31:31 +0000
X-MC-Unique: SCUAd1AEPyGpzrF_WGAUQw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 7 Jan 2021 10:31:31 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 7 Jan 2021 10:31:31 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Subject: RE: [PATCH 7/6] x86: __always_inline __{rd,wr}msr()
Thread-Topic: [PATCH 7/6] x86: __always_inline __{rd,wr}msr()
Thread-Index: AQHW5N7SY2UD6xEyu0aMJREnibyUraob9aBw
Date:   Thu, 7 Jan 2021 10:31:31 +0000
Message-ID: <1a46f52f696f422ab95f31733e638f76@AcuMS.aculab.com>
References: <20210106143619.479313782@infradead.org>
 <20210106144017.532902065@infradead.org>
 <dc6e7e19-881a-c778-22df-15176db4aeb9@infradead.org>
 <X/bWK1tNB6mtm0Bu@hirez.programming.kicks-ass.net>
 <X/bf3gV+BW7kGEsB@hirez.programming.kicks-ass.net>
In-Reply-To: <X/bf3gV+BW7kGEsB@hirez.programming.kicks-ass.net>
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

From: Peter Zijlstra
> Sent: 07 January 2021 10:18
...
> -static inline unsigned long long notrace __rdmsr(unsigned int msr)
> +static __always_inline unsigned long long __rdmsr(unsigned int msr)

Since we (should) only request 'inline' for things that need to be
inlined, maybe inline should expand to __attribute__((always_inline)).

That might throw up a few warnings where inline has been misused.
But they are less problematic than things not being inlined.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

