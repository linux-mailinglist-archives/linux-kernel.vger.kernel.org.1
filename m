Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48E772FE2E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbhAUGar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:30:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20332 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726669AbhAUG35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611210505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A/Nv6GHCQlumzPaFQAXiaHrHMfj3/YhSy2fwNasMTmw=;
        b=M1J+EPI7mHjM6cRLfs87FiBA+Uwj1FKJMZum8tfZohO4H4u+htuk3PahQg4ohO50P6B4Tj
        yIFuWkNiACFRf/058nwGEpgh4r1qdbhY7A61tb0HYdOOtEtoY+0xniMvt1+2/nMupczz52
        pPQOg+l6DPsmaa0vdadLpp0gN67njXE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-bL4ljgdHNC-2KRyhqNKf9g-1; Thu, 21 Jan 2021 01:28:23 -0500
X-MC-Unique: bL4ljgdHNC-2KRyhqNKf9g-1
Received: by mail-ed1-f71.google.com with SMTP id u17so582754edi.18
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 22:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A/Nv6GHCQlumzPaFQAXiaHrHMfj3/YhSy2fwNasMTmw=;
        b=gp1PAJeKEa/L39GHoFnSdR0+mMclhHJRUqvUSXIB3XjTpQ22MY982Y2bRMNIRwIbdO
         3b/wDyGQ5X0B4O/yZGj9TxgoPyAqmvmh9DO2cPUduwFJNw59nlzaaT5qCspq1S7JBZOH
         fD1TqSNYEDin69wjWY4SUPxojDNvtMQpuGDp1ks5iX0eRzFMiPmczjQB0SLuBPzSQQe8
         2EdQI0BRtQ6ZkURh/vmlW4t1PGETIUv+oqrW+tyZyH758rPd5jvCkHjU6fPQuhjAiFL3
         HcBlM6aq04v5zAkNCOglhzJ7NqkTnxeoNQEXmi5Bz15tspQ6H6Rp4X8leHh4wG3r4l8L
         hYqQ==
X-Gm-Message-State: AOAM531aBJhQIIBY3PeQhFOkiT3fZXqrtqyddn1nCFOA/yUSbzsrb2L6
        bUCWcZ0osA36NfVyLzXk6wJ+4OLfcaB1IsN1rsyM7eIIKyDnOrrkgmk/gEgfXv2q3wn6RLC1v7i
        U64jhV5mqAPpsV2XGOMn2TSvJ
X-Received: by 2002:a17:906:aec1:: with SMTP id me1mr8805629ejb.114.1611210502430;
        Wed, 20 Jan 2021 22:28:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgvwiFmsXss14kPoPcd+j0USA1s+mP/BikoSlDkv7eXGzd0l3lQAShgpK3XYQfPcSWmez7cw==
X-Received: by 2002:a17:906:aec1:: with SMTP id me1mr8805619ejb.114.1611210502205;
        Wed, 20 Jan 2021 22:28:22 -0800 (PST)
Received: from localhost.localdomain ([151.29.110.43])
        by smtp.gmail.com with ESMTPSA id d8sm2231050edm.75.2021.01.20.22.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 22:28:21 -0800 (PST)
Date:   Thu, 21 Jan 2021 07:28:19 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH] sched/deadline: Reduce rq lock contention in
 dl_add_task_root_domain()
Message-ID: <20210121062819.GH10569@localhost.localdomain>
References: <20210119083542.19856-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119083542.19856-1-dietmar.eggemann@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/01/21 09:35, Dietmar Eggemann wrote:
> dl_add_task_root_domain() is called during sched domain rebuild:
> 
>   rebuild_sched_domains_locked()
>     partition_and_rebuild_sched_domains()
>       rebuild_root_domains()
>          for all top_cpuset descendants:
>            update_tasks_root_domain()
>              for all tasks of cpuset:
>                dl_add_task_root_domain()
> 
> Change it so that only the task pi lock is taken to check if the task
> has a SCHED_DEADLINE (DL) policy. In case that p is a DL task take the
> rq lock as well to be able to safely de-reference root domain's DL
> bandwidth structure.
> 
> Most of the tasks will have another policy (namely SCHED_NORMAL) and
> can now bail without taking the rq lock.
> 
> One thing to note here: Even in case that there aren't any DL user
> tasks, a slow frequency switching system with cpufreq gov schedutil has
> a DL task (sugov) per frequency domain running which participates in DL
> bandwidth management.
> 
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Looks good to me, thanks!

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

