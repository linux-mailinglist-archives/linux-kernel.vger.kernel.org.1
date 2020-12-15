Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C5C2DB6B2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 23:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgLOW4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 17:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgLOWzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:55:46 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C946AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 14:55:05 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id x13so21097081oto.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 14:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WfTxGeZcQbEkDfESo7Zide/rgubu463P4yV1OlAr/Es=;
        b=wvVXfUa/Q1rbsphDSY8y1GB2Fih6ml2zI7YmbQnNhd9+P9IFpx2LKDa+2kiTnL4W0a
         3pFRWyvZODNQcP77Fkddq3FXpfJFgzUPIssb6f/9UN4ToMmjbTAmrrTuQIYTDbBAZ8kU
         a/eqVE0xDKBdUF/8DbxjOHJTByS2R0oofrA2U99bRvw3ZoNWRnhkcK497qXbKRUbFP4g
         B7TOMZi6sWBMyjGkEmO7x1eGGc21/elGiRWWqH0Neoyg/e6rv8YlOKKhAzQKWrQtZXiE
         fpeqkTuFFjKQuzF1xTpaIiHLYzVZ6LrZDt2DWu/ZfMCAQPaqs8/7z09BCmuYLEEPyGBe
         I5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WfTxGeZcQbEkDfESo7Zide/rgubu463P4yV1OlAr/Es=;
        b=nINkh1lVHl2qa3Orq5XF/OV7VmAV/eHjrFDAQmwngjFK+cD9yKo95ysYx+E/quAKVi
         Pk/qWnRWyrX49NEfz0P2IXr1oHKmY7xLMawERV/K8CGj2jK+NYkmsvteIp4Bifir1Nkx
         zS19XipACogdHxDNrcCdN8pbrgL+4RMFyu1y+XGTiND5TOmm1tEnQVHYWdv9knNE6Knh
         r/h5OhKKzl7iHCexBGBgGquSGYbE9bBap5U61L1uBzpf1UJ+tlAW2xnlyY3x9L3T78lz
         K3I+k0gFsiOVAdrEEQfUZnyg7oZSc5Z3xOmBct8T+iMplSM13fQh4mNPAem5e/pQcJhF
         vaXg==
X-Gm-Message-State: AOAM5313icgO5h7cvRASQCPwdMAbbyNENDr0ze9rneg1PBD/kh0ixSL8
        AoZ2wm6Hg4J1OjH55LY+R0/JBw==
X-Google-Smtp-Source: ABdhPJwkom0uuTtRSsvlyvDYFUcA87mN0YNXvKqstkNhDakeOds/pc5oYPozNb5OSZl9bi8HHhWbZQ==
X-Received: by 2002:a9d:27a7:: with SMTP id c36mr24529265otb.59.1608072905203;
        Tue, 15 Dec 2020 14:55:05 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 8sm58567oii.45.2020.12.15.14.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 14:55:04 -0800 (PST)
Date:   Tue, 15 Dec 2020 16:55:02 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, elder@linaro.org
Subject: Re: [PATCH] remoteproc: Create a separate workqueue for recovery
 tasks
Message-ID: <X9k+xmg9SULEbJXe@builder.lan>
References: <1607806087-27244-1-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607806087-27244-1-git-send-email-rishabhb@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 12 Dec 14:48 CST 2020, Rishabh Bhatnagar wrote:

> Create an unbound high priority workqueue for recovery tasks.

This simply repeats $subject

> Recovery time is an important parameter for a subsystem and there
> might be situations where multiple subsystems crash around the same
> time.  Scheduling into an unbound workqueue increases parallelization
> and avoids time impact.

You should be able to write this more succinctly. The important part is
that you want an unbound work queue to allow recovery to happen in
parallel - which naturally implies that you care about recovery latency.

> Also creating a high priority workqueue
> will utilize separate worker threads with higher nice values than
> normal ones.
> 

This doesn't describe why you need the higher priority.


I believe, and certainly with the in-line coredump, that we're running
our recovery work for way too long to be queued on the system_wq. As
such the content of the patch looks good!

Regards,
Bjorn

> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 46c2937..8fd8166 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -48,6 +48,8 @@ static DEFINE_MUTEX(rproc_list_mutex);
>  static LIST_HEAD(rproc_list);
>  static struct notifier_block rproc_panic_nb;
>  
> +static struct workqueue_struct *rproc_wq;
> +
>  typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
>  				 void *, int offset, int avail);
>  
> @@ -2475,7 +2477,7 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
>  		rproc->name, rproc_crash_to_string(type));
>  
>  	/* create a new task to handle the error */
> -	schedule_work(&rproc->crash_handler);
> +	queue_work(rproc_wq, &rproc->crash_handler);
>  }
>  EXPORT_SYMBOL(rproc_report_crash);
>  
> @@ -2520,6 +2522,10 @@ static void __exit rproc_exit_panic(void)
>  
>  static int __init remoteproc_init(void)
>  {
> +	rproc_wq = alloc_workqueue("rproc_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
> +	if (!rproc_wq)
> +		return -ENOMEM;
> +
>  	rproc_init_sysfs();
>  	rproc_init_debugfs();
>  	rproc_init_cdev();
> @@ -2536,6 +2542,7 @@ static void __exit remoteproc_exit(void)
>  	rproc_exit_panic();
>  	rproc_exit_debugfs();
>  	rproc_exit_sysfs();
> +	destroy_workqueue(rproc_wq);
>  }
>  module_exit(remoteproc_exit);
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
