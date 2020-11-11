Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8407E2AE93D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 07:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgKKGwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 01:52:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:57244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgKKGwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 01:52:08 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1C3B2067D;
        Wed, 11 Nov 2020 06:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605077527;
        bh=jc1AZ8JGJb112Ex8rYvgppClSvKKlmOIy9J+SCr7aqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NYBzsT/zsoLhngKTr6DcR+NsvU25M0LNyHrGVs/sZ2mihS1NkoIyZ5hXezNSmPZ7K
         YbqPYjPqPxUV6avdasQWV31MTWY8x/U02c2ti3e5GI8qPq9kIzjJaRKV+O2jkrZrjN
         PyBxGGXUhHXv/AGtejEUtubpsdNrArN5HFitsfmo=
Date:   Wed, 11 Nov 2020 08:52:00 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Stefan Agner <stefan@agner.ch>,
        ngupta@vflare.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sjenning@linux.vnet.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
Message-ID: <20201111065200.GE4758@kernel.org>
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
 <20201108064659.GD301837@kernel.org>
 <7782fb694a6b0c500e8f32ecf895b2bf@agner.ch>
 <20201110095806.GH301837@kernel.org>
 <CAK8P3a2MCdUbN0QSb+M3g5_6HjPsaQwtKxFjADMZWomdry4-Ww@mail.gmail.com>
 <20201110162155.GA4758@kernel.org>
 <20201110233620.GA3310704@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110233620.GA3310704@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 10, 2020 at 03:36:20PM -0800, Minchan Kim wrote:
