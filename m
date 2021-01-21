Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E312FE238
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbhAUC70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:59:26 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11115 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbhAUCpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 21:45:04 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DLmsZ1ZkPz15w7n;
        Thu, 21 Jan 2021 10:43:14 +0800 (CST)
Received: from [10.174.177.2] (10.174.177.2) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Jan 2021
 10:44:21 +0800
Subject: Re: [PATCH] mm/vmalloc: Separate put pages and flush VM flags
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CC:     <hch@lst.de>, <dja@axtens.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210121014118.31922-1-rick.p.edgecombe@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <21e2ed55-90f5-3e26-06ff-e4fd81709ffd@huawei.com>
Date:   Thu, 21 Jan 2021 10:44:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210121014118.31922-1-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.2]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/21 9:41, Rick Edgecombe wrote:
> When VM_MAP_PUT_PAGES was added, it was defined with the same value as
> VM_FLUSH_RESET_PERMS. This doesn't seem like it will cause any big

Good catch!

> functional problems other than some excess flushing for VM_MAP_PUT_PAGES
> allocations.
> 
> Redefine VM_MAP_PUT_PAGES to have its own value. Also, move the comment
> and remove whitespace for VM_KASAN such that the flags lower down are less
> likely to be missed in the future.
>> Fixes: b944afc9d64d ("mm: add a VM_MAP_PUT_PAGES flag for vmap")

Is this worth a Cc stable ?

> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  include/linux/vmalloc.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 80c0181c411d..0b3dd135aa5d 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -23,9 +23,6 @@ struct notifier_block;		/* in notifier.h */
>  #define VM_DMA_COHERENT		0x00000010	/* dma_alloc_coherent */
>  #define VM_UNINITIALIZED	0x00000020	/* vm_struct is not fully initialized */
>  #define VM_NO_GUARD		0x00000040      /* don't add guard page */
> -#define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
> -#define VM_MAP_PUT_PAGES	0x00000100	/* put pages and free array in vfree */
> -
>  /*
>   * VM_KASAN is used slighly differently depending on CONFIG_KASAN_VMALLOC.
>   *
> @@ -36,12 +33,13 @@ struct notifier_block;		/* in notifier.h */
>   * Otherwise, VM_KASAN is set for kasan_module_alloc() allocations and used to
>   * determine which allocations need the module shadow freed.
>   */
> -
> +#define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
>  /*
>   * Memory with VM_FLUSH_RESET_PERMS cannot be freed in an interrupt or with
>   * vfree_atomic().
>   */
>  #define VM_FLUSH_RESET_PERMS	0x00000100      /* Reset direct map and flush TLB on unmap */
> +#define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
>  
>  /* bits [20..32] reserved for arch specific ioremap internals */
>  
> 

Looks good to me.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
