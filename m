Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF042C0F85
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 17:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389744AbgKWP6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732564AbgKWP5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:57:54 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0630C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:57:53 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id g14so3892129wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 07:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k+kniU7gxDfT8jCCuCcVQlgGKYH8uUnra1Ilt/IrXFs=;
        b=YdEjW3MqZutdjMrm555QZS0lCWFzttiMHDdhJlo/U1NpQxdRix60IW/YLeDrOKg4tN
         IaZEPdoFgrCO1kzhvqJly7yK7Aek90t5vqpBkgDCVlZxY7FjkFMPt8n4fdpBrfZZ4h39
         OgW8s8D78Zy2MNubG+XCPHpJWH7KAgv3N1jVLON9WXLnzbfq+b+w8wsdfhvlCRACN3sx
         HlEW6oM0VRA5pTxt7xsBGBKxC5wuUXKmSHZgAfgUjsZXF0xmoiqCam97lLJ6aPpWz8QL
         N6Jl7QuZPrUfvkJT3/EIStbc9GCBF95gpBFYrxlMu5j2lAA0xRTVuFBBMohL+CnpqDQh
         X5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k+kniU7gxDfT8jCCuCcVQlgGKYH8uUnra1Ilt/IrXFs=;
        b=MXIJDlDcxumWmybdr5ql02r4J0NVfOLm82z2j+o9s2/3MkHGfy/k3u7rqjgR6ddogB
         Klh1dorM9hMeASgt8Ru4hDRcy5DRTiB5tm2BrI7WUVyu+pBO+OSiBijMMywaBv3wTnjL
         +rcgVUI+H0shVeZL7ZNBwXm0yOL9oblRLvoo60/lOS/tpWaP4bZwzq5kwmVcsAk+HZ2Y
         dSVx0TnbfN8Qfc/QrxaxwWnTsNFBmEYihoVBu3mVm4gAlScvHMyXF/EofXvL9d08N4Qv
         4rC3XKyBv00PZvveLgDegt4oyVwNtAhRb1012w7QjKTmNORMwz7dn8PHj70XehHbiSqa
         DkKg==
X-Gm-Message-State: AOAM532ytuBoifxPYMSi0xEJXpHmTevzt8l5kThnQbxZmeGP/BxnePUp
        gGg3Mcm9XL6dqLame4FjvnTAPQ==
X-Google-Smtp-Source: ABdhPJz3oThVv6xvqhiKLAyZGKnLgVHRDQGzZ9spfaMZqPIljEm52wEpE3LZsDUIPoiwxK431mizHw==
X-Received: by 2002:adf:de85:: with SMTP id w5mr360547wrl.90.1606147072382;
        Mon, 23 Nov 2020 07:57:52 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id u23sm17844378wmc.32.2020.11.23.07.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 07:57:51 -0800 (PST)
Date:   Mon, 23 Nov 2020 16:57:46 +0100
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] kcsan: Avoid scheduler recursion by using
 non-instrumented preempt_{disable,enable}()
Message-ID: <20201123155746.GA2203226@elver.google.com>
References: <20201123132300.1759342-1-elver@google.com>
 <20201123135512.GM3021@hirez.programming.kicks-ass.net>
 <CANpmjNPwuq8Hph3oOyJCVgWQ_d-gOTPEOT3BpbR2pnm5LBeJbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPwuq8Hph3oOyJCVgWQ_d-gOTPEOT3BpbR2pnm5LBeJbw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 04:17PM +0100, Marco Elver wrote:
