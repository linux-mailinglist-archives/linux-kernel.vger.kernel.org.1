Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9737E2FD28A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389296AbhATOWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731468AbhATM73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:59:29 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC77C06179B
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 04:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lHUmiFueFx5B8C+YZqY0KcIWEyk06ZB2IQvCenLqtRI=; b=ptbYun5xw7Y737xZI/ZBJZJfv/
        Lvs3DQDOUbkHo1fVGOs5u/3Y8h6y8yKW6tMdccx+RyicMwY9sczsHZPqr4aQf3yXU2uPtCaOdvG5E
        xEYieWCzU2Nz/qZkJqjLI0qYZRUQaeqwMVw20TgMER6+6kFIB7cBGOgTjzOxZ/2pe1K7AFCoSCmMn
        TETmZwyJpoVWJ/5U4moKCawiDEsWk/KXTp4AfAmqxRtpljTrXdqXYN6wW6t4OJ4Go0NWZ5S0oG+Wf
        YxiXEc2DSK7bdNRhEUz7n9Gdxkb6ksWVsChY8gzO5N1vk6qKvHyf37dVsPEYLA3ALCnFNdlX9QMWj
        XlPzgDLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l2D4J-0004QS-Cr; Wed, 20 Jan 2021 12:58:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 22B6D303271;
        Wed, 20 Jan 2021 13:58:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07BE9200E3598; Wed, 20 Jan 2021 13:58:36 +0100 (CET)
Date:   Wed, 20 Jan 2021 13:58:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     vincent.donnefort@arm.com
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH 2/4] cpu/hotplug: CPUHP_BRINGUP_CPU exception in fail
 injection
Message-ID: <YAgo+zMrbFjJ/meF@hirez.programming.kicks-ass.net>
References: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
 <1610385047-92151-3-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610385047-92151-3-git-send-email-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 05:10:45PM +0000, vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> The atomic states (between CPUHP_AP_IDLE_DEAD and CPUHP_AP_ONLINE) are
> triggered by the CPUHP_BRINGUP_CPU step. If the latter doesn't run, none
> of the atomic can. Hence, rollback is not possible after a hotunplug
> CPUHP_BRINGUP_CPU step failure and the "fail" interface shouldn't allow
> it. Moreover, the current CPUHP_BRINGUP_CPU teardown callback
> (finish_cpu()) cannot fail anyway.
> 
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> ---
>  kernel/cpu.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 9121edf..bcd7b2a 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2216,9 +2216,14 @@ static ssize_t write_cpuhp_fail(struct device *dev,
>  		return -EINVAL;
>  
>  	/*
> -	 * Cannot fail STARTING/DYING callbacks.
> +	 * Cannot fail STARTING/DYING callbacks. Also, those callbacks are
> +	 * triggered by BRINGUP_CPU bringup callback. Therefore, the latter
> +	 * can't fail during hotunplug, as it would mean we have no way of
> +	 * rolling back the atomic states that have been previously teared
> +	 * down.
>  	 */
> -	if (cpuhp_is_atomic_state(fail))
> +	if (cpuhp_is_atomic_state(fail) ||
> +	    (fail == CPUHP_BRINGUP_CPU && st->state > CPUHP_BRINGUP_CPU))
>  		return -EINVAL;

Should we instead disallow failing any state that has .cant_stop ?
