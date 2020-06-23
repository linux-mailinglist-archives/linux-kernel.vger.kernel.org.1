Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AED2057C5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 18:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgFWQrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 12:47:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:39310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733090AbgFWQpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:45:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B1AC4AED2;
        Tue, 23 Jun 2020 16:45:23 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 28/50] staging: vchi: Expose struct vchi_service
Date:   Tue, 23 Jun 2020 18:42:14 +0200
Message-Id: <20200623164235.29566-29-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623164235.29566-1-nsaenzjulienne@suse.de>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will make further changes easier. The struct will ultimately
disappear.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/interface/vchi/vchi.h    | 10 +++++++---
 .../vc04_services/interface/vchiq_arm/vchiq_shim.c     |  7 -------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index 9a74ca4e1062..789acb7999d1 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -29,6 +29,13 @@ struct vchi_held_msg {
 	void *message;
 };
 
+struct vchi_service {
+	unsigned int handle;
+
+	vchi_callback callback;
+	void *callback_param;
+};
+
 // structure used to provide the information needed to open a server or a client
 struct service_creation {
 	struct vchi_version version;
@@ -40,9 +47,6 @@ struct service_creation {
 // Opaque handle for a VCHIQ instance
 struct vchiq_instance;
 
-// Opaque handle for a server or client
-struct vchi_service;
-
 /******************************************************************************
  * Global funcs - implementation is specific to which side you are on
  * (local / remote)
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 9728667adbd9..843ee978928f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -10,13 +10,6 @@
 #include "vchiq.h"
 #include "vchiq_core.h"
 
-struct vchi_service {
-	unsigned int handle;
-
-	vchi_callback callback;
-	void *callback_param;
-};
-
 int vchi_queue_kernel_message(struct vchi_service *service, void *data,
 			      unsigned int size)
 {
-- 
2.27.0

