Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43ABA274EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgIWBwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgIWBwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:52:45 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF092C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:52:45 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c62so8156235qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TiMhTitM/Kckj6g33MjfhbkW3q6tpXUyaiKiQ5+I5GY=;
        b=VvuUIR5ZaPC1iCrOrvxBVYEKcKXqPHB4WbOjaNt3fNglEa4Bt/Nj8P6qCw7ALpnqKm
         QVh/TLAtreIMNM9skUUnRILK4hz+fC5/F7hZ1s3ww9yH9e0JCatzuK1y4m9TPPJrOfry
         vEoLJ906+vM5tYaaHlXoCPIC5u7vuPwsrhMgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TiMhTitM/Kckj6g33MjfhbkW3q6tpXUyaiKiQ5+I5GY=;
        b=ubLhOB9rNyHxJFjytJkBJXgSW+xwxNVH+yQwn9euOqRl1l9blYi4xPpBdlGnpJxPOu
         DbLiEdS+r8r7EKYsxXxqIUKxQBqJxU/gc6SKxp+tXkB4IKMPPbvI1wgJW/Eu7CA6Leq8
         XtlaZB2F5gc/zhghaHFlJ28WP9BbbtoO8NUcgYyPqd97wjHGh6eeM3K/cvw6XiyXFgl4
         FcR9g9vqWWyUwV9t01T4TCbQDZVK0mHFCTBkPJekfc66WrR4iP7lfPupZpltIwJt7MDH
         53QY6PnZocKcHjwSU+cb61ASQxp31p8YOm3SRHE8L1x+ZVx8YDdnM6X7ff55/XA4JEpz
         D77w==
X-Gm-Message-State: AOAM532nNsGYOjov7X9b6PJrDF1Y/KidPaCwj8p0E2NYsgz6fJWnLcnF
        4JT0EmZow1MrreIIlnK/n8TzFA==
X-Google-Smtp-Source: ABdhPJxgKWcg0mc8n85Ep1u/caKCmAyXiog5710ndV0MWbdPjZK/e9jBQ/vJtZQGZaZ8QHtfZVgVDA==
X-Received: by 2002:a37:a0cf:: with SMTP id j198mr3074886qke.408.1600825964757;
        Tue, 22 Sep 2020 18:52:44 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id f3sm13569003qtg.71.2020.09.22.18.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:52:44 -0700 (PDT)
Date:   Tue, 22 Sep 2020 21:52:43 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Aaron Lu <ziqian.lzq@antfin.com>
Subject: Re: [RFC PATCH v7 11/23] sched/fair: core wide cfs task priority
 comparison
Message-ID: <20200923015243.GA1739137@google.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <d02923d38df20f1d8c51cf4df6dce66ac0a385ce.1598643276.git.jdesfossez@digitalocean.com>
 <20200828212927.GE29142@worktop.programming.kicks-ass.net>
 <20200923014622.GA1733275@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923014622.GA1733275@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:46:22PM -0400, Joel Fernandes wrote:
> On Fri, Aug 28, 2020 at 11:29:27PM +0200, Peter Zijlstra wrote:
> > 
> > 
> > This is still a horrible patch..
> 
> Hi Peter,
> I wrote a new patch similar to this one and it fares much better in my tests,
> it is based on Aaron's idea but I do the sync only during force-idle, and not
> during enqueue. Also I yanked the whole 'core wide min_vruntime' crap. There
> is a regressing test which improves quite a bit with my patch (results below):
> 
> Aaron, Vineeth, Chris any other thoughts? This patch is based on Google's
> 4.19 device kernel so will require some massaging to apply to mainline/v7
> series. I will provide an updated patch later based on v7 series.
> 
> (Works only for SMT2, maybe we can generalize it more..)
> --------8<-----------
> 
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> Subject: [PATCH] sched: Sync the min_vruntime of cores when the system enters
>  force-idle
> 
> This patch provides a vruntime based way to compare two cfs task's priority, be
> it on the same cpu or different threads of the same core.
> 
> It is based on Aaron Lu's patch with some important differences. Namely,
> the vruntime is sync'ed only when the CPU goes into force-idle. Also I removed
> the notion of core-wide min_vruntime.
> 
> Also I don't care how long a cpu in a core is force idled,  I do my sync
> whenever the force idle starts essentially bringing both SMTs to a common time
> base. After that point, selection can happen as usual.
> 
> When running an Android audio test, with patch the perf sched latency output:
> 
> -----------------------------------------------------------------------------------------------------------------
> Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at       |
> -----------------------------------------------------------------------------------------------------------------
> FinalizerDaemon:(2)   |     23.969 ms |      969 | avg:    0.504 ms | max:  162.020 ms | max at:   1294.327339 s
> HeapTaskDaemon:(3)    |   2421.287 ms |     4733 | avg:    0.131 ms | max:   96.229 ms | max at:   1302.343366 s
> adbd:(3)              |      6.101 ms |       79 | avg:    1.105 ms | max:   84.923 ms | max at:   1294.431284 s
> 
> Without this patch and with Aubrey's initial patch (in v5 series), the max delay looks much better:
> 
> -----------------------------------------------------------------------------------------------------------------
> Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at       |
> -----------------------------------------------------------------------------------------------------------------
> HeapTaskDaemon:(2)    |   2602.109 ms |     4025 | avg:    0.231 ms | max:   19.152 ms | max at:    522.903934 s
> surfaceflinger:7478   |     18.994 ms |     1206 | avg:    0.189 ms | max:   17.375 ms | max at:    520.523061 s
> ksoftirqd/3:30        |      0.093 ms |        5 | avg:    3.328 ms | max:   16.567 ms | max at:    522.903871 s

I messed up the change log, just to clarify - the first result is without
patch (bad) and the second result is with patch (good).

thanks,

 - Joel

