Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F7426C0DE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgIPJmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgIPJmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600249331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gMIUkN39zioLKdRgfk5ZGYhuC2sGPoh7d3vjz5ISfiA=;
        b=fmvJV98SAI0Wl9n4Iannh+wk15fSoT43V3wHcSRUljVHGq2qOqdRD27FKTdgvCW/qK8UhI
        MW5Ml7Vb3XTgQs66b00WFzvmWIGkMKfhR2s3bDFlXLQjcrguHmDkjD2q7S1mCGG16Go7Or
        5cVVdbwoFm8aNSDxtBpE+HqFc0G3tPk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-696C7VKSPK6y7rofg20uaw-1; Wed, 16 Sep 2020 05:42:08 -0400
X-MC-Unique: 696C7VKSPK6y7rofg20uaw-1
Received: by mail-wm1-f69.google.com with SMTP id m25so817706wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gMIUkN39zioLKdRgfk5ZGYhuC2sGPoh7d3vjz5ISfiA=;
        b=f6AzrmNxUmjCx3hmpIoVbXxfcWk3n/pSCU1zyqEzWUP36rgdLvfNg1iyEU9JtzTQxP
         /21JkzntqduXuftIme3ZtyCghUPyQXHY+/JPWSsluDk6Go9NDplATsA7xiw5HcFJ8mil
         w+IQOdDt6KdS5F0wfyKfAbqab18DNfYM+uZTg3A0b40vzVRH/y9Tnn5F8gisuPUcWFLo
         JM0D80pmqG+Ji3UUGztH2LeNdyx4gmbmlZusQr1EuFKuOb9FkMSNZAX7MNraqYojwmeB
         UIxLBuRQqQnJrHqm5ASkpgYiI1NOlClG8ey8ZDIYHwTUorP303BZRwmZvYrTXiSVQl6n
         xpMA==
X-Gm-Message-State: AOAM532NVEW9DZx+h9041umGFAAeSbpnvvsyi9JNlZQTNZr0w+DOMXeS
        MQAJkgX36LhVHH7RgjJOhFvKUbzWVyWdamJWxSVyRmsGMcs8c0va6U5Ir0g0Wu8ZwqwsEUOzE89
        Zj2P+2QZGeyjvKqQmxKK6A/Kt
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr25717095wrt.122.1600249326348;
        Wed, 16 Sep 2020 02:42:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlAuMDjX6mL3tHiqqt3wqEEgtPAuWWbQVbNX6rpIlCJxDWqd359um1VEE2/OqwRumzZHjJhg==
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr25717069wrt.122.1600249326052;
        Wed, 16 Sep 2020 02:42:06 -0700 (PDT)
Received: from localhost.localdomain ([151.29.43.50])
        by smtp.gmail.com with ESMTPSA id l16sm35646630wrb.70.2020.09.16.02.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 02:42:05 -0700 (PDT)
Date:   Wed, 16 Sep 2020 11:42:03 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, valentin.schneider@arm.com,
        raistlin@linux.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix sched_dl_global_validate()
Message-ID: <20200916094203.GA6652@localhost.localdomain>
References: <20200915152048.GA25835@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915152048.GA25835@iZj6chx1xj0e0buvshuecpZ>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/09/20 23:20, Peng Liu wrote:
> When user changes sched_rt_{runtime, period}_us, then
> 
>   sched_rt_handler()
>     -->	sched_dl_bandwidth_validate()
> 	{
> 		new_bw = global_rt_runtime()/global_rt_period();
> 
> 		for_each_possible_cpu(cpu) {
> 			dl_b = dl_bw_of(cpu);
> 			if (new_bw < dl_b->total_bw)
> 				ret = -EBUSY;
> 		}
> 	}
> 
> Under CONFIG_SMP, dl_bw is per root domain , but not per CPU,
> dl_b->total_bw is the allocated bandwidth of the whole root domain.
> we should compare dl_b->total_bw against cpus*new_bw, where 'cpus'
> is the number of CPUs of the root domain.

Hummm, I think you are right. Guess nobody played a lot with changing
global values. :-/

> Also, below annotation(in kernel/sched/sched.h) implied implementation
> only appeared in SCHED_DEADLINE v2[1], then deadline scheduler kept
> evolving till got merged(v9), but the annotation remains unchanged,
> meaningless and misleading, correct it.
> 
> * With respect to SMP, the bandwidth is given on a per-CPU basis,
> * meaning that:
> *  - dl_bw (< 100%) is the bandwidth of the system (group) on each CPU;
> *  - dl_total_bw array contains, in the i-eth element, the currently
> *    allocated bandwidth on the i-eth CPU.
> 
> [1] https://lkml.org/lkml/2010/2/28/119
> 
> Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> ---
> In fact, I'm not 100% sure that's a bug, since it's too 'obvious' and
> not newly introduced code.
> 
> Also, the introduced #ifdef...#endif pairs look ugly, I have no idea
> how to eliminate them. Ideas and comments are welcome. Thanks.

Can't we just use dl_bw_cpus() ?

Thanks,
Juri

