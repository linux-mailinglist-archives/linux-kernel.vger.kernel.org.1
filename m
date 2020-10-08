Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DC028768C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbgJHO7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56236 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730749AbgJHO7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:59:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602169184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e06xMkbB2fD5VIcvUFWfr+X35EMRsZKUGRjfiwycl3I=;
        b=Yv0zXgOvfjC6z2P0fDdJZoxF4PZ62wih6L7WsDygG5mbKxOdTJcIL7RLJeqdLkaVTd1a4C
        IPEizHOUze726J/eVM4r8RGt9dTzMG3zRRvuJAMkl/efK1FlYuzFWIIQ+VpAo1ElgO9WtW
        KKvu7Jh6/E+OrPb3xrlObsXeQ9aEgA4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-CJSDYk4eNTivQ4o_TCBI5A-1; Thu, 08 Oct 2020 10:59:43 -0400
X-MC-Unique: CJSDYk4eNTivQ4o_TCBI5A-1
Received: by mail-qk1-f197.google.com with SMTP id f126so4110916qke.17
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 07:59:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e06xMkbB2fD5VIcvUFWfr+X35EMRsZKUGRjfiwycl3I=;
        b=PqouK4PkUEQ5QN9gfEp5MlXq/NakI/fN549Gpvv/mdyxPoXPSW3hvny5T+OrKNV5YW
         tltDoV0Xquu1WB47WeLE7f1NKPzAsyMLw/OXwcVW6uxDEVTeO3Ss5C6Fspf2AcnwYvuy
         ipEKQbayD5LhAb549rqFFRh1kBKovJSywFCiZAYYTn/0MmCOCHEAfmTGsKuJIECPpsEF
         HePczVQ8SbT0wn6WNsPx0P5hu4p9W0aJ9Ix+t5j+Z5tsfM9TlTvmYOQD84JC9DzYHDpa
         5iNmkP1mXPU0OqCVrz04GVY9qnAwhEjYaUTqKfZArwQhB3+X+/pfo5a6ckieSQAOGHVX
         ztxQ==
X-Gm-Message-State: AOAM530RFDxpJ48lJUD6qNQDJ0kl9fMW17ArcQkWIbEhmzTsptPcCuNI
        P7T+aa9FwN4Xdfvr8o+7Wr7QL2OHrmV2/94VutBLbDXnsVhdbqEx3alsO8XaiNxGEpF+ofpdCKA
        lqgRYMoPlZ0Z3Ft6GBL517tbE
X-Received: by 2002:a05:620a:13c4:: with SMTP id g4mr1861457qkl.400.1602169182555;
        Thu, 08 Oct 2020 07:59:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIMNe5KE1NedAJX8Du5b1Ll7xdHO6GNVZI1BSKymJg0vDH3s0WT0Q4YdPvX8KSH3zI1BmlYg==
X-Received: by 2002:a05:620a:13c4:: with SMTP id g4mr1861435qkl.400.1602169182309;
        Thu, 08 Oct 2020 07:59:42 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id q9sm4174423qta.70.2020.10.08.07.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:59:41 -0700 (PDT)
Date:   Thu, 8 Oct 2020 10:59:40 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>
Subject: Re: [patch 1/2] nohz: only wakeup a single target cpu when kicking a
 task
Message-ID: <20201008145940.GG6026@xz-x1>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.724302019@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201007180229.724302019@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 03:01:52PM -0300, Marcelo Tosatti wrote:
> +static void tick_nohz_kick_task(struct task_struct *tsk)
> +{
> +	int cpu = task_cpu(tsk);
> +
> +	/*
> +	 * If the task concurrently migrates to another cpu,
> +	 * we guarantee it sees the new tick dependency upon
> +	 * schedule.
> +	 *
> +	 *
> +	 * set_task_cpu(p, cpu);
> +	 *   STORE p->cpu = @cpu
> +	 * __schedule() (switch to task 'p')
> +	 *   LOCK rq->lock
> +	 *   smp_mb__after_spin_lock()          STORE p->tick_dep_mask
> +	 *   tick_nohz_task_switch()            smp_mb() (atomic_fetch_or())
> +	 *      LOAD p->tick_dep_mask           LOAD p->cpu
> +	 */
> +
> +	preempt_disable();

Pure question: is preempt_disable() required here?  Same question to
tick_nohz_full_kick_all().

> +	if (cpu_online(cpu))
> +		tick_nohz_full_kick_cpu(cpu);
> +	preempt_enable();
> +}

-- 
Peter Xu

