Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCCB1E40D4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 13:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbgE0Lzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 07:55:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:41754 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387997AbgE0LzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:55:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EDA56AFB1;
        Wed, 27 May 2020 11:55:02 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 47/50] staging: vchiq: Move conditional barrier definition into vchiq_core.h
Date:   Wed, 27 May 2020 13:53:52 +0200
Message-Id: <20200527115400.31391-48-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The barrier is only used by core code. So keep the barrier definition in
the core header.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchiq_arm/vchiq.h        | 11 -----------
 .../vc04_services/interface/vchiq_arm/vchiq_core.h   | 12 ++++++++++++
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
index 211b20705e36..57fe7d5e9a85 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
@@ -6,15 +6,4 @@
 
 #include "vchiq_if.h"
 
-/* Do this so that we can test-build the code on non-rpi systems */
-#if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
-
-#else
-
-#ifndef dsb
-#define dsb(a)
-#endif
-
-#endif	/* IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE) */
-
 #endif
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index ff91c04ba6b9..15e9867f78f4 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -15,6 +15,18 @@
 
 #include "vchiq.h"
 
+/* Do this so that we can test-build the code on non-rpi systems */
+#if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
+
+#else
+
+#ifndef dsb
+#define dsb(a)
+#endif
+
+#endif	/* IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE) */
+
+
 /* Run time control of log level, based on KERN_XXX level. */
 #define VCHIQ_LOG_DEFAULT  4
 #define VCHIQ_LOG_ERROR    3
-- 
2.26.2

