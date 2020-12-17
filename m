Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016DD2DCD11
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 08:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgLQHuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 02:50:14 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:36707 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbgLQHuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 02:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608192296; x=1639728296;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NTgNlYcb4X8fG4aPZr+pa6LHmqpavF30sDdmLy52hbs=;
  b=R8dV6WAen7xRJOi6SCV6vQjrfc4746XfKpvXvfEPSQA/p0P9yd1QW16L
   hHAlUug2WpYC0pdwfqAFk5GwWArvDOU9FEBCvOHs45c7BOD22sLlXmfaE
   NVqMFNt6g9zgNZsfpR/SpyYgef/JGoUuOLF2p4tpyIZAaF5wV5rVuZyDK
   wagLZywkhgdcc6AdN/JjMsCTGAdGH9sdoyDDbMmVPwgpqTqXrcWb7VXNd
   cgAM6J9rAi5sCra98bj/JPgdZXg41+QxeLh8omVPUFBPWEqWZpDz2u7eg
   agFRmWyw3EZmGoEzP9Bg+mUKWJRh/SyfZLTxf+8UZPA8TL2Je8IicNTxl
   w==;
IronPort-SDR: 1WUCqLYQVxAg8m70SqWWbbh9jz6JUHEJaaHGFZ6tPlsaK+y6cUgpF7ZqFD59fGFDXSxvfxT7Q2
 uS9w6wTcWTfl0adKTxwUp58NfE/qHOnTSQmkb8sjIrJkik78F0vbAO/oQCmgiHkFo4mh0hXIk0
 UjBfYB/+XqgTytZ1LYAJk3umxPlDoUe8xSiIjnawErZzyDQDPgHEDwWa4snlrmfJyb0xcB5Ljj
 cyI60+VZ1SgpilneO4fCtH5Che8Poqt0a4C6IEr+vZyNHu1FCihcECxFCMVbBGRuSYE/CbYJLY
 S0Y=
X-IronPort-AV: E=Sophos;i="5.78,426,1599494400"; 
   d="scan'208";a="259133053"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2020 16:03:17 +0800
IronPort-SDR: KusFkVtUrBeOkbQCfGsuK65tNZZq9PYt8qjy5/1g7bJkYDdcuYvwqe/OZEgD0Bg+/GnGwdLtey
 Tp/nbrcvPTf5c7YgqlbIH7hcMulBKObA2I1dAwTTroqVMvsjkBKMItv3H6NRVO0rife8KQ1nfN
 E/vkgvHP43myN2Dw8loM9efu38htFr/6WhvQ87TN8O2RMbFTgPodWssdwMeej7c7XYVZUwC4xC
 J8WQpTwZTBTcA+A2iQFBTQLoFoMaC/4f7qayPk4sWiPD9qTdrQG5UWT6MmXRzYrshch7ZgmfcZ
 ZpUUbYbNzpFFqf2agw//sZj9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 23:34:24 -0800
IronPort-SDR: h8HJiAirRgl6kkJenUcBB/tbrwZLlJ5vg/aqhDFN15CCUoqRbnRFkm9gi5bzLwQWTJ/qpRSNUF
 KZer3wH1ESeR6r986rC/fTXlCT7pxY3xd8zvwoNpEF9py0y74YyBkS9i9Q3RVgnwOq9lcek1mv
 OGIe/2QaA/xYqQtxCw+ZrKcd7hSjthbiEiICCznwS84SAFnfwCFK3vamSD1hZsaFD+ZRUnVdAI
 nDaJElXmFxgD1DEj+s8ki4h7w0Hnh+p6UT0A4dc2p6tenQmdZB0IM3EwhIkrGBKUQeKH4TP0HT
 tnY=
WDCIronportException: Internal
Received: from kelly-s-lt.ad.shared (HELO jedi-01.hgst.com) ([10.86.62.43])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Dec 2020 23:49:07 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH] RISC-V: Fix usage of memblock_enforce_memory_limit
Date:   Wed, 16 Dec 2020 23:48:55 -0800
Message-Id: <20201217074855.1948743-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memblock_enforce_memory_limit accepts the maximum memory size not the last
address. Fix the function invocation correctly.

Fixes: 1bd14a66ee52 ("RISC-V: Remove any memblock representing unusable memory area")

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 8e577f14f120..e4133c20744c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -174,7 +174,7 @@ void __init setup_bootmem(void)
 	 * Make sure that any memory beyond mem_start + (-PAGE_OFFSET) is removed
 	 * as it is unusable by kernel.
 	 */
-	memblock_enforce_memory_limit(mem_start - PAGE_OFFSET);
+	memblock_enforce_memory_limit(-PAGE_OFFSET);
 
 	/* Reserve from the start of the kernel to the end of the kernel */
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
-- 
2.25.1

