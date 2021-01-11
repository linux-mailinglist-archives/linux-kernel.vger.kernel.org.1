Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 858712F24B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405102AbhALAZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:11 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38128 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404202AbhAKXrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610408866; x=1641944866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RNOH9gvngKv4PYnI6ojB0jPRmrRFh5gcDLRyBhBMMTY=;
  b=aG+ZtzcxGJWb4/wxsxWxRo/r7+3Kk0ZLkiLI8fu4ea6inXmDfV734qMf
   UwfIujwTPN+f1ts89P71J/h8lU8pkRHn5rW8RK2k8ASO9bWuO/iHlDkE0
   qKaSH+SZQFy1Wv2rsiZ2s+5vCmqNku0rdaFuJYNXlUnwYUOXmQqsnpN5H
   vENqDK2Tl61o2x24hc3QBwJ75pIhgAridI0g5iIjJaNjFh8ensHHx99wX
   1N3/UV3iTOOtWQMm8cT4zqhM4oFUnJPXUuOrojme6cNneV67evtn7TirP
   F+JSidZk8gF2rJeFJmhQfmKTikdWtz/6iXvXGR4QvOMd1jY4rNn7cdxy1
   A==;
IronPort-SDR: LDkUGUBTF4a4TiSqoOcuKLRzfDA4hbDMa/2VGEQ1Wi084cf4/O0BvZPubd6XvnMXFThb3dPSzj
 cZVns5ouu6jruLDpmp8LKfoZ0IHrKtiffEWVdPoq40pn6kuxESML34T4YBuo7TYxCl4SijcqLT
 dF5509AF8Ubep8Xh0cneoz6njoUmmLgjfw5BwroaNtusL7hNrjU2NGU0shLOj6Fqpj6xSzRmU4
 +aJNjrtdXYUDxNjiH2bb+f/2zsDmwdlKwUvXp3hKCDcdd+AmyfBFADozt1PyTi/GY0B/KEmksl
 BvU=
X-IronPort-AV: E=Sophos;i="5.79,339,1602518400"; 
   d="scan'208";a="157190574"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 07:45:20 +0800
IronPort-SDR: sXwnDcOuGrFG9GUL8mJsccslnNUXPZVBetQ4J/AY8sRBLvyGLoRBGfly7Y2xlDn2AX69xNUZXK
 PUHWZe3017Eo1iQKJSVp2gehr0bpFARE0aSpqYgK3wAamYu3FgShiCYHw8eGZOkf9dVuoSoqhH
 ZIx8iESRu3LHrotoCg9YM2QaKsjgPPs2a39IbdAwXIxSfAmTMks5vAkuJnqjEVV7NVjhOLsIUO
 eXu/FAYcv0YGzSZrh5CkVreinVARAIzRnllfmggmY9b2cCrBe42LMmjBfjJxV+4tKCPwwhhFVi
 Gbbx7KbRqZdlw1X2S3hYLlA1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 15:28:14 -0800
IronPort-SDR: S4/lzpttx6/ZOnuXtMd2AXORHB8tLqvAqVfTYA8r+mdnyUCj7ItefrtrKECOgJE02m8nayn5A6
 CoVXlHknaU3TfcNc2Uwee8WCnSvWmEpd5tkfUQ3TEA+uIGX6197ACGDOBZkKGdI39K4Oi/0Por
 UgnAQY6aaf9JjD83vanUpc2jsIUtaElnPKvWUN8WujGXNRDtUUybiUa/b42T7LSb5TPIn/VFEZ
 /kqrRJVFAxSyq60AiEaVu8jxdvKhccWAJDDroZZMKRxusckMqvhm0DW29VLl65CpImj5UVpZ5t
 +rE=
WDCIronportException: Internal
Received: from usa002483.ad.shared (HELO jedi-01.hgst.com) ([10.86.62.194])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 15:45:20 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2 3/4] RISC-V: Fix L1_CACHE_BYTES for RV32
Date:   Mon, 11 Jan 2021 15:45:03 -0800
Message-Id: <20210111234504.3782179-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111234504.3782179-1-atish.patra@wdc.com>
References: <20210111234504.3782179-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMP_CACHE_BYTES/L1_CACHE_BYTES should be defined as 32 instead of
64 for RV32. Otherwise, there will be hole of 32 bytes with each memblock
allocation if it is requested to be aligned with SMP_CACHE_BYTES.

Reviewed-by: Anup Patel <anup@brainfault.org>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
(on vexriscv)
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/cache.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
index 9b58b104559e..c9c669ea2fe6 100644
--- a/arch/riscv/include/asm/cache.h
+++ b/arch/riscv/include/asm/cache.h
@@ -7,7 +7,11 @@
 #ifndef _ASM_RISCV_CACHE_H
 #define _ASM_RISCV_CACHE_H
 
+#ifdef CONFIG_64BIT
 #define L1_CACHE_SHIFT		6
+#else
+#define L1_CACHE_SHIFT		5
+#endif
 
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
-- 
2.25.1

