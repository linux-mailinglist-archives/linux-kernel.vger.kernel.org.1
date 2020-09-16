Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF66026CD11
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgIPUxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgIPQyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:54:11 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87068C02C2A9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:39:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m15so3386999pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 08:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jkMxiPFT5lKAK7ekVlt0PVlHZXsWZmIkFuc/7f7TT2c=;
        b=chC8gDGrIcoZ1u7L9zNbLUZqlC8LoREn6h95kzDrqMI57XjPz/IR6bobKCQ2eN4bzH
         /INGnl+++ACFSayvGWWX7+tDVkvdtLc3+v8fOR5qWYodV69QkRWExK6CmMlQprVaRYah
         77admZ3vGoIlQxpdYmn6Hn8k8qbrLxIwPBsJWg9cViYWxR+A78qby5YtFE4imM7ktFlR
         jzdIwHfdn0I71KxedqIqjUFqyH1K+lsCK9/AseQBeSGdlCe/Vy2W59EqDnSPPw2i0xH7
         1l1mey3u/Vebjl6YoXtHXkf8RRd+IWDuFTXk1LqXskkQCCQREHp/gp2DRIH3duIFa2Wb
         Ay0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jkMxiPFT5lKAK7ekVlt0PVlHZXsWZmIkFuc/7f7TT2c=;
        b=Cyb2n7E5u+wFFMyQL9hzId6rN6W0425I7JOkT3HNPTR/WEJxkeYpeAZIs1IfLEq/ZV
         jiXUA7f6iJtYT6mJCRSaBfqzIcBcVUIHWKgR+vbThVxAGtnmiWqL758haewckp2FDaGO
         UeDsiCGQuCTQXeLUwjkghnUlk8kutXtcvIERwgZo4aRW6tEfqt3z+EoxYjpcL2x1bA6u
         /7lk8HkOIebFk4ps0YcXNnE/XmC8CgbFmKHqdGXBgkDK1+5l2d97npCZ8NThHxl+dKbz
         gcdqoZWdcb1E9qEl8WCtt2OFrphMmuGFtMUibFCQLVv2GZKMA2q9ophfTQXptwCClm60
         e8lg==
X-Gm-Message-State: AOAM533gZVljOldHo5TJ/CV9DD3N6Gm5KBH2LkU8zeStI5977mKYef9d
        YcRjuc8DT9abzangl1eg5BU=
X-Google-Smtp-Source: ABdhPJxfLLSPz/7aPL7FMl/UJF09dE8L9Nm0vDQ8lQH6eKLUlfvZmYO/Vtl4pNQUyfkryZn2Xi8EGw==
X-Received: by 2002:a17:90a:8d05:: with SMTP id c5mr4383433pjo.222.1600270773046;
        Wed, 16 Sep 2020 08:39:33 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id z1sm12445510pfj.113.2020.09.16.08.39.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Sep 2020 08:39:32 -0700 (PDT)
Date:   Wed, 16 Sep 2020 23:39:28 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, valentin.schneider@arm.com,
        raistlin@linux.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix sched_dl_global_validate()
Message-ID: <20200916153928.GA27602@iZj6chx1xj0e0buvshuecpZ>
References: <20200915152048.GA25835@iZj6chx1xj0e0buvshuecpZ>
 <20200916094203.GA6652@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916094203.GA6652@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 11:42:03AM +0200, Juri Lelli wrote:
> Hi,
> 
> On 15/09/20 23:20, Peng Liu wrote:
> > When user changes sched_rt_{runtime, period}_us, then
> > 
> >   sched_rt_handler()
> >     -->	sched_dl_bandwidth_validate()
> > 	{
> > 		new_bw = global_rt_runtime()/global_rt_period();
> > 
> > 		for_each_possible_cpu(cpu) {
> > 			dl_b = dl_bw_of(cpu);
> > 			if (new_bw < dl_b->total_bw)
> > 				ret = -EBUSY;
> > 		}
> > 	}
> > 
> > Under CONFIG_SMP, dl_bw is per root domain , but not per CPU,
> > dl_b->total_bw is the allocated bandwidth of the whole root domain.
> > we should compare dl_b->total_bw against cpus*new_bw, where 'cpus'
> > is the number of CPUs of the root domain.
> 
> Hummm, I think you are right. Guess nobody played a lot with changing
> global values. :-/
> 
> > Also, below annotation(in kernel/sched/sched.h) implied implementation
> > only appeared in SCHED_DEADLINE v2[1], then deadline scheduler kept
> > evolving till got merged(v9), but the annotation remains unchanged,
> > meaningless and misleading, correct it.
> > 
> > * With respect to SMP, the bandwidth is given on a per-CPU basis,
> > * meaning that:
> > *  - dl_bw (< 100%) is the bandwidth of the system (group) on each CPU;
> > *  - dl_total_bw array contains, in the i-eth element, the currently
> > *    allocated bandwidth on the i-eth CPU.
> > 
> > [1] https://lkml.org/lkml/2010/2/28/119
> > 
> > Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
> > ---
> > In fact, I'm not 100% sure that's a bug, since it's too 'obvious' and
> > not newly introduced code.
> > 
> > Also, the introduced #ifdef...#endif pairs look ugly, I have no idea
> > how to eliminate them. Ideas and comments are welcome. Thanks.
> 
> Can't we just use dl_bw_cpus() ?
> 

Oh, good idea, I will have a try. Thanks for your time!

> Thanks,
> Juri
> 
