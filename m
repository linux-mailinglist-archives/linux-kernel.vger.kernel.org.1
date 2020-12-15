Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27732DA93E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgLOIeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbgLOIeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:34:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB05C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 00:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jze8vaSq+pX7xk2G30IYoa/LYpm0nBtDsVa/69TpkdU=; b=Gvs1D5Pz7dosF4zLwdYhp06XbI
        7ZvzWP77jFWNYKa0efpliQpFepoOvIqbHtlv0ncxA5SCNv9aBo0BJpXYf5MFTdtfS3noEQEViB5F5
        NNQyLoWVrhXkrN+3A3jA+r3CQsCOuYwMjt+IYnuA6ppRFaIjAkk7ZyA00JQzVx0Kdo6NPXl1PHm6T
        Ngn0WccYMng6bn77KlCEQTESzb3fjEC0RpKFtO2m9WnRgTNcETnZ/nN0daKpN791aw3iaFJaS90iL
        JgN8h1kOyHjOhsE61YCI6m9Joa36eiEPzM8nhgolsq/N9Q8FyybpLG+jfzLPE9QbNIatPF26jwrCr
        vBlCRVVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kp5lF-0001Tz-60; Tue, 15 Dec 2020 08:32:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 824A63059C6;
        Tue, 15 Dec 2020 09:32:38 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 43A1120218DB9; Tue, 15 Dec 2020 09:32:38 +0100 (CET)
Date:   Tue, 15 Dec 2020 09:32:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     chenxg1x@gmail.com
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, heddchen@tencent.com,
        xiaoggchen@tencent.com
Subject: Re: [PATCH] sched: don't check rq after newidle_balance return
 positive
Message-ID: <20201215083238.GB3040@hirez.programming.kicks-ass.net>
References: <1608014930-5144-1-git-send-email-xiaoggchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608014930-5144-1-git-send-email-xiaoggchen@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 02:48:50PM +0800, chenxg1x@gmail.com wrote:
> From: Chen Xiaoguang <xiaoggchen@tencent.com>
> 
> In pick_next_task_fair, if CPU is going to idle newidle_balance
> is called first trying to pull some tasks.
> When newidle_balance returns positive which means it does
> pulls tasks or some tasks enqueued then there is no need to check
> sched_fair_runnable again.

No, I think it actually does need to, because while it counts the number
of tasks it pulled, it doesn't verify it still has them after it
re-acquires rq->lock. That is, someone could've come along and stolen
them right from under our noses.

> 
> Signed-off-by: He Chen <heddchen@tencent.com>
> Signed-off-by: Xiaoguang Chen <xiaoggchen@tencent.com>

This SoB chain is broken. The first SoB should be the author, but From
does not match.
