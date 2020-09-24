Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBC2277102
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgIXM3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgIXM3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:29:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE10C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wtQTDdmEMh1+PZHybPfpi61tawXPQ1boTfv/FGVLjNI=; b=hE6dPepONZJMY8VTlwfQ4l7JiJ
        9vljV1Fwlfrr4y0G+z/26oXS8phHqllfuQjFumk75NFx5D15Cv0PcQIW+n+EUiYbx5m+WCpzPU2gu
        icYfowBARkDnWV0sHOFeHy2GkjaCXAUC76mirY2pfLJenUjUfc/KLkKnE5iVxYTyOWwDXGqL83tcd
        J2PgBZhXARsyTSUX68muDTXJZtTuFNTeB1d46dFmawJOss4TyqebiIAL+SPg6084VdrZSn5hUSM8X
        0nxRRoxZAVQx6yzhU/NJOdYDdcoc7cYX1+niIIMqm3lfBAHj45UteLq+K8weEYMrAgv1qXO9N6DGq
        CKzNnZuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLQNT-0006Cl-Ca; Thu, 24 Sep 2020 12:29:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A37383059DE;
        Thu, 24 Sep 2020 14:29:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8E08720315103; Thu, 24 Sep 2020 14:29:34 +0200 (CEST)
Date:   Thu, 24 Sep 2020 14:29:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 7/9] sched: Add migrate_disable()
Message-ID: <20200924122934.GI2628@hirez.programming.kicks-ass.net>
References: <20200921163557.234036895@infradead.org>
 <20200921163845.769861942@infradead.org>
 <jhj5z83mlvu.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj5z83mlvu.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 12:53:25PM +0100, Valentin Schneider wrote:
> On 21/09/20 17:36, Peter Zijlstra wrote:
> 
> [...]
> 
> > +void migrate_enable(void)
> > +{
> > +	if (--current->migration_disabled)
> > +		return;
> > +
> > +	barrier();
> > +
> > +	if (p->cpus_ptr == &p->cpus_mask)
> > +		return;
> 
> If we get to here this means we're the migrate_enable() invocation that
> marks the end of the migration_disabled region. How can cpus_ptr already
> point back to current's cpus_mask?

It might never have been changed away.


	migrate_disable()
	  ->migration_disabled++;
	|	|
	|	|
	|	v
	|	migrate_disable_switch()
	|	  if (->cpus_ptr == &->cpus_mask)
	|	    __do_set_cpus_allowed(.new_mask = cpumask_of())
	|	|
	|	|
	v	v
	migrate_enable()
	  ->migration_disabled--;


Only if we've passed through a context switch between migrate_disable()
and migrate_enable() will the mask have been changed.
