Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1B4295F04
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898990AbgJVMx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441028AbgJVMx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:53:58 -0400
Received: from localhost (unknown [176.167.137.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FDAB223BF;
        Thu, 22 Oct 2020 12:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603371238;
        bh=gETMYWufyBD1Uv05rJk3SYq+AkAoGUZBPHj1bDf1fK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFqP+DPLiKSDJZoPnLxTjclvRZXZOL92qjscT7SezPAPjEXHmEzCzK7jzF53Gch1V
         mM3kn7Bbg/WtCV/4wudfFPLQTr+bLs6d8pozibJ0BbLhqYF+paqbx4+qZ/8qmymGM7
         3kpdRiFEq+RUERiKXgZQFfNP+Q05RrEQRJvUJLIQ=
Date:   Thu, 22 Oct 2020 14:53:55 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [patch 1/2] nohz: only wakeup a single target cpu when kicking a
 task
Message-ID: <20201022125355.GA16049@lothringen>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.724302019@redhat.com>
 <20201008122256.GW2628@hirez.programming.kicks-ass.net>
 <20201008175409.GB14207@fuller.cnet>
 <20201008195444.GB86389@lothringen>
 <20201013171328.GA19284@fuller.cnet>
 <20201014083321.GA2628@hirez.programming.kicks-ass.net>
 <20201014234053.GA86158@lothringen>
 <20201020185245.GA3577@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020185245.GA3577@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 03:52:45PM -0300, Marcelo Tosatti wrote:
> On Thu, Oct 15, 2020 at 01:40:53AM +0200, Frederic Weisbecker wrote:
> > Alternatively, we could rely on p->on_rq which is set to TASK_ON_RQ_QUEUED
> > at wake up time, prior to the schedule() full barrier. Of course that doesn't
> > mean that the task is actually the one running on the CPU but it's a good sign,
> > considering that we are running in nohz_full mode and it's usually optimized
> > for single task mode.
> 
> Unfortunately that would require exporting p->on_rq which is internal to
> the scheduler, locklessly.
> 
> (can surely do that if you prefer!)

May be:

    bool task_on_rq(struct task_struct *p) ?

Thanks.
