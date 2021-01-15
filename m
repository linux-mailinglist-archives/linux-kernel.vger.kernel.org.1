Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DD72F7689
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbhAOKWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbhAOKV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:21:58 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343DDC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 02:21:19 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v15so5040655wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 02:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2V/bZEZDEb3V/fhFz7mUvhwT4BoeshuJFwVGruvza08=;
        b=aYjLFPlRopkC8U+z0eeACcdHQr5l3mA5gCPJGb7hvxxDKTu77jLMB36mJ9NcXLPXe9
         DN0RymKSRhrU8jSS/Dewg6Y281s+HKwVt325kb508PUn+bn0FrWwiU8L2EC4KT90r+vY
         +cRvk7ZkOh9a8IXv140J5YgXsZM9fnQcWQmKA9nRSMUdb82slzKK2N1WewCRChtQEgkj
         v4ZP6fwXlv23OfWd+byqBPULGtjjn7PR/KwMmgwroXNqXWK2tXUB+xSAaC9EElgp3EJC
         hUNBOFcfKV554D9fzkBhUqYZT8UCJmznSPHsscChw15ZbNp/KxOkMtky8bypYbAGGCaK
         LuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2V/bZEZDEb3V/fhFz7mUvhwT4BoeshuJFwVGruvza08=;
        b=q8UwE/GNN74+56RO8NsSF4DEYPfzuywf47DfQUZk9LyynI25NABzBib9ShOumS/Li/
         vpd4QGweVpyQ7amAUMpBkzGGJVNiEMeggFjRMvyJ5YP1BFp4JYTS/G72NhUzxt/8P7TM
         2Ql6JFcTHO5dObe2l0+eRWaBJyucQ5XKW1nAMEsKK1tI7F+gorOCsqGnYol6Dmqcrmpl
         x73FFGPn2b+mrE0302/0am2a9AoUc8LVHuVUQBHoI6ogt5q3IPhh2dLNL2SsdzlEafjU
         +SLMn5U2VTG7gkAnoMnRSLBVgjs0jR+O99Fcx/Y5R+3PUStW+RNqjSwjmcB9D00KGAc5
         AEaQ==
X-Gm-Message-State: AOAM532HMula47Cc7YAXufH+ajdeLp/fK6HtWiAXB/E6TbVyPzypyP9o
        ld4sVGrQMubi/JAgRU7n+N6Tnw==
X-Google-Smtp-Source: ABdhPJwakoU+7BSQGbhR1JfvHegL+hWVJpGp1oN3cDW5tg3nshzdGm4R96q2lqQmaHmjIqHM8lN3Gg==
X-Received: by 2002:adf:e410:: with SMTP id g16mr12476278wrm.364.1610706077647;
        Fri, 15 Jan 2021 02:21:17 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o20sm1876407wmm.24.2021.01.15.02.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 02:21:17 -0800 (PST)
Date:   Fri, 15 Jan 2021 10:21:15 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] kgdb: Schedule breakpoints via workqueue
Message-ID: <20210115102115.twv3oy3pmnhdejij@maple.lan>
References: <20210115001344.117108-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115001344.117108-1-dave@stgolabs.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 04:13:44PM -0800, Davidlohr Bueso wrote:
> The original functionality was added back in:
> 
>     1cee5e35f15 (kgdb: Add the ability to schedule a breakpoint via a tasklet)
> 
> However tasklets have long been deprecated as being too heavy on
> the system by running in irq context - and this is not a performance
> critical path. If a higher priority process wants to run, it must
> wait for the tasklet to finish before doing so. Instead, generate
> the breakpoint exception in process context.

I don't agree that "this is not a performance critical path".

kgdb is a stop-the-world debugger: if the developer trying to understand
the system behaviour has commanded the system to halt then that is what
it should be doing. It should not be scheduling tasks that are not
necessary to bring the system a halt.

In other words this code is using tasklets *specifically* to benefit
from their weird calling context.

However I am aware the way the wind is blowing w.r.t. tasklets
and...

> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
> Compile-tested only.

... this code can only ever be compile tested since AFAIK it has no
in-kernel callers.

There is a (still maintained) out-of-tree user that provides
kgdb-over-ethernet using the netpoll API. It must defer the stop to a
tasklet to avoid problems with netpoll running alongside the RX handler.

Whilst I have some sympathy, that code has been out-of-tree for more
than 10 years and I don't recall any serious attempt to upstream it at
any point in the last five.

So unless someone yells (convincingly) perhaps it's time to rip this
out and help prepare for a tasklet-free future?


Daniel.


> 
>  kernel/debug/debug_core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index af6e8b4fb359..e1ff974c6b6f 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -119,7 +119,7 @@ static DEFINE_RAW_SPINLOCK(dbg_slave_lock);
>   */
>  static atomic_t			masters_in_kgdb;
>  static atomic_t			slaves_in_kgdb;
> -static atomic_t			kgdb_break_tasklet_var;
> +static atomic_t			kgdb_break_work_var;
>  atomic_t			kgdb_setting_breakpoint;
>  
>  struct task_struct		*kgdb_usethread;
> @@ -1085,27 +1085,27 @@ static void kgdb_unregister_callbacks(void)
>  }
>  
>  /*
> - * There are times a tasklet needs to be used vs a compiled in
> + * There are times a workqueue needs to be used vs a compiled in
>   * break point so as to cause an exception outside a kgdb I/O module,
>   * such as is the case with kgdboe, where calling a breakpoint in the
>   * I/O driver itself would be fatal.
>   */
> -static void kgdb_tasklet_bpt(unsigned long ing)
> +static void kgdb_work_bpt(struct work_struct *unused)
>  {
>  	kgdb_breakpoint();
> -	atomic_set(&kgdb_break_tasklet_var, 0);
> +	atomic_set(&kgdb_break_work_var, 0);
>  }
>  
> -static DECLARE_TASKLET_OLD(kgdb_tasklet_breakpoint, kgdb_tasklet_bpt);
> +static DECLARE_WORK(kgdb_async_breakpoint, kgdb_work_bpt);
>  
>  void kgdb_schedule_breakpoint(void)
>  {
> -	if (atomic_read(&kgdb_break_tasklet_var) ||
> +	if (atomic_read(&kgdb_break_work_var) ||
>  		atomic_read(&kgdb_active) != -1 ||
>  		atomic_read(&kgdb_setting_breakpoint))
>  		return;
> -	atomic_inc(&kgdb_break_tasklet_var);
> -	tasklet_schedule(&kgdb_tasklet_breakpoint);
> +	atomic_inc(&kgdb_break_work_var);
> +	schedule_work(&kgdb_async_breakpoint);
>  }
>  EXPORT_SYMBOL_GPL(kgdb_schedule_breakpoint);
>  
> -- 
> 2.26.2
> 
