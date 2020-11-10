Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D996F2AD6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgKJMz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJMz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:55:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366C4C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 04:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NDNamzygZv0UYLaI6V7BJniz/TwKVa8aDWRmQYtojk0=; b=qesK5MM6DtR7AQrXvl2GEGxYG3
        rF21pgSGmOIHO8HN8ECsQB1WYVdUx0g5+qAFqar/TG8adaN1PLyr+z1Z0Zo0SUxEAQ4VjFnVVkZQY
        bLu4O5DYnZBkc0oHhiiFWG7gZfziilhTKJPaAGjGDgbdz2I3ww8Lapw+49Cy+7/dTwpg/+SkFKRGB
        gJRgxXVJAlJKLtqVEmojQGFF4flXRfFZ7HIp9nhZw/32vSST3jCkEg7wnfhTLa/QIN6Ka82ptmcWv
        eirWbW+sSBwI9KXGASR8c6/KxNcDYU225vVujVkSMqKDckjZbbGV4HUeeaHh0Vk3qUaRFWiF8FAl0
        pykOtKAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcTAx-0006OE-4Q; Tue, 10 Nov 2020 12:55:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2586D301E02;
        Tue, 10 Nov 2020 13:55:06 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12F882BA1DD1B; Tue, 10 Nov 2020 13:55:06 +0100 (CET)
Date:   Tue, 10 Nov 2020 13:55:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, riel@surriel.com, clm@fb.com,
        hannes@cmpxchg.org
Subject: Re: [PATCH] sched/fair: ensure tasks spreading in LLC during LB
Message-ID: <20201110125506.GJ2594@hirez.programming.kicks-ass.net>
References: <20201102102457.28808-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102102457.28808-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 11:24:57AM +0100, Vincent Guittot wrote:
> schbench shows latency increase for 95 percentile above since:
>   commit 0b0695f2b34a ("sched/fair: Rework load_balance()")
> 
> Align the behavior of the load balancer with the wake up path, which tries
> to select an idle CPU which belongs to the LLC for a waking task.
> 
> calculate_imbalance() will use nr_running instead of the spare
> capacity when CPUs share resources (ie cache) at the domain level. This
> will ensure a better spread of tasks on idle CPUs.
> 
> Running schbench on a hikey (8cores arm64) shows the problem:
> 
> tip/sched/core :
> schbench -m 2 -t 4 -s 10000 -c 1000000 -r 10
> Latency percentiles (usec)
> 	50.0th: 33
> 	75.0th: 45
> 	90.0th: 51
> 	95.0th: 4152
> 	*99.0th: 14288
> 	99.5th: 14288
> 	99.9th: 14288
> 	min=0, max=14276
> 
> tip/sched/core + patch :
> schbench -m 2 -t 4 -s 10000 -c 1000000 -r 10
> Latency percentiles (usec)
> 	50.0th: 34
> 	75.0th: 47
> 	90.0th: 52
> 	95.0th: 78
> 	*99.0th: 94
> 	99.5th: 94
> 	99.9th: 94
> 	min=0, max=94
> 
> Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
> Reported-by: Chris Mason <clm@fb.com>
> Suggested-by: Rik van Riel <riel@surriel.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