> On Tue, Nov 10, 2020 at 06:21:55PM +0200, Mike Rapoport wrote:
> > On Tue, Nov 10, 2020 at 12:21:11PM +0100, Arnd Bergmann wrote:
> > > On Tue, Nov 10, 2020 at 10:58 AM Mike Rapoport <rppt@kernel.org> wrote:
> > > > > >
> > > > > > asm/sparsemem.h is not available on some architectures.
> > > > > > It's better to use linux/mmzone.h instead.
> > > 
> > > Ah, I missed that, too.
> > > 
> > > > > Hm, linux/mmzone.h only includes asm/sparsemem.h when CONFIG_SPARSEMEM
> > > > > is enabled. However, on ARM at least I can have configurations without
> > > > > CONFIG_SPARSEMEM and physical address extension on (e.g.
> > > > > multi_v7_defconfig + CONFIG_LPAE + CONFIG_ZSMALLOC).
> > > > >
> > > > > While sparsemem seems to be a good idea with LPAE it really seems not
> > > > > required (see also https://lore.kernel.org/patchwork/patch/567589/).
> > > > >
> > > > > There seem to be also other architectures which define MAX_PHYSMEM_BITS
> > > > > only when SPARSEMEM is enabled, e.g.
> > > > > arch/riscv/include/asm/sparsemem.h...
> > > > >
> > > > > Not sure how to get out of this.. Maybe make ZSMALLOC dependent on
> > > > > SPARSEMEM? It feels a bit silly restricting ZSMALLOC selection only due
> > > > > to a compile time define...
> > > >
> > > > I think we can define MAX_POSSIBLE_PHYSMEM_BITS in one of
> > > > arch/arm/inclide/asm/pgtable-{2,3}level-*.h headers to values supported
> > > > by !LPAE and LPAE.
> > > 
> > > Good idea. I wonder what other architectures need the same though.
> > > Here are some I found:
> > > 
> > > $ git grep -l PHYS_ADDR_T_64BIT arch | grep Kconfig
> > > arch/arc/Kconfig
> > > arch/arm/mm/Kconfig
> > > arch/mips/Kconfig
> > > arch/powerpc/platforms/Kconfig.cputype
> > > arch/x86/Kconfig
> > > 
> > > arch/arc has a CONFIG_ARC_HAS_PAE40 option
> > > arch/riscv has 34-bit addressing in rv32 mode
> > > arch/mips has up to 40 bits with mips32r3 XPA, but I don't know what
> > >     supports that
> > > 
> > > arch/powerpc has this:
> > > config PHYS_64BIT
> > >         bool 'Large physical address support' if E500 || PPC_86xx
> > >         depends on (44x || E500 || PPC_86xx) && !PPC_83xx && !PPC_82xx
> > > 
> > > Apparently all three (4xx, e500v2, mpc86xx/e600) do 36-bit physical
> > > addressing, but each one has a different page table format.
> > > 
> > > Microblaze has physical address extensions, but neither those nor
> > > 64-bit mode have so far made it into the kernel.
> > > 
> > > To be on the safe side, we could provoke a compile-time error
> > > when CONFIG_PHYS_ADDR_T_64BIT is set on a 32-bit
> > > architecture, but MAX_POSSIBLE_PHYSMEM_BITS is not set.
> > 
> > Maybe compile time warning and a runtime error in zs_init() if 32 bit
> > machine has memory above 4G?
> 
> I guess max_pfn will represent maximum pfn configued in the system
> and will not be changed in the runtime. If it's true, how about this?
> (didn't test at all but just for RFC)

Largely, max_pfn is the maximal pfn at boot time but I don't think it
can be used on systems with memory hotplug. Unless I'm missing
something, with memory hotplug we must have compile-time maximum.

> From 2f51a743a08d10c787a36912515a91826693e308 Mon Sep 17 00:00:00 2001
> From: Minchan Kim <minchan@kernel.org>
> Date: Tue, 10 Nov 2020 15:17:12 -0800
> Subject: [PATCH] zsmalloc: do not support if system has too big memory
> 
> zsmalloc encode object location into unsigned long so if the system
> has too big memory to encode the object location into BITS_PER_LONG,
> it should return the error. Otherwise, system will be crash.
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/zsmalloc.c | 82 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 45 insertions(+), 37 deletions(-)
> 
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 662ee420706f..13552f412ca1 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -87,19 +87,8 @@
>   * This is made more complicated by various memory models and PAE.
>   */
>  
> -#ifndef MAX_POSSIBLE_PHYSMEM_BITS
> -#ifdef MAX_PHYSMEM_BITS
> -#define MAX_POSSIBLE_PHYSMEM_BITS MAX_PHYSMEM_BITS
> -#else
> -/*
> - * If this definition of MAX_PHYSMEM_BITS is used, OBJ_INDEX_BITS will just
> - * be PAGE_SHIFT
> - */
> -#define MAX_POSSIBLE_PHYSMEM_BITS BITS_PER_LONG
> -#endif
> -#endif
> -
> -#define _PFN_BITS		(MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
> +static unsigned int pfn_bits;
> +static unsigned int obj_index_bits;
>  
>  /*
>   * Memory for allocating for handle keeps object position by
> @@ -119,18 +108,20 @@
>   */
>  #define OBJ_ALLOCATED_TAG 1
>  #define OBJ_TAG_BITS 1
> -#define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
> -#define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
> +static unsigned int obj_index_mask;
>  
>  #define FULLNESS_BITS	2
>  #define CLASS_BITS	8
>  #define ISOLATED_BITS	3
>  #define MAGIC_VAL_BITS	8
>  
> -#define MAX(a, b) ((a) >= (b) ? (a) : (b))
> -/* ZS_MIN_ALLOC_SIZE must be multiple of ZS_ALIGN */
> -#define ZS_MIN_ALLOC_SIZE \
> -	MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> OBJ_INDEX_BITS))
> +/* zs_min_alloc_size must be multiple of ZS_ALIGN */
> +int zs_min_alloc_size(void)
> +{
> +	return max_t(unsigned long, 32, ZS_MAX_PAGES_PER_ZSPAGE <<
> +			PAGE_SHIFT >> obj_index_bits);
> +}
> +
>  /* each chunk includes extra space to keep handle */
>  #define ZS_MAX_ALLOC_SIZE	PAGE_SIZE
>  
> @@ -144,12 +135,11 @@
>   *    determined). NOTE: all those class sizes must be set as multiple of
>   *    ZS_ALIGN to make sure link_free itself never has to span 2 pages.
>   *
> - *  ZS_MIN_ALLOC_SIZE and ZS_SIZE_CLASS_DELTA must be multiple of ZS_ALIGN
> + *  zs_min_alloc_size and ZS_SIZE_CLASS_DELTA must be multiple of ZS_ALIGN
>   *  (reason above)
>   */
>  #define ZS_SIZE_CLASS_DELTA	(PAGE_SIZE >> CLASS_BITS)
> -#define ZS_SIZE_CLASSES	(DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - ZS_MIN_ALLOC_SIZE, \
> -				      ZS_SIZE_CLASS_DELTA) + 1)
> +static unsigned int zs_size_classes;
>  
>  enum fullness_group {
>  	ZS_EMPTY,
> @@ -253,7 +243,7 @@ struct link_free {
>  struct zs_pool {
>  	const char *name;
>  
> -	struct size_class *size_class[ZS_SIZE_CLASSES];
> +	struct size_class **size_class;
>  	struct kmem_cache *handle_cachep;
>  	struct kmem_cache *zspage_cachep;
>  
> @@ -541,11 +531,11 @@ static int get_size_class_index(int size)
>  {
>  	int idx = 0;
>  
> -	if (likely(size > ZS_MIN_ALLOC_SIZE))
> -		idx = DIV_ROUND_UP(size - ZS_MIN_ALLOC_SIZE,
> +	if (likely(size > zs_min_alloc_size()))
> +		idx = DIV_ROUND_UP(size - zs_min_alloc_size(),
>  				ZS_SIZE_CLASS_DELTA);
>  
> -	return min_t(int, ZS_SIZE_CLASSES - 1, idx);
> +	return min_t(int, zs_size_classes - 1, idx);
>  }
>  
>  /* type can be of enum type zs_stat_type or fullness_group */
> @@ -605,7 +595,7 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
>  			"obj_allocated", "obj_used", "pages_used",
>  			"pages_per_zspage", "freeable");
>  
> -	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
> +	for (i = 0; i < zs_size_classes; i++) {
>  		class = pool->size_class[i];
>  
>  		if (class->index != i)
> @@ -845,8 +835,8 @@ static void obj_to_location(unsigned long obj, struct page **page,
>  				unsigned int *obj_idx)
>  {
>  	obj >>= OBJ_TAG_BITS;
> -	*page = pfn_to_page(obj >> OBJ_INDEX_BITS);
> -	*obj_idx = (obj & OBJ_INDEX_MASK);
> +	*page = pfn_to_page(obj >> obj_index_bits);
> +	*obj_idx = (obj & obj_index_mask);
>  }
>  
>  /**
> @@ -858,8 +848,8 @@ static unsigned long location_to_obj(struct page *page, unsigned int obj_idx)
>  {
>  	unsigned long obj;
>  
> -	obj = page_to_pfn(page) << OBJ_INDEX_BITS;
> -	obj |= obj_idx & OBJ_INDEX_MASK;
> +	obj = page_to_pfn(page) << obj_index_bits;
> +	obj |= obj_idx & obj_index_mask;
>  	obj <<= OBJ_TAG_BITS;
>  
>  	return obj;
> @@ -2202,7 +2192,7 @@ static void async_free_zspage(struct work_struct *work)
>  	struct zs_pool *pool = container_of(work, struct zs_pool,
>  					free_work);
>  
> -	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
> +	for (i = 0; i < zs_size_classes; i++) {
>  		class = pool->size_class[i];
>  		if (class->index != i)
>  			continue;
> @@ -2320,7 +2310,7 @@ unsigned long zs_compact(struct zs_pool *pool)
>  	int i;
>  	struct size_class *class;
>  
> -	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
> +	for (i = zs_size_classes - 1; i >= 0; i--) {
>  		class = pool->size_class[i];
>  		if (!class)
>  			continue;
> @@ -2366,7 +2356,7 @@ static unsigned long zs_shrinker_count(struct shrinker *shrinker,
>  	struct zs_pool *pool = container_of(shrinker, struct zs_pool,
>  			shrinker);
>  
> -	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
> +	for (i = zs_size_classes - 1; i >= 0; i--) {
>  		class = pool->size_class[i];
>  		if (!class)
>  			continue;
> @@ -2427,18 +2417,20 @@ struct zs_pool *zs_create_pool(const char *name)
>  	if (create_cache(pool))
>  		goto err;
>  
> +	pool->size_class = kmalloc(sizeof(void *) * zs_size_classes, GFP_KERNEL);
> +
>  	/*
>  	 * Iterate reversely, because, size of size_class that we want to use
>  	 * for merging should be larger or equal to current size.
>  	 */
> -	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
> +	for (i = zs_size_classes - 1; i >= 0; i--) {
>  		int size;
>  		int pages_per_zspage;
>  		int objs_per_zspage;
>  		struct size_class *class;
>  		int fullness = 0;
>  
> -		size = ZS_MIN_ALLOC_SIZE + i * ZS_SIZE_CLASS_DELTA;
> +		size = zs_min_alloc_size() + i * ZS_SIZE_CLASS_DELTA;
>  		if (size > ZS_MAX_ALLOC_SIZE)
>  			size = ZS_MAX_ALLOC_SIZE;
>  		pages_per_zspage = get_pages_per_zspage(size);
> @@ -2528,7 +2520,7 @@ void zs_destroy_pool(struct zs_pool *pool)
>  	zs_unregister_migration(pool);
>  	zs_pool_stat_destroy(pool);
>  
> -	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
> +	for (i = 0; i < zs_size_classes; i++) {
>  		int fg;
>  		struct size_class *class = pool->size_class[i];
>  
> @@ -2547,6 +2539,7 @@ void zs_destroy_pool(struct zs_pool *pool)
>  		kfree(class);
>  	}
>  
> +	kfree(pool->size_class);
>  	destroy_cache(pool);
>  	kfree(pool->name);
>  	kfree(pool);
> @@ -2557,6 +2550,21 @@ static int __init zs_init(void)
>  {
>  	int ret;
>  
> +	/*
> +	 * If BITS_PER_LONG is not big enough to encode metadata(e.g., object
> +	 * location and some tags), it could't work at this moment.
> +	 */
> +	pfn_bits = ilog2(max_pfn) + 1;
> +	if (BITS_PER_LONG - OBJ_TAG_BITS - pfn_bits < 0) {
> +		pr_warn("max_pfn %lu is too large for zsmalloc\n",
> +				max_pfn);
> +		return -EFBIG;
> +	}
> +
> +	obj_index_bits = BITS_PER_LONG - OBJ_TAG_BITS - pfn_bits;
> +	obj_index_mask = (1 << obj_index_bits) - 1;
> +	zs_size_classes = (DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - zs_min_alloc_size(),  ZS_SIZE_CLASS_DELTA) + 1);
> +
>  	ret = zsmalloc_mount();
>  	if (ret)
>  		goto out;
> -- 
> 2.29.2.299.gdc1121823c-goog
> 

-- 
Sincerely yours,
Mike.
