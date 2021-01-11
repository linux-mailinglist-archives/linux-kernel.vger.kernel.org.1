Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353482F24BF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391601AbhALAZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:12 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:47494 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404204AbhAKXsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610408891; x=1641944891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+/8BmP8C7btVepEdnOtx9sho7KAoL9aXx1ciJIHqe4c=;
  b=WxD35NP3WlFmQ3qwhIhSQNmbrHd/uzcy2tmStcBrKNPVPZBHUphyZ98v
   PtTRBqtGPw45QcEukwP3RdDMp8Nye9fKsIpv+dw1uyrfbdH3Y2PdoewMj
   TFetblz5UU0Bq62XmhfZUV/fFMc9L5dHPYAR+3DNypLkbXGToT0u2jjtv
   5IyinS0y49PH0PiNvvcky1mj6T8SQIxYIRto/M4JZwG7ATbzDTR1UnARp
   MLF2ufCJgoLdOGt7yqBMgUsxq7vdXvmrcXlXG+CMIhDdrmaSSXrTJXDHb
   y9GCs6Uj1/PAPTy8dLHFm0pEq7CVrrHZpkmkq9zCMpJ/pQ3qBWsSKdxVd
   Q==;
IronPort-SDR: uXk9FAurF492VsggGknBd/QAeTJ+T+4XyZwpPLIK651np4tpTX3UHbB3l8PGfVFaWAOZIuNo7I
 tZBT6EpwfK4KdzApPSpTY98cfJ9skzF9ibD7h8UpsYjV9VHcXsQZfWLv4hzJKn1QxGbQYNQqhB
 +OGV45jP/90P/PKEXe9HRPkApGIaVmAM0ES0JEEZfH6a49cj+k32VqtnEmP2XQJPZL6QVpKm1o
 6T2u9EgZH0UaLtH9u3PcloL1eh9LJFJxAretpRkL7vSEqjJmetHsotg5fIrXui5t+NTCei4DDN
 e3Y=
X-IronPort-AV: E=Sophos;i="5.79,339,1602518400"; 
   d="scan'208";a="157190577"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 07:45:21 +0800
IronPort-SDR: +bUHhmdSx/ghF1LKWkrUrpgQRqq/ozJcBxn7aVDiixhs0w7kpBgdZ6HCkgwe95frmr3XbgWECx
 Kph8fFlqPSJKnCSO8TiCAqM/h++09vzP3Dpn2WrDczyFW4YDJmLTx0KlV57GBUrF+kcvYjK1oS
 wdFJ1Rv1Z2bbRo+0viePCxuIjPI2dhInFboadOXF1Z1GzU3h36ntSmr8SKJicMmSMSPhSHO/JR
 l0aoWa9g23jEyWzIf7LDF9rQOuL74AAW2ESrLMCxzfumpOnM3bXoG26UKRF85KdmrhqVjvohQO
 M3ac2+By9A3Ctoop1PYaP6yr
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 15:28:15 -0800
IronPort-SDR: zFde0dV1F7ht98QYkLAXJBORMAjs7tHP3IEAYTIWsA4CUz13AiLqT4r5/9B7sGzVCQj6Arl1F+
 BOv2cKIrsO9wh6aJHd+ew9712SjYCDn0RdQBli4/sR3xKuEMybGbGBoNnXV/664RTCo8k/cbjq
 5D3ZdxYmNucNrCFlp7lNQR6mloDBG1f0AsjygumfCSo3sF5hl289xRO2iMVxG4Q2lqSvnxNboa
 YVd7oah5XAGLjlXnEhZl//krMn/kjLrO9ITDtYEn7cQKOTlKylcAgNuWteZ85PO9NI5iFkHLlo
 DrY=
WDCIronportException: Internal
Received: from usa002483.ad.shared (HELO jedi-01.hgst.com) ([10.86.62.194])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Jan 2021 15:45:21 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-riscv@lists.infradead.org, Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v2 4/4] RISC-V: Fix maximum allowed phsyical memory for RV32
Date:   Mon, 11 Jan 2021 15:45:04 -0800
Message-Id: <20210111234504.3782179-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111234504.3782179-1-atish.patra@wdc.com>
References: <20210111234504.3782179-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel can only map 1GB of address space for RV32 as the page offset
is set to 0xC0000000. The current description in the Kconfig is confusing
as it indicates that RV32 can support 2GB of physical memory. That is
simply not true for current kernel. In future, a 2GB split support can be
added to allow 2GB physical address space.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 81b76d44725d..e9e2c1f0a690 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -137,7 +137,7 @@ config PA_BITS
 
 config PAGE_OFFSET
 	hex
-	default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
+	default 0xC0000000 if 32BIT && MAXPHYSMEM_1GB
 	default 0x80000000 if 64BIT && !MMU
 	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
 	default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
@@ -247,10 +247,12 @@ config MODULE_SECTIONS
 
 choice
 	prompt "Maximum Physical Memory"
-	default MAXPHYSMEM_2GB if 32BIT
+	default MAXPHYSMEM_1GB if 32BIT
 	default MAXPHYSMEM_2GB if 64BIT && CMODEL_MEDLOW
 	default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
 
+	config MAXPHYSMEM_1GB
+		bool "1GiB"
 	config MAXPHYSMEM_2GB
 		bool "2GiB"
 	config MAXPHYSMEM_128GB
-- 
2.25.1

