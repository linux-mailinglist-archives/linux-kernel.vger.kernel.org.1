Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1572C4DD7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 04:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgKZDkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 22:40:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730187AbgKZDkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 22:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606362031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g+M2zpe7eopLOEZjwPaod+awjUNP2pDZNrKfFpsIxiA=;
        b=MqHEn4MQlzeKHHwM5hjdnNgON4nucporT33DXC7fHLYL9J2fdUKU8YnLSxTQo8WcO4EJb6
        SFIgV/i+7fWCUTGD6ZPeMWaKM6xlaqn44+qVLo5OWh0c50ufbJY2nl4+/dFwWRUbOzRTMl
        y+x1mJZrTdyfd/jfYNKOPvTgtQfDRXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-ZQZjXmNiOvehzO5vOfIUtQ-1; Wed, 25 Nov 2020 22:40:27 -0500
X-MC-Unique: ZQZjXmNiOvehzO5vOfIUtQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D033A185E489;
        Thu, 26 Nov 2020 03:40:25 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0A965D9C6;
        Thu, 26 Nov 2020 03:40:20 +0000 (UTC)
Date:   Wed, 25 Nov 2020 22:40:20 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X78jpOqo+IVq1Fn+@redhat.com>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20201121194506.13464-1-aarcange@redhat.com>
 <20201121194506.13464-2-aarcange@redhat.com>
 <ea911b11-945f-d2c5-5558-a3fe0bda492a@suse.cz>
 <X73s8fxDKPRD6wET@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X73s8fxDKPRD6wET@redhat.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 12:34:41AM -0500, Andrea Arcangeli wrote:
> pfn    physaddr   page->flags
> 500224 0x7a200000 0x1fff000000001000 reserved True
> 500225 0x7a201000 0x1fff000000001000 reserved True
> *snip*
> 500245 0x7a215000 0x1fff000000001000 reserved True
> 500246 0x7a216000 0x1fff000000001000 reserved True
> 500247 0x7a217000 0x3fff000000000000 reserved False
> 500248 0x7a218000 0x3fff000000000000 reserved False

The range is still this:

7a17b000-7a216fff : Unknown E820 type
7a217000-7ffdbfff : System RAM

This is with v5.3:

Interestingly the pages below 0x7a217000 weren't even marked reserved.

DMA      zone_start_pfn 1            zone_end_pfn() 4096         contiguous 1     
DMA32    zone_start_pfn 4096         zone_end_pfn() 524252       contiguous 1     
Normal   zone_start_pfn 0            zone_end_pfn() 0            contiguous 0     
Movable  zone_start_pfn 0            zone_end_pfn() 0            contiguous 0     

500246 0x7a216000 0x1fff000000000000 reserved False
500247 0x7a217000 0x1fff000000022036 reserved False
500248 0x7a218000 0x1fff000000002032 reserved False

4b094b7851bf4bf551ad456195d3f26e1c03bd74 no change (because the
unknown e820 type 20 was still initialized by memmap_init_zone despite
it was not part of memblock.memory):

DMA      zone_start_pfn 1            zone_end_pfn() 4096         contiguous 1     
DMA32    zone_start_pfn 4096         zone_end_pfn() 524252       contiguous 1     
Normal   zone_start_pfn 0            zone_end_pfn() 0            contiguous 0     
Movable  zone_start_pfn 0            zone_end_pfn() 0            contiguous 0     

500246 0x7a216000 0x1fff000000000000 reserved False
500247 0x7a217000 0x1fff000000022036 reserved False
500248 0x7a218000 0x1fff000000002032 reserved False

73a6e474cb376921a311786652782155eac2fdf0 this changed it:

DMA      zone_start_pfn 1            zone_end_pfn() 4096         contiguous 1     
DMA32    zone_start_pfn 4096         zone_end_pfn() 524252       contiguous 0     
Normal   zone_start_pfn 0            zone_end_pfn() 0            contiguous 0     
Movable  zone_start_pfn 0            zone_end_pfn() 0            contiguous 0     

500246 0x7a216000 0xfff000000001000 reserved True
500247 0x7a217000 0x1fff000000000000 reserved False
500248 0x7a218000 0x1fff000000010200 reserved False

