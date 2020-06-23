Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 429FB205788
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 18:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733162AbgFWQpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 12:45:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:40008 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733132AbgFWQpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:45:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF9D6AEF3;
        Tue, 23 Jun 2020 16:45:31 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 42/50] staging: vchiq: Move definitions only used by core into core header
Date:   Tue, 23 Jun 2020 18:42:28 +0200
Message-Id: <20200623164235.29566-43-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623164235.29566-1-nsaenzjulienne@suse.de>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vchiq_if.h is used by service consumers and only the exported API should
be present. Move the rest of definitions, which were not exported by the
way, to vchiq_core.h where they belong.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_core.h          | 22 +++++++++++++++++++
 .../interface/vchiq_arm/vchiq_if.h            | 16 --------------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index b97b661bea1c..ff91c04ba6b9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -486,6 +486,18 @@ struct bulk_waiter {
 	int actual;
 };
 
+struct vchiq_config {
+	unsigned int max_msg_size;
+	unsigned int bulk_threshold; /* The message size above which it
+					is better to use a bulk transfer
+					(<= max_msg_size) */
+	unsigned int max_outstanding_bulks;
+	unsigned int max_services;
+	short version;      /* The version of VCHIQ */
+	short version_min;  /* The minimum compatible version of VCHIQ */
+};
+
+
 extern spinlock_t bulk_waiter_spinlock;
 
 extern int vchiq_core_log_level;
@@ -665,4 +677,14 @@ extern void
 vchiq_log_dump_mem(const char *label, uint32_t addr, const void *voidMem,
 	size_t numBytes);
 
+extern enum vchiq_status vchiq_remove_service(unsigned int service);
+
+extern int vchiq_get_client_id(unsigned int service);
+
+extern void vchiq_get_config(struct vchiq_config *config);
+
+extern enum vchiq_status
+vchiq_set_service_option(unsigned int service, enum vchiq_service_option option,
+			 int value);
+
 #endif
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index b852980447dc..931debcd6492 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -78,17 +78,6 @@ struct vchiq_service_params {
 	short version_min;   /* Update for incompatible changes */
 };
 
-struct vchiq_config {
-	unsigned int max_msg_size;
-	unsigned int bulk_threshold; /* The message size above which it
-					is better to use a bulk transfer
-					(<= max_msg_size) */
-	unsigned int max_outstanding_bulks;
-	unsigned int max_services;
-	short version;      /* The version of VCHIQ */
-	short version_min;  /* The minimum compatible version of VCHIQ */
-};
-
 struct vchiq_instance;
 
 extern enum vchiq_status vchiq_initialise(struct vchiq_instance **pinstance);
@@ -98,7 +87,6 @@ extern enum vchiq_status vchiq_open_service(struct vchiq_instance *instance,
 	const struct vchiq_service_params *params,
 	unsigned int *pservice);
 extern enum vchiq_status vchiq_close_service(unsigned int service);
-extern enum vchiq_status vchiq_remove_service(unsigned int service);
 extern enum vchiq_status vchiq_use_service(unsigned int service);
 extern enum vchiq_status vchiq_release_service(unsigned int service);
 extern enum vchiq_status vchiq_queue_kernel_message(unsigned int handle,
@@ -112,11 +100,7 @@ extern enum vchiq_status vchiq_bulk_transmit(unsigned int service,
 extern enum vchiq_status vchiq_bulk_receive(unsigned int service,
 	void *data, unsigned int size, void *userdata,
 	enum vchiq_bulk_mode mode);
-extern int   vchiq_get_client_id(unsigned int service);
 extern void *vchiq_get_service_userdata(unsigned int service);
-extern void vchiq_get_config(struct vchiq_config *config);
-extern enum vchiq_status vchiq_set_service_option(unsigned int service,
-	enum vchiq_service_option option, int value);
 extern enum vchiq_status vchiq_get_peer_version(unsigned int handle,
       short *peer_version);
 extern void vchiq_msg_queue_push(unsigned handle, struct vchiq_header *header);
-- 
2.27.0

