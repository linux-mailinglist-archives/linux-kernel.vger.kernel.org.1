Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882692D9D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 18:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439009AbgLNR0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 12:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440358AbgLNR0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 12:26:23 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473FEC0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 09:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O3gSaz8QejPpfzYTIQMsvrNSeRSpHoRrt5ixi5UrUrU=; b=nBK3OJ6lGoiO+2Utpd6wDesJny
        4OOZqIZ+ExRa9CZ3+vTSovtNaaLSCjGow/aQRxX20odaau991ksZsRejg0+Yya4womhfAWIA3chXk
        5/cBPVm6spt+rIRkE88d6oVSA9X1B3h7Pfj+z/6W0DEkNw8h3Van+s5egTzgGzLFxCJWMsDnqAvDr
        1X+dQz8OPZCEay2s5x/dCuo6JxCxatE5YtB/2rwOCguRMFh1VyaZGgen4grshs0Ns3jMJ3QXuZtPP
        OgAYtwv6186OdPJSR+rodytdXA9/P3ATHr9SeZk0b6jjE8bGoYV3lPCHdcaWLggHZOlvioUZZ0f2O
        Zw5iilfA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1korbN-0004Ri-BD; Mon, 14 Dec 2020 17:25:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5C4FB3010CF;
        Mon, 14 Dec 2020 18:25:34 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 40C202C6E01D8; Mon, 14 Dec 2020 18:25:34 +0100 (CET)
Date:   Mon, 14 Dec 2020 18:25:34 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 02/10] workqueue: use cpu_possible_mask instead of
 cpu_active_mask to break affinity
Message-ID: <X9egDheiQPLdR0IS@hirez.programming.kicks-ass.net>
References: <20201214155457.3430-1-jiangshanlai@gmail.com>
 <20201214155457.3430-3-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214155457.3430-3-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 11:54:49PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> There might be other CPU online. The workers losing binding on its CPU
> should have chance to work on those later onlined CPUs.
> 
> Fixes: 06249738a41a ("workqueue: Manually break affinity on hotplug")
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  kernel/workqueue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index aba71ab359dd..1f5b8385c0cf 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -4909,8 +4909,9 @@ static void unbind_workers(int cpu)
>  
>  		raw_spin_unlock_irq(&pool->lock);
>  
> +		/* don't rely on the scheduler to force break affinity for us. */
>  		for_each_pool_worker(worker, pool)
> -			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_active_mask) < 0);
> +			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);

Please explain this one.. it's not making sense. Also the Changelog
doesn't seem remotely related to the actual change.

Afaict this is actively wrong.

Also, can you please not Cc me parts of a series? That's bloody
annoying.
