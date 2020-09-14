Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77149268329
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 05:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgINDhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 23:37:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgINDhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 23:37:10 -0400
Received: from X1 (unknown [209.33.215.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C93208E4;
        Mon, 14 Sep 2020 03:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600054629;
        bh=6QTZVOcjG+eWq0IH6MhYUclBlgC09xtCL5lo4Aa+Lws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v178SJJnJs8lH9UmSTZLhzuSkOlaUKflojWWQ2rGtAicG9r05hQqyjzDhW6z/eo9I
         9S5ZFNNHo8P08NR48jxxf75hLJWxiXE41Vebdfu4eGmAZ0c8/xLMRj5BKMhCJsxgdG
         iaOVS4aqvouVn/zJCpw6j5RegDJgIFpX0xh+sEWI=
Date:   Sun, 13 Sep 2020 20:37:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, christian.brauner@ubuntu.com,
        mingo@kernel.org, peterz@infradead.org, ebiederm@xmission.com,
        esyr@redhat.com, tglx@linutronix.de, christian@kellner.me,
        areber@redhat.com, shakeelb@google.com, cyphar@cyphar.com,
        psodagud@codeaurora.org, pratikp@codeaurora.org
Subject: Re: [RFC PATCH] fork: Free per-cpu cached vmalloc'ed thread stacks
 with
Message-Id: <20200913203708.ec97aab4ec42b22cac532f38@linux-foundation.org>
In-Reply-To: <010101745b9b7830-0392d16f-4ee3-4b0e-afc1-51ebb71d0cb3-000000@us-west-2.amazonses.com>
References: <010101745b9b7830-0392d16f-4ee3-4b0e-afc1-51ebb71d0cb3-000000@us-west-2.amazonses.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Sep 2020 00:12:29 +0000 "Isaac J. Manjarres" <isaacm@codeaurora.org> wrote:

> The per-cpu cached vmalloc'ed stacks are currently freed in the
> CPU hotplug teardown path by the free_vm_stack_cache() callback,
> which invokes vfree(), which may result in purging the list of
> lazily freed vmap areas.
> 
> Purging all of the lazily freed vmap areas can take a long time
> when the list of vmap areas is large. This is problematic, as
> free_vm_stack_cache() is invoked prior to the offline CPU's timers
> being migrated. This is not desirable as it can lead to timer
> migration delays in the CPU hotplug teardown path, and timer callbacks
> will be invoked long after the timer has expired.
> 
> For example, on a system that has only one online CPU (CPU 1) that is
> running a heavy workload, and another CPU that is being offlined,
> the online CPU will invoke free_vm_stack_cache() to free the cached
> vmalloc'ed stacks for the CPU being offlined. When there are 2702
> vmap areas that total to 13498 pages, free_vm_stack_cache() takes
> over 2 seconds to execute:
> 
> [001]   399.335808: cpuhp_enter: cpu: 0005 target:   0 step:  67 (free_vm_stack_cache)
> 
> /* The first vmap area to be freed */
> [001]   399.337157: __purge_vmap_area_lazy: [0:2702] 0xffffffc033da8000 - 0xffffffc033dad000 (5 : 13498)
> 
> /* After two seconds */
> [001]   401.528010: __purge_vmap_area_lazy: [1563:2702] 0xffffffc02fe10000 - 0xffffffc02fe15000 (5 : 5765)
> 
> Instead of freeing the per-cpu cached vmalloc'ed stacks synchronously
> with respect to the CPU hotplug teardown state machine, free them
> asynchronously to help move along the CPU hotplug teardown state machine
> quickly.
> 
> ...
>
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -202,7 +202,7 @@ static int free_vm_stack_cache(unsigned int cpu)
>  		if (!vm_stack)
>  			continue;
>  
> -		vfree(vm_stack->addr);
> +		vfree_atomic(vm_stack->addr);
>  		cached_vm_stacks[i] = NULL;
>  	}

I guess that makes sense, although perhaps we shouldn't be permitting
purge_list to get so large - such latency issues will still appear in
other situations.

If we go with this fix-just-fork approach, can we please have a comment
in there explaining why vfree_atomic() is being used?

