Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B08B2D2D43
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgLHOcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgLHOcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:32:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DDCC061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 06:31:43 -0800 (PST)
Date:   Tue, 8 Dec 2020 15:31:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607437901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WVcSuuygsXNMV9kVaZ17L42D6L+abQR56EO42343yPg=;
        b=eFRlu0OyTIhq2hXElBzeGQ6sABMM9z2EctfnU50NcV/7M03wQzXhtnilzt+0tQw3XKHHC0
        Tpu61iRG4LN8sMVNiITB6DtSlE2HU7g5HnvjAfVJYnFpAtApTsnwv2aqczvBVlBzQYORUT
        qTyvlqHTri0tJHg0wBHlV/TvDmm5aDs3YXLWLGkXV9/1faZTwn0AyHggghGUUPrtkrwOWp
        9GxmL9e2XHxvYYFmIG8ZfuqsmSBHGX67yeCFJVGyIIDrqEI/7c3BXY6xls4tGsRDPT4Su/
        HBrqFwMLo2iQQgep+vRan1wwVToEwcHlT5yr3TkIGWOS/W0yC9U1QGk39ZhTFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607437901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WVcSuuygsXNMV9kVaZ17L42D6L+abQR56EO42343yPg=;
        b=M9CXzNEqcgrP1LzgssmA3YQebFAeA8029DkH/4EB2cjgS1ZIHm6KSNFjHhC1XO06OEkccn
        51dEmFU18i72TXCA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>
Subject: Re: [PATCH -tip v1 3/3] seqlock: kernel-doc: Specify when preemption
 is automatically altered
Message-ID: <X8+OS/K0+9ibIEGz@lx-t490>
References: <20201206162143.14387-1-a.darwish@linutronix.de>
 <20201206162143.14387-4-a.darwish@linutronix.de>
 <20201207204316.GF552508@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207204316.GF552508@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, Dec 07, 2020 at 04:43:16PM -0400, Jason Gunthorpe wrote:
...
>
> The thing that was confusing is if it was appropriate to use a
> seqcount in case where write side preemption was not disabled - which
> is safe only if the read side doesn't spin.
>

No, that's not correct.

What was confusing was that *everyone* in that mm/ thread, including
yourself, thought that write_seqcount_begin() will automatically disable
preemption for plain seqcount_t:

  https://lkml.kernel.org/r/20201030235121.GQ2620339@nvidia.com

Quoting Peter Xu: "My understanding is that we used
raw_write_seqcount_t_begin() because we're with spin lock so assuming we
disabled preemption already."

Quoting you: "write_seqcount_begin - Enforces preemption off".

And that's why this patch explicitly adds to the kernel-doc: "Preemption
will be automatically disabled if and only if the seqcount write
serialization lock is associated, and preemptible."

Honestly, I should've added that statement anyway in my original
"sequence counters with associated locks" submission. I take the blame
for the resulting confusion, and I'm sorry...

~~~~~~~~~~~~~~~~~~~~

Now regarding the other point, where the seqcount_t write side does not
need to disable preemption if the reader does not spin. We've already
discussed that (at length) last time.

There comes a point where you decide what level of documentation to add,
and what level to skip.

Because in the end, you don't want to confuse "Joe, the generic driver
developer" with too much details that's not relevant to their task at
hand.

You want to keep the general case simple, but the special case do-able.
And you also want to encourage people to use the standard write side
critical section entry and exit functions, as much as possible.

Because, oh, look at that:

  [PATCH v2 0/6] seqlock: seqcount_t call sites bugfixes
  https://lkml.kernel.org/r/20200603144949.1122421-1-a.darwish@linutronix.de

Sequence counters are already hard to get right. And driver developers
get things wrong, a lot -- you don't want to confuse them even further.

For developers who're advanced enough to know the difference, they don't
need the kernel-doc anyway. And that's why I've kindly asked to add the
following to your mm/ patch (which you did, thanks):

	/*
	 * Disabling preemption is not needed for the write side, as
	 * the read side does not spin, but goes to mmap_lock.
	 * ...
	 */

And IMHO, that should be enough. Developers of such special cases are
already assumed to know what they're doing.

Thanks a lot,

--
Ahmed S. Darwish
Linutronix GmbH
