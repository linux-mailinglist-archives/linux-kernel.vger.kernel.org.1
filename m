Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252741E40EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 13:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgE0L4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 07:56:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:41690 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387854AbgE0Lyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1046EAD66;
        Wed, 27 May 2020 11:54:51 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 35/50] staging: vchiq: Pass vchiq's message when holding a message
Date:   Wed, 27 May 2020 13:53:40 +0200
Message-Id: <20200527115400.31391-36-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vchi created an opaque structure to be held by services while they
process callback messages. The contents of this opaque structure are the
service handle, which all services already maintain, and a pointer to
vchiq's message structure, struct vchiq_header.

Let's get rid of this opaque structure and directly pass struct
vchiq_header, which is what ultimately vchiq consumes when handling
callback messages.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../vc04_services/interface/vchi/vchi.h       | 14 ++---------
 .../interface/vchiq_arm/vchiq_shim.c          | 25 ++++++-------------
 .../vc04_services/vc-sm-cma/vc_sm_cma_vchi.c  |  6 ++---
 3 files changed, 12 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 74fd169e079a..72771fdee9d6 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -11,16 +11,6 @@
 // Macros to manipulate 'FOURCC' values
 #define MAKE_FOURCC(x) ((int32_t)((x[0] << 24) | (x[1] << 16) | (x[2] << 8) | x[3]))
 
-// Opaque service information
-struct opaque_vchi_service_t;
-
-// Descriptor for a held message. Allocated by client, initialised by vchi_msg_hold,
-// vchi_msg_iter_hold or vchi_msg_iter_hold_next. Fields are for internal VCHI use only.
-struct vchi_held_msg {
-	struct opaque_vchi_service_t *service;
-	void *message;
-};
-
 // Opaque handle for a VCHIQ instance
 struct vchiq_instance;
 
@@ -67,7 +57,7 @@ extern int vchi_queue_kernel_message(unsigned handle, void *data,
 extern int32_t vchi_msg_hold(unsigned handle,
 			     void **data,        // } may be NULL, as info can be
 			     uint32_t *msg_size, // } obtained from HELD_MSG_T
-			     struct vchi_held_msg *message_descriptor);
+			     struct vchiq_header **message);
 
 /*******************************************************************************
  * Global service support API - operations on held messages
@@ -75,7 +65,7 @@ extern int32_t vchi_msg_hold(unsigned handle,
  ******************************************************************************/
 
 // Routine to release a held message after it has been processed
-extern int32_t vchi_held_msg_release(struct vchi_held_msg *message);
+extern int32_t vchi_held_msg_release(unsigned handle, struct vchiq_header *message);
 
 /******************************************************************************
  * Global bulk API
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 578346965da6..6eb9a9878641 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -113,7 +113,8 @@ EXPORT_SYMBOL(vchi_bulk_queue_transmit);
 /***********************************************************
  * Name: vchi_held_msg_release
  *
- * Arguments:  struct vchi_held_msg *message
+ * Arguments:  unsgined handle
+ *	       struct vchiq_header *message
  *
  * Description: Routine to release a held message (after it has been read with
  *              vchi_msg_hold)
@@ -121,7 +122,7 @@ EXPORT_SYMBOL(vchi_bulk_queue_transmit);
  * Returns: int32_t - success == 0
  *
  ***********************************************************/
-int32_t vchi_held_msg_release(struct vchi_held_msg *message)
+int32_t vchi_held_msg_release(unsigned handle, struct vchiq_header *message)
 {
 	/*
 	 * Convert the service field pointer back to an
@@ -131,8 +132,7 @@ int32_t vchi_held_msg_release(struct vchi_held_msg *message)
 	 * to a pointer.
 	 */
 
-	vchiq_release_message((unsigned int)(long)message->service,
-			      (struct vchiq_header *)message->message);
+	vchiq_release_message(handle, message);
 
 	return 0;
 }
@@ -144,7 +144,7 @@ EXPORT_SYMBOL(vchi_held_msg_release);
  * Arguments:  struct vchi_service *service,
  *             void **data,
  *             uint32_t *msg_size,
- *             struct vchi_held_msg *message_handle
+ *             struct vchiq_header **message
  *
  * Description: Routine to return a pointer to the current message (to allow
  *              in place processing). The message is dequeued - don't forget
@@ -155,7 +155,7 @@ EXPORT_SYMBOL(vchi_held_msg_release);
  *
  ***********************************************************/
 int32_t vchi_msg_hold(unsigned handle, void **data, uint32_t *msg_size,
-		      struct vchi_held_msg *message_handle)
+		      struct vchiq_header **message)
 {
 	struct vchiq_header *header;
 
@@ -165,18 +165,7 @@ int32_t vchi_msg_hold(unsigned handle, void **data, uint32_t *msg_size,
 
 	*data = header->data;
 	*msg_size = header->size;
-
-	/*
-	 * upcast the unsigned int which is an int
-	 * to a pointer and stuff it in the held message.
-	 * This pointer is opaque to everything except
-	 * vchi_held_msg_release which simply downcasts it back
-	 * to an int.
-	 */
-
-	message_handle->service =
-		(struct opaque_vchi_service_t *)(long)handle;
-	message_handle->message = header;
+	*message = header;
 
 	return 0;
 }
diff --git a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
index b0339b5438aa..08979502f551 100644
--- a/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
+++ b/drivers/staging/vc04_services/vc-sm-cma/vc_sm_cma_vchi.c
@@ -176,7 +176,7 @@ static int vc_sm_cma_vchi_videocore_io(void *arg)
 	struct sm_instance *instance = arg;
 	struct sm_cmd_rsp_blk *cmd = NULL, *cmd_tmp;
 	struct vc_sm_result_t *reply;
-	struct vchi_held_msg msg;
+	struct vchiq_header *message;
 	u32 reply_len;
 	s32 status;
 	int svc_use = 1;
@@ -234,7 +234,7 @@ static int vc_sm_cma_vchi_videocore_io(void *arg)
 		} while (1);
 
 		while (!vchi_msg_hold(instance->service_handle,
-				      (void **)&reply, &reply_len, &msg)) {
+				      (void **)&reply, &reply_len, &message)) {
 			if (reply->trans_id & 0x80000000) {
 				/* Async event or cmd from the VPU */
 				if (instance->vpu_event)
@@ -245,7 +245,7 @@ static int vc_sm_cma_vchi_videocore_io(void *arg)
 						      reply_len);
 			}
 
-			vchi_held_msg_release(&msg);
+			vchi_held_msg_release(instance->service_handle, message);
 		}
 
 		/* Go through the dead list and free them */
-- 
2.26.2

