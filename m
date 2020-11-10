Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C142ADC66
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 17:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgKJQub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 11:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKJQub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 11:50:31 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CE2C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 08:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yuIbCOnKKp1cU5nUzMJ2su+aXHIyfLl8hCU3icRFERo=; b=adRDsVj1nKuaKshLjR93xHtIHB
        HVFao2u5t8QH/2chVzoM9LVxYRrhniiGE9Eq0M+feBXN37+SYvLy3nRwOdTML6JovKUj7PMV2pzr9
        bszc+F/nwGjv/Bx8LxMs3t7eqErLKUcHi/yk7C/ovA1PER0r2zf4ynlSs7W2SaCtpjYKszF/DDpvf
        MVYLjsgV5UPeLgW+f1FljCqO8AtOLi1Mu9FCGobnReCEQpnNFOwKuEf99HvDUmHJVpgnmnOtBW6qE
        8ny1xuvzoPlFllJy3e7M5sQuLWv4Zo/gIpGkjK6qWWbEqDyDZ7vFAFgPowb7jEeLRXoaaeuTxgDen
        MYvxv7xA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcWqX-0007vC-Ld; Tue, 10 Nov 2020 16:50:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5A57F301324;
        Tue, 10 Nov 2020 17:50:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23B8729A56BE4; Tue, 10 Nov 2020 17:50:15 +0100 (CET)
Date:   Tue, 10 Nov 2020 17:50:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        morten.rasmussen@arm.com, ouwen210@hotmail.com
Subject: Re: [PATCH v3] sched/fair: prefer prev cpu in asymmetric wakeup path
Message-ID: <20201110165015.GM2594@hirez.programming.kicks-ass.net>
References: <20201029161824.26389-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029161824.26389-1-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 05:18:24PM +0100, Vincent Guittot wrote:
> During fast wakeup path, scheduler always check whether local or prev cpus
> are good candidates for the task before looking for other cpus in the
> domain. With
>   commit b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
> the heterogenous system gains a dedicated path but doesn't try to reuse
> prev cpu whenever possible. If the previous cpu is idle and belong to the
> LLC domain, we should check it 1st before looking for another cpu because
> it stays one of the best candidate and this also stabilizes task placement
> on the system.
> 
> This change aligns asymmetric path behavior with symmetric one and reduces
> cases where the task migrates across all cpus of the sd_asym_cpucapacity
> domains at wakeup.
> 
> This change does not impact normal EAS mode but only the overloaded case or
> when EAS is not used.
> 
> - On hikey960 with performance governor (EAS disable)
> 
> ./perf bench sched pipe -T -l 50000
>              mainline           w/ patch
> # migrations   999364                  0
> ops/sec        149313(+/-0.28%)   182587(+/- 0.40) +22%
> 
> - On hikey with performance governor
> 
> ./perf bench sched pipe -T -l 50000
>              mainline           w/ patch
> # migrations        0                  0
> ops/sec         47721(+/-0.76%)    47899(+/- 0.56) +0.4%
> 
> According to test on hikey, the patch doesn't impact symmetric system
> compared to current implementation (only tested on arm64)
> 
> Also read the uclamped value of task's utilization at most twice instead
> instead each time we compare task's utilization with cpu's capacity.
> 
> Fixes: b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---

Thanks!
