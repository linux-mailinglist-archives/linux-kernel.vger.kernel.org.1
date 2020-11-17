Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC162B699E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgKQQNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgKQQN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:13:29 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0078C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 08:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=noYJcmkZ1pKuEG0/DtLEB1n7xvrgps4QtlKybXX4u7Q=; b=ERIGSMjoZeskjSWCb0nMDzylOJ
        BllmA8djxY7fO25/odBSbGFx5iv/7Mnt5PXHKGuFrKJxfKYvnmhSLppaxZQVSj5BSS5Mr/GB6npi/
        y4bfS9lOJ0QAAPqXcQtuqgaq/KYk7xPOLYSZ4/kk+yI6PU6njfFe6jRwK/K8Hpk4PfF1zt4EHE5gW
        h2leHUQJWYSEFcfBx9b4x7Lla1iSsWGXSbTmr6F7r1lu8wu8qyRV1iywrZyLnMrie8wwcGWFxNKD6
        evhN8EM7wwFC4IefdNs9h0g5vJM8gQJ5TaKEGns4Ywh52vRTXB8ve4bfFppowRkSAjIjyLKJQ5pIo
        2mxo2IKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf3be-0008So-JC; Tue, 17 Nov 2020 16:13:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 654883019CE;
        Tue, 17 Nov 2020 17:13:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4F6C0203DEE9D; Tue, 17 Nov 2020 17:13:18 +0100 (CET)
Date:   Tue, 17 Nov 2020 17:13:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix data-race in wakeup
Message-ID: <20201117161318.GP3121392@hirez.programming.kicks-ass.net>
References: <20201116131102.GA29992@willie-the-truck>
 <20201116133721.GQ3371@techsingularity.net>
 <20201116142005.GE3121392@hirez.programming.kicks-ass.net>
 <20201116193149.GW3371@techsingularity.net>
 <20201117083016.GK3121392@hirez.programming.kicks-ass.net>
 <20201117091545.GA31837@willie-the-truck>
 <20201117092936.GA3121406@hirez.programming.kicks-ass.net>
 <20201117094621.GE3121429@hirez.programming.kicks-ass.net>
 <jhjv9e4w3gj.mognet@arm.com>
 <jhjtutovvtm.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjtutovvtm.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 03:37:24PM +0000, Valentin Schneider wrote:

> >> +	/*
> >> +	 * This field must not be in the scheduler word above due to wakelist
> >> +	 * queueing no longer being serialized by p->on_cpu. However:
> >> +	 *
> >> +	 * p->XXX = X;			ttwu()
> >> +	 * schedule()			  if (p->on_rq && ..) // false
> >> +	 *   smp_mb__after_spinlock();	  if (smp_load_acquire(&p->on_cpu) && //true
> >> +	 *   deactivate_task()		      ttwu_queue_wakelist())
> >> +	 *     p->on_rq = 0;			p->sched_remote_wakeup = Y;
> >> +	 *
> >> +	 * guarantees all stores of 'current' are visible before
> >> +	 * ->sched_remote_wakeup gets used, so it can be in this word.
> >> +	 */
> >
> > Isn't the control dep between that ttwu() p->on_rq read and
> > p->sched_remote_wakeup write "sufficient"?
> 
> smp_acquire__after_ctrl_dep() that is, since we need
>   ->on_rq load => 'current' bits load + store

I don't think we need that extra barrier; after all, there will be a
complete schedule() between waking the task and it actually becoming
current.
