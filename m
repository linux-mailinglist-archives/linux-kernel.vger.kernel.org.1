Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07629205791
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 18:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbgFWQph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 12:45:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:39240 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733111AbgFWQp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:45:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E9CEAEDD;
        Tue, 23 Jun 2020 16:45:28 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 36/50] staging: vchi: Rework vchi_msg_hold() to match vchiq_msg_hold()
Date:   Tue, 23 Jun 2020 18:42:22 +0200
Message-Id: <20200623164235.29566-37-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623164235.29566-1-nsaenzjulienne@suse.de>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The services have access to struct vchiq_header's internals, so we can
let them get the data pointer. This pretty much makes both functions
exactly the same, which will allow us to make a switch to
vchiq_msg_hold() further down the road.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/interface/vchi/vchi.h   |  5 +----
 .../interface/vchiq_arm/vchiq_shim.c              | 15 ++-------------
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 72771fdee9d6..59559d4cd5f1 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -54,10 +54,7 @@ extern int vchi_queue_kernel_message(unsigned handle, void *data,
 // Routine to look at a message in place.
 // The message is dequeued, so the caller is left holding it; the descriptor is
 // filled in and must be released when the user has finished with the message.
-extern int32_t vchi_msg_hold(unsigned handle,
-			     void **data,        // } may be NULL, as info can be
-			     uint32_t *msg_size, // } obtained from HELD_MSG_T
-			     struct vchiq_header **message);
+struct vchiq_header *vchi_msg_hold(unsigned handle);
 
 /*******************************************************************************
  * Global service support API - operations on held messages
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 6eb9a9878641..fc12b76617d1 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -154,20 +154,9 @@ EXPORT_SYMBOL(vchi_held_msg_release);
  * Returns: int32_t - success == 0
  *
  ***********************************************************/
-int32_t vchi_msg_hold(unsigned handle, void **data, uint32_t *msg_size,
-		      struct vchiq_header **message)
+struct vchiq_header *vchi_msg_hold(unsigned handle)
 {
-	struct vchiq_header *header;
-
-	header = vchiq_msg_hold(handle);
-	if (!header)
-		return -ENOENT;
-
-	*data = header->data;
-	*msg_size = header->size;
-	*message = header;
-
-	return 0;
+	return vchiq_msg_hold(handle);
 }
 EXPORT_SYMBOL(vchi_msg_hold);
 
-- 
2.27.0

