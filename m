Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17E9255691
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 10:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgH1Igq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 04:36:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43856 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgH1Ign (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 04:36:43 -0400
Date:   Fri, 28 Aug 2020 10:37:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598603801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pOCz0+m6Q3dzLmGCe/U+1Ir1tkOUWh0lzPLpXP4rESU=;
        b=L64pBzxBF2X1LhBifpV/LOyayH7sFDp00Gu2jNEB7iQhEapqPAP6NN5ePDUSy/IcSu31k9
        khRRwpvPowk1ObbACcrJUlutB7gMeC+IvQXPzWfj6TbnuBAEs51+IiusLM+5X3HsUz3Pz0
        Ocb+8mJZxF6tgCey+lOfX1gP3LunL5a3Ny8+pE51UX81Lv5FtI/Vw63RjXLVPiFh0BXTVf
        yQKJTeub5n848JljZI2aiLusL2A0HmPrZjkzrIA5SWhbWnznJmaxD2emCppVoHSy5Z7Ew7
        KP3kNLR77eO74UiwuClJUNWgzkqaIAhI6+6PP7f6dv0k2HsJJITLvwxLrRYPEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598603801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pOCz0+m6Q3dzLmGCe/U+1Ir1tkOUWh0lzPLpXP4rESU=;
        b=dHNcpQcSx5+qWH8EuEM8+ttbRH3Srio3bSru4Zgk3bxanxxJKRKutAKN9sfv1rq8Wrzxl8
        lRerVAUk/GRW5wBQ==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     peterz@infradead.org
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/5] seqlock: seqcount_t: Implement all read APIs as
 statement expressions
Message-ID: <20200828083702.GA7074@lx-t490>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200828010710.5407-1-a.darwish@linutronix.de>
 <20200828010710.5407-4-a.darwish@linutronix.de>
 <20200828083022.GO1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828083022.GO1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 10:30:22AM +0200, peterz@infradead.org wrote:
> On Fri, Aug 28, 2020 at 03:07:08AM +0200, Ahmed S. Darwish wrote:
> >  #define __read_seqcount_begin(s)					\
> > +({									\
> > +	unsigned seq;							\
> > +									\
> > +	do {								\
> > +		seq = __seqcount_sequence(s);				\
> > +		if (likely(! (seq & 1)))				\
> > +			break;						\
> > +		cpu_relax();						\
> > +	} while (true);							\
> > +									\
> > +	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
> > +	seq;								\
> > +})
>
> Since we're there anyway, does it make sense to (re)write this like:
>
> 	while ((seq = __seqcount_sequence(s)) & 1)
> 		cpu_relax();
>
> ?
>

Yeah, much better of course; will do.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
