Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA45F30462E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394668AbhAZSUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:20:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34896 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389411AbhAZSP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611684873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=86V3O1CpDYfjlF8VjAknPG5EI+Zpfg6lv7tE22Cqg3g=;
        b=L49rzUYruEK0goKr/DxqkeT9GsXmpqZiQe4cybZOhAH7H/D3UeW/ChpRTxI0WoFDstnMdQ
        nuoZvG+Ibooiwd8G8K8CO+Wr8ix1bhQK6jIfEl1ESY9lU+JL8NFOOd+RyDECDyvwvZ+3aN
        RzBsEWJBg7m625r0b82F3b/DvsX04P8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-wTu-Vj2-Pp6aojRBEV30Zw-1; Tue, 26 Jan 2021 13:14:28 -0500
X-MC-Unique: wTu-Vj2-Pp6aojRBEV30Zw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58441107ACFE;
        Tue, 26 Jan 2021 18:14:26 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-192.ams2.redhat.com [10.36.114.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E96E36F991;
        Tue, 26 Jan 2021 18:14:20 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-csky@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v1] csky: use free_initmem_default() in free_initmem()
Date:   Tue, 26 Jan 2021 19:14:20 +0100
Message-Id: <20210126181420.19223-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing code is essentially
free_initmem_default()->free_reserved_area() without poisoning.

Note that existing code missed to update the managed page count of the
zone.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Not compile tested as documentation on how to get
	https://gitlab.com/c-sky/buildroot
running, especially with a custom kernel, is a bit sparse.

---
 arch/csky/mm/init.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index 81e4e5e78f38..894050a8ce09 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -110,24 +110,9 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 }
 
-extern char __init_begin[], __init_end[];
-
 void free_initmem(void)
 {
-	unsigned long addr;
-
-	addr = (unsigned long) &__init_begin;
-
-	while (addr < (unsigned long) &__init_end) {
-		ClearPageReserved(virt_to_page(addr));
-		init_page_count(virt_to_page(addr));
-		free_page(addr);
-		totalram_pages_inc();
-		addr += PAGE_SIZE;
-	}
-
-	pr_info("Freeing unused kernel memory: %dk freed\n",
-	((unsigned int)&__init_end - (unsigned int)&__init_begin) >> 10);
+	free_initmem_default(-1);
 }
 
 void pgd_init(unsigned long *p)
-- 
2.29.2

