Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69380259BBA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 19:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgIARGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 13:06:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:52894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729600AbgIARGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:06:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D990FAC26;
        Tue,  1 Sep 2020 17:06:02 +0000 (UTC)
Subject: Re: [PATCH v3 1/3] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1598928612-68996-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <fab9e78e-5635-5d0a-9aa7-227178684044@suse.cz>
Date:   Tue, 1 Sep 2020 19:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598928612-68996-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 4:50 AM, Alex Shi wrote:
> pageblock_flags is used as long, since every pageblock_flags is just 4
> bits, 'long' size will include 8(32bit machine) or 16 pageblocks' flags,
> that flag setting has to sync in cmpxchg with 7 or 15 other pageblock
> flags. It would cause long waiting for sync.
> 
> If we could change the pageblock_flags variable as char, we could use
> char size cmpxchg, which just sync up with 2 pageblock flags. it could
> relief much false sharing in cmpxchg.
> 
> With this and next patch, we could see mmtests/thpscale get slight fast
> on my 4 cores box, and cmpxchg retry times is reduced.
> 
>                    pageblock   pageblock   pageblock        rc2         rc2         rc2
>                           16        16-2        16-3          a           b           c
> Duration User          14.81       15.24       14.55      14.76       14.97       14.38
> Duration System        84.44       88.38       90.64     100.43       89.15       88.89
> Duration Elapsed       98.83       99.06       99.81     100.30       99.24       99.14

The large variance in these numbers suggest that 3 iterations are not enough to
conclude a statistically significant difference. You'd need more iterations and
calculate at least mean+variance.

> rc2 is 5.9-rc2 kernel, pageblock is 5.9-rc2 + this patchset
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/mmzone.h          |  6 +++---
>  include/linux/pageblock-flags.h |  2 +-
>  mm/page_alloc.c                 | 38 +++++++++++++++++++-------------------
>  3 files changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 8379432f4f2f..be676e659fb7 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -437,7 +437,7 @@ struct zone {
>  	 * Flags for a pageblock_nr_pages block. See pageblock-flags.h.
>  	 * In SPARSEMEM, this map is stored in struct mem_section
>  	 */
> -	unsigned long		*pageblock_flags;
> +	unsigned char		*pageblock_flags;
>  #endif /* CONFIG_SPARSEMEM */
>  
>  	/* zone_start_pfn == zone_start_paddr >> PAGE_SHIFT */
> @@ -1159,7 +1159,7 @@ struct mem_section_usage {
>  	DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
>  #endif
>  	/* See declaration of similar field in struct zone */
> -	unsigned long pageblock_flags[0];
> +	unsigned char	pageblock_flags[0];
>  };
>  
>  void subsection_map_init(unsigned long pfn, unsigned long nr_pages);
> @@ -1212,7 +1212,7 @@ struct mem_section {
>  extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
>  #endif
>  
> -static inline unsigned long *section_to_usemap(struct mem_section *ms)
> +static inline unsigned char *section_to_usemap(struct mem_section *ms)
>  {
>  	return ms->usage->pageblock_flags;
>  }
> diff --git a/include/linux/pageblock-flags.h b/include/linux/pageblock-flags.h
> index fff52ad370c1..d189441568eb 100644
> --- a/include/linux/pageblock-flags.h
> +++ b/include/linux/pageblock-flags.h
> @@ -54,7 +54,7 @@ enum pageblock_bits {
>  /* Forward declaration */
>  struct page;
>  
> -unsigned long get_pfnblock_flags_mask(struct page *page,
> +unsigned char get_pfnblock_flags_mask(struct page *page,
>  				unsigned long pfn,
>  				unsigned long mask);
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fab5e97dc9ca..81e96d4d9c42 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -445,7 +445,7 @@ static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
>  #endif
>  
>  /* Return a pointer to the bitmap storing bits affecting a block of pages */
> -static inline unsigned long *get_pageblock_bitmap(struct page *page,
> +static inline unsigned char *get_pageblock_bitmap(struct page *page,
>  							unsigned long pfn)
>  {
>  #ifdef CONFIG_SPARSEMEM
> @@ -474,24 +474,24 @@ static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
>   * Return: pageblock_bits flags
>   */
>  static __always_inline
> -unsigned long __get_pfnblock_flags_mask(struct page *page,
> +unsigned char __get_pfnblock_flags_mask(struct page *page,
>  					unsigned long pfn,
>  					unsigned long mask)
>  {
> -	unsigned long *bitmap;
> -	unsigned long bitidx, word_bitidx;
> -	unsigned long word;
> +	unsigned char *bitmap;
> +	unsigned long bitidx, byte_bitidx;
> +	unsigned char byte;
>  
>  	bitmap = get_pageblock_bitmap(page, pfn);
>  	bitidx = pfn_to_bitidx(page, pfn);
> -	word_bitidx = bitidx / BITS_PER_LONG;
> -	bitidx &= (BITS_PER_LONG-1);
> +	byte_bitidx = bitidx / BITS_PER_BYTE;
> +	bitidx &= (BITS_PER_BYTE-1);
>  
> -	word = bitmap[word_bitidx];
> -	return (word >> bitidx) & mask;
> +	byte = bitmap[byte_bitidx];
> +	return (byte >> bitidx) & mask;
>  }
>  
> -unsigned long get_pfnblock_flags_mask(struct page *page, unsigned long pfn,
> +unsigned char get_pfnblock_flags_mask(struct page *page, unsigned long pfn,
>  					unsigned long mask)
>  {
>  	return __get_pfnblock_flags_mask(page, pfn, mask);
> @@ -513,29 +513,29 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
>  					unsigned long pfn,
>  					unsigned long mask)
>  {
> -	unsigned long *bitmap;
> -	unsigned long bitidx, word_bitidx;
> -	unsigned long old_word, word;
> +	unsigned char *bitmap;
> +	unsigned long bitidx, byte_bitidx;
> +	unsigned char old_byte, byte;
>  
>  	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
>  	BUILD_BUG_ON(MIGRATE_TYPES > (1 << PB_migratetype_bits));
>  
>  	bitmap = get_pageblock_bitmap(page, pfn);
>  	bitidx = pfn_to_bitidx(page, pfn);
> -	word_bitidx = bitidx / BITS_PER_LONG;
> -	bitidx &= (BITS_PER_LONG-1);
> +	byte_bitidx = bitidx / BITS_PER_BYTE;
> +	bitidx &= (BITS_PER_BYTE-1);
>  
>  	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
>  
>  	mask <<= bitidx;
>  	flags <<= bitidx;
>  
> -	word = READ_ONCE(bitmap[word_bitidx]);
> +	byte = READ_ONCE(bitmap[byte_bitidx]);
>  	for (;;) {
> -		old_word = cmpxchg(&bitmap[word_bitidx], word, (word & ~mask) | flags);
> -		if (word == old_word)
> +		old_byte = cmpxchg(&bitmap[byte_bitidx], byte, (byte & ~mask) | flags);
> +		if (byte == old_byte)
>  			break;
> -		word = old_word;
> +		byte = old_byte;
>  	}
>  }
>  
> 

