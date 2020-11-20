Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EDA42BAAA5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 14:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgKTM6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgKTM6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:58:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF1EC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 04:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qfhCzsxk+FUHQt2BIkhhxlSNS+tUP6ViHlrOcs1g0EA=; b=Lrxb2NmTF+GkaHKD6TmVipchJY
        KXlm8tjdrvi6Y7xr0F0i0jgDKpVECI3iQn6Yex70ZMqe8SEGl3vVbaDwkyeLkQF3xoXxI1LsjXja3
        /qpQp7qbMpwLdrUlGz0lZZ17slUUzANLjZxjR6Tut9bLjEmNiL6lI3Bm5vXr+v9nPGWPi/zh6xnUH
        aZA5WMoewkmnJX6yhjgI6Mn1nK6i3SjFvMxXhl26QSntunpCcO0pRIAtzI1pugrzOnjxvt/xLLYxI
        0pO3UdIL+/EVX2pXD3K/tOw11LEEEyEQA+VZ5pmaa2gDHalZM5kTi/O4tNifSYLnTh0eBZsM4mxYR
        SkVCXlwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg5zP-0001FA-R8; Fri, 20 Nov 2020 12:58:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 52A08304D28;
        Fri, 20 Nov 2020 13:58:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3DC4C201D16DD; Fri, 20 Nov 2020 13:58:11 +0100 (CET)
Date:   Fri, 20 Nov 2020 13:58:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] Revisit NUMA imbalance tolerance and fork
 balancing
Message-ID: <20201120125811.GJ3021@hirez.programming.kicks-ass.net>
References: <20201120090630.3286-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120090630.3286-1-mgorman@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 09:06:26AM +0000, Mel Gorman wrote:

> Mel Gorman (4):
>   sched/numa: Rename nr_running and break out the magic number
>   sched: Avoid unnecessary calculation of load imbalance at clone time
>   sched/numa: Allow a floating imbalance between NUMA nodes
>   sched: Limit the amount of NUMA imbalance that can exist at fork time
> 
>  kernel/sched/fair.c | 44 +++++++++++++++++++++++++++++++-------------
>  1 file changed, 31 insertions(+), 13 deletions(-)

OK, lets give this another go :-)

Thanks!
