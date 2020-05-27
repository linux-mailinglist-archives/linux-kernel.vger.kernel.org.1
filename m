Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557851E40F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 13:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387912AbgE0L5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 07:57:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:41214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387697AbgE0Lyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 29337AE2D;
        Wed, 27 May 2020 11:54:38 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 25/50] staging: vchiq: Introduce vchiq_validate_params()
Date:   Wed, 27 May 2020 13:53:30 +0200
Message-Id: <20200527115400.31391-26-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adding a new service validate the configuration parameters
provided, and remove unnecessary checks in vchi, now that we have
validated service's config.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_core.c              | 15 +++++++++++++++
 .../interface/vchiq_arm/vchiq_shim.c              |  4 ----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index ae9183db44ee..46b09b7154f8 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -2265,6 +2265,16 @@ vchiq_init_state(struct vchiq_state *state, struct vchiq_slot_zero *slot_zero)
 	return VCHIQ_ERROR;
 }
 
+static int vchiq_validate_params(const struct vchiq_service_params *params)
+{
+	if (!params->callback || !params->fourcc) {
+		vchiq_loud_error("Can't add service, invalid params\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Called from application thread when a client or server service is created. */
 struct vchiq_service *
 vchiq_add_service_internal(struct vchiq_state *state,
@@ -2275,8 +2285,13 @@ vchiq_add_service_internal(struct vchiq_state *state,
 	struct vchiq_service *service;
 	struct vchiq_service __rcu **pservice = NULL;
 	struct vchiq_service_quota *service_quota;
+	int ret;
 	int i;
 
+	ret = vchiq_validate_params(params);
+	if (ret)
+		return NULL;
+
 	service = kmalloc(sizeof(*service), GFP_KERNEL);
 	if (!service)
 		return service;
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index e09c595d6f9d..dcf8776834b1 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -271,15 +271,11 @@ static enum vchiq_status shim_callback(enum vchiq_reason reason,
 	struct vchi_service *service =
 		(struct vchi_service *)VCHIQ_GET_SERVICE_USERDATA(handle);
 
-	if (!service->callback)
-		goto release;
-
 	if (reason == VCHIQ_MESSAGE_AVAILABLE)
 		vchiu_queue_push(&service->queue, header);
 
 	service->callback(service->callback_param, reason, bulk_user);
 
-release:
 	return VCHIQ_SUCCESS;
 }
 
-- 
2.26.2

