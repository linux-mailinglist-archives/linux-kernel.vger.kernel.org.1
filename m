Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893EB2CAE60
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbgLAV3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:29:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388128AbgLAV3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:29:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 477C920870;
        Tue,  1 Dec 2020 21:28:49 +0000 (UTC)
Date:   Tue, 1 Dec 2020 16:28:47 -0500
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
Subject: Re: [PATCH v2] mm: mmap_lock: fix use-after-free race and css ref
 leak in tracepoints
Message-ID: <20201201162847.654f3013@gandalf.local.home>
In-Reply-To: <20201201203249.4172751-1-axelrasmussen@google.com>
References: <20201201203249.4172751-1-axelrasmussen@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Dec 2020 12:32:49 -0800
Axel Rasmussen <axelrasmussen@google.com> wrote:

> +/* Called with reg_lock held. */

The above comment is reduntant, as the lockdep_is_held() below also suggest
that it is ;-)

> +static void free_memcg_path_bufs(void)
> +{
> +	int cpu;
> +	char *old;
> +
> +	for_each_possible_cpu(cpu) {
> +		old = rcu_dereference_protected(per_cpu(memcg_path_buf, cpu),
> +						lockdep_is_held(&reg_lock));
> +		if (old == NULL)
> +			break;

Hmm, what if the topology of the system has missing CPU numbers (this is
possible I believe on some systems)?

> +		rcu_assign_pointer(per_cpu(memcg_path_buf, cpu), NULL);
> +		/* Wait for inflight memcg_path_buf users to finish. */
> +		synchronize_rcu();

Please break this up into two loops. You will need to have another array
that is created in trace_mmap_lock_reg() function:

static char **path_holders;

trace_mmap_lock_reg()
{
[..]
	path_holders = kmalloc(num_possible_cpus * sizeof(*path_holders));
[..]
}

Then this function can be:

static void free_memcg_path_bufs(void)
{
	int cpu;

	for_each_possible_cpu(cpu) {
		path_holders[cpu] = rcu_dereference_protected(per_cpu(memcg_path_buf, cpu),
						lockdep_is_held(&reg_lock));
		rcu_assign_pointer(per_cpu(memcg_path_buf, cpu), NULL);
	}

	/* Wait for inflight memcg_path_buf users to finish. */
	synchronize_rcu();

	for_each_possible_cpu(cpu) {
		kfree(path_holders[cpu]);
	}

	kfree(path_holders);
	path_holders = NULL;
}

Otherwise, if you have a machine with 128 possible CPUs, doing 128
synchronize_rcu()s is going to be expensive!

> +		kfree(old);
> +	}
> +}
>  


>  static inline char *get_memcg_path_buf(void)
>  {
> +	char *buf;
>  	int idx;
>  
> +	rcu_read_lock();

The caller of get_mm_memcg_path() has preemption disabled, which is also
now an RCU lock. So the rcu_read_lock() is somewhat redundant.

Oh, and looking at the original patch:

+                                      memcg_path != NULL ? memcg_path : "",   \

The above could be shorten to:

					memcg_path ? : "",

As gcc has a trick with the "? :" which is if there's nothing in between
the "?" and ":" it will use what was tested as the result if it is not zero
or NULL.

-- Steve

> +	buf = rcu_dereference(*this_cpu_ptr(&memcg_path_buf));
> +	if (buf == NULL)
> +		return NULL;
>  	idx = this_cpu_add_return(memcg_path_buf_idx, MEMCG_PATH_BUF_SIZE) -
>  	      MEMCG_PATH_BUF_SIZE;
> -	return &this_cpu_read(memcg_path_buf)[idx];
> +	return &buf[idx];
>  }
