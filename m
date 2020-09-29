Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79AB27D6F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgI2Tcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbgI2Tcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:32:51 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74728C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:32:51 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q5so5588593qkc.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zg8iMIsBc8YQg4a8RQTBuYUHUxGslvf65TSd1TPBfWg=;
        b=RG93ImRVwF+OzQrBZ8j5zTbvCaOPy7Xp/13LbPge6pGaB3bKpqb1rgobFK4hOK3wOU
         Y4yOvSQ2gSxm9OSBGLGMylRedgr6a9fMhUtOVuviFDxbmpq+8Si0hneHqdEhr/i2jDlN
         bvi4t/A5P2Z6x6UpLOkYgtvwcedCmUdyOE+EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zg8iMIsBc8YQg4a8RQTBuYUHUxGslvf65TSd1TPBfWg=;
        b=UwJfCG3lE2lyo+iZ00GTvdYzDeXrJmUudsV1P0+U932Z6sNLTcMybbj8A9YzSkxHHe
         6cQkt7LjGbJ09O9afrf/pUFG/OqETsCc5iGH+mInbG9AqbUSrTI/9QTxxnBscsQz+zHI
         OSRLFMV46bXz/3+E9qJB//988LV29mXIft+Ka1M6o/ywgpHA5hHHe3D2EEVV0YUCN/9p
         n9/Op3CAPZp5Rp3DkIdpJQjpsvBTd1UMzoCjZrKmHsYsfPJmIu094IyJnjCnFEFWVpdX
         YJIHRPPpwCNMpT+w+Htygim4NuHh0t3dxno5rrFTTFUC65j3bUD7CG2W8Zhcv89tcLvh
         4+uw==
X-Gm-Message-State: AOAM5315xqi+3vb9E+IYm7gCcB13+tM36LBZAfBgPfvHH0YuajfvLSgQ
        pMoauMZ/kLWyP899TSffJ67oruTRoyGJGA==
X-Google-Smtp-Source: ABdhPJyfUHgUE93ygdECSC29BHUx36ErXjMCZRjXaxfPtEiDtPjZOMjPfyzIop/t0T1yoIDD1e6zig==
X-Received: by 2002:a37:a5c6:: with SMTP id o189mr5748497qke.209.1601407970312;
        Tue, 29 Sep 2020 12:32:50 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id q8sm6062295qkq.57.2020.09.29.12.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:32:49 -0700 (PDT)
Date:   Tue, 29 Sep 2020 15:32:48 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/2] docs: Update RCU's hotplug requirements with a bit
 about design
Message-ID: <20200929193248.GA3749988@google.com>
References: <20200929192928.3749502-1-joel@joelfernandes.org>
 <20200929192928.3749502-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929192928.3749502-2-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Tue, Sep 29, 2020 at 03:29:28PM -0400, Joel Fernandes (Google) wrote:
> RCU's hotplug design will help understand the requirements an RCU
> implementation needs to fullfill, such as dead-lock avoidance.
> 
> The rcu_barrier() section of the "Hotplug CPU" section already talks
> about deadlocks, however the description of what else can deadlock other
> than rcu_barrier is rather incomplete.
> 
> This commit therefore continues the section by describing how RCU's
> design handles CPU hotplug in a deadlock-free way.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  .../RCU/Design/Requirements/Requirements.rst  | 30 +++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
> index 1ae79a10a8de..e0413aa989dd 100644
> --- a/Documentation/RCU/Design/Requirements/Requirements.rst
> +++ b/Documentation/RCU/Design/Requirements/Requirements.rst
> @@ -1929,8 +1929,10 @@ The Linux-kernel CPU-hotplug implementation has notifiers that are used
>  to allow the various kernel subsystems (including RCU) to respond
>  appropriately to a given CPU-hotplug operation. Most RCU operations may
>  be invoked from CPU-hotplug notifiers, including even synchronous
> -grace-period operations such as ``synchronize_rcu()`` and
> -``synchronize_rcu_expedited()``.
> +grace-period operations such as. However, the synchronous variants
> +(``synchronize_rcu()`` and ``synchronize_rcu_expedited()``) should not
> +from notifiers that execute via ``stop_machine()`` -- specifically those

The "should not from notifiers" should be "should not be used from
notifiers" here. Sorry and hope you can fix it up.

thanks,

 - Joel



> +between the ``CPUHP_AP_OFFLINE`` and ``CPUHP_AP_ONLINE`` states.
>  
>  However, all-callback-wait operations such as ``rcu_barrier()`` are also
>  not supported, due to the fact that there are phases of CPU-hotplug
> @@ -1940,6 +1942,30 @@ deadlock. Furthermore, ``rcu_barrier()`` blocks CPU-hotplug operations
>  during its execution, which results in another type of deadlock when
>  invoked from a CPU-hotplug notifier.
>  
> +Also, RCU's implementation avoids serious deadlocks which could occur due to
> +interaction between hotplug, timers and grace period processing. It does so by
> +maintaining its own books of every CPU's hotplug state, independent of
> +the existing general-purpose CPU masks and by reporting quiescent states
> +explictly when an online CPU is going down. Due to this design, the force
> +quiescent state loop (FQS) is not required to report quiescent states for
> +offline CPUs, like it does for idle CPUs, but it does splat if offline CPUs are
> +stalling the RCU grace period for too long.
> +
> +For an offline CPU, the quiescent state will be reported in either of:
> +1. During CPU offlining, using RCU's hotplug notifier (``rcu_report_dead()``).
> +2. During grace period initialization (``rcu_gp_init()``) if it detected a race
> +   with CPU offlining, or a race with a task unblocking on a node which
> +   previously had all of its CPUs offlined.
> +
> +The CPU onlining path (``rcu_cpu_starting()``) does not need to report a
> +quiescent state for an offline CPU; in fact it would trigger a warning if a
> +quiescent state was not already reported for that CPU.
> +
> +During the checking/modification of RCU's hotplug bookkeeping, the
> +corresponding CPU's leaf node lock is held. This avoids race conditions between
> +RCU's hotplug notifier hooks, grace period initialization code and the FQS loop
> +which can concurrently refer to or modify the bookkeeping.
> +
>  Scheduler and RCU
>  ~~~~~~~~~~~~~~~~~
>  
> -- 
> 2.28.0.709.gb0816b6eb0-goog
> 
