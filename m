Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2962B9A3F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgKSR7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:59:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728277AbgKSR7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605808753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdl+nb7e2oJZF6AF2GCPDAAXEdI1omwuYReQp8ot+EI=;
        b=LCbITyIRUNejz+WdsT0AT52vzShbdm59PNZnRSuo+DcSG3oq8kPDgaqdyptrhQ7RTh0Why
        KX2/0KdYeHRkZq4QvaSbt8xpIc7vA5OiA61gFTpZgkagW/buAoEN8U6aJbMa3so4w3E5A0
        tphLt4NQLfzlEvTMZg5Z4WUo1GtmS24=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-7su32n1iPAS9hLha1uPBwQ-1; Thu, 19 Nov 2020 12:59:11 -0500
X-MC-Unique: 7su32n1iPAS9hLha1uPBwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CCAC8145E1;
        Thu, 19 Nov 2020 17:59:10 +0000 (UTC)
Received: from mail (ovpn-113-32.rdu2.redhat.com [10.10.113.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1162560854;
        Thu, 19 Nov 2020 17:59:03 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86: restore the write back cache of reserved RAM in iounmap()
Date:   Thu, 19 Nov 2020 12:59:02 -0500
Message-Id: <20201119175902.17394-2-aarcange@redhat.com>
In-Reply-To: <20201119175902.17394-1-aarcange@redhat.com>
References: <20201119175902.17394-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If reserved memory is mapped with ioremap_noncache() or ioremap_wc(),
the kernel correctly splits the direct mapping and marks the PAGE_SIZE
granular region uncached, so both the virtual direct mapping and the
second virtual mapping in vmap space will be both marked uncached or
write through (i.e.  _PAGE_PCD/PWT set on the pagetable).

However when iounmap is called later, nothing restores the direct
mapping write back memtype.

So if kernel executes this sequence:

   SetPageReserved
   ioremap_nocache
   iounmap
   ClearPageReserved

if the page is ever freed later it remains "uncached" indefinitely.

Those uncached regions can be tiny compared to the total size of the
RAM, so it may take a long time until a performance critical piece of
kernel memory gets allocated in a page that is uncached in the direct
mapping, long after the iounmap that left it uncached.

However when it eventually happens, it generates unexpected severe and
non reproducible kernel slowdowns.

The fix consist in restoring the original write back cache on reserved
RAM at iounmap() time. This is preferable than supporting multiple
overlapping ioremap on the same physical range because:

- the malfunction will happen when an ioremap is still outstanding,
  and ideally it'll happen synchronously at iounmap time, so it should
  be easier to track down than by scanning all kernel pagetables
  searching for any PCD/PWT leftover bits

- two ioremap at the same time of non write back memtype are already
  forbidden by the bugcheck in reserve_ram_page_type that verifies the
  current page type is still _PAGE_CACHE_MODE_WB before
  proceeding. And all ioremap are of write back memtype the patch will
  not make a difference

- even if two ioremap at the same on RAM would be allowed, the caller
  would need to still enforce they all have the same memtype, so it is
  more likely able to enforce that it doesn't do overlapping ioremaps
  at once than to be able to undo the changes to the direct mapping
  pagetables

Fixes: f56d005d3034 ("x86: no CPA on iounmap")
Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 arch/x86/mm/ioremap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 9e5ccc56f8e0..65dbc88edf43 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -437,6 +437,7 @@ EXPORT_SYMBOL(ioremap_prot);
 void iounmap(volatile void __iomem *addr)
 {
 	struct vm_struct *p, *o;
+	u64 p_start, p_end;
 
 	if ((void __force *)addr <= high_memory)
 		return;
@@ -472,12 +473,17 @@ void iounmap(volatile void __iomem *addr)
 		return;
 	}
 
-	memtype_free(p->phys_addr, p->phys_addr + get_vm_area_size(p));
+	p_start = p->phys_addr;
+	p_end = p_start + get_vm_area_size(p);
+	memtype_free(p_start, p_end);
 
 	/* Finally remove it */
 	o = remove_vm_area((void __force *)addr);
 	BUG_ON(p != o || o == NULL);
 	kfree(p);
+	if (o)
+		memtype_kernel_map_sync(p_start, p_end,
+					_PAGE_CACHE_MODE_WB);
 }
 EXPORT_SYMBOL(iounmap);
 

