Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF66299305
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786656AbgJZQzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:55:08 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37930 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786650AbgJZQzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:55:08 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09QGsiYp013043;
        Mon, 26 Oct 2020 11:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603731284;
        bh=lI1+t9kOFNtGhtBm80EWQM6FulLisnAeQk+fkW7PgBY=;
        h=From:To:CC:Subject:Date;
        b=jnmpF6o/CmuTi9W2w+KauHS2vLgrxasO7v9Iw7eHaDRH1dkVECzGdwiLnZWihpaDf
         v3DfJ/UEWhy7uqmAbUJKbB/3bSdhaeDxz3P9Az3zxy41YHyvWZ53xgpnK2O2MZzsou
         vewTpHzbAMuykc2438SyP9z2bwLjZXdmEUjqTllg=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09QGsi6l081232
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Oct 2020 11:54:44 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 26
 Oct 2020 11:54:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 26 Oct 2020 11:54:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09QGsi3E088555;
        Mon, 26 Oct 2020 11:54:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Swapnil Jakhade <sjakhade@cadence.com>, Jyri Sarha <jsarha@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <a.hajda@samsung.com>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>, <ssantosh@kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] drm: bridge: cdns: Kconfig: Switch over dependency to ARCH_K3
Date:   Mon, 26 Oct 2020 11:54:41 -0500
Message-ID: <20201026165441.22894-1-nm@ti.com>
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
places for v5.10-rc1. Fix the missing user so that we can clean up the
configs in v5.11.

[1] drivers/soc/ti/k3-socinfo.c commit 907a2b7e2fc7 ("soc: ti: add k3 platforms chipid module driver")
[2] https://lore.kernel.org/linux-arm-kernel/20200908112534.t5bgrjf7y3a6l2ss@akan/

Fixes: afba7e6c5fc1 ("rm: bridge: cdns-mhdp8546: Add TI J721E wrapper")
Cc: Swapnil Jakhade <sjakhade@cadence.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Yuti Amonkar <yamonkar@cadence.com>
Cc: Jyri Sarha <jsarha@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/gpu/drm/bridge/cadence/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/Kconfig b/drivers/gpu/drm/bridge/cadence/Kconfig
index 511d67b16d14..ef8c230e0f62 100644
--- a/drivers/gpu/drm/bridge/cadence/Kconfig
+++ b/drivers/gpu/drm/bridge/cadence/Kconfig
@@ -13,7 +13,7 @@ config DRM_CDNS_MHDP8546
 if DRM_CDNS_MHDP8546
 
 config DRM_CDNS_MHDP8546_J721E
-	depends on ARCH_K3_J721E_SOC || COMPILE_TEST
+	depends on ARCH_K3 || COMPILE_TEST
 	bool "J721E Cadence DPI/DP wrapper support"
 	default y
 	help
-- 
2.28.0