> On Mon, 23 Nov 2020 at 14:55, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Nov 23, 2020 at 02:23:00PM +0100, Marco Elver wrote:
> > > When enabling KCSAN for kernel/sched (remove KCSAN_SANITIZE := n from
> > > kernel/sched/Makefile), with CONFIG_DEBUG_PREEMPT=y, we can observe
> > > recursion due to:
> > >
> > >       check_access() [via instrumentation]
> > >         kcsan_setup_watchpoint()
> > >           reset_kcsan_skip()
> > >             kcsan_prandom_u32_max()
> > >               get_cpu_var()
> > >                 preempt_disable()
> > >                   preempt_count_add() [in kernel/sched/core.c]
> > >                     check_access() [via instrumentation]
> > >
> > > Avoid this by rewriting kcsan_prandom_u32_max() to only use safe
> > > versions of preempt_disable() and preempt_enable() that do not call into
> > > scheduler code.
> > >
> > > Note, while this currently does not affect an unmodified kernel, it'd be
> > > good to keep a KCSAN kernel working when KCSAN_SANITIZE := n is removed
> > > from kernel/sched/Makefile to permit testing scheduler code with KCSAN
> > > if desired.
> > >
> > > Fixes: cd290ec24633 ("kcsan: Use tracing-safe version of prandom")
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > > v2:
> > > * Update comment to also point out preempt_enable().
> > > ---
> > >  kernel/kcsan/core.c | 15 ++++++++++++---
> > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > > index 3994a217bde7..10513f3e2349 100644
> > > --- a/kernel/kcsan/core.c
> > > +++ b/kernel/kcsan/core.c
> > > @@ -284,10 +284,19 @@ should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *
> > >   */
> > >  static u32 kcsan_prandom_u32_max(u32 ep_ro)
> > >  {
> > > -     struct rnd_state *state = &get_cpu_var(kcsan_rand_state);
> > > -     const u32 res = prandom_u32_state(state);
> > > +     struct rnd_state *state;
> > > +     u32 res;
> > > +
> > > +     /*
> > > +      * Avoid recursion with scheduler by using non-tracing versions of
> > > +      * preempt_disable() and preempt_enable() that do not call into
> > > +      * scheduler code.
> > > +      */
> > > +     preempt_disable_notrace();
> > > +     state = raw_cpu_ptr(&kcsan_rand_state);
> > > +     res = prandom_u32_state(state);
> > > +     preempt_enable_no_resched_notrace();
> >
> > This is a preemption bug. Does preempt_enable_notrace() not work?
> 
> No it didn't, because we end up calling preempt_schedule_notrace(),
> which again might end in recursion.
> 
> Normally we could surround this by
> kcsan_disable_current/kcsan_enable_current(), but that doesn't work
> because we have this sequence:
> 
>      reset_kcsan_skip();
>      if (!kcsan_is_enabled())
>          ...
> 
> to avoid underflowing the skip counter if KCSAN is disabled. That
> could be solved by writing to the skip-counter twice: once with a
> non-random value, and if KCSAN is enabled with a random value. Would
> that be better?

See below for concrete alternative that works.

> And I'd like to avoid adding __no_kcsan to scheduler functions.
> 
> Any recommendation?

Let me know what you prefer.

Thanks,
-- Marco

------ >8 ------

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 10513f3e2349..c8eadef3f42a 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -266,8 +266,8 @@ should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *
 		return false;
 
 	/*
-	 * NOTE: If we get here, kcsan_skip must always be reset in slow path
-	 * via reset_kcsan_skip() to avoid underflow.
+	 * Note: If we get here, kcsan_skip must always be reset in slow path to
+	 * avoid underflow.
 	 */
 
 	/* this operation should be watched */
@@ -288,27 +288,19 @@ static u32 kcsan_prandom_u32_max(u32 ep_ro)
 	u32 res;
 
 	/*
-	 * Avoid recursion with scheduler by using non-tracing versions of
-	 * preempt_disable() and preempt_enable() that do not call into
-	 * scheduler code.
+	 * Avoid recursion with scheduler by disabling KCSAN because
+	 * preempt_enable_notrace() will still call into scheduler code.
 	 */
+	kcsan_disable_current();
 	preempt_disable_notrace();
 	state = raw_cpu_ptr(&kcsan_rand_state);
 	res = prandom_u32_state(state);
-	preempt_enable_no_resched_notrace();
+	preempt_enable_notrace();
+	kcsan_enable_current_nowarn();
 
 	return (u32)(((u64) res * ep_ro) >> 32);
 }
 
-static inline void reset_kcsan_skip(void)
-{
-	long skip_count = kcsan_skip_watch -
-			  (IS_ENABLED(CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE) ?
-				   kcsan_prandom_u32_max(kcsan_skip_watch) :
-				   0);
-	this_cpu_write(kcsan_skip, skip_count);
-}
-
 static __always_inline bool kcsan_is_enabled(void)
 {
 	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
@@ -430,10 +422,16 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Always reset kcsan_skip counter in slow-path to avoid underflow; see
 	 * should_watch().
 	 */
-	reset_kcsan_skip();
-
-	if (!kcsan_is_enabled())
+	if (likely(kcsan_is_enabled())) {
+		long skip_count = kcsan_skip_watch -
+				  (IS_ENABLED(CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE) ?
+					   kcsan_prandom_u32_max(kcsan_skip_watch) :
+					   0);
+		this_cpu_write(kcsan_skip, skip_count);
+	} else {
+		this_cpu_write(kcsan_skip, kcsan_skip_watch);
 		goto out;
+	}
 
 	/*
 	 * Special atomic rules: unlikely to be true, so we check them here in
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 5fc9c9b70862..21fb5a5662b5 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -7,12 +7,6 @@ endif
 # that is not a function of syscall inputs. E.g. involuntary context switches.
 KCOV_INSTRUMENT := n
 
-# There are numerous data races here, however, most of them are due to plain accesses.
-# This would make it even harder for syzbot to find reproducers, because these
-# bugs trigger without specific input. Disable by default, but should re-enable
-# eventually.
-KCSAN_SANITIZE := n
-
 ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
 # needed for x86 only.  Why this used to be enabled for all architectures is beyond
