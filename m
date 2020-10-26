Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E68C299358
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787175AbgJZRGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:06:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40734 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406381AbgJZRGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:06:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09QH6V8l017926;
        Mon, 26 Oct 2020 12:06:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603731991;
        bh=u2nOf5B4jTgtANv4nynXigj9qU3x+BwKMHlxahpnqe0=;
        h=From:To:CC:Subject:Date;
        b=hPTlX7tXN+GsF81l3Kv+7rjFmvEERzT/hMJf3cMezXJKLL5qkr7ORcp6Js14eztT5
         9IQgRVXeUOQBrYZNSYyDE1+ARAeHpB+NaeQJkEdWZ0edBrLg6bbDKpwQyW1GKejp/0
         aWu2fAm8IpxAOo5Mg38swG28tntxZ+BgH0Mn8TNU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09QH6V1M128404
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Oct 2020 12:06:31 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 26
 Oct 2020 12:06:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 26 Oct 2020 12:06:31 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09QH6Vit112043;
        Mon, 26 Oct 2020 12:06:31 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Jyri Sarha <jsarha@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH] soc: ti: Kconfig: Drop ARM64 SoC specific configs
Date:   Mon, 26 Oct 2020 12:06:24 -0500
Message-ID: <20201026170624.24241-1-nm@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the integration of chip-id detection scheme in kernel[1], there
is no specific need to maintain multitudes of SoC specific config
options, discussed as per [2], we have deprecated the usage in other
places for v5.10-rc1. Drop the configuration for the follow on kernel.

[1] drivers/soc/ti/k3-socinfo.c commit 907a2b7e2fc7 ("soc: ti: add k3 platforms chipid module driver")
[2] https://lore.kernel.org/linux-arm-kernel/20200908112534.t5bgrjf7y3a6l2ss@akan/

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/soc/ti/Kconfig | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index f5b82ffa637b..7e2fb1c16af1 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -1,22 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-# 64-bit ARM SoCs from TI
-if ARM64
-
-if ARCH_K3
-
-config ARCH_K3_AM6_SOC
-	bool "K3 AM6 SoC"
-	help
-	  Enable support for TI's AM6 SoC Family support
-
-config ARCH_K3_J721E_SOC
-	bool "K3 J721E SoC"
-	help
-	  Enable support for TI's J721E SoC Family support
-
-endif
-
-endif
 
 #
 # TI SOC drivers
-- 
2.28.0

