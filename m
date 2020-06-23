Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C8B205792
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 18:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbgFWQpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 12:45:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:40324 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733154AbgFWQpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:45:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1EA8DAEBE;
        Tue, 23 Jun 2020 16:45:36 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 50/50] staging: vchiq: Move vchiq.h into include directory
Date:   Tue, 23 Jun 2020 18:42:36 +0200
Message-Id: <20200623164235.29566-51-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623164235.29566-1-nsaenzjulienne@suse.de>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the separation clear between vchiq's header files and vchiq.h,
which is to be used by services and is the 'public' API, move it into a
dedicated includes directory.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/Makefile                        | 2 +-
 drivers/staging/vc04_services/bcm2835-audio/Makefile          | 2 +-
 drivers/staging/vc04_services/bcm2835-audio/bcm2835.h         | 2 +-
 .../vchiq_arm => include/linux/raspberrypi}/vchiq.h           | 0
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.h    | 2 +-
 .../staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h   | 2 +-
 drivers/staging/vc04_services/vchiq-mmal/Makefile             | 1 +
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c         | 4 ++--
 8 files changed, 8 insertions(+), 7 deletions(-)
 rename drivers/staging/vc04_services/{interface/vchiq_arm => include/linux/raspberrypi}/vchiq.h (100%)

diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc04_services/Makefile
index e02a9c2abf77..7546d70116a0 100644
--- a/drivers/staging/vc04_services/Makefile
+++ b/drivers/staging/vc04_services/Makefile
@@ -12,5 +12,5 @@ obj-$(CONFIG_SND_BCM2835)		+= bcm2835-audio/
 obj-$(CONFIG_VIDEO_BCM2835)		+= bcm2835-camera/
 obj-$(CONFIG_BCM2835_VCHIQ_MMAL)	+= vchiq-mmal/
 
-ccflags-y += -D__VCCOREVER__=0x04000000
+ccflags-y += -I $(srctree)/$(src)/include  -D__VCCOREVER__=0x04000000
 
diff --git a/drivers/staging/vc04_services/bcm2835-audio/Makefile b/drivers/staging/vc04_services/bcm2835-audio/Makefile
index 13fa6d7d9745..d59fe4dde615 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/Makefile
+++ b/drivers/staging/vc04_services/bcm2835-audio/Makefile
@@ -2,4 +2,4 @@
 obj-$(CONFIG_SND_BCM2835)	+= snd-bcm2835.o
 snd-bcm2835-objs		:= bcm2835.o bcm2835-ctl.o bcm2835-pcm.o bcm2835-vchiq.o
 
-ccflags-y += -I $(srctree)/$(src)/.. -D__VCCOREVER__=0x04000000
+ccflags-y += -I $(srctree)/$(src)/../include -D__VCCOREVER__=0x04000000
diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index ca220f5230ec..1b36475872d6 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -6,10 +6,10 @@
 
 #include <linux/device.h>
 #include <linux/wait.h>
+#include <linux/raspberrypi/vchiq.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm-indirect.h>
-#include "interface/vchiq_arm/vchiq.h"
 
 #define MAX_SUBSTREAMS   (8)
 #define AVAIL_SUBSTREAMS_MASK  (0xff)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h b/drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
similarity index 100%
rename from drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
rename to drivers/staging/vc04_services/include/linux/raspberrypi/vchiq.h
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 8a27f3d7217e..e67692879249 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -10,10 +10,10 @@
 #include <linux/kref.h>
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
+#include <linux/raspberrypi/vchiq.h>
 
 #include "vchiq_cfg.h"
 
-#include "vchiq.h"
 
 /* Do this so that we can test-build the code on non-rpi systems */
 #if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index f285d754ad28..3653fd99d8a1 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -5,7 +5,7 @@
 #define VCHIQ_IOCTLS_H
 
 #include <linux/ioctl.h>
-#include "vchiq.h"
+#include <linux/raspberrypi/vchiq.h>
 
 #define VCHIQ_IOC_MAGIC 0xc4
 #define VCHIQ_INVALID_HANDLE (~0)
diff --git a/drivers/staging/vc04_services/vchiq-mmal/Makefile b/drivers/staging/vc04_services/vchiq-mmal/Makefile
index f8164c33aec3..b2a830f48acc 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/Makefile
+++ b/drivers/staging/vc04_services/vchiq-mmal/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_BCM2835_VCHIQ_MMAL) += bcm2835-mmal-vchiq.o
 
 ccflags-y += \
 	-I$(srctree)/$(src)/.. \
+	-I$(srctree)/$(src)/../include \
 	-D__VCCOREVER__=0x04000000
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 72afa4319bd3..b99b7555a8fb 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -23,14 +23,14 @@
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/vmalloc.h>
+#include <linux/raspberrypi/vchiq.h>
 #include <media/videobuf2-vmalloc.h>
+#include <linux/raspberrypi/vchiq.h>
 
 #include "mmal-common.h"
 #include "mmal-vchiq.h"
 #include "mmal-msg.h"
 
-#include "interface/vchiq_arm/vchiq.h"
-
 /*
  * maximum number of components supported.
  * This matches the maximum permitted by default on the VPU
-- 
2.27.0

