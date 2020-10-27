Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF5229BB89
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900893AbgJ0QRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:17:04 -0400
Received: from foss.arm.com ([217.140.110.172]:45198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S369040AbgJ0QC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:02:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14D75139F;
        Tue, 27 Oct 2020 09:02:25 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DD713F719;
        Tue, 27 Oct 2020 09:02:23 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: [PATCH] mm: vmalloc: Fix kasan shadow poisoning size
Date:   Tue, 27 Oct 2020 16:02:13 +0000
Message-Id: <20201027160213.32904-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of vm area can be affected by the presence or not of the guard
page. In particular when VM_NO_GUARD is present, the actual accessible
size has to be considered like the real size minus the guard page.

Currently kasan does not keep into account this information during the
poison operation and in particular tries to poison the guard page as
well.

This approach, even if incorrect, does not cause an issue because the
tags for the guard page are written in the shadow memory.
With the future introduction of the Tag-Based KASAN, being the guard
page inaccessible by nature, the write tag operation on this page
triggers a fault.

Fix kasan shadow poisoning size invoking get_vm_area_size() instead of
accessing directly the field in the data structure to detect the correct
value.

Fixes: d98c9e83b5e7c ("kasan: fix crashes on access to memory mapped by vm_map_ram()")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6ae491a8b210..1b5426965e84 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2256,7 +2256,7 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
 	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
 
-	kasan_poison_vmalloc(area->addr, area->size);
+	kasan_poison_vmalloc(area->addr, get_vm_area_size(area));
 
 	vm_remove_mappings(area, deallocate_pages);
 
-- 
2.28.0

