Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312F62ABE5E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbgKIOOw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Nov 2020 09:14:52 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:44268 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730467AbgKIOOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:14:48 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-176-ab1M7LMuPKqwIq9jjcuAtw-1; Mon, 09 Nov 2020 14:14:44 +0000
X-MC-Unique: ab1M7LMuPKqwIq9jjcuAtw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 9 Nov 2020 14:14:43 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 9 Nov 2020 14:14:43 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "eranian@google.com" <eranian@google.com>
Subject: RE: [PATCH 4/6] perf: Optimize get_recursion_context()
Thread-Topic: [PATCH 4/6] perf: Optimize get_recursion_context()
Thread-Index: AQHWrxDB+hviZpPrkUisLgNdhr09JamxnS3ggA4n6oCAAB9HwA==
Date:   Mon, 9 Nov 2020 14:14:43 +0000
Message-ID: <262e5838b89f4776a1830bc218a6d9a6@AcuMS.aculab.com>
References: <20201030151345.540479897@infradead.org>
 <20201030151955.187580298@infradead.org> <20201030181138.215b2b6a@carbon>
 <20201030162248.58e388f0@oasis.local.home>
 <20201030230152.GT2594@hirez.programming.kicks-ass.net>
 <6371740df7704217926315e97294a894@AcuMS.aculab.com>
 <20201109121237.GJ2594@hirez.programming.kicks-ass.net>
In-Reply-To: <20201109121237.GJ2594@hirez.programming.kicks-ass.net>
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



> -----Original Message-----
> From: Peter Zijlstra <peterz@infradead.org>
> Sent: 09 November 2020 12:13
> To: David Laight <David.Laight@ACULAB.COM>
> Cc: Steven Rostedt <rostedt@goodmis.org>; Jesper Dangaard Brouer <brouer@redhat.com>;
> mingo@kernel.org; tglx@linutronix.de; linux-kernel@vger.kernel.org; kan.liang@linux.intel.com;
> acme@kernel.org; mark.rutland@arm.com; alexander.shishkin@linux.intel.com; jolsa@redhat.com;
> namhyung@kernel.org; ak@linux.intel.com; eranian@google.com
> Subject: Re: [PATCH 4/6] perf: Optimize get_recursion_context()
> 
> On Sat, Oct 31, 2020 at 12:11:42PM +0000, David Laight wrote:
> > The gcc 7.5.0 I have handy probably generates the best code for:
> >
> > unsigned char q_2(unsigned int pc)
> > {
> >         unsigned char rctx = 0;
> >
> >         rctx += !!(pc & (NMI_MASK));
> >         rctx += !!(pc & (NMI_MASK | HARDIRQ_MASK));
> >         rctx += !!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET));
> >
> >         return rctx;
> > }
> >
> > 0000000000000000 <q_2>:
> >    0:   f7 c7 00 00 f0 00       test   $0xf00000,%edi     # clock 0
> >    6:   0f 95 c0                setne  %al                # clock 1
> >    9:   f7 c7 00 00 ff 00       test   $0xff0000,%edi     # clock 0
> >    f:   0f 95 c2                setne  %dl                # clock 1
> >   12:   01 c2                   add    %eax,%edx          # clock 2
> >   14:   81 e7 00 01 ff 00       and    $0xff0100,%edi
> >   1a:   0f 95 c0                setne  %al
> >   1d:   01 d0                   add    %edx,%eax          # clock 3
> >   1f:   c3                      retq
> >
> > I doubt that is beatable.
> >
> > I've annotated the register dependency chain.
> > Likely to be 3 (or maybe 4) clocks.
> > The other versions are a lot worse (7 or 8) without allowing
> > for 'sbb' taking 2 clocks on a lot of Intel cpus.
> 
> https://godbolt.org/z/EfnG8E
> 
> Recent GCC just doesn't want to do that. Still, using u8 makes sense, so
> I've kept that.

u8 helps x86 because its 'setne' only affects the low 8 bits.
I guess that seemed a good idea when it was added (386).
It doesn't seem to make the other architectures much worse.

gcc 10.x can be persuaded to generate the above code.

https://godbolt.org/z/6GoT94

It sometimes seems to me that every new version of gcc is
larger, slower and generates worse code than the previous one.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

