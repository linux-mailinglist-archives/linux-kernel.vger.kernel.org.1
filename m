Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CBF1EEFB6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 05:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgFEDEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 23:04:07 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8071 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFEDEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 23:04:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed9b5c30000>; Thu, 04 Jun 2020 20:02:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Jun 2020 20:04:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Jun 2020 20:04:06 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Jun
 2020 03:04:05 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Jun 2020 03:04:05 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.162.42]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ed9b624000a>; Thu, 04 Jun 2020 20:04:05 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <skomatineni@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH] sdhci: tegra: Add comment for PADCALIB and PAD_CONTROL NVQUIRKS
Date:   Thu, 4 Jun 2020 20:04:00 -0700
Message-ID: <1591326240-28928-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591326148; bh=e6lsRUyXbBY2DH6vBJIzg+ZcZznqgTERIZGcofUkzto=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=LqnMJUj+jbBilQ7EU+mu5q8/upRIMByYnXuUOaNcnxFteeGYdqtuY97E6Gmf/tHOG
         Ul/EbXJZ6TsNFg0rQh9Pa9nMrIz5Tdr78nWoUZXgiNJ8eN7GNK4p8MPmxyI8rOfaNh
         9C+lz+3SHZEwpzx1NKNLB4MOSggjuL+LlrRxc60V6UQu+Q/r1zJLvL0Wxscyc4DB2L
         9KDH7hzy7e0zmskbGr0JPf3AARxH5DqiFv+KlHMFAEM6GfrirMsKFMCNpMPk8qAS3X
         dq9oROKqJjMCIhElRwBLxplePenwpRW755nOINgl9X70GOgn/IsMEIzDk2UWKfpSoB
         0g0ssaK6lVFEA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds comments about NVQUIRKS HAS_PADCALIB and NEEDS_PAD_CONTROL.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 3a372ab..0a3f9d0 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -96,7 +96,16 @@
 #define NVQUIRK_ENABLE_SDR50				BIT(3)
 #define NVQUIRK_ENABLE_SDR104				BIT(4)
 #define NVQUIRK_ENABLE_DDR50				BIT(5)
+/*
+ * HAS_PADCALIB NVQUIRK is for SoC's supporting auto calibration of pads
+ * drive strength.
+ */
 #define NVQUIRK_HAS_PADCALIB				BIT(6)
+/*
+ * NEEDS_PAD_CONTROL NVQUIRK is for SoC's having separate 3V3 and 1V8 pads.
+ * 3V3/1V8 pad selection happens through pinctrl state selection depending
+ * on the signaling mode.
+ */
 #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
 #define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
 #define NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING		BIT(9)
-- 
2.7.4

