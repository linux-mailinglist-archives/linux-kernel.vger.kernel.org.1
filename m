Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7513E1E40E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 13:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbgE0Lzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 07:55:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:42080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388011AbgE0LzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:55:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 568A3AE44;
        Wed, 27 May 2020 11:55:04 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [RFC 48/50] staging: vchiq: Use vchiq.h as the main header file for services
Date:   Wed, 27 May 2020 13:53:53 +0200
Message-Id: <20200527115400.31391-49-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This used to be vchiq_if.h but vchiq.h is more concise for an include
file that will hopefully be in the future in the includes directory.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/bcm2835-audio/bcm2835.h     |   2 +-
 .../vc04_services/interface/vchiq_arm/vchiq.h | 107 ++++++++++++++++-
 .../interface/vchiq_arm/vchiq_if.h            | 109 ------------------
 .../interface/vchiq_arm/vchiq_ioctl.h         |   2 +-
 .../staging/vc04_services/vc-sm-cma/vc_sm.c   |   2 +-
 .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.c  |   2 +-
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     |   2 +-
 7 files changed, 108 insertions(+), 118 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
index a15f251033ac..ca220f5230ec 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.h
@@ -9,7 +9,7 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm-indirect.h>
-#include "interface/vchiq_arm/vchiq_if.h"
+#include "interface/vchiq_arm/vchiq.h"
 
 #define MAX_SUBSTREAMS   (8)
 #define AVAIL_SUBSTREAMS_MASK  (0xff)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
index 57fe7d5e9a85..04b7ff41a025 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h
@@ -1,9 +1,108 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /* Copyright (c) 2010-2012 Broadcom. All rights reserved. */
 
-#ifndef VCHIQ_VCHIQ_H
-#define VCHIQ_VCHIQ_H
+#ifndef VCHIQ_H
+#define VCHIQ_H
 
-#include "vchiq_if.h"
+#define VCHIQ_SERVICE_HANDLE_INVALID 0
 
