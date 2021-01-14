Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E42C2F564D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbhANBp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbhANBE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 20:04:59 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A9AC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 17:04:05 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c79so2371651pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 17:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CaoaKKd5M9AXqaOBBlf+JFTatRvOkgnOQ24cjHUKjB8=;
        b=jz4sQ8hpEprSWo2TN4Z5Ieylr2L45aakaLVclCQUScM0nDwcb7WNzM+zIJwkKMHY0j
         m9KhwUR8/DRP18dVVVvbKasbuiLKUgMsk58z0RBQ9lhNdYN3vFy65GFPBAj3TbOxyafS
         q9owIQD9U5aJGbrwK3mweJCvxQaaJHctcWdjmqfq3QDlSLj/0f6+ivkZYD+BQSAIGZKm
         IfuhVSoG3Kp41YTOX7xr5tqGtViWx22Pb9EqP4nqE692xW/47am9+8XHWD24bmestQs0
         TEDOdNVWcmv9JTx5R9XEo6BN8j9ORWA2wqALWUKRZw1nTY/IL0MwjfAGmQJoqwZCGq1W
         QQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CaoaKKd5M9AXqaOBBlf+JFTatRvOkgnOQ24cjHUKjB8=;
        b=F0xtRizF/NubdbdI3T7QERYZCIoA4xwRYQMKR7iaRK637mdb7Ptp9VmmAq715YGyMj
         GujIyaIm8Y6GJO2vnw8UF6lj3E/s5AxIKVQGmmf8a6BTAHA2UvGINzthP9eO1XwAJbO5
         g9jAINuWsKVdw/pNYwaKFoAXyy5jpcndrUXQIyOsfwo9mcKRjRgNDJqZU1oAte9CNjjp
         IftySZqgSUN/nNcj6x5ofC2GFpneDN//34Ybk/FOjYM5p/9l1KSTcpCRU7+QnEi3ohCh
         qt+KhX3Y6LGJW4Zk9GRChjqQxjPXhcNxLAvvMvkwX3WHQYxGolLokRHTTg0v0+OKBmWn
         qEdw==
X-Gm-Message-State: AOAM533vQI7HNbMpZwpQL+Tn+FkAjzy94Ir0aZnQvBEqQlsqbIC2y3fV
        ZPkWLs+ro5gLK9XWpHMrSvg=
X-Google-Smtp-Source: ABdhPJyhLiXEnInLU2k36Cn4Jj5Vtg5SwSdQtUwQHJvthUG2qHcxeTQbpCP72bxUokiOnuW4/6NT3Q==
X-Received: by 2002:a63:700c:: with SMTP id l12mr4772537pgc.137.1610586244799;
        Wed, 13 Jan 2021 17:04:04 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id a26sm3573857pgd.64.2021.01.13.17.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 17:04:03 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 13 Jan 2021 17:04:01 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, hyesoo.yu@samsung.com,
        david@redhat.com, mhocko@suse.com, surenb@google.com,
        pullip.cho@samsung.com, joaodias@google.com, hridya@google.com
Subject: Re: [PATCH v3 4/4] dma-buf: heaps: add chunk heap to dmabuf heaps
Message-ID: <X/+YgTWY2k4AjxlK@google.com>
References: <20210113012143.1201105-5-minchan@kernel.org>
 <202101131134.ACIz6uj2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202101131134.ACIz6uj2-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 11:11:56AM +0800, kernel test robot wrote:
> Hi Minchan,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on next-20210112]
> [cannot apply to s390/features robh/for-next linux/master linus/master hnaz-linux-mm/master v5.11-rc3 v5.11-rc2 v5.11-rc1 v5.11-rc3]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Minchan-Kim/Chunk-Heap-Support-on-DMA-HEAP/20210113-092747
> base:    df869cab4b3519d603806234861aa0a39df479c0
> config: mips-allyesconfig (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/531ebc21d3c2584784d44714e3b4f1df46b80eee
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Minchan-Kim/Chunk-Heap-Support-on-DMA-HEAP/20210113-092747
>         git checkout 531ebc21d3c2584784d44714e3b4f1df46b80eee
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/dma-buf/heaps/chunk_heap.c: In function 'chunk_heap_do_vmap':
>    drivers/dma-buf/heaps/chunk_heap.c:215:24: error: implicit declaration of function 'vmalloc'; did you mean 'kvmalloc'? [-Werror=implicit-function-declaration]
>      215 |  struct page **pages = vmalloc(sizeof(struct page *) * npages);
>          |                        ^~~~~~~
>          |                        kvmalloc

Looks like we need vmalloc.h.


> >> drivers/dma-buf/heaps/chunk_heap.c:215:24: warning: initialization of 'struct page **' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>    drivers/dma-buf/heaps/chunk_heap.c:228:10: error: implicit declaration of function 'vmap'; did you mean 'kmap'? [-Werror=implicit-function-declaration]
>      228 |  vaddr = vmap(pages, npages, VM_MAP, PAGE_KERNEL);
>          |          ^~~~
>          |          kmap

We need vmap, not kmap.

>    drivers/dma-buf/heaps/chunk_heap.c:228:30: error: 'VM_MAP' undeclared (first use in this function); did you mean 'VM_MTE'?
>      228 |  vaddr = vmap(pages, npages, VM_MAP, PAGE_KERNEL);
>          |                              ^~~~~~
>          |                              VM_MTE

Looks like bot was confused since we have missed the vmalloc.h
In next spin, let's fix it.

>    drivers/dma-buf/heaps/chunk_heap.c:228:30: note: each undeclared identifier is reported only once for each function it appears in
>    drivers/dma-buf/heaps/chunk_heap.c:229:2: error: implicit declaration of function 'vfree'; did you mean 'kvfree'? [-Werror=implicit-function-declaration]
>      229 |  vfree(pages);
>          |  ^~~~~
>          |  kvfree
>    drivers/dma-buf/heaps/chunk_heap.c: In function 'chunk_heap_vunmap':
>    drivers/dma-buf/heaps/chunk_heap.c:268:3: error: implicit declaration of function 'vunmap'; did you mean 'kunmap'? [-Werror=implicit-function-declaration]
>      268 |   vunmap(buffer->vaddr);
>          |   ^~~~~~
>          |   kunmap
>    cc1: some warnings being treated as errors
> 
> 
> vim +215 drivers/dma-buf/heaps/chunk_heap.c
> 
>    210	
>    211	static void *chunk_heap_do_vmap(struct chunk_heap_buffer *buffer)
>    212	{
>    213		struct sg_table *table = &buffer->sg_table;
>    214		int npages = PAGE_ALIGN(buffer->len) / PAGE_SIZE;
>  > 215		struct page **pages = vmalloc(sizeof(struct page *) * npages);
>    216		struct page **tmp = pages;
>    217		struct sg_page_iter piter;
>    218		void *vaddr;
>    219	
>    220		if (!pages)
>    221			return ERR_PTR(-ENOMEM);
>    222	
>    223		for_each_sgtable_page(table, &piter, 0) {
>    224			WARN_ON(tmp - pages >= npages);
>    225			*tmp++ = sg_page_iter_page(&piter);
>    226		}
>    227	
>    228		vaddr = vmap(pages, npages, VM_MAP, PAGE_KERNEL);
>    229		vfree(pages);
>    230	
>    231		if (!vaddr)
>    232			return ERR_PTR(-ENOMEM);
>    233	
>    234		return vaddr;
>    235	}
>    236	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


