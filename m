Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C5928E15E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbgJNNcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727250AbgJNNcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602682373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m47UYKFk/3zOESWP+ny/G5ToVtPRTEjIE+FkJ8vLBUs=;
        b=X/PV25uwlRl9CrOGTE5Kyfvjf4SZAy37OSWC2QBV0BX4ODkxQrcOwO+xRMbedgIrBMJsuI
        2hZ+J69PQuuBux7XH3tqxEd6LzP36AnbWhRnUPsooZBNCkxueDISiQjst7UiXjrz8vHAux
        cWPCqZGMYQcxKkDSvLMma9VTAwD+XaA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-BbAa4pkAO6GrPgvHKsuOzw-1; Wed, 14 Oct 2020 09:32:51 -0400
X-MC-Unique: BbAa4pkAO6GrPgvHKsuOzw-1
Received: by mail-wr1-f72.google.com with SMTP id i6so1278425wrx.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:32:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m47UYKFk/3zOESWP+ny/G5ToVtPRTEjIE+FkJ8vLBUs=;
        b=IYZ1jqlNMFftndSAdNmYFTgc/yLW+yI+TXVYl2uVItTUdgerkp0tAesd6ZAJOORwMI
         UpHCRjNpJ21kxQ0J0dLMaDm/uF6BnbKPJ2/PFyL1sPYF9kvwdBdBErfV+weyA2ImxyfR
         WBu+XYW5Vrg+LeNtw5k+5w68OFkQz6KJ4qGAOmsN2mJLONHh/2FekxR2IjxPruBB+8Y0
         kZS7gju8+MxRDTXbUUqOeb53sFQ/ZEyhr8fTmJdClK5PVl/iL5qXDzcMRiCEiZgtdE25
         XFD5B0qJ8JBh9d3DCjult9hRdTTx4C7E66KAYVpaqnMi3QA1R1uJm6XAakWojsA3woil
         NoxA==
X-Gm-Message-State: AOAM530D4U3rJnFKpYBfQcqUo0NJIYZvgf/iFEtSHNS/HY1PaE+qpEFz
        Yz9oW8jXdShCBk99GeHQLOBJ0Dbo2IMBu6FtBNyGPQxoLTmrXRlOqhmkASBqH1JNX/mReTCysBa
        60uhwxR2Qtk3O03fxV9RiHYdO
X-Received: by 2002:adf:f7d1:: with SMTP id a17mr5636508wrq.396.1602682370267;
        Wed, 14 Oct 2020 06:32:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyARr/IsRyrYkqNIYDO+gojSI1wXxUc/3MCyB8YBQ2a+/0bZYgzY9MJhrodtqcW7YAJRFuGRA==
X-Received: by 2002:adf:f7d1:: with SMTP id a17mr5636475wrq.396.1602682369976;
        Wed, 14 Oct 2020 06:32:49 -0700 (PDT)
Received: from localhost.localdomain ([151.29.181.254])
        by smtp.gmail.com with ESMTPSA id k190sm3347217wme.33.2020.10.14.06.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 06:32:49 -0700 (PDT)
Date:   Wed, 14 Oct 2020 15:32:47 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peng Liu <iwtbavbm@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, valentin.schneider@arm.com,
        raistlin@linux.it
Subject: Re: [PATCH v6 0/2] sched/deadline: Fix and optimize
 sched_dl_global_validate()
Message-ID: <20201014133247.GC219214@localhost.localdomain>
References: <cover.1602171061.git.iwtbavbm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1602171061.git.iwtbavbm@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/10/20 23:47, Peng Liu wrote:
> When change global rt bandwidth, we check to make sure that new
> settings could accommodate the allocated dl bandwidth.
> 
> Under SMP, the dl_bw is on a per root domain basis, currently we check
> and update the new settings one cpu by one cpu, but not in the unit of
> root domain, which is either overdoing or error.
> 
> patch 1 removed the superfluous checking and updating
> patch 2 fixed the error validation
> 
> For details, please see the corresponding patch.
> 
> ----------------
> v6 <-- v5:
>  - no functional changes, just revert visit_gen back to u64;
> 
> v5 <-- v4:
>  - no functional changes, just split the v4 single patch to two to
>    obey the "one patch do only one thing" rule;
>  - turn root_domain::visit_gen from u64 to u32;
>    both suggested by Juri.
>  - refine changelog;
> 
> v4 <-- v3:
>  - refine changelog;
>  - eliminate the ugly #ifdef guys with Peter's method;
> 
> v3 <-- v2:
>  - fix build error for !CONFIG_SMP, reported by kernel test robot;
> 
> v2 <-- v1:
>  - replace cpumask_weight(cpu_rq(cpu)->rd->span) with dl_bw_cpus(cpu),
>    suggested by Juri;
> 
> Peng Liu (2):
>   sched/deadline: Optimize sched_dl_global_validate()
>   sched/deadline: Fix sched_dl_global_validate()
> 
>  kernel/sched/deadline.c | 44 +++++++++++++++++++++++++++--------
>  kernel/sched/sched.h    | 51 ++++++++++++++++++++++-------------------
>  kernel/sched/topology.c |  1 +
>  3 files changed, 63 insertions(+), 33 deletions(-)

These look now good to me. Thanks a lot!

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

