Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C50270F25
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 17:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgISPhR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 19 Sep 2020 11:37:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:58060 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbgISPhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 11:37:17 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-84-GWrqbXc2NvCA3BPd7nszzA-1; Sat, 19 Sep 2020 16:37:13 +0100
X-MC-Unique: GWrqbXc2NvCA3BPd7nszzA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 19 Sep 2020 16:37:12 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 19 Sep 2020 16:37:12 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>,
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
Thread-Index: AQHWjhpCdhxJQ/Fq7U+wxL6/+NIsNalwFyxA
Date:   Sat, 19 Sep 2020 15:37:12 +0000
Message-ID: <40d7cc7127084d96a8654993a91b68f4@AcuMS.aculab.com>
References: <000000000000762dee05af9ccd01@google.com>
 <CALCETrVL=VGNXbWK1BB1LnsxaKOGRbEfCGUEx4jaCW9cF-54Ag@mail.gmail.com>
 <20200918235528.GB3421308@ZenIV.linux.org.uk>
 <CALCETrVi=quLyPXzt-0ou-FF_OYMa7pE5N8_NchRaWtwLg3kNg@mail.gmail.com>
 <20200919001714.GC3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200919001714.GC3421308@ZenIV.linux.org.uk>
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

From: Al Viro
> Sent: 19 September 2020 01:17
> 
> On Fri, Sep 18, 2020 at 05:07:43PM -0700, Andy Lutomirski wrote:
> > On Fri, Sep 18, 2020 at 4:55 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Fri, Sep 18, 2020 at 04:31:33PM -0700, Andy Lutomirski wrote:
> > >
> > > > check_zeroed_user() looks buggy.  It does:
> > > >
> > > >        if (!user_access_begin(from, size))
> > > >                return -EFAULT;
> > > >
> > > >        unsafe_get_user(val, (unsigned long __user *) from, err_fault);
> > > >
> > > > This is wrong if size < sizeof(unsigned long) -- you read outside the
> > > > area you verified using user_access_begin().
> > >
> > > Read the code immediately prior to that.  from will be word-aligned,
> > > and size will be extended accordingly.  If the area acceptable for
> > > user_access_begin() ends *NOT* on a word boundary, you have a problem
> > > and I would strongly recommend to seek professional help.
> > >
> > > All reads in that thing are word-aligned and word-sized.  So I very
> > > much doubt that your analysis is correct.
> >
> > Maybe -ETOOTIRED, but I seriously question the math in here.  Suppose
> > from == (unsigned long *)1 and size == 1.  Then align is 1, and we do:
> >
> > from -= align;
> > size += align;
> >
> > So now from = 0 and size = 2.  Now we do user_access_begin(0, 2) and
> > then immediately read 4 or 8 bytes.  No good.
> 
> Could you explain what kind of insane hardware manages to do #PF-related
> checks (including SMAP, whatever) with *sub*WORD* granularity?
> 
> If it's OK with 16bit read from word-aligned address, but barfs on 64bit
> one...  I want to know what the hell had its authors been smoking.

Not going to happen to anything in the data cache. But...

Byte parity errors on memory locations that have never been written
but power-up initialised to 'bad parity'?

I have seen that - but I've completely forgotten the hardware.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

