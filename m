Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DE82B171B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgKMISf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgKMISd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:18:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E565C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 00:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jw7SvFWr69ZYlFoLhNiv1c47Ivhef5jgAESILfLDztU=; b=mqpgOb14ckzZBkDEdtWTMp2AQG
        rVfS0p9iGYOJznrbIEG+brMwenrEUvn0du+q0wwoTcYUPGvapM/+EtO7djeX+V4EGHoRxb7/eP1iR
        6VFtq0RZ5uRkU5Uz9obcvaIgyjvb8WxS+7lKiBXcyRyebwYrTku94RcQrKzoJYBKYx4yhuus9sYRE
        1XBtIdgP1Kehd+L8PL05QMAkSShb8NzOjMJ1c8j6n/6qIvu+1z3m2eLBxT6TqRzfwbKDxo7I12MeD
        Y6tx31GVIPo8BWGwc8jkyeF0E6+75NUOdyormR5v2wHdu3onUyT04XyRQrMjaYXkoMq2Jb0eAsKTj
        ikaKJXjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdUHk-0007Cj-Eq; Fri, 13 Nov 2020 08:18:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CA5393050F0;
        Fri, 13 Nov 2020 09:18:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9E312C084CB2; Fri, 13 Nov 2020 09:18:19 +0100 (CET)
Date:   Fri, 13 Nov 2020 09:18:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@qperret.net>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Rick Yiu <rickyiu@google.com>
Subject: Re: [PATCH] sched/fair: Fix overutilized update in
 enqueue_task_fair()
Message-ID: <20201113081819.GB2628@hirez.programming.kicks-ass.net>
References: <20201112111201.2081902-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112111201.2081902-1-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 11:12:01AM +0000, Quentin Perret wrote:
> enqueue_task_fair() attempts to skip the overutilized update for new
> tasks as their util_avg is not accurate yet. However, the flag we check
> to do so is overwritten earlier on in the function, which makes the
> condition pretty much a nop.
> 
> Fix this by saving the flag early on.
> 
> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point
> indicator")

Fix that wrapping for you :-)

> Reported-by: Rick Yiu <rickyiu@google.com>
> Signed-off-by: Quentin Perret <qperret@google.com>

Thanks!
