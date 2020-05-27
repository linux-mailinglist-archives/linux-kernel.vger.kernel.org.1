Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AB21E40C3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 13:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbgE0Lyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 07:54:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:40832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729323AbgE0LyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:54:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B8CE3ACB8;
        Wed, 27 May 2020 11:54:21 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        gregkh@linuxfoundation.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org
Subject: [RFC 09/50] staging: vchiq: move vchiq_release_message() into vchiq
Date:   Wed, 27 May 2020 13:53:14 +0200
Message-Id: <20200527115400.31391-10-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527115400.31391-1-nsaenzjulienne@suse.de>
References: <20200527115400.31391-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For messages with a reason different from VCHIQ_MESSAGE_AVAILABLE the
responsibility for releasing them is kept in vchi, in other words,
services don't need to worry about it. As we're trying to unify vchi and
vchiq, move the release code into vchiq.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c    | 4 ++++
 .../staging/vc04_services/interface/vchiq_arm/vchiq_shim.c    | 4 +---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 67b2090c91db..ef31e541c902 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -372,6 +372,10 @@ make_service_callback(struct vchiq_service *service, enum vchiq_reason reason,
 			service->state->id, service->handle);
 		status = VCHIQ_SUCCESS;
 	}
+
+	if (reason != VCHIQ_MESSAGE_AVAILABLE)
+		vchiq_release_message(service->handle, header);
+
 	return status;
 }
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
index 0fc5fa05c6c2..55f9e34ea50e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_shim.c
@@ -444,7 +444,7 @@ static enum vchiq_status shim_callback(enum vchiq_reason reason,
 		service->callback(service->callback_param,
 				  VCHI_CALLBACK_MSG_AVAILABLE, NULL);
 
-		goto done;
+		break;
 
 	case VCHIQ_BULK_TRANSMIT_DONE:
 		service->callback(service->callback_param,
@@ -483,8 +483,6 @@ static enum vchiq_status shim_callback(enum vchiq_reason reason,
 	}
 
 release:
-	vchiq_release_message(service->handle, header);
-done:
 	return VCHIQ_SUCCESS;
 }
 
-- 
2.26.2

