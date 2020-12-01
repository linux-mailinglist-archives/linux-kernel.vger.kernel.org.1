Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F36922C9633
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 05:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgLAD6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 22:58:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbgLAD6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 22:58:39 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73413206F9;
        Tue,  1 Dec 2020 03:57:56 +0000 (UTC)
Date:   Mon, 30 Nov 2020 22:57:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michel Lespinasse <walken@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        dsahern@kernel.org, gregkh@linuxfoundation.org, kuba@kernel.org,
        liuhangbin@gmail.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: mmap_lock: fix use-after-free race and css ref leak
 in tracepoints
Message-ID: <20201130225754.38a8d717@oasis.local.home>
In-Reply-To: <20201130233504.3725241-1-axelrasmussen@google.com>
References: <20201130233504.3725241-1-axelrasmussen@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 15:35:04 -0800
Axel Rasmussen <axelrasmussen@google.com> wrote:

> syzbot reported[1] a use-after-free introduced in 0f818c4bc1f3. The bug
> is that an ongoing trace event might race with the tracepoint being
> disabled (and therefore the _unreg() callback being called). Consider
> this ordering:
> 
> T1: trace event fires, get_mm_memcg_path() is called
> T1: get_memcg_path_buf() returns a buffer pointer
> T2: trace_mmap_lock_unreg() is called, buffers are freed
> T1: cgroup_path() is called with the now-freed buffer
> 
> The solution in this commit is to modify trace_mmap_lock_unreg() to
> first stop new buffers from being handed out, and then to wait (spin)
> until any existing buffer references are dropped (i.e., those trace
> events complete).
> 
> I have a simple reproducer program which spins up two pools of threads,
> doing the following in a tight loop:
> 
>   Pool 1:
>   mmap(NULL, 4096, PROT_READ | PROT_WRITE,
>        MAP_PRIVATE | MAP_ANONYMOUS, -1, 0)
>   munmap()
> 
>   Pool 2:
>   echo 1 > /sys/kernel/debug/tracing/events/mmap_lock/enable
>   echo 0 > /sys/kernel/debug/tracing/events/mmap_lock/enable
> 
> This triggers the use-after-free very quickly. With this patch, I let it
> run for an hour without any BUGs.
> 
> While fixing this, I also noticed and fixed a css ref leak. Previously
> we called get_mem_cgroup_from_mm(), but we never called css_put() to
> release that reference. get_mm_memcg_path() now does this properly.
> 
> [1]: https://syzkaller.appspot.com/bug?extid=19e6dd9943972fa1c58a
> 
> Fixes: 0f818c4bc1f3 ("mm: mmap_lock: add tracepoints around lock acquisition")
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>

Looking at the original patch that this fixes, I'm thinking, why use a
spinlock in the reg/unreg callers? Registering and unregistering a
tracepoint can sleep (it calls mutex locks), so the reg/unreg can sleep
too. As the use of the get_mm_memcg_path() is done under
preempt_disable, which is a rcu grace period, you could simply change
the unregister to:

void trace_mmap_lock_unreg(void)
{
	int cpu;

	mutex_lock(&reg_lock);

	if (--reg_refcount)
		goto out;

	/* Make sure all users of memcg_path_buf are done */
	synchronize_rcu();

	for_each_possible_cpu(cpu) {
		kfree(per_cpu(memcg_path_buf, cpu));
	}

out:
	mutex_unlock(&reg_lock);
}


Obviously, you would need to change reg_lock to mutex in the _reg()
function.

-- Steve


