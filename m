Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DCB2ECCCF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbhAGJ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:29:57 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58328 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbhAGJ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610011795; x=1641547795;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TSpch2pQwg7r6biat5mhz4gut7FJvx8Gohu4p1aa5sE=;
  b=HUMmOuQ1UWLwvNlMWPhNaC92R/o/N8gd0sW1spWAGnaMA5ycM8LdIvyX
   +2vQTz+54gbCOWdsIeEpSJyQGr5V/RQ/0tDnV/ahbykBJmXzzbKBugbtW
   Bug3Cp+ymSEZrdYUEx8ifmZPEH1ec7O5VoNyeZ1EX6TNEdBifuX2AG0vM
   VWqBQPbi+wVoCSIj0Lnz1Lq+kcqEsul0cj3OIdUoSdsy9cjhj/hfOSJNN
   UUctGL0ybQDI7xM4Y1b9sWXwGWoPnq0/0A1FNVBr0rv32F69h2keFdEev
   QB1Y/6hcJSVgdtZNk66Q+L4lDytJrS4fQZRMWZaUYcpIZpPGYqwZWNFK3
   A==;
IronPort-SDR: wVTmpz1G8xIvPo8Uc1ELVKaVY03MfD3jOWnQlpY6wkMwnfQdI/TQzRQt8e0Dj2jxp/iCSSFk0A
 jnYqet0CPdZIlNZGAaYYV2M3cKYgIQzA+7RqGUrxrzDrCn+jkj17U4iADvqjbdPBJiwRBMSaI0
 QzsS7NdwSLrlmaAsFZU77f8MybT2ltb6osrTIGTl9yncXdqb4S/1h1CIN2hZ5revlBbPlvRdEP
 cKr0RFRGxcjP0wdBO+Sd/gULvSZQcT1SOHPvnG6H0s1aObZyNT6K1WD3lw/17u8dyj5cSDWV+b
 PBc=
X-IronPort-AV: E=Sophos;i="5.79,329,1602518400"; 
   d="scan'208";a="156695572"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jan 2021 17:27:30 +0800
IronPort-SDR: yZUioj4nRMR/FXyMm5wI2r+zId6jXtmjtDlwa02GNXhN1GMWQ/GxEuMy7e5n5k2mauwkxkHZ5d
 /BP5th5A4oUURb+QR8loVSfefnGtfg2CPLH/aH9C6V8TcFjAhbI460SvdGc4zKM99pZiiELTWe
 QPnLZzVS5mJqm2eo9Uj456DL3imVczeLKDFs+6TINIq5oFpfl3Tu65G5AW51ARKDtCZeUZBm7A
 jU4oFfov5nj+SMadb7cqoRSAPZulB9hdJTasnecko0iOrFXRer9FYzTz7UaqRmBPUXF/QslIMR
 NqhFcrUtLfNcRdRhZiMRnAHt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 01:12:21 -0800
IronPort-SDR: D/Knafnf+hm5DcoIAHYkKbWfhimscqE4QSGo3S2M2O+n3VUcQpS+4ojoLeHyP8B9OyAF/F4kbQ
 NqBGYWOhSBtmY5WGTSmIozXmNdRdpuGmp2fjHgGC/zxeHCs4eqjjcoRjj5fkgLmihhAvgSkixm
 70hyFaAOj7wxpn1V6vqucV4/KOiocJdfHFEftb5IPo8hyi5epUu5EtdHR1Hm01SklVW9pkC1VR
 IiNTlhmvWDfv0w/GxMhZ+edhT4S/ULvwrHdxmpcgnqWekAauPDEhOr92rxlovhEUM01bOhWSPF
 M4s=
WDCIronportException: Internal
Received: from usa002483.ad.shared (HELO jedi-01.hgst.com) ([10.86.62.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jan 2021 01:27:30 -0800
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
Subject: [PATCH 3/4] RISC-V: Fix L1_CACHE_BYTES for RV32
Date:   Thu,  7 Jan 2021 01:26:51 -0800
Message-Id: <20210107092652.3438696-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210107092652.3438696-1-atish.patra@wdc.com>
References: <20210107092652.3438696-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMP_CACHE_BYTES/L1_CACHE_BYTES should be defined as 32 instead of
64 for RV32. Otherwise, there will be hole of 32 bytes with each memblock
allocation if it is requested to be aligned with SMP_CACHE_BYTES.

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

