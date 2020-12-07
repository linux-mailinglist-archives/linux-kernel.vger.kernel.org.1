Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5152D16C4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgLGQsU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Dec 2020 11:48:20 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:33219 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727303AbgLGQsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:48:20 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-242-QI3yR-scPsyRFFaCGeCl_A-1; Mon, 07 Dec 2020 16:46:41 +0000
X-MC-Unique: QI3yR-scPsyRFFaCGeCl_A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 7 Dec 2020 16:46:40 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 7 Dec 2020 16:46:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'John Ogness' <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
Thread-Topic: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
Thread-Index: AQHWzICKswdVD7bXr0KkK6JFsMrIzKnr1zJA
Date:   Mon, 7 Dec 2020 16:46:40 +0000
Message-ID: <d7d870a0081d4375945d169ee5850b9d@AcuMS.aculab.com>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-3-john.ogness@linutronix.de> <X8n9a2DWUFE/giyB@alley>
 <875z5eof8g.fsf@jogness.linutronix.de>
 <20201207093419.GH3040@hirez.programming.kicks-ass.net>
 <87mtyq9blw.fsf@jogness.linutronix.de>
In-Reply-To: <87mtyq9blw.fsf@jogness.linutronix.de>
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

From: John Ogness
> Sent: 07 December 2020 10:04
> 
> On 2020-12-07, Peter Zijlstra <peterz@infradead.org> wrote:
> >> Yes, and it is read-only access. Perhaps atomic64_t is the wrong thing
> >> to use here. We could use a seqcount_latch and a shadow variable so that
> >> if a writer has been preempted, we can use the previous value. (Only
> >> kmsg_dump would need to use the lockless variant to read the value.)
> >>
> >> void clear_seq_set(u64 val)
> >> {
> >>         spin_lock_irq(&clear_lock);
> >>         raw_write_seqcount_latch(&clear_latch);
> >>         clear_seq[0] = val;
> >>         raw_write_seqcount_latch(&clear_latch);
> >>         clear_seq[1] = val;
> >>         spin_unlock_irq(&clear_lock);
> >> }
> >>
> >> u64 clear_seq_get_nolock(void)
> >> {
> >>         unsigned int seq, idx;
> >>         u64 val;
> >>
> >>         do {
> >>                 seq = raw_read_seqcount_latch(&clear_latch);
> >>                 idx = seq & 0x1;
> >>                 val = clear_seq[idx];
> >>         } while (read_seqcount_latch_retry(&clear_latch, seq));
> >>
> >>         return val;
> >> }
> >
> > That's overly complicated.
> >
> > If you're going to double the storage you can simply do:
> >
> >
> > 	seq = val
> > 	smp_wmb();
> > 	seq_copy = val;
> >
> > vs
> >
> > 	do {
> > 		tmp = seq_copy;
> > 		smp_rmb();
> > 		val = seq;
> > 	} while (val != tmp);
> 
> That will not work. We are talking about a situation where the writer is
> preempted. So seq will never equal seq_copy in that situation. I expect
> that the seqcount_latch is necessary.

Is the value just being incremented??
If so you can do:
	seq_hi_0 = val >> 32;
	smp_wmb();
	seq_lo = val;
	smp_wmb();
	seq_hi_1 = val >> 32;

Then the reader can assume that seq_lo is zero if seq_h1_0 and
seq_hi_1 differ.

	David

	

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

