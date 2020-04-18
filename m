Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F381AECB4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 15:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDRNMP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 18 Apr 2020 09:12:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:44834 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbgDRNMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 09:12:14 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-131-rGoIA-_aOhihO9LMd8F6hg-1; Sat, 18 Apr 2020 14:12:08 +0100
X-MC-Unique: rGoIA-_aOhihO9LMd8F6hg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 18 Apr 2020 14:12:07 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 18 Apr 2020 14:12:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Jakub Jelinek <jakub@redhat.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Michael Matz <matz@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2] x86: fix early boot crash on gcc-10
Thread-Topic: [PATCH v2] x86: fix early boot crash on gcc-10
Thread-Index: AQHWFKRQ3c596QelW0eAgWyRTVEr96h+3Cjw
Date:   Sat, 18 Apr 2020 13:12:07 +0000
Message-ID: <26a33cf023024a52bb85bfbe9be2e1fa@AcuMS.aculab.com>
References: <20200328084858.421444-1-slyfox@gentoo.org>
 <20200413163540.GD3772@zn.tnic>
 <alpine.LSU.2.21.2004141343370.11688@wotan.suse.de>
 <20200415074842.GA31016@zn.tnic>
 <alpine.LSU.2.21.2004151445520.11688@wotan.suse.de>
 <20200415231930.19755bc7@sf> <20200417075739.GA7322@zn.tnic>
 <20200417080726.GS2424@tucnak> <20200417084224.GB7322@zn.tnic>
 <20200417085859.GU2424@tucnak>
 <20200417103808.GW20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200417103808.GW20730@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra
> Sent: 17 April 2020 11:38
> 
> On Fri, Apr 17, 2020 at 10:58:59AM +0200, Jakub Jelinek wrote:
> > Or go with the for (;;);, I don't think any compiler optimizes those away;
> > GCC 10 for C++ can optimize away infinite loops that have some conditional
> > exit because the language guarantees forward progress, but the C language
> > rules are different and for unconditional infinite loops GCC doesn't
> > optimize them away even if explicitly asked to -ffinite-loops.
> 
> 'Funnily' there are people building the kernel with C++ :/

Can't you 'make progress' by using longjmp() to exit a signal handler?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

