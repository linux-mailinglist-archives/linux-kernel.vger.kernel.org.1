Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC442F3D41
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388799AbhALVfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437112AbhALVHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:07:02 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A9DC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 13:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=kkPWkBZZqKOkMG5EsadJckZcviV2Ah0ETqTE46n08Fs=; b=AODIvpRTi6q3I2oBZKuKRdLtHw
        I+faK5Pduucju5JdH5XfgbkwbI1/HApFDJOqdW4lyx8zTU1oxFkFdlGBGyDNgkdjy9dBu12KRMDLz
        1mhWZ32I2BynJns9Z6PxWkID8W2xDuX0T+mi+n4UERH0Ou/eR7yODt0xs0S1rUXnBrXVhHIcyfixZ
        6LZAcQcsKmI0cmyHl228nDS4XKT7JsLh13nW5YIXQgWRSSziWXYIPn2uUfmil0/InguXTjGZcvFte
        sphYqKiMPahvgztNzc49Zq6fQyT6NcsNJkRyGk7PlrpiYRLiN9XUD8D5VUxAdTqlHxSbLHroQnRJR
        MSltvrgw==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzQrd-0002cC-Gq; Tue, 12 Jan 2021 21:06:05 +0000
Subject: Re: [PATCH v2 10/70] mm/mmap: Change unmapped_area and
 unmapped_area_topdown to use maple tree
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@google.com>, Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210112161240.2024684-1-Liam.Howlett@Oracle.com>
 <20210112161240.2024684-11-Liam.Howlett@Oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <477569cb-3762-ff89-52b3-10e9cc62f417@infradead.org>
Date:   Tue, 12 Jan 2021 13:05:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210112161240.2024684-11-Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

one copy-pasta error below:

On 1/12/21 8:11 AM, Liam R. Howlett wrote:
> Use the new maple tree data structure to find an unmapped area.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 249 ++++++------------------------------------------------
>  1 file changed, 27 insertions(+), 222 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f123f9c97dfe8..3b3084ee309b7 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2040,260 +2040,65 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	return error;
>  }
>  
> +/* unmapped_area() Find an area between the low_limit and the high_limit with
> + * the correct alignment and offset, all from @info. Note: current->mm is used
> + * for the search.
> + *
> + * @info: The unmapped area information including the range (low_limit -
> + * hight_limit), the alignment offset and mask.
> + *
> + * Return: A memory address or -ENOMEM.
> + */
>  static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
>  {
...
>  }
>  
> +/* unmapped_area() Find an area between the low_limit and the high_limit with

s/unmapped_area/unmapped_area_topdown/

> + * the correct alignment and offset at the highest available address, all from
> + * @info. Note: current->mm is used for the search.
> + *
> + * @info: The unmapped area information including the range (low_limit -
> + * hight_limit), the alignment offset and mask.
> + *
> + * Return: A memory address or -ENOMEM.
> + */
>  static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
>  {

thanks.
-- 
~Randy

