Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88822B179C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgKMI4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMI4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:56:42 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1E5C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 00:56:41 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id a65so7677611wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 00:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+b6Of82ddkfbrpXWs23d9A8b06mW1BlrUbEZX8laN9A=;
        b=vl+R4S9e8flwZ/MIdBa/khtcC4DgUeNCQ574CBmrugpbBNOw8cZkDeuS9qY+ngaFS8
         SwwmfEvVfSfm6iv20iz0Pe5yhr/+VY/snkP/DZ5a2iPaXYu4QyfSr0u0L6SKAm0WaQYj
         l9ewIXqrtyjxZ7ipUoFjCRF4HVOBoq1pdK05ygNwqOsR5/bOujS6izV6PPBqEr+dqdgI
         2h17EE5u2exLEwTLVNjB30MKDXPXI45pu7ubjPG/rOcvf/XmYBaiNAHEWsvEEPD0o6Is
         5yO99pGV5HwuJUJflG6x5bTYpNUWKIOSgeAjIyxRxmAi4CbseN3MTw2Muwz2R3k6pcZD
         rEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+b6Of82ddkfbrpXWs23d9A8b06mW1BlrUbEZX8laN9A=;
        b=bTW2+CpZYb2wUy9fpb2b0/8LzRt+W29mXUyBcfxutfO8g6CDFwvquxZ7Yrv1UsX7hR
         kDyqgZnv0yKGAFEUYJGMtK2vIdlJixV44qTqltGVty3eosxcRBPodLnfczfrEwmAEzzl
         Wnlhm//TAXIMey8d3ozdvDtxyGdvSIEKxEwN6dC75woRR5aF5aa5ZTjwiAGZ6B8shUzj
         1cwtIrXQM+yHj05xBWJJWhptCaZIXwoh1xVjFWCn06AeRPo+BcBin30HcPtzSwv6qU/c
         ewLnhO1wgqQie1Ym46yMn6m3Gq8aH1A0FtIeLd8ZHpr/+rru5gKDEXMu6jB9oH5cfy1O
         NW4g==
X-Gm-Message-State: AOAM532zrns8QSbT73oLecOvke/lYZaz1inob3nkw5lGY+Xn/BNBwVUh
        7O/RuESKqb1a+eI7NbiAARvh4A==
X-Google-Smtp-Source: ABdhPJw5O4JX22EMLSGBYPYnUTSvWBuSWy3nxwqWISlNguR0qD2IXNZcMD9IfwpyYCU2AaQ+lpQb3g==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr1524902wmg.68.1605257800579;
        Fri, 13 Nov 2020 00:56:40 -0800 (PST)
Received: from vingu-book ([2a01:e0a:f:6020:5997:5d6c:7016:710d])
        by smtp.gmail.com with ESMTPSA id i6sm9637360wma.42.2020.11.13.00.56.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Nov 2020 00:56:39 -0800 (PST)
Date:   Fri, 13 Nov 2020 09:56:37 +0100
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [bug report] sched/fair: Prefer prev cpu in asymmetric wakeup
 path
Message-ID: <20201113085637.GA31601@vingu-book>
References: <20201113084657.GA86197@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201113084657.GA86197@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Le vendredi 13 nov. 2020 à 11:46:57 (+0300), Dan Carpenter a écrit :
> Hello Vincent Guittot,
> 
> The patch b4c9c9f15649: "sched/fair: Prefer prev cpu in asymmetric
> wakeup path" from Oct 29, 2020, leads to the following static checker
> warning:
> 
> 	kernel/sched/fair.c:6249 select_idle_sibling()
> 	error: uninitialized symbol 'task_util'.
> 
> kernel/sched/fair.c
>   6233  static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   6234  {
>   6235          struct sched_domain *sd;
>   6236          unsigned long task_util;
>   6237          int i, recent_used_cpu;
>   6238  
>   6239          /*
>   6240           * On asymmetric system, update task utilization because we will check
>   6241           * that the task fits with cpu's capacity.
>   6242           */
> 
> The original comment was a bit more clear...  Perhaps "On asymmetric
> system[s], [record the] task utilization because we will check that the
> task [can be done within] the cpu's capacity."

The comment "update task utilization because we will check ..." refers to
sync_entity_load_avg()

> 
>   6243          if (static_branch_unlikely(&sched_asym_cpucapacity)) {
>   6244                  sync_entity_load_avg(&p->se);
>   6245                  task_util = uclamp_task_util(p);
>   6246          }
> 
> "task_util" is not initialized on the else path.

no need because it will not be used

> 
>   6247  
>   6248          if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
>   6249              asym_fits_capacity(task_util, target))
>                                        ^^^^^^^^^
> Uninitialized variable warning.

asym_fits_capacity includes the same condition as above when we set task_util
so task_util can't be used unintialize

static inline bool asym_fits_capacity(int task_util, int cpu)
{
	if (static_branch_unlikely(&sched_asym_cpucapacity))
		return fits_capacity(task_util, capacity_of(cpu));

	return true;
}


> 
>   6250                  return target;
>   6251  
>   6252          /*
>   6253           * If the previous CPU is cache affine and idle, don't be stupid:
>   6254           */
>   6255          if (prev != target && cpus_share_cache(prev, target) &&
>   6256              (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
>   6257              asym_fits_capacity(task_util, prev))
>   6258                  return prev;
>   6259  
>   6260          /*
>   6261           * Allow a per-cpu kthread to stack with the wakee if the
> 
> regards,
> dan carpenter