-#endif
+#define VCHIQ_SLOT_SIZE     4096
+#define VCHIQ_MAX_MSG_SIZE  (VCHIQ_SLOT_SIZE - sizeof(struct vchiq_header))
+
+#define VCHIQ_MAKE_FOURCC(x0, x1, x2, x3) \
+			(((x0) << 24) | ((x1) << 16) | ((x2) << 8) | (x3))
+
+enum vchiq_reason {
+	VCHIQ_SERVICE_OPENED,         /* service, -, -             */
+	VCHIQ_SERVICE_CLOSED,         /* service, -, -             */
+	VCHIQ_MESSAGE_AVAILABLE,      /* service, header, -        */
+	VCHIQ_BULK_TRANSMIT_DONE,     /* service, -, bulk_userdata */
+	VCHIQ_BULK_RECEIVE_DONE,      /* service, -, bulk_userdata */
+	VCHIQ_BULK_TRANSMIT_ABORTED,  /* service, -, bulk_userdata */
+	VCHIQ_BULK_RECEIVE_ABORTED    /* service, -, bulk_userdata */
+};
+
+enum vchiq_status {
+	VCHIQ_ERROR   = -1,
+	VCHIQ_SUCCESS = 0,
+	VCHIQ_RETRY   = 1
+};
+
+enum vchiq_bulk_mode {
+	VCHIQ_BULK_MODE_CALLBACK,
+	VCHIQ_BULK_MODE_BLOCKING,
+	VCHIQ_BULK_MODE_NOCALLBACK,
+	VCHIQ_BULK_MODE_WAITING		/* Reserved for internal use */
+};
+
+enum vchiq_service_option {
+	VCHIQ_SERVICE_OPTION_AUTOCLOSE,
+	VCHIQ_SERVICE_OPTION_SLOT_QUOTA,
+	VCHIQ_SERVICE_OPTION_MESSAGE_QUOTA,
+	VCHIQ_SERVICE_OPTION_SYNCHRONOUS,
+	VCHIQ_SERVICE_OPTION_TRACE
+};
+
+struct vchiq_header {
+	/* The message identifier - opaque to applications. */
+	int msgid;
+
+	/* Size of message data. */
+	unsigned int size;
+
+	char data[0];           /* message */
+};
+
+struct vchiq_element {
+	const void __user *data;
+	unsigned int size;
+};
+
+struct vchiq_service_base {
+	int fourcc;
+	enum vchiq_status (*callback)(enum vchiq_reason reason,
+				      struct vchiq_header *header,
+				      unsigned int handle,
+				      void *bulk_userdata);
+	void *userdata;
+};
+
+struct vchiq_service_params {
+	int fourcc;
+	enum vchiq_status (*callback)(enum vchiq_reason reason,
+				      struct vchiq_header *header,
+				      unsigned int handle,
+				      void *bulk_userdata);
+	void *userdata;
+	short version;       /* Increment for non-trivial changes */
+	short version_min;   /* Update for incompatible changes */
+};
+
+struct vchiq_instance;
+
+extern enum vchiq_status vchiq_initialise(struct vchiq_instance **pinstance);
+extern enum vchiq_status vchiq_shutdown(struct vchiq_instance *instance);
+extern enum vchiq_status vchiq_connect(struct vchiq_instance *instance);
+extern enum vchiq_status vchiq_open_service(struct vchiq_instance *instance,
+	const struct vchiq_service_params *params,
+	unsigned int *pservice);
+extern enum vchiq_status vchiq_close_service(unsigned int service);
+extern enum vchiq_status vchiq_use_service(unsigned int service);
+extern enum vchiq_status vchiq_release_service(unsigned int service);
+extern void vchiq_msg_queue_push(unsigned handle, struct vchiq_header *header);
+extern void           vchiq_release_message(unsigned int service,
+	struct vchiq_header *header);
+extern int vchiq_queue_kernel_message(unsigned handle, void *data,
+				      unsigned size);
+extern enum vchiq_status vchiq_bulk_transmit(unsigned int service,
+	const void *data, unsigned int size, void *userdata,
+	enum vchiq_bulk_mode mode);
+extern enum vchiq_status vchiq_bulk_receive(unsigned int service,
+	void *data, unsigned int size, void *userdata,
+	enum vchiq_bulk_mode mode);
+extern void *vchiq_get_service_userdata(unsigned int service);
+extern enum vchiq_status vchiq_get_peer_version(unsigned int handle,
+      short *peer_version);
+extern struct vchiq_header *vchiq_msg_hold(unsigned handle);
+
+#endif /* VCHIQ_H */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
deleted file mode 100644
index 6374eda4ea0c..000000000000
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ /dev/null
@@ -1,109 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/* Copyright (c) 2010-2012 Broadcom. All rights reserved. */
-
-#ifndef VCHIQ_IF_H
-#define VCHIQ_IF_H
-
-#define VCHIQ_SERVICE_HANDLE_INVALID 0
-
-#define VCHIQ_SLOT_SIZE     4096
-#define VCHIQ_MAX_MSG_SIZE  (VCHIQ_SLOT_SIZE - sizeof(struct vchiq_header))
-
-#define VCHIQ_MAKE_FOURCC(x0, x1, x2, x3) \
-			(((x0) << 24) | ((x1) << 16) | ((x2) << 8) | (x3))
-
-enum vchiq_reason {
-	VCHIQ_SERVICE_OPENED,         /* service, -, -             */
-	VCHIQ_SERVICE_CLOSED,         /* service, -, -             */
-	VCHIQ_MESSAGE_AVAILABLE,      /* service, header, -        */
-	VCHIQ_BULK_TRANSMIT_DONE,     /* service, -, bulk_userdata */
-	VCHIQ_BULK_RECEIVE_DONE,      /* service, -, bulk_userdata */
-	VCHIQ_BULK_TRANSMIT_ABORTED,  /* service, -, bulk_userdata */
-	VCHIQ_BULK_RECEIVE_ABORTED    /* service, -, bulk_userdata */
-};
-
-enum vchiq_status {
-	VCHIQ_ERROR   = -1,
-	VCHIQ_SUCCESS = 0,
-	VCHIQ_RETRY   = 1
-};
-
-enum vchiq_bulk_mode {
-	VCHIQ_BULK_MODE_CALLBACK,
-	VCHIQ_BULK_MODE_BLOCKING,
-	VCHIQ_BULK_MODE_NOCALLBACK,
-	VCHIQ_BULK_MODE_WAITING		/* Reserved for internal use */
-};
-
-enum vchiq_service_option {
-	VCHIQ_SERVICE_OPTION_AUTOCLOSE,
-	VCHIQ_SERVICE_OPTION_SLOT_QUOTA,
-	VCHIQ_SERVICE_OPTION_MESSAGE_QUOTA,
-	VCHIQ_SERVICE_OPTION_SYNCHRONOUS,
-	VCHIQ_SERVICE_OPTION_TRACE
-};
-
-struct vchiq_header {
-	/* The message identifier - opaque to applications. */
-	int msgid;
-
-	/* Size of message data. */
-	unsigned int size;
-
-	char data[0];           /* message */
-};
-
-struct vchiq_element {
-	const void __user *data;
-	unsigned int size;
-};
-
-struct vchiq_service_base {
-	int fourcc;
-	enum vchiq_status (*callback)(enum vchiq_reason reason,
-				      struct vchiq_header *header,
-				      unsigned int handle,
-				      void *bulk_userdata);
-	void *userdata;
-};
-
-struct vchiq_service_params {
-	int fourcc;
-	enum vchiq_status (*callback)(enum vchiq_reason reason,
-				      struct vchiq_header *header,
-				      unsigned int handle,
-				      void *bulk_userdata);
-	void *userdata;
-	short version;       /* Increment for non-trivial changes */
-	short version_min;   /* Update for incompatible changes */
-};
-
-struct vchiq_instance;
-
-extern enum vchiq_status vchiq_initialise(struct vchiq_instance **pinstance);
-extern enum vchiq_status vchiq_shutdown(struct vchiq_instance *instance);
-extern enum vchiq_status vchiq_connect(struct vchiq_instance *instance);
-extern enum vchiq_status vchiq_open_service(struct vchiq_instance *instance,
-	const struct vchiq_service_params *params,
-	unsigned int *pservice);
-extern enum vchiq_status vchiq_close_service(unsigned int service);
-extern enum vchiq_status vchiq_use_service(unsigned int service);
-extern enum vchiq_status vchiq_release_service(unsigned int service);
-extern int vchiq_queue_kernel_message(unsigned handle, void *data,
-				      unsigned size);
-extern void vchiq_msg_queue_push(unsigned handle, struct vchiq_header *header);
-extern void           vchiq_release_message(unsigned int service,
-	struct vchiq_header *header);
-extern enum vchiq_status vchiq_bulk_transmit(unsigned int service,
-	const void *data, unsigned int size, void *userdata,
-	enum vchiq_bulk_mode mode);
-extern enum vchiq_status vchiq_bulk_receive(unsigned int service,
-	void *data, unsigned int size, void *userdata,
-	enum vchiq_bulk_mode mode);
-extern void *vchiq_get_service_userdata(unsigned int service);
-extern enum vchiq_status vchiq_get_peer_version(unsigned int handle,
-      short *peer_version);
-extern void vchiq_msg_queue_push(unsigned handle, struct vchiq_header *header);
-extern struct vchiq_header *vchiq_msg_hold(unsigned handle);
-
-#endif /* VCHIQ_IF_H */
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
index 202889b3774f..f285d754ad28 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_ioctl.h
@@ -5,7 +5,7 @@
 #define VCHIQ_IOCTLS_H
 
 #include <linux/ioctl.h>
-#include "vchiq_if.h"
+#include "vchiq.h"
 
 #define VCHIQ_IOC_MAGIC 0xc4
 #define VCHIQ_INVALID_HANDLE (~0)
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c b/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
index 572068538a4c..e4f7bdeef66d 100644
--- a/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm.c
@@ -48,7 +48,7 @@
 #include <linux/types.h>
 #include <asm/cacheflush.h>
 
-#include "vchiq_if.h"
+#include "vchiq.h"
 #include "vchiq_connected.h"
 #include "vc_sm_cma_vchi.h"
 
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
index 1ff165c05706..2c65416cd331 100644
--- a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
@@ -19,7 +19,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
-#include "interface/vchiq_arm/vchiq_if.h"
+#include "vchiq.h"
 #include "vc_sm_cma_vchi.h"
 
 #define VC_SM_VER  1
diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index c5f59d71badf..2101b79780eb 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -32,7 +32,7 @@
 
 #include "vc-sm-cma/vc_sm_knl.h"
 
-#include "interface/vchiq_arm/vchiq_if.h"
+#include "interface/vchiq_arm/vchiq.h"
 
 /*
  * maximum number of components supported.
-- 
2.26.2

