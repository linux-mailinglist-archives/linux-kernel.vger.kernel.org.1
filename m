Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95B52EC0E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbhAFQME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbhAFQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:12:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC9BC06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+qfyMs5FDgoaco8XbmopXuzDpnstYMRh4Uqdozaw48Q=; b=cfS+8NKNIyjueFubKoNIY/8dwW
        4sY+B79+qt7Fy8e8VGegR0z37jeWagFOWSMdT9SSgzNQ+pbGeUK87HlB3RFn1idn8aj+N7t7TKcZx
        ylxVPalDbHIuHBZ5JdQ27WiSiFWy6PTGPu9xutAFY/+iCWlytsGpP9J7LMsJ6hiq7D6Q22mxQwOHv
        EVIRiAEGlw8/uwKVWHTbNYnFG0my4GQElFrh11I4zi2HbAZE2m+lAiMSJMK2vjGQvByz0UlusLL4M
        Vp8py+u3GGd2I9BcaefMWsjZ986jPJNcDUWpHsp7zWgJrwQskRlv3pu5WpMk/UvKAlOM6cte2PNrF
        NkNE4sEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxBOt-00071A-Ry; Wed, 06 Jan 2021 16:11:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D94183013E5;
        Wed,  6 Jan 2021 17:11:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDFE82029C723; Wed,  6 Jan 2021 17:11:03 +0100 (CET)
Date:   Wed, 6 Jan 2021 17:11:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] sched/fair: reduce cases for active balance
Message-ID: <X/XhFzKo/Gv+bFsx@hirez.programming.kicks-ass.net>
References: <20210106133419.2971-1-vincent.guittot@linaro.org>
 <20210106133419.2971-4-vincent.guittot@linaro.org>
 <X/XTlRMiOVs7L28B@hirez.programming.kicks-ass.net>
 <CAKfTPtCEV5zzXLM3RNf2-6XhVcDsstHdzh9OKX_j6WviRUVeYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCEV5zzXLM3RNf2-6XhVcDsstHdzh9OKX_j6WviRUVeYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 04:41:04PM +0100, Vincent Guittot wrote:

> Let me try again:
> 
> Active balance is triggered for a number of voluntary cases like
> misfit or pinned tasks cases but also after that a number of load
> balance attempts failed to migrate a task. There is no need to use
> active load balance when the group is overloaded because an overloaded
> state means that there is at least one waiting task. Nevertheless, the
> waiting task is not selected and detached until the threshold becomes
> higher than its load. This threshold increases with the number of
> failed lb (see the condition if ((load >> env->sd->nr_balance_failed)
> > env->imbalance) in detach_tasks()) and the waiting task will end up
> to be selected after a number of attempts.

Ah, makes sense now. Thanks!
