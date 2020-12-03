Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092F12CE1F3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgLCWjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:39:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731901AbgLCWjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:39:22 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jacopo Mondi <jacopo@jmondi.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: bcm2835: fix vchiq_mmal dependencies
Date:   Thu,  3 Dec 2020 23:38:30 +0100
Message-Id: <20201203223836.1362313-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When the MMAL code is built-in but the vchiq core config is
set to =m, the mmal code never gets built, which in turn can
lead to link errors:

ERROR: modpost: "vchiq_mmal_port_set_format" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
ERROR: modpost: "vchiq_mmal_port_disable" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
ERROR: modpost: "vchiq_mmal_port_parameter_set" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
ERROR: modpost: "vchiq_mmal_component_finalise" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
ERROR: modpost: "vchiq_mmal_port_connect_tunnel" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
ERROR: modpost: "vchiq_mmal_component_enable" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
ERROR: modpost: "vchiq_mmal_finalise" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
ERROR: modpost: "vchiq_mmal_component_init" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
ERROR: modpost: "vchiq_mmal_component_disable" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
ERROR: modpost: "mmal_vchi_buffer_init" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
ERROR: modpost: "vchiq_mmal_port_enable" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
ERROR: modpost: "vchiq_mmal_version" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
ERROR: modpost: "vchiq_mmal_submit_buffer" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
ERROR: modpost: "vchiq_mmal_init" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
ERROR: modpost: "mmal_vchi_buffer_cleanup" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
ERROR: modpost: "vchiq_mmal_port_parameter_get" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!

Change the Kconfig to depend on BCM2835_VCHIQ like the other drivers,
and remove the now redundant dependencies.

Fixes: b18ee53ad297 ("staging: bcm2835: Break MMAL support out from camera")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/vc04_services/vchiq-mmal/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/Kconfig b/drivers/staging/vc04_services/vchiq-mmal/Kconfig
index 500c0d12e4ff..c99525a0bb45 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/Kconfig
+++ b/drivers/staging/vc04_services/vchiq-mmal/Kconfig
@@ -1,6 +1,6 @@
 config BCM2835_VCHIQ_MMAL
 	tristate "BCM2835 MMAL VCHIQ service"
-	depends on (ARCH_BCM2835 || COMPILE_TEST)
+	depends on BCM2835_VCHIQ
 	help
 	  Enables the MMAL API over VCHIQ interface as used for the
 	  majority of the multimedia services on VideoCore.
-- 
2.27.0

