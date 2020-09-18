Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F379726F4BC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIRDdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:33:21 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:16874 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIRDdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600400001; x=1631936001;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GJp5n8jVa0gSejTEvB+IYZIdJiYFQosoJaDX7d0g+9M=;
  b=VurZkonFNRXhLjY4DuCSEXTS5gkkjxTu05NdYNZVtDSA2/gNW4tXQdXG
   wobzWHPFtPs13XO331n6Xv6ohSg/RBBmrO28jB8DCILizeO/VhpDy1+ju
   Wg38WuSo/g0ZmYF83cepub282tW2oBy4//TBDyhLmR03W8vtBaqlPvZmc
   0=;
X-IronPort-AV: E=Sophos;i="5.77,273,1596499200"; 
   d="scan'208";a="75965978"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 18 Sep 2020 03:33:18 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 7BBCCA242C;
        Fri, 18 Sep 2020 03:33:15 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 18 Sep 2020 03:33:14 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13d01UWA002.ant.amazon.com (10.43.160.74) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 18 Sep 2020 03:33:14 +0000
Received: from dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (172.19.34.216)
 by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 18 Sep 2020 03:33:13 +0000
Received: by dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (Postfix, from userid 800212)
        id 55B562C0; Fri, 18 Sep 2020 03:33:12 +0000 (UTC)
Date:   Fri, 18 Sep 2020 03:33:12 +0000
From:   Clint Sbisa <csbisa@amazon.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Clint Sbisa <csbisa@amazon.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200918033312.ddfpibgfylfjpex2@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change exposes write-combine mappings under sysfs for
prefetchable PCI resources on arm64.

Originally, the usage of "write combine" here was driven by the x86
definition of write combine. This definition is specific to x86 and
does not generalize to other architectures. However, the usage of WC
has mutated to "write combine" semantics, which is implemented
differently on each arch.

Generally, prefetchable BARs are accepted to allow speculative
accesses, write combining, and re-ordering-- from the PCI perspective,
this means there are no read side effects. (This contradicts the PCI
spec which allows prefetchable BARs to have read side effects, but
this definition is ill-advised as it is impossible to meet.) On x86,
prefetchable BARs are mapped as WC as originally defined (with some
conditionals on arch features). On arm64, WC is taken to mean normal
non-cacheable memory.

In practice, write combine semantics are used to minimize write
operations. A common usage of this is minimizing PCI TLPs which can
significantly improve performance with PCI devices. In order to
provide the same benefits to userspace, we need to allow userspace to
map prefetchable BARs with write combine semantics. The resourceX_wc
mapping is used today by userspace programs and libraries.

While this model is flawed as "write combine" is very ill-defined, it
is already used by multiple non-x86 archs to expose write combine
semantics to user space. We enable this on arm64 to give userspace on
arm64 an equivalent mechanism for utilizing write combining with PCI
devices.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Clint Sbisa <csbisa@amazon.com>
---
Changes in v2:
  - Rewrote the commit message.

 arch/arm64/include/asm/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index 70b323cf8300..b33ca260e3c9 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -17,6 +17,7 @@
 #define pcibios_assign_all_busses() \
 	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
 
+#define arch_can_pci_mmap_wc() 1
 #define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
 
 extern int isa_dma_bridge_buggy;
-- 
2.23.3

