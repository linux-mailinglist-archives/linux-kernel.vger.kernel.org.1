Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A971E20DF6A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 23:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbgF2Uf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 16:35:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:59488 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732181AbgF2TVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E647EAFF7;
        Mon, 29 Jun 2020 15:10:04 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 29/47] staging: vchiq: Don't use a typedef for vchiq_callback
Date:   Mon, 29 Jun 2020 17:09:27 +0200
Message-Id: <20200629150945.10720-30-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629150945.10720-1-nsaenzjulienne@suse.de>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux coding style says to avoid typdefs.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/interface/vchi/vchi.h    |  5 ++++-
 .../vc04_services/interface/vchiq_arm/vchiq_if.h   | 14 ++++++++------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi.h b/drivers/staging/vc04_services/interface/vchi/vchi.h
index fdc243f3f60a..cb66ea1ffad2 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi.h
@@ -35,7 +35,10 @@ struct vchi_service {
 struct service_creation {
 	struct vchi_version version;
 	int32_t service_id;
-	vchiq_callback callback;
+	enum vchiq_status (*callback)(enum vchiq_reason reason,
+				      struct vchiq_header *header,
+				      unsigned int handle,
+				      void *bulk_userdata);
 	void *callback_param;
 };
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
index c99caa3add57..b3d4c14536bd 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h
@@ -60,19 +60,21 @@ struct vchiq_element {
 	unsigned int size;
 };
 
-typedef enum vchiq_status (*vchiq_callback)(enum vchiq_reason,
-					    struct vchiq_header *,
-					    unsigned int, void *);
-
 struct vchiq_service_base {
 	int fourcc;
-	vchiq_callback callback;
+	enum vchiq_status (*callback)(enum vchiq_reason reason,
+				      struct vchiq_header *header,
+				      unsigned int handle,
+				      void *bulk_userdata);
 	void *userdata;
 };
 
 struct vchiq_service_params {
 	int fourcc;
-	vchiq_callback callback;
+	enum vchiq_status (*callback)(enum vchiq_reason reason,
+				      struct vchiq_header *header,
+				      unsigned int handle,
+				      void *bulk_userdata);
 	void *userdata;
 	short version;       /* Increment for non-trivial changes */
 	short version_min;   /* Update for incompatible changes */
-- 
2.27.0

