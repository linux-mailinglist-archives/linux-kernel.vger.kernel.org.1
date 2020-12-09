Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379B32D4859
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 18:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbgLIRwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:52:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:59520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgLIRwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:52:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DD245AD3F;
        Wed,  9 Dec 2020 17:51:20 +0000 (UTC)
Subject: Re: [PATCH v2 sl-b 3/5] mm: Make mem_dump_obj() handle vmalloc()
 memory
To:     paulmck@kernel.org, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, iamjoonsoo.kim@lge.com,
        andrii@kernel.org, linux-mm@kvack.org
References: <20201209011124.GA31164@paulmck-ThinkPad-P72>
 <20201209011303.32737-3-paulmck@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1c25ca09-ec43-df31-a5ba-476397637a53@suse.cz>
Date:   Wed, 9 Dec 2020 18:51:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201209011303.32737-3-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/20 2:13 AM, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit adds vmalloc() support to mem_dump_obj().  Note that the
> vmalloc_dump_obj() function combines the checking and dumping, in
> contrast with the split between kmem_valid_obj() and kmem_dump_obj().
> The reason for the difference is that the checking in the vmalloc()
> case involves acquiring a global lock, and redundant acquisitions of
> global locks should be avoided, even on not-so-fast paths.
> 
> Note that this change causes on-stack variables to be reported as
> vmalloc() storage from kernel_clone() or similar, depending on the degree
> of inlining that your compiler does.  This is likely more helpful than
> the earlier "non-paged (local) memory".
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: <linux-mm@kvack.org>
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

...

> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3431,6 +3431,18 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
>  }
>  #endif	/* CONFIG_SMP */
>  
> +bool vmalloc_dump_obj(void *object)
> +{
> +	struct vm_struct *vm;
> +	void *objp = (void *)PAGE_ALIGN((unsigned long)object);
> +
> +	vm = find_vm_area(objp);
> +	if (!vm)
> +		return false;
> +	pr_cont(" vmalloc allocated at %pS\n", vm->caller);

Would it be useful to print the vm area boundaries too?

> +	return true;
> +}
> +
>  #ifdef CONFIG_PROC_FS
>  static void *s_start(struct seq_file *m, loff_t *pos)
>  	__acquires(&vmap_purge_lock)
> 

