Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9FB277E08
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 04:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgIYCk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 22:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbgIYCkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 22:40:53 -0400
Received: from X1 (unknown [104.245.68.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64FD520809;
        Fri, 25 Sep 2020 02:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601001652;
        bh=pQ6z0ir2xfCPVTr5SFHMaCkXwYdTbS6aBAi6ME84jmI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=anFlFAk26hM03/gZSTtDSTWfEbCDm6NCgWWmhIiYHOzGjLoYA71QVZq0sNyqzMUgo
         9Zwufj2fRF4UjFOig14Yciftyjvpqbm9AfNqHcLBcSsdZI5YvqVK0fZieuRPqd2G7+
         NBEQCrN9tudI1Az3ILeOCBk+fvWrZe47aa+iS/hs=
Date:   Thu, 24 Sep 2020 19:40:51 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/mempool: Add 'else' to split mutually exclusive
 case
Message-Id: <20200924194051.6b1aa0470114d90c6ef665af@linux-foundation.org>
In-Reply-To: <20200924111641.28922-1-linmiaohe@huawei.com>
References: <20200924111641.28922-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 07:16:41 -0400 Miaohe Lin <linmiaohe@huawei.com> wrote:

> Add else to split mutually exclusive case and avoid some unnecessary check.
> It doesn't seem to change code generation (compiler is smart), but I think
> it helps readability.
> 
> ...
>
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -58,11 +58,10 @@ static void __check_element(mempool_t *pool, void *element, size_t size)
>  static void check_element(mempool_t *pool, void *element)
>  {
>  	/* Mempools backed by slab allocator */
> -	if (pool->free == mempool_free_slab || pool->free == mempool_kfree)
> +	if (pool->free == mempool_free_slab || pool->free == mempool_kfree) {
>  		__check_element(pool, element, ksize(element));
> -
>  	/* Mempools backed by page allocator */
> -	if (pool->free == mempool_free_pages) {
> +	} else if (pool->free == mempool_free_pages) {
>  		int order = (int)(long)pool->pool_data;
>  		void *addr = kmap_atomic((struct page *)element);
>  
> @@ -82,11 +81,10 @@ static void __poison_element(void *element, size_t size)
>  static void poison_element(mempool_t *pool, void *element)
>  {
>  	/* Mempools backed by slab allocator */
> -	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
> +	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc) {
>  		__poison_element(element, ksize(element));
> -
>  	/* Mempools backed by page allocator */
> -	if (pool->alloc == mempool_alloc_pages) {
> +	} else if (pool->alloc == mempool_alloc_pages) {
>  		int order = (int)(long)pool->pool_data;
>  		void *addr = kmap_atomic((struct page *)element);
>  

OK, I guess.  But the comments are now in the wrong place.

--- a/mm/mempool.c~mm-mempool-add-else-to-split-mutually-exclusive-case-fix
+++ a/mm/mempool.c
@@ -60,8 +60,8 @@ static void check_element(mempool_t *poo
 	/* Mempools backed by slab allocator */
 	if (pool->free == mempool_free_slab || pool->free == mempool_kfree) {
 		__check_element(pool, element, ksize(element));
-	/* Mempools backed by page allocator */
 	} else if (pool->free == mempool_free_pages) {
+		/* Mempools backed by page allocator */
 		int order = (int)(long)pool->pool_data;
 		void *addr = kmap_atomic((struct page *)element);
 
@@ -83,8 +83,8 @@ static void poison_element(mempool_t *po
 	/* Mempools backed by slab allocator */
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc) {
 		__poison_element(element, ksize(element));
-	/* Mempools backed by page allocator */
 	} else if (pool->alloc == mempool_alloc_pages) {
+		/* Mempools backed by page allocator */
 		int order = (int)(long)pool->pool_data;
 		void *addr = kmap_atomic((struct page *)element);
 
_

