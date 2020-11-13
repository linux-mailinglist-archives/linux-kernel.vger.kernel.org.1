Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3402B2559
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgKMU0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:26:15 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43164 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgKMU0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605299172; x=1636835172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hd8ZmjId7vBbXQM1jz5+4Nu+51CF6i4iXNW7aRPTEWM=;
  b=bYwcoU45jrhbeRGPekZ+XGAnvlSlE0pgjh7kHzhrbsJjxNi9H6Qna6Ap
   gtwb5YzTIsWX9B6LZzTPyqwl/PmvNqwwBStgbPqHWFLzhHvBn8rAjHJKt
   sO8W+5kBPTFsGM4yDMxdK9WE1EbB02eL8viNdpp1Wj74QlbcAArLlds2C
   A69Dw/4NcVgryAzpChMc2h+nLGCy9vZ8lKiSkQipC/8jFnWKEYjJu0imW
   oFnIO9G9cSihFbqsQYxxqX9RYvBXDmiI0FbNIXloGQ/7N14jBy5lsv4kL
   bWjEsjt+YkAXZ3K0GbjJiRYeNZ9cG2KZuoplVmDCiUmjuhvixoq/uqk3T
   w==;
IronPort-SDR: lvJHC9zhzSwrgLuTMFY7DsY1uccx762ufAq08ibtL6bXhvC2z+mVXooRMVE36a1bhvihBwnY+y
 tokG4zX0KQ7eVAYFMOxeC3K1E0vB3MJVRvszXcVjTFs9JR1R2cwnk2/cB3LzP2Xzc3XTcxkV6E
 Sd4QOOf1xQ0GNmVzim2X81K/8/X1hsoiwdlbTTdZ3HLJZmoxvLAvt0kl3c3dqYzDXXzTmXau8U
 R94jE10CCsvpltSsXTzzqvE2/IG5jVMi1WBBDdApb0tIXIcKkNyhF+pqKn+WBmuA//Ob7ewm0e
 UQs=
X-IronPort-AV: E=Sophos;i="5.77,476,1596470400"; 
   d="scan'208";a="157074938"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2020 04:26:12 +0800
IronPort-SDR: tWTmT45VzwyT/IdC5C5cqYPIuFAuI1eL7BBJHW68qTeBoJSmLmCfPS1IWwsIiIHaFVNxkwbVXP
 LHPujjmOiBzLpNzuaOERTu3Xsv9f/A90qA4OzatYfvNGkzKPqCsB/MVepyFHButkl9A/R1zj2F
 hKw0lW6+2YlsJZpxGj0wYcDO0/tYx+IpQ6T5axb//3ZQNJDgGfKGjfEpLpDfzppOkqwolUZCiW
 z88Ka18ncUZ/WyAJ9oxjWjPp/9UA7HVlRQGSOA6UiAe5zHCLfTpaz1kE2qZ+0bdJPHyn/WvqUo
 NhGyFZwiBONlWovQmcS+mgz9
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 12:12:09 -0800
IronPort-SDR: GudsojcbCJuJ151ef4pw2kB59L4vcuQhce5JpZv1kOCLeSlZOY3DxuQWl8sRQSNPEaiP4Y58V9
 ctH2csmrRUyzpU9vVIEmxl5jWe2cWVSzwMRr/OwmrSXGj2vofyzy6bpP6ZKU5/lkXkagF+2YFj
 pqQVV3+lXQjixM/jYZ7gfbiNN5q2GcqBoAwA+bEMOgOYI7gq1I7SpXX5y5WNy10K3B19Bh2AL4
 phSt7zYMHfqjeki68OTkkS34HdI1XX+L4lubt1W88yRRncydlw+azuCOF0smVTvmKs9Wz0SzDb
 Dbw=
WDCIronportException: Internal
Received: from usa003372.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.22])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Nov 2020 12:26:12 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Anup Patel <anup@brainfault.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril.Jean@microchip.com, Ivan.Griffin@microchip.com,
        Conor.Dooley@microchip.com
Subject: [RFC PATCH v2 1/4] RISC-V: Add Microchip PolarFire SoC kconfig option
Date:   Fri, 13 Nov 2020 12:25:47 -0800
Message-Id: <20201113202550.3693323-2-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113202550.3693323-1-atish.patra@wdc.com>
References: <20201113202550.3693323-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Microchip PolarFire kconfig option which selects SoC specific
and common drivers that is required for this SoC.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Bin Meng <bin.meng@windriver.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/Kconfig.socs | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index 8a55f6156661..148ab095966b 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -1,5 +1,12 @@
 menu "SoC selection"
 
+config SOC_MICROCHIP_POLARFIRE
+	bool "Microchip PolarFire SoCs"
+	select MCHP_CLK_PFSOC
+	select SIFIVE_PLIC
+	help
+	  This enables support for Microchip PolarFire SoC platforms.
+
 config SOC_SIFIVE
 	bool "SiFive SoCs"
 	select SERIAL_SIFIVE if TTY
-- 
2.25.1

