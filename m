Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AC025B54A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 22:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgIBU3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 16:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBU3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:29:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2C5C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 13:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=NZgrNRwvUqZ2fItnpuN0y7CKknqhb7o5yUK6eUEHgO8=; b=lGgdPmracBAkg8LSxWNuCfHRRv
        bNQ0bBliMublqsUgS+ZD/b2sjBi2dwYvGKicxbxrOcTIgxGmQFBBvIhrM+Yq1D54X2MrPgMaMQcMW
        D/sj1l4tjaI/iteMTNUy4+pBfszZe/nqpV4kHMBmatuRkocTg1z8JWi0a6Z0Ka4PcU3eknsPSK2xe
        dQ7KYz6xlAzQ6e0bpUUvurDQiwM9DhAT8tk2JCb02y/8WkA3RxASKjbs1JpZm7SXKh0krLULQOUSe
        mZQ02Me9obB2ruDt74ooLU4W4MqLSbFyZdYIKsGyCwtssmI3Zo58VDM7u8bMItDJmM+2XsyCDxgHV
        Z6Q/ZNYw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDZNx-000637-37; Wed, 02 Sep 2020 20:29:37 +0000
Subject: Re: [RFC PATCH 01/16] mm: add pagechain container for storing
 multiple pages.
To:     Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
        Roman Gushchin <guro@fb.com>
Cc:     Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902180628.4052244-2-zi.yan@sent.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5a91ac07-2c15-2e15-caec-5570bacf415b@infradead.org>
Date:   Wed, 2 Sep 2020 13:29:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902180628.4052244-2-zi.yan@sent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 11:06 AM, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> When depositing page table pages for 1GB THPs, we need 512 PTE pages +
> 1 PMD page. Instead of counting and depositing 513 pages, we can use the
> PMD page as a leader page and chain the rest 512 PTE pages with ->lru.
> This, however, prevents us depositing PMD pages with ->lru, which is
> currently used by depositing PTE pages for 2MB THPs. So add a new
> pagechain container for PMD pages.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/pagechain.h | 73 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 include/linux/pagechain.h
> 
> diff --git a/include/linux/pagechain.h b/include/linux/pagechain.h
> new file mode 100644
> index 000000000000..be536142b413
> --- /dev/null
> +++ b/include/linux/pagechain.h
> @@ -0,0 +1,73 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * include/linux/pagechain.h
> + *
> + * In many places it is efficient to batch an operation up against multiple
> + * pages. A pagechain is a multipage container which is used for that.
> + */
> +
> +#ifndef _LINUX_PAGECHAIN_H
> +#define _LINUX_PAGECHAIN_H
> +
> +#include <linux/slab.h>
> +
> +/* 14 pointers + two long's align the pagechain structure to a power of two */
> +#define PAGECHAIN_SIZE	13

OK, I'll bite.  I see neither 14 pointers nor 2 longs below.
Is the comment out of date or am I just confuzed?

Update: struct list_head is 2 pointers, so I see 15 pointers & one unsigned int.
Where are the 2 longs?

> +
> +struct page;
> +
> +struct pagechain {
> +	struct list_head list;
> +	unsigned int nr;
> +	struct page *pages[PAGECHAIN_SIZE];
> +};

thanks.

-- 
~Randy
