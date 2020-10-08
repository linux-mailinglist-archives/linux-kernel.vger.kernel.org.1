Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50052287584
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgJHN6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbgJHN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:58:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B142FC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 06:58:12 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l126so4076389pfd.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 06:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oir1Bc8C7USXN/vmPcT89Ig8CUI5f1Wq3nBTHLQdxVg=;
        b=M3Xlm6V3daPblXhc58Q8FryNR2c+0lfLiwa0b4HtkEBsZWKL93s7q4DddnLmGsftka
         MxClZi3ecNsotFwGNf0yxJ44MAM65Hxe1q0ezUNbdwPK3Cn87Zvf8YT78wKSHOWEq8Ld
         LSAY7EaIDqemxjTadP5G1N7i9XW9I7hy5EUyp+CebPP4r64tkPcaNdDHQfNE89TZklDA
         hopMJvdScDQsVFHY8nZkIxk7/5/RkBExpCzwf3Umk6Xg/XsqdUBk61K582Ohq29OUmwk
         IS/Nz98lSEkwOWg0pA0feV/NZmVsyPmFvdDuRiFIO8Nrg1W91p57syVxg916IllIy4zP
         MPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oir1Bc8C7USXN/vmPcT89Ig8CUI5f1Wq3nBTHLQdxVg=;
        b=ttkceC541GzWs/YnPuKlAQzcYxBs806/wvPDDr7rbcODZcq4K9zHHsYHtzlAOXw8XB
         XC3Upz0e9/wa3FNluG2LX6Z9svN+RN9Y7ho4+s7/JMh2H3mw/p5kgBwWhXrREOTTJ4QW
         tneKMED8+rCfhNuo66D06gRhpFUL4SPyxPe1rmMBqEBbWsf/C90qN04YL1dw49BA1+/Z
         9HodYDslPjofCe6b1TfyiPxlrlv9lw3fIyaCJLRVJ7miPX44DjOY+iYUenwkFDQsL46D
         p7uLEN5miHJsOCM4h9E3ToLSyz+oO8HySfqS75bqZBmvFfb54oOUvE13i2w8pIr4pexo
         HFMQ==
X-Gm-Message-State: AOAM531C7oiw2SgDc9Fl54vsUY+7QvPUys04mlcI/aFUJCACUZj8fKq+
        kcT+EMbfNe1472Cfb9Hjc0w=
X-Google-Smtp-Source: ABdhPJyH/uRW1eZh/xq+ACARedlHW66P2CKbCFFT7X6NQjM9doT1EUmZeMsZkS7R1IQUyYuBB7M0dQ==
X-Received: by 2002:a63:541a:: with SMTP id i26mr7308285pgb.265.1602165492240;
        Thu, 08 Oct 2020 06:58:12 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id z28sm7900470pfq.81.2020.10.08.06.58.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Oct 2020 06:58:11 -0700 (PDT)
Date:   Thu, 8 Oct 2020 21:58:07 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, valentin.schneider@arm.com, raistlin@linux.it,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] sched/deadline: optimize
 sched_dl_global_validate()
Message-ID: <20201008135807.GA29010@iZj6chx1xj0e0buvshuecpZ>
References: <cover.1601993091.git.iwtbavbm@gmail.com>
 <9ad8eff54a3dd6f7f0da50e827047e4d3c4bb00a.1601993091.git.iwtbavbm@gmail.com>
 <20201007165533.GL2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007165533.GL2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 06:55:33PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 07, 2020 at 11:12:29PM +0800, Peng Liu wrote:
> > +/* Used for dl_bw check and update. */
> > +static u32 dl_generation;
> 
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 28709f6b0975..53477e8b26b0 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -798,6 +798,13 @@ struct root_domain {
> >  	 */
> >  	cpumask_var_t		dlo_mask;
> >  	atomic_t		dlo_count;
> > +
> > +	/*
> > +	 * Indicate whether a root_domain's dl_bw has been checked or
> > +	 * updated. It's monotonously increasing, then wrap around.
> > +	 */
> > +	u32 visit_gen;
> > +
> >  	struct dl_bw		dl_bw;
> >  	struct cpudl		cpudl;
> >  
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index dd7770226086..90f3e5558fa2 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -516,6 +516,7 @@ static int init_rootdomain(struct root_domain *rd)
> >  	init_irq_work(&rd->rto_push_work, rto_push_irq_work_func);
> >  #endif
> >  
> > +	rd->visit_gen = 0;
> >  	init_dl_bw(&rd->dl_bw);
> >  	if (cpudl_init(&rd->cpudl) != 0)
> >  		goto free_rto_mask;
> 
> I'm fairly sure I made the generation a u64, the above is susceptible to
> a false positive due to wrap-around.
> 
> Increase the generation to -1, create a new root domain, then the next
> generation is 0 and we'll skip the new domain, even though it should be
> updated.

Ah... at first, I also thought that u32 is "big enough" given that
no one would frequently change the settings, 'wrap-around' shouldn't
be a concern.

So...OK, I will revert it back to u64. What a big circle! :)

Thanks for your time!