da50c57bdbb8e37ec6f8c934a2f8acbf4e4fdfb9
(73a6e474cb376921a311786652782155eac2fdf0^) no change:

DMA      zone_start_pfn 1            zone_end_pfn() 4096         contiguous 1     
DMA32    zone_start_pfn 4096         zone_end_pfn() 524252       contiguous 1     
Normal   zone_start_pfn 0            zone_end_pfn() 0            contiguous 0     
Movable  zone_start_pfn 0            zone_end_pfn() 0            contiguous 0     

500246 0x7a216000 0x1fff000000000000 reserved False
500247 0x7a217000 0x1fff000000002032 reserved False
500248 0x7a218000 0x1fff000000002032 reserved False

So like Mike suggested this started in
73a6e474cb376921a311786652782155eac2fdf0, although the previous code
looked buggy too by not setting PageReserved when it should have.

It appears the pfn in the e820 type 20 were initialized by
memmap_init_zone before commit
73a6e474cb376921a311786652782155eac2fdf0 and they're not initialized
anymore after 73a6e474cb376921a311786652782155eac2fdf0 because the
memblock.memory didn't include the e820 type 20 so it couldn't call
memmap_init_zone anymore.

So after 4b094b7851bf4bf551ad456195d3f26e1c03bd74 uninitialized pfn
gets the 0,0 assignment (but even before
4b094b7851bf4bf551ad456195d3f26e1c03bd74 they would have gotten a
completely zero page->flags, 4b094b7851bf4bf551ad456195d3f26e1c03bd74
is completely unrelated to this issue).

Mike, your patch alone doesn't help because nothing calls
memblock_reserve on the range starting at 0x7a17b000. I appended at
the end the output of memblock=debug.

Only after I apply the below hack on top of your patch finally all
sign of bugs are gone, PG_reserved is finally set (old code was wrong
not setting it) and the zoneid/nid is right (new code leaves it
uninitialized and so it's wrong):

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 983cd53ed4c9..bbb5b4d7a117 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1303,6 +1303,8 @@ void __init e820__memblock_setup(void)
 
 		if (entry->type == E820_TYPE_SOFT_RESERVED)
 			memblock_reserve(entry->addr, entry->size);
+		if (entry->type == 20)
+			memblock_reserve(entry->addr, entry->size);
 
 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
 			continue;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3fb35fe6a9e4..2e2047282ff3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6145,7 +6145,9 @@ void __meminit __weak memmap_init(unsigned long size, int nid,
 {
 	unsigned long start_pfn, end_pfn;
 	unsigned long range_end_pfn = range_start_pfn + size;
+	phys_addr_t start, end;
 	int i;
+	u64 j;
 
 	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
 		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
@@ -6157,6 +6159,19 @@ void __meminit __weak memmap_init(unsigned long size, int nid,
 					 MEMINIT_EARLY, NULL);
 		}
 	}
+
+	for_each_mem_range(j, &memblock.reserved, NULL, nid,  MEMBLOCK_NONE,
+			     &start, &end, NULL) {
+		start_pfn = clamp(PHYS_PFN(start), range_start_pfn,
+				  range_end_pfn);
+		end_pfn = clamp(PHYS_PFN(end), range_start_pfn, range_end_pfn);
+
+		if (end_pfn > start_pfn) {
+			size = end_pfn - start_pfn;
+			memmap_init_zone(size, nid, zone, start_pfn,
+					 MEMINIT_EARLY, NULL);
+		}
+	}
 }
 
 static int zone_batchsize(struct zone *zone)

Result with above patch all good:

500246 0x7a216000 0x1fff000000001000 reserved True pfn_valid True
500247 0x7a217000 0x1fff000000002032 reserved False pfn_valid True
500248 0x7a218000 0x1fff000000020036 reserved False pfn_valid True

Summary: both old code (missing PG_reserved) and the current code
(leaving the page struct uninitialized and with wrong nodeid/nid) look
wrong.

Overall this brings more questions:

- why memblock.reserved exists and isn't automatically calculated as
  inversion of memblock.memory? (or if you prefer: why is the above
  call to memblock_reserve needed to initialize the memory holes?)

