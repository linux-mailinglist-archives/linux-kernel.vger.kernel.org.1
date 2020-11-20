Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9852BABC5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgKTOTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbgKTOTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:19:36 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743B8C0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 06:19:36 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id j7so10228973wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 06:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xxByCDasYrQl9/cr/4ND1bYYvzVsnbPeWW4lsY9uHSo=;
        b=f6nWmbpFrO6nNmXfCRHQt8BwD43B8eTaHj2dsxELld+2WXCRI2+VDo3F0lzCLEQWHk
         tDs866iLMScCTCkeWLDb70rRPpn/JRtpHl3PVBFefHJNIyvAmBL05Wce/vAhpxgOigt5
         cxzD5YGnhuWhWJ/VNhj6C47fk4uFbHe+MpKotnjdf1PScSkZOKjGBYA8LKsqZ+FVvpYw
         lu6GO2a/O0RvIgninfUlzoVKijGErLVmTWcd50Rakq+JefcURGDLFcmTw9+c6EuxYVIL
         Z6PklLpGgVj501tENaGi31Mj0Ci+wim7UHRnRgIFnUkx+gmL6olAStZJV9+GUzPuK9Ez
         Iz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xxByCDasYrQl9/cr/4ND1bYYvzVsnbPeWW4lsY9uHSo=;
        b=eHIxixr46/wohDFJfnJTzEWDsSzytJpqCFi/7Mup+KHoaH7+4Pt484nYHcKnoqtjd9
         M/3Lyy/C1Ezvv+nQrOaivDTMAUF/BqK5PDQdYYGIbHfHdBwyTGjLf/hKf09CJZwFQomQ
         XDXmMOtBGwvpM3x8wAIwbDr5cPn2cu0P3fMjMGJd2ttbzv9hkB3mKDrvDk1uYIk2E5Up
         CzSMicogHWlTX2NN99/+E63+6Te8s44mfD8W4+J4KzkOCP0VSIeEk6Z7l66jhoOGZRGS
         nDRqvxhfluJSr1lAwtbPrjyS9mWdMOV07VfKDigbF8D/GvLLGiLM2DOqXn+3I3o3lvMY
         ubVQ==
X-Gm-Message-State: AOAM533hhFGsbq/Oz1Nan1UO1WQ6AiJbJXYHJ3SOCGMVu4V9qsaHt+KO
        FA5BlT6vkROUnhQLgfdPQgF4PQ==
X-Google-Smtp-Source: ABdhPJz4v/XxzYmKZBv+ZBNMQC9A3BdP10+FcI7X+d6vI9r6IciwcBqs4061FjYyjj1dIoLy7knpXw==
X-Received: by 2002:adf:e74d:: with SMTP id c13mr17088093wrn.277.1605881974917;
        Fri, 20 Nov 2020 06:19:34 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id l13sm5307917wrm.24.2020.11.20.06.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 06:19:33 -0800 (PST)
Date:   Fri, 20 Nov 2020 15:19:28 +0100
From:   Marco Elver <elver@google.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: linux-next: stall warnings and deadlock on Arm64 (was: [PATCH]
 kfence: Avoid stalling...)
Message-ID: <20201120141928.GB3120165@elver.google.com>
References: <20201117105236.GA1964407@elver.google.com>
 <20201117182915.GM1437@paulmck-ThinkPad-P72>
 <20201118225621.GA1770130@elver.google.com>
 <20201118233841.GS1437@paulmck-ThinkPad-P72>
 <20201119125357.GA2084963@elver.google.com>
 <20201119151409.GU1437@paulmck-ThinkPad-P72>
 <20201119170259.GA2134472@elver.google.com>
 <20201119184854.GY1437@paulmck-ThinkPad-P72>
 <20201119193819.GA2601289@elver.google.com>
 <20201119213512.GB1437@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119213512.GB1437@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 01:35PM -0800, Paul E. McKenney wrote:
> On Thu, Nov 19, 2020 at 08:38:19PM +0100, Marco Elver wrote:
> > On Thu, Nov 19, 2020 at 10:48AM -0800, Paul E. McKenney wrote:
> > > On Thu, Nov 19, 2020 at 06:02:59PM +0100, Marco Elver wrote:
> 
> [ . . . ]
> 
> > > > I can try bisection again, or reverting some commits that might be
> > > > suspicious? But we'd need some selection of suspicious commits.
> > > 
> > > The report claims that one of the rcu_node ->lock fields is held
> > > with interrupts enabled, which would indeed be bad.  Except that all
> > > of the stack traces that it shows have these locks held within the
> > > scheduling-clock interrupt handler.  Now with the "rcu: Don't invoke
> > > try_invoke_on_locked_down_task() with irqs disabled" but without the
> > > "sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled"
> > > commit, I understand why.  With both, I don't see how this happens.
> > 
> > I'm at a loss, but happy to keep bisecting and trying patches. I'm also
> > considering:
> > 
> > 	Is it the compiler? Probably not, I tried 2 versions of GCC.
> > 
> > 	Can we trust lockdep to precisely know IRQ state? I know there's
> > 	been some recent work around this, but hopefully we're not
> > 	affected here?
> > 
> > 	Is QEMU buggy?
> > 
> > > At this point, I am reduced to adding lockdep_assert_irqs_disabled()
> > > calls at various points in that code, as shown in the patch below.
> > > 
> > > At this point, I would guess that your first priority would be the
> > > initial bug rather than this following issue, but you never know, this
> > > might well help diagnose the initial bug.
> > 
> > I don't mind either way. I'm worried deadlocking the whole system might
> > be worse.
> 
> Here is another set of lockdep_assert_irqs_disabled() calls on the
> off-chance that they actually find something.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit bcca5277df3f24db15e15ccc8b05ecf346d05169
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Thu Nov 19 13:30:33 2020 -0800
> 
>     rcu: Add lockdep_assert_irqs_disabled() to raw_spin_unlock_rcu_node() macros

None of those triggered either.

I found that disabling ftrace for some of kernel/rcu (see below) solved
the stalls (and any mention of deadlocks as a side-effect I assume),
resulting in successful boot.

Does that provide any additional clues? I tried to narrow it down to 1-2
files, but that doesn't seem to work.

Thanks,
-- Marco

------ >8 ------

diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index 0cfb009a99b9..678b4b094f94 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -3,6 +3,13 @@
 # and is generally not a function of system call inputs.
 KCOV_INSTRUMENT := n
 
+ifdef CONFIG_FUNCTION_TRACER
+CFLAGS_REMOVE_update.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_sync.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_srcutree.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_tree.o = $(CC_FLAGS_FTRACE)
+endif
+
 ifeq ($(CONFIG_KCSAN),y)
 KBUILD_CFLAGS += -g -fno-omit-frame-pointer
 endif
