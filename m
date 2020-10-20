Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F401293F67
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408630AbgJTPSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731735AbgJTPS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603207106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+fq27Lrjh4A+WF1/QMsoiHGG+aBtxAgUfHzjn77I/58=;
        b=Esd+pUHck26qaIkw+pm0T+mdIIqstAzBlRPmWSX8fIuCsFb2HjBJ49jewC3Nrgu2/+6579
        9FyqBkpG1kJ1iggJuZUbAMxxPg/o/JAjd22aI2WikSxEoInjKdJZJCEvF97+nh6ep0c8vJ
        ro7LfotfQs/bO2XDFINXIPd4BdVP0nQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-5n0XqEwfO1i_tqMwy6QGFg-1; Tue, 20 Oct 2020 11:18:20 -0400
X-MC-Unique: 5n0XqEwfO1i_tqMwy6QGFg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E417F64145;
        Tue, 20 Oct 2020 15:18:17 +0000 (UTC)
Received: from localhost (ovpn-12-44.pek2.redhat.com [10.72.12.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC9156EF45;
        Tue, 20 Oct 2020 15:18:16 +0000 (UTC)
Date:   Tue, 20 Oct 2020 23:18:14 +0800
From:   "bhe@redhat.com" <bhe@redhat.com>
To:     Rahul Gopakumar <gopakumarr@vmware.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Rajender M <manir@vmware.com>,
        Yiu Cho Lau <lauyiuch@vmware.com>,
        Peter Jonasson <pjonasson@vmware.com>,
        Venkatesh Rajaram <rajaramv@vmware.com>
Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kernel
Message-ID: <20201020151814.GU25604@MiWiFi-R3L-srv>
References: <DM6PR05MB52921FF90FA01CC337DD23A1A4080@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201010061124.GE25604@MiWiFi-R3L-srv>
 <DM6PR05MB529281F914953691E0F52D1CA4070@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201013131735.GL25604@MiWiFi-R3L-srv>
 <DM6PR05MB52926FDAB0E58F5CFA2E892DA41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR05MB52926FDAB0E58F5CFA2E892DA41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/20 at 01:45pm, Rahul Gopakumar wrote:
> Hi Baoquan,
> 
> We had some trouble applying the patch to problem commit and the latest upstream commit. Steven (CC'ed) helped us by providing the updated draft patch. We applied it on the latest commit (3e4fb4346c781068610d03c12b16c0cfb0fd24a3), and it doesn't look like improving the performance numbers.

Thanks for your feedback. From the code, I am sure what the problem is,
but I didn't test it on system with huge memory. Forget mentioning my
draft patch is based on akpm/master branch since it's a mm issue, it
might be a little different with linus's mainline kernel, sorry for the
inconvenience.

I will test and debug this on a server with 4T memory in our lab, and
update if any progress.

> 
> Patch on latest commit - 20.161 secs
> Vanilla latest commit - 19.50 secs

Here, do you mean it even cost more time with the patch applied?

> 
> Here is the draft patch we tried
> 
> ------------------------
> 
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index 8e7b8c6c576e..ff5fa4c3889e 100644
> --- a/arch/ia64/mm/init.c
> +++ b/arch/ia64/mm/init.c
> @@ -537,7 +537,7 @@ virtual_memmap_init(u64 start, u64 end, void *arg)
>  
>          if (map_start < map_end)
>                  memmap_init_zone((unsigned long)(map_end - map_start),
> -                                args->nid, args->zone, page_to_pfn(map_start),
> +                                args->nid, args->zone, page_to_pfn(map_start), page_to_pfn(map_end),
>                                   MEMINIT_EARLY, NULL);
>          return 0;
>  }
> @@ -547,7 +547,7 @@ memmap_init (unsigned long size, int nid, unsigned long zone,
>               unsigned long start_pfn)
>  {
>          if (!vmem_map) {
> -               memmap_init_zone(size, nid, zone, start_pfn,
> +               memmap_init_zone(size, nid, zone, start_pfn, start_pfn + size,
>                                   MEMINIT_EARLY, NULL);
>          } else {
>                  struct page *start;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 16b799a0522c..65e34b370e33 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2416,7 +2416,7 @@ extern int __meminit __early_pfn_to_nid(unsigned long pfn,
>  
>  extern void set_dma_reserve(unsigned long new_dma_reserve);
>  extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long,
> -               enum meminit_context, struct vmem_altmap *);
> +               unsigned long, enum meminit_context, struct vmem_altmap *);
>  extern void setup_per_zone_wmarks(void);
>  extern int __meminit init_per_zone_wmark_min(void);
>  extern void mem_init(void);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index ce3e73e3a5c1..03fddd8f4b11 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -728,7 +728,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>           * expects the zone spans the pfn range. All the pages in the range
>           * are reserved so nobody should be touching them so we should be safe
>           */
> -       memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn,
> +       memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn, 0,
>                           MEMINIT_HOTPLUG, altmap);
>  
>          set_zone_contiguous(zone);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 780c8f023b28..fe80055ea59c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5989,8 +5989,8 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
>   * done. Non-atomic initialization, single-pass.
>   */
>  void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> -               unsigned long start_pfn, enum meminit_context context,
> -               struct vmem_altmap *altmap)
> +               unsigned long start_pfn, unsigned long zone_end_pfn,
> +               enum meminit_context context, struct vmem_altmap *altmap)
>  {
>          unsigned long pfn, end_pfn = start_pfn + size;
>          struct page *page;
> @@ -6024,7 +6024,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>                  if (context == MEMINIT_EARLY) {
>                          if (overlap_memmap_init(zone, &pfn))
>                                  continue;
> -                       if (defer_init(nid, pfn, end_pfn))
> +                       if (defer_init(nid, pfn, zone_end_pfn))
>                                  break;
>                  }
>  
> @@ -6150,7 +6150,7 @@ void __meminit __weak memmap_init(unsigned long size, int nid,
>  
>                  if (end_pfn > start_pfn) {
>                          size = end_pfn - start_pfn;
> -                       memmap_init_zone(size, nid, zone, start_pfn,
> +                       memmap_init_zone(size, nid, zone, start_pfn, range_end_pfn,
>                                           MEMINIT_EARLY, NULL);
>                  }
>          }
> 
> 
> ------------------------
> 
> We have attached default dmesg logs and also dmesg logs collected with memblock=debug kernel cmdline for both vanilla and patched kernels. Let me know if you need more info.
> 
> 
> 
> From: bhe@redhat.com <bhe@redhat.com>
> Sent: 13 October 2020 6:47 PM
> To: Rahul Gopakumar <gopakumarr@vmware.com>
> Cc: linux-mm@kvack.org <linux-mm@kvack.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; akpm@linux-foundation.org <akpm@linux-foundation.org>; natechancellor@gmail.com <natechancellor@gmail.com>; ndesaulniers@google.com <ndesaulniers@google.com>; clang-built-linux@googlegroups.com <clang-built-linux@googlegroups.com>; rostedt@goodmis.org <rostedt@goodmis.org>; Rajender M <manir@vmware.com>; Yiu Cho Lau <lauyiuch@vmware.com>; Peter Jonasson <pjonasson@vmware.com>; Venkatesh Rajaram <rajaramv@vmware.com>
> Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kernel 
>  
> Hi Rahul,
> 
> On 10/12/20 at 05:21pm, Rahul Gopakumar wrote:
> > Hi Baoquan,
> > 
> > Attached collected dmesg logs for with and without
> > commit after adding memblock=debug to kernel cmdline.
> 
> Can you test below draft patch and see if it works for you? 
> 
> From a2ea6caef3c73ad9efb2dd2b48039065fe430bb2 Mon Sep 17 00:00:00 2001
> From: Baoquan He <bhe@redhat.com>
> Date: Tue, 13 Oct 2020 20:05:30 +0800
> Subject: [PATCH] mm: make memmap defer init only take effect per zone
> 
> Deferred struct page init is designed to work per zone. However since
> commit 73a6e474cb376 ("mm: memmap_init: iterate over memblock regions
> rather that check each PFN"), the handling is mistakenly done in all memory
> ranges inside one zone. Especially in those unmovable zones of multiple nodes,
> memblock reservation split them into many memory ranges. This makes
> initialized struct page more than expected in early stage, then increases
> much boot time.
> 
> Let's fix it to make the memmap defer init handled in zone wide, but not in
> memory range of one zone.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/ia64/mm/init.c | 4 ++--
>  include/linux/mm.h  | 5 +++--
>  mm/memory_hotplug.c | 2 +-
>  mm/page_alloc.c     | 6 +++---
>  4 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
> index ef12e097f318..27ca549ff47e 100644
> --- a/arch/ia64/mm/init.c
> +++ b/arch/ia64/mm/init.c
> @@ -536,7 +536,7 @@ virtual_memmap_init(u64 start, u64 end, void *arg)
>  
>          if (map_start < map_end)
>                  memmap_init_zone((unsigned long)(map_end - map_start),
> -                                args->nid, args->zone, page_to_pfn(map_start),
> +                                args->nid, args->zone, page_to_pfn(map_start), page_to_pfn(map_end),
>                                   MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
>          return 0;
>  }
> @@ -546,7 +546,7 @@ memmap_init (unsigned long size, int nid, unsigned long zone,
>               unsigned long start_pfn)
>  {
>          if (!vmem_map) {
> -               memmap_init_zone(size, nid, zone, start_pfn,
> +               memmap_init_zone(size, nid, zone, start_pfn, start_pfn + size,
>                                   MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
>          } else {
>                  struct page *start;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ef360fe70aaf..5f9fc61d5be2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2439,8 +2439,9 @@ extern int __meminit __early_pfn_to_nid(unsigned long pfn,
>  #endif
>  
>  extern void set_dma_reserve(unsigned long new_dma_reserve);
> -extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long,
> -               enum meminit_context, struct vmem_altmap *, int migratetype);
> +extern void memmap_init_zone(unsigned long, int, unsigned long,
> +               unsigned long, unsigned long, enum meminit_context,
> +               struct vmem_altmap *, int migratetype);
>  extern void setup_per_zone_wmarks(void);
>  extern int __meminit init_per_zone_wmark_min(void);
>  extern void mem_init(void);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b44d4c7ba73b..f9a37e6abc1c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -732,7 +732,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>           * expects the zone spans the pfn range. All the pages in the range
>           * are reserved so nobody should be touching them so we should be safe
>           */
> -       memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn,
> +       memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn, 0,
>                           MEMINIT_HOTPLUG, altmap, migratetype);
>  
>          set_zone_contiguous(zone);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2ebf9ddafa3a..e8b19fdd18ec 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6044,7 +6044,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
>   * zone stats (e.g., nr_isolate_pageblock) are touched.
>   */
>  void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
> -               unsigned long start_pfn,
> +               unsigned long start_pfn, unsigned long zone_end_pfn,
>                  enum meminit_context context,
>                  struct vmem_altmap *altmap, int migratetype)
>  {
> @@ -6080,7 +6080,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>                  if (context == MEMINIT_EARLY) {
>                          if (overlap_memmap_init(zone, &pfn))
>                                  continue;
> -                       if (defer_init(nid, pfn, end_pfn))
> +                       if (defer_init(nid, pfn, zone_end_pfn))
>                                  break;
>                  }
>  
> @@ -6194,7 +6194,7 @@ void __meminit __weak memmap_init(unsigned long size, int nid,
>  
>                  if (end_pfn > start_pfn) {
>                          size = end_pfn - start_pfn;
> -                       memmap_init_zone(size, nid, zone, start_pfn,
> +                       memmap_init_zone(size, nid, zone, start_pfn, range_end_pfn,
>                                           MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
>                  }
>          }
> -- 
> 2.17.2





