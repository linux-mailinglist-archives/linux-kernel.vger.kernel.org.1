Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D674A2EB001
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 17:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbhAEQ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 11:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbhAEQ0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:26:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12493C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 08:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3c+2QQ6IEx4+shd4/rUcNQ2aFzXA0gIgRmomRrgLTyE=; b=ZNukMT8lQhROAVs6lpxsQwG8C7
        mathsUZmQiVV0D/ua9qXGl3+9ZjMRUAMkdOGeR6EQc/specJd4biK6/FkrH5HsFg+6ypgG+x3b3DV
        17iQBPoohKA8FJSrvCZLCxswzZnzp5vaIFvWdDNAKOh5x93ehimSxsnAaWCcBSeAWRAPVTYpAAf1/
        8YGQ9yiYwT/8xdYn9fGufhLif/k3iYYtZxXops4xxQdkIqF4JKoPKeKg7WBddTvxKczcr+EbDWefz
        ywBVUFN9llw1CszyMR5r4+xaS3IzzgtXDCmUa/JgjjvKiYti0tI9tc8atpXDOvTlhambXQT5IbwFj
        KfIcaKJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kwp8K-001Qvq-Q7; Tue, 05 Jan 2021 16:24:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1252330377D;
        Tue,  5 Jan 2021 17:24:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCB41201B8B9C; Tue,  5 Jan 2021 17:24:31 +0100 (CET)
Date:   Tue, 5 Jan 2021 17:24:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -tip V3 3/8] workqueue: introduce wq_online_cpumask
Message-ID: <20210105162431.GL3040@hirez.programming.kicks-ass.net>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <20201226025117.2770-4-jiangshanlai@gmail.com>
 <20210104135649.GO3021@hirez.programming.kicks-ass.net>
 <CAJhGHyB_MUHG8GGANcN9sQbjY7M5m8WPHQgXp-PmkGK481M5Tg@mail.gmail.com>
 <CAJhGHyCwyuzikMZAxub=rxn9oe-N2P5C8CEOmyigd9d55SV5YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyCwyuzikMZAxub=rxn9oe-N2P5C8CEOmyigd9d55SV5YA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 04:23:44PM +0800, Lai Jiangshan wrote:

> Even with the help of wq_online_cpumask, the patchset can't silence
> the warning in __set_cpus_allowed_ptr() in this case.  It is indeed
> hard to suppress the warning for unbound pools.  Maybe we need something
                                   ^^^^^^^

Argh.. I forgot about the distinction between bound and unbound again.

> like this (outmost callback of CPUHP_AP_WORKQUEUE_UNBOUND_ONLINE,
> so that workqueue can do preparation when offlining before AP_ACTIVE):
> 
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 0042ef362511..ac2103deb20b 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -20,6 +20,9 @@
>   *               |                               ^
>   *               v                               |
>   *              AP_ACTIVE                      AP_ACTIVE
> + *               |                               ^
> + *               v                               |
> + *              ONLINE                         ONLINE
>   */
> 
>  enum cpuhp_state {
> @@ -194,6 +197,7 @@ enum cpuhp_state {
>         CPUHP_AP_X86_HPET_ONLINE,
>         CPUHP_AP_X86_KVM_CLK_ONLINE,
>         CPUHP_AP_ACTIVE,
> +       CPUHP_AP_WORKQUEUE_UNBOUND_ONLINE,
>         CPUHP_ONLINE,
>  };

Yes, doing the unbound things late should not be a problem.

> The other way is to modify __set_cpus_allowed_ptr() to suppress the
> warning for kworkers and believe/let the workqueue handle cpumask correctly.

The thing is that we don't want 'random' work injected in the CPU during
the hotplug process since we're not exactly sure what state the thing is
in. Once we're active, we know all is well and we can run regular crud.

The thing with bound workers is that they'll only run work originating
on the CPU itself, and should thus be fine.
