Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584CC2FFDEF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbhAVIMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:12:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21486 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726904AbhAVIKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:10:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611302937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1r1C6b8Yt+X+h4kUeUrmzS4UC5HaV/EkqiwbM/xr4OU=;
        b=NtZzJ9KD84xarm0pWCQ7v+CDNl8scVldVnC6hqfVri6m7kjg9ers2NmH73VEcloGMgTtaG
        38+Sbl3OspUwbuvZ8YMN9VDQ5t/5Ntrx0Nfmmk0VSRiJP5CbnS/fsZos5E+vNyY5d28puM
        BdEcwoymDiZaSZaAG5a4MHB2hKLHnhQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-AsMHF58ZMU2gMq7wpl5nCA-1; Fri, 22 Jan 2021 03:08:55 -0500
X-MC-Unique: AsMHF58ZMU2gMq7wpl5nCA-1
Received: by mail-ed1-f70.google.com with SMTP id g6so2544494edw.13
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:08:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1r1C6b8Yt+X+h4kUeUrmzS4UC5HaV/EkqiwbM/xr4OU=;
        b=FvnNb18UnekeGv6rGNejkKKKSNwZqZLGDvsZ0sd7IS7ENIOKxHo5FTvU2RvbPgH5Ue
         V1FUgqYHkOtqTG91H/gIZYgWtWyFxR04Bp353/kPNNg1mcDYPcgIvWlpC8dtP13rwATH
         hGW7+bajffiBsDKYem0iB+8IYCHGj5yXgbDxnfRHC7lzCDLRG+OQZr30qmrhjk3PdOGL
         06wPFm9+AbvXEi3OM+uUmKO0Q1T9M5aQSJSYwwQaiSPPAeD6U6RWDjpuTF7QEU++XR78
         H47Ox3HycHSq1Q/w6XQINAe2U7YVbnUp1afg1g6LO8tDdUrcQmcK3PQ353/yHw4AEz5c
         zZrA==
X-Gm-Message-State: AOAM531RQeNEcGlQISFwMehz9N5H1G4cXUqDmf4Z/xbSiXvevBWtVUU0
        36C5nXzS0DUdMEyPqEwkuh7Vxj99UUScsGycVHHOlCbr+Uh4ymm4T3wnUutBSh7MdGjnEiM4vJs
        yR2SE73Y1T1SKAtXoSYe4eiZl
X-Received: by 2002:a05:6402:490:: with SMTP id k16mr2229223edv.71.1611302934541;
        Fri, 22 Jan 2021 00:08:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4iPl8/f+eb+Pr1AYLOy/jbyis1Gtj5kxSaoayd7OeDLN/a+loD+oNA0ELuCO2YPT68pB8SQ==
X-Received: by 2002:a05:6402:490:: with SMTP id k16mr2229200edv.71.1611302934288;
        Fri, 22 Jan 2021 00:08:54 -0800 (PST)
Received: from localhost.localdomain ([151.29.110.43])
        by smtp.gmail.com with ESMTPSA id x17sm4706846edq.77.2021.01.22.00.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 00:08:53 -0800 (PST)
Date:   Fri, 22 Jan 2021 09:08:51 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Marco Perronet <perronet@mpi-sws.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 3/6] sched/deadline: Allow DL tasks on empty (cgroup v2)
 cpusets
Message-ID: <20210122080851.GK10569@localhost.localdomain>
References: <cover.1610463999.git.bristot@redhat.com>
 <8380113688bd64a6deb3241ff6a0fff62b157f47.1610463999.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8380113688bd64a6deb3241ff6a0fff62b157f47.1610463999.git.bristot@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/01/21 16:53, Daniel Bristot de Oliveira wrote:
> cgroups v2 allows the cpuset controller to be enabled/disabled on
> demand. On Fedora 32, cpuset is disabled by default. To enable it,
> a user needs to:
> 
>   # cd /sys/fs/cgroup/
>   # echo +cpuset > cgroup.subtree_control
> 
> Existing cgroups will expose the cpuset interface (e.g., cpuset.cpus
> file). By default, cpuset.cpus has no CPU assigned, which means that
> existing tasks will move to a cpuset without cpus.

This is kind of confusing, though. Isn't it?

> Initially, I thought about returning an error and blocking the
> operation. However, that is indeed not needed. The cpuset without
> CPUs assigned will be a non-root cpuset, hence its cpu mask will
> be the same as the root one. So, the bandwidth was already accounted,
> and the task can proceed.
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> ---
>  kernel/sched/deadline.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 943aa32cc1bc..788a391657a5 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2871,6 +2871,13 @@ int dl_task_can_attach(struct task_struct *p,
>  	bool overflow;
>  	int ret;
>  
> +	/*
> +	 * The cpuset has no cpus assigned, so the thread will not
> +	 * change its affinity.

Is this always the case also in the presence of deeper hierarchies?

Thanks,
Juri

