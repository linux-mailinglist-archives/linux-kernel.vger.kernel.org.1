Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334DE2AD90A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgKJOm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbgKJOmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:42:25 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99914C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:42:25 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id qeiP2300k4C55Sk06eiPaJ; Tue, 10 Nov 2020 15:42:24 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcUql-001CQM-Ie; Tue, 10 Nov 2020 15:42:23 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcUqk-00Dkz9-UN; Tue, 10 Nov 2020 15:42:22 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm: DRM_KMB_DISPLAY should select DRM_MIPI_DSI
Date:   Tue, 10 Nov 2020 15:42:19 +0100
Message-Id: <20201110144219.3278831-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_DRM_MIPI_DSI=n:

    aarch64-linux-gnu-ld: drivers/gpu/drm/kmb/kmb_dsi.o: in function `kmb_dsi_host_unregister':
    kmb_dsi.c:(.text+0xa48): undefined reference to `mipi_dsi_host_unregister'
    aarch64-linux-gnu-ld: drivers/gpu/drm/kmb/kmb_dsi.o: in function `kmb_dsi_host_bridge_init':
    kmb_dsi.c:(.text+0xb14): undefined reference to `mipi_dsi_host_register'

Fix this be selecting DRM_MIPI_DSI, like other drivers do.

Fixes: ed794057b052b52a ("drm/kmb: Build files for KeemBay Display driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/kmb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/kmb/Kconfig b/drivers/gpu/drm/kmb/Kconfig
index 2dd7e6848b08943c..022ef3e3f05635be 100644
--- a/drivers/gpu/drm/kmb/Kconfig
+++ b/drivers/gpu/drm/kmb/Kconfig
@@ -5,6 +5,7 @@ config DRM_KMB_DISPLAY
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
+	select DRM_MIPI_DSI
 	help
 	Choose this option if you have Intel's KeemBay SOC which integrates
 	an ARM Cortex A53 CPU with an Intel Movidius VPU.
-- 
2.25.1

