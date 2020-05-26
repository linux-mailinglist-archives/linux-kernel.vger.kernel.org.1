Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B642D1C96FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgEGRAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 13:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726922AbgEGRAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:00:22 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBFCC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 10:00:22 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id l18so955041qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zrl4Q5RwimOaOPzJ4SvHWrYvKD/IGDnpYrEl4Dr0Twg=;
        b=AG5WDF/CkoslEjDZdSnwRk5sEa28EkvkUYjjtyS8kME1e7eqJzm6NLMS+vuGLDU4zK
         tN76V8FpTQbDTXdWqjWKBymdDZ5VcKbbzrQcHbEJUmrVCWz6vjVg3T5iCV7P9aRTddXe
         lblNzqxepfUMxXN2Z7BTzvgcd6sMFvFLRRMjmC1RW/CVijzI+BeIpgrzKr6mIpNHX+BC
         H32PGtDDeG1AGNL+H52cyl0/53UHRQtbpIjur0GcBp2n+vjBm41bJlHnVeuzq81IxO8p
         gx+vbUP9uqMMjviTOyQFFuIT0fZSyTqdkn5bDc1dlRR6h8Yiin4SpgnzjNjYBAAzhVtK
         3Tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zrl4Q5RwimOaOPzJ4SvHWrYvKD/IGDnpYrEl4Dr0Twg=;
        b=CtSGQIk+evo66cRhf/jjUyVtpZwcxaHXTJ81Yw+5Mw9svc4k5HxW8j3rxQC6czaE/i
         hhICh/7QD1LW2I6H6HuKRh8OKvFNfDzJg7uQ/vtCuZovQX9BzmkiKpXvuhzmembe5JfX
         k0BN9P4JMXGpe8ryHDIOc72iQwoevxubdWtnF1kXM8GklInQ0FgIozh7Vlabz0mKt9kA
         tRYCL9YcjQFHLOz2vQeiy9+sbxRcaKw8UWOW7R/AAMYr0thJlusOOYMHONK1IKlz16Jc
         YZDb4VRegFV6gusmJLo98V741SuC2+KsYg0LPKxXIzwntmDSCENH346/yusgKBij9Y8C
         UnAQ==
X-Gm-Message-State: AGi0PubzheSgoLry7QHjj980qiH4XdckUfldtCq2bdrvxSb12beTGccD
        XGORH+uWI0WIPnnj+PtMeRMFwg==
X-Google-Smtp-Source: APiQypJix8z3BJDzc3/nMXJNVLJU+fpdTdhM5AUcNziovXv/1ZEfZhczdAgwriND7njS3zR/txvJkQ==
X-Received: by 2002:ac8:67d9:: with SMTP id r25mr15785986qtp.338.1588870821922;
        Thu, 07 May 2020 10:00:21 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id s15sm4843057qtc.31.2020.05.07.10.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:00:21 -0700 (PDT)
Date:   Thu, 7 May 2020 13:00:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     paulmck@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, viro@zeniv.linux.org.uk,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH RFC tip/core/rcu] Add shrinker to shift to
 fast/inefficient GP mode
Message-ID: <20200507170006.GA155220@cmpxchg.org>
References: <20200507004240.GA9156@paulmck-ThinkPad-P72>
 <20200506175535.d4986a4d497071a410b69765@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506175535.d4986a4d497071a410b69765@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 05:55:35PM -0700, Andrew Morton wrote:
> On Wed, 6 May 2020 17:42:40 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > This commit adds a shrinker so as to inform RCU when memory is scarce.
> > RCU responds by shifting into the same fast and inefficient mode that is
> > used in the presence of excessive numbers of RCU callbacks.  RCU remains
> > in this state for one-tenth of a second, though this time window can be
> > extended by another call to the shrinker.

We may be able to use shrinkers here, but merely being invoked does
not carry a reliable distress signal.

Shrinkers get invoked whenever vmscan runs. It's a useful indicator
for when to age an auxiliary LRU list - test references, clear and
rotate or reclaim stale entries. The urgency, and what can and cannot
be considered "stale", is encoded in the callback frequency and scan
counts, and meant to be relative to the VM's own rate of aging: "I've
tested X percent of mine for recent use, now you go and test the same
share of your pool." It doesn't translate well to other
interpretations of the callbacks, although people have tried.

> > If it proves feasible, a later commit might add a function call directly
> > indicating the end of the period of scarce memory.
> 
> (Cc David Chinner, who often has opinions on shrinkers ;))
> 
> It's a bit abusive of the intent of the slab shrinkers, but I don't
> immediately see a problem with it.  Always returning 0 from
> ->scan_objects might cause a problem in some situations(?).
> 
> Perhaps we should have a formal "system getting low on memory, please
> do something" notification API.

It's tricky to find a useful definition of what low on memory
means. In the past we've used sc->priority cutoffs, the vmpressure
interface (reclaimed/scanned - reclaim efficiency cutoffs), oom
notifiers (another reclaim efficiency cutoff). But none of these
reliably capture "distress", and they vary highly between different
hardware setups. It can be hard to trigger OOM itself on fast IO
devices, even when the machine is way past useful (where useful is
somewhat subjective to the user). Userspace OOM implementations that
consider userspace health (also subjective) are getting more common.

> How significant is this?  How much memory can RCU consume?

I think if rcu can end up consuming a significant share of memory, one
way that may work would be to do proper shrinker integration and track
the age of its objects relative to the age of other allocations in the
system. I.e. toss them all on a clock list with "new" bits and shrink
them at VM velocity. If the shrinker sees objects with new bit set,
clear and rotate. If it sees objects without them, we know rcu_heads
outlive cache pages etc. and should probably cycle faster too.
