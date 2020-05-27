Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9479A1E40CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 13:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgE0LzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 07:55:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:41458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387784AbgE0Lyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A4713AB7D;
        Wed, 27 May 2020 11:54:46 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 32/50] staging: vchiq: Don't use a typedef for vchiq_callback
Date:   Wed, 27 May 2020 13:53:37 +0200
Message-Id: <20200527115400.31391-33-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
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
2.26.2

