Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F2C2057DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 18:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbgFWQsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 12:48:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:38788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732182AbgFWQpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:45:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 151CDAED2;
        Tue, 23 Jun 2020 16:45:09 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 04/50] staging: mmal-vchiq: Make timeout a defined parameter
Date:   Tue, 23 Jun 2020 18:41:50 +0200
Message-Id: <20200623164235.29566-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623164235.29566-1-nsaenzjulienne@suse.de>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

The timeout period for VPU communications is a useful thing
to extend when debugging.
Set it via a define, rather than a magic number buried in the code.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index c30caad75253..070ff63b3850 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -38,6 +38,12 @@
  */
 #define VCHIQ_MMAL_MAX_COMPONENTS 64
 
+/*
+ * Timeout for synchronous msg responses in seconds.
+ * Helpful to increase this if stopping in the VPU debugger.
+ */
+#define SYNC_MSG_TIMEOUT       3
+
 /*#define FULL_MSG_DUMP 1*/
 
 #ifdef DEBUG
@@ -686,7 +692,7 @@ static int send_synchronous_mmal_msg(struct vchiq_mmal_instance *instance,
 	}
 
 	timeout = wait_for_completion_timeout(&msg_context->u.sync.cmplt,
-					      3 * HZ);
+					      SYNC_MSG_TIMEOUT * HZ);
 	if (timeout == 0) {
 		pr_err("timed out waiting for sync completion\n");
 		ret = -ETIME;
-- 
2.27.0

