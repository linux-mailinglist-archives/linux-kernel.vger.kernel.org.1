Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8857C280769
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 21:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbgJATFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 15:05:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19126 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgJATFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 15:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601579104; x=1633115104;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mvG+0a31TUnr2CleZRBwC1uO2SIRLdp7lGvzolLznks=;
  b=FxFJb639QLF3QB4JTV2szdyYzGOqSrCn+hiHw5gtBobyZPhNQ1BKd4kC
   U2TlCOH5sMd4Zx6PNEWOsMAIafZSe7itcwPXCGA4UCtuyvlb+vRCxTR9w
   lZ2c7vIUB3d3h8UXouj3JxtMbEbJXi45sRFbno6TyWG+6QqAiERGwHoEJ
   tH0piOUeauJ0cjavXHJNYyctzx5g4Drk1L12WYzVIEy64w0+jPIeB8hLO
   e0tg08b/raSiI469w37WIVntMaS7ObzrkebPBapQqqbuujfZZNSyRjSWR
   SO9wMDGI5CWsw023BawUnvGlEWwPfsOIpW6r8vLPXEEy+xmNsoB1JlLIV
   g==;
IronPort-SDR: gyxO8q3bJDi884dH2Imn0LAU6rjUzcCFxCDbNI4vgF7w3bc7abg44hcjRii6lZ256aHBsybIfB
 sfDFDe3zVRe0VZEa2V8yK1xXtfgMysUga0UiGKwAFbe/CLiuuwvs1X/e0v07sz7WzHiJgC9/dC
 f8EC7HsSAD5SFKuLX8ujjhd8FyVJJ6ZtDVcHyZF/9GT5611VRqIT4iDIYqmlv5N8768jFvcO97
 XQXSAoD2Zqlmp7PQfH38Pf1IGEsSvwlrCPZck+jqG1sEGJvqbZK+JaCTNx7ixCGgqWlxQMSiLk
 MtY=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; 
   d="scan'208";a="148739896"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 03:05:03 +0800
IronPort-SDR: /TUkh5ki1yOrS71KUVH61J2Pu+ExxSEap7IuwFfpE8Yvncn0rELnOFTEWDttKLen6vJVko4ItS
 b8CEBJcIdR9g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 11:51:00 -0700
IronPort-SDR: ANr0iEXCHrjkkstTEh+kleISfOPOrgEc0i+HKg80Rgg/9bBuEMNWDj59/ju9D1TYggD0hpBPNn
 st5KEKQTthnQ==
WDCIronportException: Internal
Received: from 30tyk72.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.249])
  by uls-op-cesaip02.wdc.com with ESMTP; 01 Oct 2020 12:05:03 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] RISC-V: Make sure memblock reserves the memory containing DT
Date:   Thu,  1 Oct 2020 12:04:56 -0700
Message-Id: <20201001190456.2860155-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the memory containing DT is not reserved. Thus, that region
of memory can be reallocated or reused for other purposes. This may result
in  corrupted DT for nommu virt board in Qemu. We may not face any issue
in kendryte as DT is embedded in the kernel image for that.

Fixes: 6bd33e1ece52 ("riscv: add nommu support")
Signed-off-by: Atish Patra <atish.patra@wdc.com>

---
@Palmer This patch is applicable for v5.9 & before. This fix is already
part of the "RISC-V: Move DT mapping outof fixmap" patch from UEFI support
series. That's why, this patch doesn't need to go into for-next.
---
 arch/riscv/mm/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 564e0be677b7..cabf1697e748 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -510,6 +510,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #else
 	dtb_early_va = (void *)dtb_pa;
 #endif
+	dtb_early_pa = dtb_pa;
 }
 
 static inline void setup_vm_final(void)
-- 
2.25.1

