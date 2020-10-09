Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE5E289A79
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 23:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391372AbgJIVN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 17:13:59 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50437 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388641AbgJIVNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 17:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602278540; x=1633814540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uLCpsvC/inR65HE35KjykwBVwDdqIbHHxLVflczTr2Y=;
  b=gAuQV2QeFJPSYU+xb7Zv7PcKJlsNEx6ZUHcoRRsQijQYjgY1LdMp0ggc
   0lWBf8zwEeLXSRr83CHP3UH4OsKPYXrzNEWIU8acdtfMuSVY5QJwNbbj2
   ejj3zswe674antiBffUsA/Cx+qffZpgV/PD5c0NxRMh+ITcmI3r8KDVH+
   z3qjifw0gJfrWArRVH/tskGVYsABXDI3WXNUvTddwAjPxMluMKNeyJA/T
   U1/Hwi4Zi62B+uKP7z+/gPVl0BtN59tlRrerMNEVrlA3fS5e2or+B1kZQ
   O2271rwhdykUpIJezxZBhhDDErGqvYPvVTtlUMY2o6CiriEu2MaYZ5oJm
   A==;
IronPort-SDR: 2jTULRqrLt75s7R9QWiBxH9KryrBoPYyFzEFV2C/SBH39SHg96lxYm81TlNVWlVePygP+0ComR
 7wN2LwfR8+jxSd2dVUsoJODU1NeybocyOc0XpRYbUcm/Xa/Flj7XDWpkbzojxj6+mS2qI9n4jn
 a/OtxcvbpdcMqjlYOQtMAlS0qyb4aTEILuKUMa4yghroDDU/mVJ+NlbcI8RQd4N7grR8EKvJyv
 H08CmX+eRW72rwSyE8TbkygVIN1g08INQSS2qLWi/cfX6Pi3ChSJ3PjKXTbX+ZTFUw7scVnu8M
 xHA=
X-IronPort-AV: E=Sophos;i="5.77,356,1596470400"; 
   d="scan'208";a="252936932"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2020 05:22:20 +0800
IronPort-SDR: CiFH05tBtND0QWKQeZMmvomLN4pxVWiaUa7cObTJRBeYmmdUSL3lvzBqcRRdMfz8c+XBmxbDKr
 RSVMg+v49eVxwJpQHb/xXBhTmxV5oeT0eefbyzIOT9OJu9bEvWqNjPeRlGAtBz9IqL0oIUShl8
 tRyeT8ToVSZPs+2+opTeAK013LWaZCmMmU3Iy4G5IP5Rmj4RRIBeGary4TrtFiX808dAkjFsmW
 Csey8P/JZEvjywqQtDWohvpukB+zcGw+mojGnosE8n2bU0TE3EmNgAlFdm06r2KOqEKIt8Xrg4
 ts25VoIBcalsyWyaerd6VfRk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 13:59:41 -0700
IronPort-SDR: k7VpveUvGC2efjb8TPkb5b963i4tk0vSeShUCYhda4iG2UWjLq+U326k8Xt4PhRxdYNxbiKZlQ
 /mBkP0UVKgvqGOVYokqviIhHplcWANZ7EsinNEySw51Yn+4Ac5jV/YeNq+Zufdes7yw8VE/Zx+
 vE/MtSu5voyQ5Ycv8mdj3yTD9Q/Sd517jWj4nIxipZ5wPzDivks1gcSZ2ikOthVbWJtplBy+nP
 WQGaAG1aXjZw+VDCaMbqVrqB4Ix9O92YzSxBPXVdJsavTS4J0IZBC6pd/olzUvJb5ymWMbgd6V
 Rrg=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Oct 2020 14:13:53 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org,
        Michel Lespinasse <walken@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH 2/5] RISC-V: Initialize SBI early
Date:   Fri,  9 Oct 2020 14:13:41 -0700
Message-Id: <20201009211344.2358688-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201009211344.2358688-1-atish.patra@wdc.com>
References: <20201009211344.2358688-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, SBI is initialized towards the end of arch setup. This prevents
the set memory operations to be invoked earlier as it requires a full tlb
flush.

Initialize SBI as early as possible.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/setup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 1db17f37736e..a5cac440aadf 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -90,6 +90,9 @@ void __init setup_arch(char **cmdline_p)
 		pr_err("No DTB found in kernel mappings\n");
 #endif
 
+#if IS_ENABLED(CONFIG_RISCV_SBI)
+	sbi_init();
+#endif
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
 #endif
@@ -98,10 +101,6 @@ void __init setup_arch(char **cmdline_p)
 	kasan_init();
 #endif
 
-#if IS_ENABLED(CONFIG_RISCV_SBI)
-	sbi_init();
-#endif
-
 #ifdef CONFIG_SMP
 	setup_smp();
 #endif
-- 
2.25.1

