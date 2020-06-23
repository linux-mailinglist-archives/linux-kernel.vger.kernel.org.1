Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB442057DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 18:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387544AbgFWQs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 12:48:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:38940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732483AbgFWQpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:45:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B796B03F;
        Tue, 23 Jun 2020 16:45:11 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     gregkh@linuxfoundation.org
Cc:     kernel-list@raspberrypi.com, laurent.pinchart@ideasonboard.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org,
        Dave Stevenson <dave.stevenson@raspberrypi.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 08/50] staging: mmal-vchiq: Always return the param size from param_get
Date:   Tue, 23 Jun 2020 18:41:54 +0200
Message-Id: <20200623164235.29566-9-nsaenzjulienne@suse.de>
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

mmal-vchiq is a reimplementation of the userland library for MMAL.
When getting a parameter, the client provides the storage and
the size of the storage. The VPU then returns the size of the
parameter that it wished to return, and as much as possible of
that parameter is returned to the client.

The implementation previously only returned the size provided
by the VPU should it exceed the buffer size. So for parameters
such as the supported encodings list the client had no idea
how much of the provided storage had been populated.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index c598a10452be..df2957abc37c 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -1282,11 +1282,12 @@ static int port_parameter_get(struct vchiq_mmal_instance *instance,
 		 */
 		memcpy(value, &rmsg->u.port_parameter_get_reply.value,
 		       *value_size);
-		*value_size = rmsg->u.port_parameter_get_reply.size;
 	} else {
 		memcpy(value, &rmsg->u.port_parameter_get_reply.value,
 		       rmsg->u.port_parameter_get_reply.size);
 	}
+	/* Always report the size of the returned parameter to the caller */
+	*value_size = rmsg->u.port_parameter_get_reply.size;
 
 	pr_debug("%s:result:%d component:0x%x port:%d parameter:%d\n", __func__,
 		 ret, port->component->handle, port->handle, parameter_id);
-- 
2.27.0

