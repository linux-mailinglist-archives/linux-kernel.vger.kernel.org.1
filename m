Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A95F26F59B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 08:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgIRGAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 02:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725886AbgIRGAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 02:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600408833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7GjiLePj2d/62yENu9Rruo7vO63aApraxg0iEhjHAYE=;
        b=ZB3D+Qt+Wf5vONbhbTIr/Z+//lfCYlUfQpCwFbA3SDlQEk6d68EKkHwXJR8vuLOCbsuQTj
        jKGYRS3XitpymKv/taJ8t2Q8sMcoDVXmJ7X/8y3LKsEpviJmweq/eJbtg8rJNyfcRcgeCP
        +3LDgw4T0RkACOUL+r3r6Uj2NMUNFhc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-BGvCzAg6NbyIYQ0BWeSdIA-1; Fri, 18 Sep 2020 02:00:31 -0400
X-MC-Unique: BGvCzAg6NbyIYQ0BWeSdIA-1
Received: by mail-wr1-f71.google.com with SMTP id f18so1717057wrv.19
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 23:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7GjiLePj2d/62yENu9Rruo7vO63aApraxg0iEhjHAYE=;
        b=FJQyh0MolUaxRV0t8mkFeXCmoem1slD2zLx0n7sZ23tl1MIwnyZQl7PJXsCFyyN+qQ
         uvsLV4TG0RwUxPxYKrrMRQyRqoiel3MNzkhRXmZyk5ByA/Mn08K/mhw85Rw5JnYn1Zlc
         mlC6U9AXronrT5UyPPskj5OIvnu4gDeSM3h4PLs/PeZ3TtKyPT+usqzBitoiLIHdYImx
         KKl2JN60WZsb8de1FJZbfRrdqvDFya5MiPOiPedE/of9iyNF87sVNL23NDvj8SeB/Y/c
         1y/WzEDtxO8bnNOTAfr7zsRm69+G1q8lifkTmivUiRECIJLFOEpC4YnlkMhos4G0iq5w
         pE9g==
X-Gm-Message-State: AOAM532jCCjhTKzJPOMcAC+BQrT//tEAQ28qwXY/+pILnwkcj//qiZuZ
        BjOH+kBkTmza9VDne/XFL/On6N3ksKyXj8aFUpeqpzXGqYem2AUsThPphgvb637H4u8OXAnfpps
        v96iX5kVZgp7+4/Fklhn4jlLk
X-Received: by 2002:adf:e80b:: with SMTP id o11mr34185436wrm.118.1600408829955;
        Thu, 17 Sep 2020 23:00:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoqnTuZodlmFvt9lTgsfrU4+rzaDRF8WKHlDBwrxsBe1ffEfW5zGPP4d2/ftQ4bFWqoBQC+g==
X-Received: by 2002:adf:e80b:: with SMTP id o11mr34185414wrm.118.1600408829691;
        Thu, 17 Sep 2020 23:00:29 -0700 (PDT)
Received: from localhost.localdomain ([151.29.184.101])
        by smtp.gmail.com with ESMTPSA id a5sm3175493wrp.37.2020.09.17.23.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 23:00:28 -0700 (PDT)
Date:   Fri, 18 Sep 2020 08:00:26 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Simmons <msimmons@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Unthrottle PI boosted threads while
 enqueuing
Message-ID: <20200918060026.GC261845@localhost.localdomain>
References: <5076e003450835ec74e6fa5917d02c4fa41687e6.1600170294.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5076e003450835ec74e6fa5917d02c4fa41687e6.1600170294.git.bristot@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On 16/09/20 09:06, Daniel Bristot de Oliveira wrote:
> stress-ng has a test (stress-ng --cyclic) that creates a set of threads
> under SCHED_DEADLINE with the following parameters:
> 
>     dl_runtime   =  10000 (10 us)
>     dl_deadline  = 100000 (100 us)
>     dl_period    = 100000 (100 us)
> 
> These parameters are very aggressive. When using a system without HRTICK
> set, these threads can easily execute longer than the dl_runtime because
> the throttling happens with 1/HZ resolution.
> 
> During the main part of the test, the system works just fine because
> the workload does not try to run over the 10 us. The problem happens at
> the end of the test, on the exit() path. During exit(), the threads need
> to do some cleanups that require real-time mutex locks, mainly those
> related to memory management, resulting in this scenario:
> 
> Note: locks are rt_mutexes...
>  ------------------------------------------------------------------------
>     TASK A:		TASK B:				TASK C:
>     activation
> 							activation
> 			activation
> 
>     lock(a): OK!	lock(b): OK!
>     			<overrun runtime>
>     			lock(a)
>     			-> block (task A owns it)
> 			  -> self notice/set throttled
>  +--<			  -> arm replenished timer
>  |    			switch-out
>  |    							lock(b)
>  |    							-> <C prio > B prio>
>  |    							-> boost TASK B
>  |  unlock(a)						switch-out
>  |  -> handle lock a to B
>  |    -> wakeup(B)
>  |      -> B is throttled:
>  |        -> do not enqueue
>  |     switch-out
>  |
>  |
>  +---------------------> replenishment timer
> 			-> TASK B is boosted:
> 			  -> do not enqueue
>  ------------------------------------------------------------------------
> 
> BOOM: TASK B is runnable but !enqueued, holding TASK C: the system
> crashes with hung task C.
> 
> This problem is avoided by removing the throttle state from the boosted
> thread while boosting it (by TASK A in the example above), allowing it to
> be queued and run boosted.
> 
> The next replenishment will take care of the runtime overrun, pushing
> the deadline further away. See the "while (dl_se->runtime <= 0)" on
> replenish_dl_entity() for more information.
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Reported-by: Mark Simmons <msimmons@redhat.com>
> Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
> Tested-by: Mark Simmons <msimmons@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: linux-kernel@vger.kernel.org
> 
> ---

Thanks for this fix.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

