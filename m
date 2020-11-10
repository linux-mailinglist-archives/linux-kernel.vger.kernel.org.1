Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7F22AD91B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbgKJOn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbgKJOnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:43:55 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722ADC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:43:55 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id qejs230084C55Sk06ejsuV; Tue, 10 Nov 2020 15:43:54 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcUsB-001CQp-R7; Tue, 10 Nov 2020 15:43:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcUsB-00Dl4E-Dp; Tue, 10 Nov 2020 15:43:51 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
        Edmund Dea <edmund.j.dea@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm: DRM_KMB_DISPLAY should depend on ARCH_KEEMBAY
Date:   Tue, 10 Nov 2020 15:43:50 +0100
Message-Id: <20201110144350.3279147-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel Keem Bay display controller is only present on Intel Keem Bay
SoCs.  Hence add a dependency on ARCH_KEEMBAY, to prevent asking the
user about this driver when configuring a kernel without Intel Keem Bay
platform support.

Note that:
  1. The dependency on ARM is dropped, as Keem Bay SoCs are only
     supported in arm64 kernel builds,
  2. The dependencies on OF and COMMON_CLK can be dropped for
     compile-testing, as the driver builds fine regardless.

Fixes: ed794057b052b52a ("drm/kmb: Build files for KeemBay Display driver")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/kmb/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/kmb/Kconfig b/drivers/gpu/drm/kmb/Kconfig
index 022ef3e3f05635be..3921c57ac511e2fb 100644
--- a/drivers/gpu/drm/kmb/Kconfig
+++ b/drivers/gpu/drm/kmb/Kconfig
@@ -1,7 +1,7 @@
 config DRM_KMB_DISPLAY
 	tristate "INTEL KEEMBAY DISPLAY"
-	depends on DRM && OF && (ARM || ARM64)
-	depends on COMMON_CLK
+	depends on DRM
+	depends on ARCH_KEEMBAY || COMPILE_TEST
 	select DRM_KMS_HELPER
 	select DRM_KMS_CMA_HELPER
 	select DRM_GEM_CMA_HELPER
-- 
2.25.1

