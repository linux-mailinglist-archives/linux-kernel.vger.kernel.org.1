Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590EB272136
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIUKda convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Sep 2020 06:33:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:34997 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726699AbgIUKdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:33:25 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-108-DbCTplcGNneZ3ytIFDanIg-1; Mon, 21 Sep 2020 11:33:20 +0100
X-MC-Unique: DbCTplcGNneZ3ytIFDanIg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 21 Sep 2020 11:33:19 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 21 Sep 2020 11:33:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rasmus Villemoes' <linux@rasmusvillemoes.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>
CC:     syzbot <syzbot+ea3a78a71705faf41d77@syzkaller.appspotmail.com>,
        "Aleksa Sarai" <cyphar@cyphar.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, "X86 ML" <x86@kernel.org>
Subject: RE: WARNING in ex_handler_uaccess
Thread-Topic: WARNING in ex_handler_uaccess
Thread-Index: AQHWkAEVdhxJQ/Fq7U+wxL6/+NIsNaly5Eug
Date:   Mon, 21 Sep 2020 10:33:19 +0000
Message-ID: <8bef09fd4d644f48a7c83aa18b653f76@AcuMS.aculab.com>
References: <000000000000762dee05af9ccd01@google.com>
 <CALCETrVL=VGNXbWK1BB1LnsxaKOGRbEfCGUEx4jaCW9cF-54Ag@mail.gmail.com>
 <20200918235528.GB3421308@ZenIV.linux.org.uk>
 <CALCETrVi=quLyPXzt-0ou-FF_OYMa7pE5N8_NchRaWtwLg3kNg@mail.gmail.com>
 <20200919001714.GC3421308@ZenIV.linux.org.uk>
 <bc5d889c-17f0-dcb8-d174-f21b321cf85b@rasmusvillemoes.dk>
In-Reply-To: <bc5d889c-17f0-dcb8-d174-f21b321cf85b@rasmusvillemoes.dk>
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

From: Rasmus Villemoes
> Sent: 21 September 2020 11:22
 
> On 19/09/2020 02.17, Al Viro wrote:
> > On Fri, Sep 18, 2020 at 05:07:43PM -0700, Andy Lutomirski wrote:
> >> On Fri, Sep 18, 2020 at 4:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >>>
> >>> On Fri, Sep 18, 2020 at 04:31:33PM -0700, Andy Lutomirski wrote:
> >>>
> >>>> check_zeroed_user() looks buggy.  It does:
> >>>>
> >>>>        if (!user_access_begin(from, size))
> >>>>                return -EFAULT;
> >>>>
> >>>>        unsafe_get_user(val, (unsigned long __user *) from, err_fault);
> >>>>
> >>>> This is wrong if size < sizeof(unsigned long) -- you read outside the
> >>>> area you verified using user_access_begin().
> >>>
> >>> Read the code immediately prior to that.  from will be word-aligned,
> >>> and size will be extended accordingly.  If the area acceptable for
> >>> user_access_begin() ends *NOT* on a word boundary, you have a problem
> >>> and I would strongly recommend to seek professional help.
> >>>
> >>> All reads in that thing are word-aligned and word-sized.  So I very
> >>> much doubt that your analysis is correct.
> >>
> >> Maybe -ETOOTIRED, but I seriously question the math in here.  Suppose
> >> from == (unsigned long *)1 and size == 1.  Then align is 1, and we do:
> >>
> >> from -= align;
> >> size += align;
> >>
> >> So now from = 0 and size = 2.  Now we do user_access_begin(0, 2) and
> >> then immediately read 4 or 8 bytes.  No good.
> >
> > Could you explain what kind of insane hardware manages to do #PF-related
> > checks (including SMAP, whatever) with *sub*WORD* granularity?
> >
> > If it's OK with 16bit read from word-aligned address, but barfs on 64bit
> > one...  I want to know what the hell had its authors been smoking.
> >
> 
> So, not sure how the above got triggered, but I notice there might be an
> edge case in check_zeroed_user():
> 
> 	from -= align;
> 	size += align;
> 
> 	if (!user_read_access_begin(from, size))
> 		return -EFAULT;
> 
> 	unsafe_get_user(val, (unsigned long __user *) from, err_fault);
> 
> 
> Suppose size is (size_t)-3 and align is 3. What's the convention for
> access_ok(whatever, 0)? Is that equivalent to access_ok(whatever, 1), or
> is it always true (or $ARCH-dependent)?

Doesn't matter, it will be doing access_ok(xxx, 8) regardless of
the user-supplied transfer length.

> But, AFAICT, no current caller of check_zeroed_user can end up passing
> in a size that can overflow to 0. E.g. for the case at hand, size cannot
> be more than SIZE_MAX-24.

Basically KASAN doesn't like you reading full words and masking
off the unused bytes.

	David

	

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