- why there's no initialization of the memblock.reserved regions given
  they exists, was it just an oversight? (this one is fixed by Mike's
  patch, although I wish it was possible to drop the function
  memblock_reserve instead)

- what can we do instead of setting the uninitialized nodeid/nid to
  0,0 and to reliably detect at boot if some page structure within
  zones (but ideally also outside the zone boundary for any pfn where
  pfn_valid returns true) is left uninitialized, as it is happening
  currently on the e820 type 20 range?

Thanks,
Andrea

[    0.006587] memblock_reserve: [0x00000000000f6bf0-0x00000000000f6bff] smp_scan_config+0xaa/0xee
[    0.006590] memblock_reserve: [0x00000000000f6c00-0x00000000000f6d7b] smp_scan_config+0xc1/0xee
[    0.006595] memblock_reserve: [0x0000000003400000-0x0000000003406fff] setup_arch+0x51b/0xb4e
[    0.006599] memblock_add: [0x0000000000001000-0x000000000009fbff] e820__memblock_setup+0x63/0x89
[    0.006614] memblock_add: [0x0000000000100000-0x000000007a17afff] e820__memblock_setup+0x63/0x89
[    0.006615] memblock_add: [0x000000007a217000-0x000000007ffdbfff] e820__memblock_setup+0x63/0x89
[    0.006627] memblock_reserve: [0x000000000009f000-0x00000000000fffff] setup_arch+0x53f/0xb4e
[    0.006634] memblock_reserve: [0x0000000000099000-0x000000000009efff] reserve_real_mode+0x6f/0x8d
[    0.006665] memblock_reserve: [0x0000000000000000-0x000000000000ffff] setup_arch+0x56b/0xb4e
[    0.006907] memblock_reserve: [0x000000007fdff000-0x000000007fdfffff] alloc_low_pages+0x16b/0x180
[    0.007219] memblock_reserve: [0x000000007ffd9000-0x000000007ffdbfff] memblock_alloc_range_nid+0xb1/0x11f
[    0.007245] memblock_alloc_try_nid: 16384 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 sparse_init+0x8c/0x2c9
[    0.007246] memblock_reserve: [0x000000007ffd5000-0x000000007ffd8fff] memblock_alloc_range_nid+0xb1/0x11f
[    0.007250] memblock_alloc_try_nid: 4096 bytes align=0x40 nid=0 from=0x0000000000000000 max_addr=0x0000000000000000 sparse_index_alloc+0x44/0x67
[    0.007252] memblock_reserve: [0x000000007ffd4000-0x000000007ffd4fff] memblock_alloc_range_nid+0xb1/0x11f
[    0.007260] memblock_alloc_try_nid: 640 bytes align=0x40 nid=0 from=0x0000000000000000 max_addr=0x0000000000000000 sparse_init_nid+0x3d/0x224
[    0.007262] memblock_reserve: [0x000000007ffd3d80-0x000000007ffd3fff] memblock_alloc_range_nid+0xb1/0x11f
[    0.007265] memblock_alloc_exact_nid_raw: 33554432 bytes align=0x200000 nid=0 from=0x0000000001000000 max_addr=0x0000000000000000 sparse_init_nid+0x8a/0x224
[    0.007266] memblock_reserve: [0x000000007dc00000-0x000000007fbfffff] memblock_alloc_range_nid+0xb1/0x11f
[    0.012443] memblock_alloc_try_nid_raw: 4096 bytes align=0x1000 nid=0 from=0x0000000001000000 max_addr=0x0000000000000000 vmemmap_alloc_block_zero.constprop.0+0xc/0x24
[    0.012450] memblock_reserve: [0x000000007ffd2000-0x000000007ffd2fff] memblock_alloc_range_nid+0xb1/0x11f
[    0.012453] memblock_alloc_try_nid_raw: 4096 bytes align=0x1000 nid=0 from=0x0000000001000000 max_addr=0x0000000000000000 vmemmap_alloc_block_zero.constprop.0+0xc/0x24
[    0.012454] memblock_reserve: [0x000000007ffd1000-0x000000007ffd1fff] memblock_alloc_range_nid+0xb1/0x11f
[    0.016975] memblock_alloc_try_nid: 73 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 acpi_parse_hpet+0xca/0x132
[    0.016983] memblock_reserve: [0x000000007ffd3d00-0x000000007ffd3d48] memblock_alloc_range_nid+0xb1/0x11f
[    0.016992] memblock_alloc_try_nid: 75 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 io_apic_init_mappings+0x38/0x1c0
[    0.016993] memblock_reserve: [0x000000007ffd3c80-0x000000007ffd3cca] memblock_alloc_range_nid+0xb1/0x11f
[    0.017012] memblock_alloc_try_nid: 768 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 e820__reserve_resources+0x2c/0x1be
[    0.017013] memblock_reserve: [0x000000007ffd3980-0x000000007ffd3c7f] memblock_alloc_range_nid+0xb1/0x11f
[    0.017017] memblock_alloc_try_nid: 104 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 firmware_map_add_early+0x2a/0x52
[    0.017019] memblock_reserve: [0x000000007ffd3900-0x000000007ffd3967] memblock_alloc_range_nid+0xb1/0x11f
[    0.017023] memblock_alloc_try_nid: 104 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 firmware_map_add_early+0x2a/0x52
[    0.017025] memblock_reserve: [0x000000007ffd3880-0x000000007ffd38e7] memblock_alloc_range_nid+0xb1/0x11f
[    0.017026] memblock_alloc_try_nid: 104 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 firmware_map_add_early+0x2a/0x52
[    0.017028] memblock_reserve: [0x000000007ffd3800-0x000000007ffd3867] memblock_alloc_range_nid+0xb1/0x11f
[    0.017029] memblock_alloc_try_nid: 104 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 firmware_map_add_early+0x2a/0x52
[    0.017031] memblock_reserve: [0x000000007ffd3780-0x000000007ffd37e7] memblock_alloc_range_nid+0xb1/0x11f
[    0.017032] memblock_alloc_try_nid: 104 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 firmware_map_add_early+0x2a/0x52
[    0.017033] memblock_reserve: [0x000000007ffd3700-0x000000007ffd3767] memblock_alloc_range_nid+0xb1/0x11f
[    0.017035] memblock_alloc_try_nid: 104 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 firmware_map_add_early+0x2a/0x52
[    0.017036] memblock_reserve: [0x000000007ffd3680-0x000000007ffd36e7] memblock_alloc_range_nid+0xb1/0x11f
[    0.017038] memblock_alloc_try_nid: 104 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 firmware_map_add_early+0x2a/0x52
[    0.017039] memblock_reserve: [0x000000007ffd3600-0x000000007ffd3667] memblock_alloc_range_nid+0xb1/0x11f
[    0.017041] memblock_alloc_try_nid: 104 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 firmware_map_add_early+0x2a/0x52
[    0.017042] memblock_reserve: [0x000000007ffd3580-0x000000007ffd35e7] memblock_alloc_range_nid+0xb1/0x11f
[    0.017044] memblock_alloc_try_nid: 104 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 firmware_map_add_early+0x2a/0x52
[    0.017045] memblock_reserve: [0x000000007ffd3500-0x000000007ffd3567] memblock_alloc_range_nid+0xb1/0x11f
[    0.017047] memblock_alloc_try_nid: 104 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 firmware_map_add_early+0x2a/0x52
[    0.017048] memblock_reserve: [0x000000007ffd3480-0x000000007ffd34e7] memblock_alloc_range_nid+0xb1/0x11f
[    0.017050] memblock_alloc_try_nid: 104 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 firmware_map_add_early+0x2a/0x52
[    0.017051] memblock_reserve: [0x000000007ffd3400-0x000000007ffd3467] memblock_alloc_range_nid+0xb1/0x11f
[    0.017069] memblock_alloc_try_nid: 32 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 __register_nosave_region+0x7a/0xf7
[    0.017071] memblock_reserve: [0x000000007ffd33c0-0x000000007ffd33df] memblock_alloc_range_nid+0xb1/0x11f
[    0.017073] memblock_alloc_try_nid: 32 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 __register_nosave_region+0x7a/0xf7
[    0.017075] memblock_reserve: [0x000000007ffd3380-0x000000007ffd339f] memblock_alloc_range_nid+0xb1/0x11f
[    0.017099] memblock_alloc_try_nid: 32 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 __register_nosave_region+0x7a/0xf7
[    0.017101] memblock_reserve: [0x000000007ffd3340-0x000000007ffd335f] memblock_alloc_range_nid+0xb1/0x11f
[    0.020380] memblock_alloc_try_nid: 70 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 start_kernel+0x110/0x57c
[    0.020382] memblock_reserve: [0x000000007ffd32c0-0x000000007ffd3305] memblock_alloc_range_nid+0xb1/0x11f
[    0.020383] memblock_alloc_try_nid: 70 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 start_kernel+0x124/0x57c
[    0.020385] memblock_reserve: [0x000000007ffd3240-0x000000007ffd3285] memblock_alloc_range_nid+0xb1/0x11f
[    0.020391] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_alloc_alloc_info+0x5e/0x8f
[    0.020392] memblock_reserve: [0x000000007ffd0000-0x000000007ffd0fff] memblock_alloc_range_nid+0xb1/0x11f
[    0.020394] memblock_alloc_try_nid: 4096 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_embed_first_chunk+0x6a/0x299
[    0.020396] memblock_reserve: [0x000000007ffcf000-0x000000007ffcffff] memblock_alloc_range_nid+0xb1/0x11f
[    0.020397] memblock_alloc_try_nid: 2097152 bytes align=0x200000 nid=0 from=0x0000000001000000 max_addr=0x0000000000000000 pcpu_embed_first_chunk+0xd0/0x299
[    0.020399] memblock_reserve: [0x000000007da00000-0x000000007dbfffff] memblock_alloc_range_nid+0xb1/0x11f
[    0.020584] memblock_free: [0x000000007da37000-0x000000007da3ffff] pcpu_embed_first_chunk+0x1b8/0x299
[    0.020590] memblock_free: [0x000000007da77000-0x000000007da7ffff] pcpu_embed_first_chunk+0x1b8/0x299
[    0.020595] memblock_free: [0x000000007dab7000-0x000000007dabffff] pcpu_embed_first_chunk+0x1b8/0x299
[    0.020600] memblock_free: [0x000000007daf7000-0x000000007dafffff] pcpu_embed_first_chunk+0x1b8/0x299
[    0.020606] memblock_free: [0x000000007db37000-0x000000007db3ffff] pcpu_embed_first_chunk+0x1b8/0x299
[    0.020611] memblock_free: [0x000000007db77000-0x000000007db7ffff] pcpu_embed_first_chunk+0x1b8/0x299
[    0.020616] memblock_free: [0x000000007dbb7000-0x000000007dbbffff] pcpu_embed_first_chunk+0x1b8/0x299
[    0.020621] memblock_free: [0x000000007dbf7000-0x000000007dbfffff] pcpu_embed_first_chunk+0x1b8/0x299
[    0.020624] memblock_alloc_try_nid: 8 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_setup_first_chunk+0x2f2/0x7ae
[    0.020625] memblock_reserve: [0x000000007ffd3200-0x000000007ffd3207] memblock_alloc_range_nid+0xb1/0x11f
[    0.020626] memblock_alloc_try_nid: 8 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_setup_first_chunk+0x30f/0x7ae
[    0.020628] memblock_reserve: [0x000000007ffd31c0-0x000000007ffd31c7] memblock_alloc_range_nid+0xb1/0x11f
[    0.020629] memblock_alloc_try_nid: 32 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_setup_first_chunk+0x345/0x7ae
[    0.020630] memblock_reserve: [0x000000007ffd3180-0x000000007ffd319f] memblock_alloc_range_nid+0xb1/0x11f
[    0.020632] memblock_alloc_try_nid: 64 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_setup_first_chunk+0x37f/0x7ae
[    0.020633] memblock_reserve: [0x000000007ffd3140-0x000000007ffd317f] memblock_alloc_range_nid+0xb1/0x11f
[    0.020639] memblock_alloc_try_nid: 576 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_setup_first_chunk+0x638/0x7ae
[    0.020640] memblock_reserve: [0x000000007ffcedc0-0x000000007ffcefff] memblock_alloc_range_nid+0xb1/0x11f
[    0.020645] memblock_alloc_try_nid: 144 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_alloc_first_chunk+0x7a/0x259
[    0.020646] memblock_reserve: [0x000000007ffd3080-0x000000007ffd310f] memblock_alloc_range_nid+0xb1/0x11f
[    0.020648] memblock_alloc_try_nid: 384 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_alloc_first_chunk+0xd0/0x259
[    0.020649] memblock_reserve: [0x000000007ffcec40-0x000000007ffcedbf] memblock_alloc_range_nid+0xb1/0x11f
[    0.020650] memblock_alloc_try_nid: 392 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_alloc_first_chunk+0x10f/0x259
[    0.020652] memblock_reserve: [0x000000007ffcea80-0x000000007ffcec07] memblock_alloc_range_nid+0xb1/0x11f
[    0.020653] memblock_alloc_try_nid: 96 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_alloc_first_chunk+0x12f/0x259
[    0.020654] memblock_reserve: [0x000000007ffd3000-0x000000007ffd305f] memblock_alloc_range_nid+0xb1/0x11f
[    0.020657] memblock_alloc_try_nid: 144 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_alloc_first_chunk+0x7a/0x259
[    0.020658] memblock_reserve: [0x000000007ffce9c0-0x000000007ffcea4f] memblock_alloc_range_nid+0xb1/0x11f
[    0.020660] memblock_alloc_try_nid: 1024 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_alloc_first_chunk+0xd0/0x259
[    0.020661] memblock_reserve: [0x000000007ffce5c0-0x000000007ffce9bf] memblock_alloc_range_nid+0xb1/0x11f
[    0.020662] memblock_alloc_try_nid: 1032 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_alloc_first_chunk+0x10f/0x259
[    0.020664] memblock_reserve: [0x000000007ffce180-0x000000007ffce587] memblock_alloc_range_nid+0xb1/0x11f
[    0.020665] memblock_alloc_try_nid: 256 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 pcpu_alloc_first_chunk+0x12f/0x259
[    0.020667] memblock_reserve: [0x000000007ffce080-0x000000007ffce17f] memblock_alloc_range_nid+0xb1/0x11f
[    0.020668] memblock_free: [0x000000007ffd0000-0x000000007ffd0fff] pcpu_embed_first_chunk+0x25a/0x299
[    0.020670] memblock_free: [0x000000007ffcf000-0x000000007ffcffff] pcpu_embed_first_chunk+0x287/0x299
[    0.020681] memblock_alloc_try_nid: 4096 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_large_system_hash+0x16b/0x25a
[    0.020682] memblock_reserve: [0x000000007ffd0000-0x000000007ffd0fff] memblock_alloc_range_nid+0xb1/0x11f
[    0.020741] memblock_alloc_try_nid: 2097152 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_large_system_hash+0x16b/0x25a
[    0.020742] memblock_reserve: [0x000000007d800000-0x000000007d9fffff] memblock_alloc_range_nid+0xb1/0x11f
[    0.020854] memblock_alloc_try_nid: 1048576 bytes align=0x40 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 alloc_large_system_hash+0x16b/0x25a
[    0.020856] memblock_reserve: [0x000000007fece080-0x000000007ffce07f] memblock_alloc_range_nid+0xb1/0x11f
[    0.020891] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 spp_getpage+0x3d/0x70
[    0.020893] memblock_reserve: [0x000000007ffcf000-0x000000007ffcffff] memblock_alloc_range_nid+0xb1/0x11f
[    0.020895] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 spp_getpage+0x3d/0x70
[    0.020896] memblock_reserve: [0x000000007fecd000-0x000000007fecdfff] memblock_alloc_range_nid+0xb1/0x11f
[    0.020898] memblock_alloc_try_nid: 4096 bytes align=0x1000 nid=-1 from=0x0000000000000000 max_addr=0x0000000000000000 spp_getpage+0x3d/0x70
[    0.020900] memblock_reserve: [0x000000007fecc000-0x000000007feccfff] memblock_alloc_range_nid+0xb1/0x11f

