Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E0525D547
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 11:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgIDJj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 05:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDJj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:39:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965FEC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 02:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QqT90p3rhFaTDHgMOPcigZE+5LY1U6eqKJ6hY6XGnC4=; b=NAWz69Ng8WWM4gSDVNHqU03nmk
        YD6X8hQ4P7prxhBldmOeg5Sp8VzYxFkSzAPJJ9Lzb28fX9wxBYIFQKMrGlCDacg/mGtajvXOu7Zzn
        yV1CyS4eVLLag6GvwDd5vzR/cReYVXP3S1ZjD/jUBgF8WdyoAisntUnPX+lyEVW0m3WYcQIREyh2L
        8qFoqIIKkK94JIBGUzzmKOgS/v4npb7yf+pFbgjDj2DriTDherxbDogpOOxW+k8nkfZ85Na3AISFX
        E4rjRq0XGIj3inZYynT/k8NYHtw0Jbp78p/bsu+9p+kRwzWyQnhiGU/CpZMYb7BOPexDmJ7S2pvXh
        3woyGGsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kE8C8-0003eC-SI; Fri, 04 Sep 2020 09:39:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 628193012DF;
        Fri,  4 Sep 2020 11:39:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2DE0428B80007; Fri,  4 Sep 2020 11:39:43 +0200 (CEST)
Date:   Fri, 4 Sep 2020 11:39:43 +0200
From:   peterz@infradead.org
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as SCHED_DEADLINE reviewer
Message-ID: <20200904093943.GI1362448@hirez.programming.kicks-ass.net>
References: <4476a6da70949913a59dab9aacfbd12162c1fbd7.1599146667.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4476a6da70949913a59dab9aacfbd12162c1fbd7.1599146667.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 11:26:23AM +0200, Daniel Bristot de Oliveira wrote:

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 592467ba3f4d..56d185210a43 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15363,6 +15363,7 @@ R:	Dietmar Eggemann <dietmar.eggemann@arm.com> (SCHED_NORMAL)
>  R:	Steven Rostedt <rostedt@goodmis.org> (SCHED_FIFO/SCHED_RR)
>  R:	Ben Segall <bsegall@google.com> (CONFIG_CFS_BANDWIDTH)
>  R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
> +R:	Daniel Bristot de Oliveira <bristot@redhat.com> (SCHED_DEADLINE)
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core

Absolutely, great to have you looking over that!

