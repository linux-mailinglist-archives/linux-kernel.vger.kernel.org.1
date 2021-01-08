Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D112EF4DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbhAHPb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:31:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:50808 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbhAHPb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:31:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C3587ACC6;
        Fri,  8 Jan 2021 15:30:46 +0000 (UTC)
Subject: Re: [PATCH mm,percpu_ref,rcu 4/6] mm: Make mem_obj_dump() vmalloc()
 dumps include start and length
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org, linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        ming.lei@redhat.com, axboe@kernel.dk, kernel-team@fb.com
References: <20210106011603.GA13180@paulmck-ThinkPad-P72>
 <20210106011750.13709-4-paulmck@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8c387b3c-33f5-968a-6882-55075066d9f4@suse.cz>
Date:   Fri, 8 Jan 2021 16:30:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210106011750.13709-4-paulmck@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/21 2:17 AM, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> This commit adds the starting address and number of pages to the vmalloc()
> information dumped by way of vmalloc_dump_obj().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: <linux-mm@kvack.org>
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/vmalloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index c274ea4..e3229ff 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3456,7 +3456,8 @@ bool vmalloc_dump_obj(void *object)
>  	vm = find_vm_area(objp);
>  	if (!vm)
>  		return false;
> -	pr_cont(" vmalloc allocated at %pS\n", vm->caller);
> +	pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",
> +		vm->nr_pages, (unsigned long)vm->addr, vm->caller);
>  	return true;
>  }
>  
> 

