Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE57A2176FB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 20:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgGGSpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 14:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgGGSpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:45:34 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BC8C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 11:45:33 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id m8so15086292qvk.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pG2rfBHuMMk3OEB7gVGSVBSplw8MMVUuOym1KKtoxnU=;
        b=d7qtGy6hWHtbgHfObrey4XSs+iqg6NYk/FHoHcBrE41c95M0cd5wiDIJ4yDXTtqBOi
         n8/IUeznX1FGJ4IJJ6Rv3unBs4OOce0lcfI+hlNh5xXCYVGjkY+kpBIaSRyBKnDg50iz
         C4R/XDT3bqjvCYzSXyehvE5YDas124HAb6amI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pG2rfBHuMMk3OEB7gVGSVBSplw8MMVUuOym1KKtoxnU=;
        b=F2k+xVkk9F6qhstXLCYvB6Uekm3hRChwp1/elP4GVb36FlTDWhuGcuj86jJtR8XIWL
         D3o9pO81tvM6e/LJZP3bNB4D4UgQGV7iy21BPQWcAEq768TQ7jirB+iNw5n2+qpp8HyZ
         f++qseJNHIeFTfAcCyKEN71i4m8kcqGzqw0MnZI68/NA/3Aqagln32V08/Ls9TJNpF8e
         m0M980EEnVYrm185Ur3Bq0DmqPqzeeXV3rtEK2WK/tqWkzF4o55r1Egi4CK7SCwacQfJ
         CmzNjA/1A2v5KhcKanmf2B97O8eBKxb6TQJI01sXbWxC8Cd1a0PqKsd9llGg4CFaYUxa
         iWUA==
X-Gm-Message-State: AOAM5309NIb9/MPCPHnpu1k2E2cNLUNRO+OU43tYau5cXyMS6PmlHpx3
        eW46CvXHnRmUHnSD22/0sUpaqg==
X-Google-Smtp-Source: ABdhPJxAJJxgayqbwMxEq+Lm1kpT/BWtAQO2SkYd3c23nWGvu+d+5XnLw4dIFDUbGY7lXnzRBtNFMA==
X-Received: by 2002:ad4:5912:: with SMTP id ez18mr43800249qvb.24.1594147532806;
        Tue, 07 Jul 2020 11:45:32 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 23sm24366602qkl.52.2020.07.07.11.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 11:45:32 -0700 (PDT)
Date:   Tue, 7 Jul 2020 14:45:31 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com
Subject: Re: [PATCH tip/core/rcu 03/17] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200707184531.GC233429@google.com>
References: <20200624201200.GA28901@paulmck-ThinkPad-P72>
 <20200624201226.21197-3-paulmck@kernel.org>
 <20200630164543.4mdcf6zb4zfclhln@linutronix.de>
 <20200630183534.GG9247@paulmck-ThinkPad-P72>
 <20200702141216.r4rbt5w3hjzafpgg@linutronix.de>
 <20200702164826.GQ9247@paulmck-ThinkPad-P72>
 <20200702201908.jfiacgvion6a4nmj@linutronix.de>
 <20200706210645.GJ9247@paulmck-ThinkPad-P72>
 <20200707173441.GA28267@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200707173441.GA28267@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 07:34:41PM +0200, Uladzislau Rezki wrote:
