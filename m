Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEBC2676C6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 02:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgILAXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 20:23:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:45613 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgILAXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 20:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599870224; x=1631406224;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/hsea2x47F0MN5xVlvN7uaRSxJBMCY8XyO44RdpLtjI=;
  b=qPCVe3AXjFGlsvLKRIkO4alSG8RsR/f25siTsE0ooIa+8H8GDW5Io2zM
   mYEkw2OFYtlK6rS+IAZXf9PedavDDmsWxLhakbMlmS8JFkumOj+tamklL
   MtTpDW59+Ra+1XOdaD4QAj3zLx4XgLT0U9JcaBzznceHhzKkeHy7RMJFR
   ExHv7ErV8xn9msktHDzEgmrlLilz4CRmwZ5VOTPeFM5WMQhc2Hn+xV493
   FGkStGIBPxS0tEPLKh2J4AVXlWaQ8rvSzfyXbGMpZX1twXO7O1APXK0Mf
   Pukmmq4828ChO/XBGH6zyHpPvvZOeBwVhzxDmOGLG/1/OZEBd1stYoxdC
   Q==;
IronPort-SDR: cH1tNnzDqcgIc9KegDyNYEW6P7AvNexkHd8CjGsVkaftC6nEISF8WhAYxOqFZ9peVbzP7yQpP5
 ojsrSl8MuB+StP6dZlQR3HmXmhrXk9rLpxNZb/RG2b5PkV1q7cZYTsSKpSlsmHkIGLw7O7sx40
 ++7BW/XnqXH2sqRhLzobdbW8b0wjKTlLk9bHv1/lI42VS2h2BW2wAPRdlpr+MLTLJ/0E8WbyML
 Ag4kHnMtYICpNTijxuffu8qWrH18r5EcPD9QMADDNa9+gCGcMBAZeUBsJ/A12RJba8aD+EQH4B
 ezI=
X-IronPort-AV: E=Sophos;i="5.76,418,1592841600"; 
   d="scan'208";a="147094439"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2020 08:23:44 +0800
IronPort-SDR: tjAy55HmZUZKfZfKVD+xMwM/u1ZVKSmLDGMtV0UHTr4Mbh7hPnxB92GgyF/xzBbe6tjglLslEZ
 Rm4BGAO0HBaA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2020 17:10:59 -0700
IronPort-SDR: AyWggxGakAL0OV49dIZqCueRDcobwmAd0LGIlkqV8w1WCFzOuTkNrgG2qsCRYMQvV0pYvpGeca
 x3D9x7AmYBQw==
WDCIronportException: Internal
Received: from unknown (HELO jedi-01.hgst.com) ([10.86.59.229])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2020 17:23:43 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>, Mike Rapoport <rppt@kernel.org>
Subject: [PATCH] RISC-V: Consider sparse memory while removing unusable memory
Date:   Fri, 11 Sep 2020 17:23:41 -0700
Message-Id: <20200912002341.4869-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, any usable memory area beyond page_offset is removed by adding the
memory sizes from each memblock. That may not work for sparse memory
as memory regions can be very far apart resulting incorrect removal of some
usable memory.

Just use the start of the first memory block and the end of the last memory
block to compute the size of the total memory that can be used.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/init.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 787c75f751a5..188281fc2816 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -147,7 +147,6 @@ void __init setup_bootmem(void)
 {
 	struct memblock_region *reg;
 	phys_addr_t mem_size = 0;
-	phys_addr_t total_mem = 0;
 	phys_addr_t mem_start, end = 0;
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
 	phys_addr_t vmlinux_start = __pa_symbol(&_start);
@@ -155,18 +154,17 @@ void __init setup_bootmem(void)
 	/* Find the memory region containing the kernel */
 	for_each_memblock(memory, reg) {
 		end = reg->base + reg->size;
-		if (!total_mem)
+		if (!mem_start)
 			mem_start = reg->base;
 		if (reg->base <= vmlinux_start && vmlinux_end <= end)
 			BUG_ON(reg->size == 0);
-		total_mem = total_mem + reg->size;
 	}
 
 	/*
 	 * Remove memblock from the end of usable area to the
 	 * end of region
 	 */
-	mem_size = min(total_mem, (phys_addr_t)-PAGE_OFFSET);
+	mem_size = min(end - mem_start, (phys_addr_t)-PAGE_OFFSET);
 	if (mem_start + mem_size < end)
 		memblock_remove(mem_start + mem_size,
 				end - mem_start - mem_size);
-- 
2.24.0

