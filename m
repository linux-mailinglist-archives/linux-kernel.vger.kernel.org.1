Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF272ECCCE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbhAGJ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:29:42 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33386 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbhAGJ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:29:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610011780; x=1641547780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M5vIqNGUKsHMdFcPSrix1DQ77zV4rtwvAiAcgNpAPDw=;
  b=bSKAnnFyTEHEouJimTssWFKa4mIwXVocjyJethmOQbUeYMaUtyLLwHyb
   hJPiiiK0NVWHzYVIazX9DHs6Ip1SY7t4wt49jE4LMLbrGpgP8g1hmJljf
   H59HZbVDdB6md8iADUsOE6pyCfMUemIz4CKrM9PkGOetDmTuTDVwc6hNu
   YxN6o16xSOx/RGqg9timzVkv3exFRLQRdKoeQONZpBqoe696RM/a/j9Ht
   wZX0p59iPXPw/45sX2Phg+5HlxfosX6jiZcL6wSybPKOGJHU7PtDwpuFs
   hjCbfgWxypTIf+U48aAvPjMezh4FMdH8zh8o+KMkoYMScq/pNwKUkCU/5
   A==;
IronPort-SDR: OFJCtcfdiuE3W7WDdkTWe3zO/e4sehRrtYgI1VK/8b9jMBhwTKR4IvLIp754B2mQ6Tqi8S+6Z8
 EuVFgxCFkzrj+Gl9E8ERvynf5e6Ou9HorYZR8aVKUb4XwK81YG9K4fhrog8C8Qw1oN1L3xp9kK
 0WgXIP2QzXcQgHgOET7IKtP7Fx1iHvCngFUNHHSbuie4/Sb43CsKA0FvVdszvocm3gDmnGvtut
 R3iSImXrmHkCjZtv19q8PTLsQMGN08LiWs9UFSEzmkYLSgnbgmmWV1TNL/MNc0izPEBJdKD1nc
 ZzU=
X-IronPort-AV: E=Sophos;i="5.79,329,1602518400"; 
   d="scan'208";a="156695569"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2021 17:27:30 +0800
IronPort-SDR: XZ5F1jC7nvFM6ZuTaPr+WJg61NrpK4vPeWLAoPDD+Hx8KTObv1OIpO92NLA6OHh6ad7T2SlgVV
 UDo1ON301GHJQNkRjyWlMBRSJaFomSV9JuJmvqLC6HAzFf3MfDRYZkjoLI2YxbTSR8me4a/mzw
 3mMUb6Exl2In9LkIIZjyWRYz6YDnJwNc/avct/kRtY/V+fS3L12r64n1tWTeUhcRVfDSIVuQMP
 /dWwwcXAEgRdtVvEmzSh+ETovzG8PEhMK23tIz+0b7HpwUOSwiCvRCUWWQ+FmZuN11e6jt5xlg
 E2qK/Wx7X4V73wsJ8ZLpTlhf
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 01:12:21 -0800
IronPort-SDR: zSv8gBFiIWRny6FjEV8Yh1InJHxQN7lciB7TEACKijT9oMMn4Tl9SSMq5naYBX+V7UCT6WEv2Z
 Z0HeSBhGLtYefyMzDZTigNYRqc24ppYws+x8SVISbFqIGpR2ntO6AHRB9EO/DH5K3UBXbjRkuT
 OoVJlsGpCksgX/BTluFubRa2KIe+HQqnMAa7p0tc9+bYi44CrVIeSwrk9W0umSP8hRnCF0Nbmd
 xpNy9jsRxwfU81LaiCOHwItEbAvCdjq2sd1f8hHe76owjXGvF577atF8HZs5h5i9J0qhY07Jee
 1jw=
WDCIronportException: Internal
Received: from usa002483.ad.shared (HELO jedi-01.hgst.com) ([10.86.62.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jan 2021 01:27:29 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>
Subject: [PATCH 2/4] RISC-V: Set current memblock limit
Date:   Thu,  7 Jan 2021 01:26:50 -0800
Message-Id: <20210107092652.3438696-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107092652.3438696-1-atish.patra@wdc.com>
References: <20210107092652.3438696-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, linux kernel can not use last 4k bytes of addressable space because
IS_ERR_VALUE macro treats those as an error. This will be an issue for RV32
as any memblock allocator potentially allocate chunk of memory from the end
of DRAM (2GB) leading bad address error even though the address was technically
valid.

Fix this issue by limiting the memblock if available memory spans the entire
address space.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/init.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index bf5379135e39..da53902ef0fc 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -157,9 +157,10 @@ static void __init setup_initrd(void)
 void __init setup_bootmem(void)
 {
 	phys_addr_t mem_start = 0;
-	phys_addr_t start, end = 0;
+	phys_addr_t start, dram_end, end = 0;
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
 	phys_addr_t vmlinux_start = __pa_symbol(&_start);
+	phys_addr_t max_mapped_addr = __pa(PHYS_ADDR_MAX);
 	u64 i;
 
 	/* Find the memory region containing the kernel */
@@ -181,7 +182,18 @@ void __init setup_bootmem(void)
 	/* Reserve from the start of the kernel to the end of the kernel */
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
-	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
+	dram_end = memblock_end_of_DRAM();
+
+	/*
+	 * memblock allocator is not aware of the fact that last 4K bytes of
+	 * the addressable memory can not be mapped because of IS_ERR_VALUE
+	 * macro. Make sure that last 4k bytes are not usable by memblock
+	 * if end of dram is equal to maximum addressable memory.
+	 */
+	if (max_mapped_addr == (dram_end - 1))
+		memblock_set_current_limit(max_mapped_addr - 4096);
+
+	max_pfn = PFN_DOWN(dram_end);
 	max_low_pfn = max_pfn;
 	dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));
 	set_max_mapnr(max_low_pfn);
-- 
2.25.1