> On Mon, Jul 06, 2020 at 02:06:45PM -0700, Paul E. McKenney wrote:
> > On Thu, Jul 02, 2020 at 10:19:08PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2020-07-02 09:48:26 [-0700], Paul E. McKenney wrote:
> > > > On Thu, Jul 02, 2020 at 04:12:16PM +0200, Sebastian Andrzej Siewior wrote:
> > > > > On 2020-06-30 11:35:34 [-0700], Paul E. McKenney wrote:
> > > > > > > This is not going to work together with the "wait context validator"
> > > > > > > (CONFIG_PROVE_RAW_LOCK_NESTING). As of -rc3 it should complain about
> > > > > > > printk() which is why it is still disabled by default.
> > > > > > 
> > > > > > Fixing that should be "interesting".  In particular, RCU CPU stall
> > > > > > warnings rely on the raw spin lock to reduce false positives due
> > > > > > to race conditions.  Some thought will be required here.
> > > > > 
> > > > > I don't get this part. Can you explain/give me an example where to look
> > > > > at?
> > > > 
> > > > Starting from the scheduler-clock interrupt's call into RCU,
> > > > we have rcu_sched_clock_irq() which calls rcu_pending() which
> > > > calls check_cpu_stall() which calls either print_cpu_stall() or
> > > > print_other_cpu_stall(), depending on whether the stall is happening on
> > > > the current CPU or on some other CPU, respectively.
> > > > 
> > > > Both of these last functions acquire the rcu_node structure's raw ->lock
> > > > and expect to do printk()s while holding it.
> > > 
> > > …
> > > > Thoughts?
> > > 
> > > Okay. So in the RT queue there is a printk() rewrite which fixes this
> > > kind of things. Upstream the printk() interface is still broken in this
> > > regard and therefore CONFIG_PROVE_RAW_LOCK_NESTING is disabled.
> > > [Earlier the workqueue would also trigger a warning but this has been
> > > fixed as of v5.8-rc1.]
> > > This was just me explaining why this bad, what debug function would
> > > report it and why it is not enabled by default.
> > 
> > Whew!!!  ;-)
> > 
> > > > > > > So assume that this is fixed and enabled then on !PREEMPT_RT it will
> > > > > > > complain that you have a raw_spinlock_t acquired (the one from patch
> > > > > > > 02/17) and attempt to acquire a spinlock_t in the memory allocator.
> > > > > > 
> > > > > > Given that the slab allocator doesn't acquire any locks until it gets
> > > > > > a fair way in, wouldn't it make sense to allow a "shallow" allocation
> > > > > > while a raw spinlock is held?  This would require yet another GFP_ flag,
> > > > > > but that won't make all that much of a difference in the total.  ;-)
> > > > > 
> > > > > That would be one way of dealing with. But we could go back to
> > > > > spinlock_t and keep the memory allocation even for RT as is. I don't see
> > > > > a downside of this. And we would worry about kfree_rcu() from real
> > > > > IRQ-off region once we get to it.
> > > > 
> > > > Once we get to it, your thought would be to do per-CPU queuing of
> > > > memory from IRQ-off kfree_rcu(), and have IRQ work or some such clean
> > > > up after it?  Or did you have some other trick in mind?
> > > 
> > > So for now I would very much like to revert the raw_spinlock_t back to
> > > the spinlock_t and add a migrate_disable() just avoid the tiny
> > > possible migration between obtaining the CPU-ptr and acquiring the lock
> > > (I think Joel was afraid of performance hit).
> > 
> > Performance is indeed a concern here.
> > 
> > > Should we get to a *real* use case where someone must invoke kfree_rcu()
> > > from a hard-IRQ-off region then we can think what makes sense. per-CPU
> > > queues and IRQ-work would be one way of dealing with it.
> > 
> > It looks like workqueues can also be used, at least in their current
> > form.  And timers.
> > 
> > Vlad, Joel, thoughts?
> >
> Some high level thoughts:
> 
> Currently everything is done in workqueue context, it means all freeing
> happens there. For RT kernel we can invoke a page allocator only for single
> kfree_rcu() argument(though we skip it). As for double one, it is impossible,
> that is why a simple path is used by linking rcu_head among each other for
> further reclaim in wq context. As of now, for RT, everything is already
> deferred.
> 
> If we revert to spinlock_t then calling of kfree_rcu() from hard IRQ
> context is broken, even though we think that for RT kernel it will
> never happen. Therefore i do not see a clear motivation and benefits
> why we should revert to spinlock_t.
> 
> IMHO, if we can avoid of such drawback i would go with that way, i.e.
> i would not like to think what to do with that when it becomes broken.

I am also of Vlad's opinion. It seems to me that doing the migrate_disable()
before dropping the raw spinlock should suffice.

Note that in the future, we may have other users of this path such as
a potential kmem_cache_free_rcu(). It seems burdensome to make these all
callable only from sleepable-context.

Is there a drawback of doing migrate_disable before dropping the raw internal
lock, that I'm missing?

thanks,

 - Joel

