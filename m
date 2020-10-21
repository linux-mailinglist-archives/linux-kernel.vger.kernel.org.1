Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203A92953AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 22:54:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505616AbgJUUyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 16:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439388AbgJUUyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:54:22 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B03C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:54:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id h4so1780987pjk.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dG1urLRlw7mKpoC4I4MWhjjiRaE07zaSuqqMYga81to=;
        b=nLfkbd6wqlxW4Y3Z6+6ols8KTj5rDehX+a2kIhl7mKmvnbrMlh2xeRv1cfhJ9NkzjN
         POygFgaf6FUpJINzgzAD9JndLQhXlp3yvhj9cJ0/KvEvy/byi3OOSUyq4JJq6MRIXb3E
         BndNoe1S6OzHnOJnpdQZZV/C1W+zuDi/TwHSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dG1urLRlw7mKpoC4I4MWhjjiRaE07zaSuqqMYga81to=;
        b=Gmjpq2oMLzR2l0wAyHHpbMlOvfq44b8lfZ3Up67GwnSEOLnTChXku7Ln2EaKt08tCu
         AgRcJCRdHsyrXae9MQnKzL2jt77LkI6paDCR/jzcEVVYLvtFExvMtXYyVy3Qdmg8ogIN
         uqUA5wUsYviOmxNiCfcukVv1Z8uZlLk7Ulct3UQ8XzKe7yZd+S7qE//dy7T4/N5qrJJ1
         92oWC7P75ogyQMAHA2z1AbbTyV3uooxWH2J1UiGys4moiclVh/E/3VXOaGZupKGXG9bs
         q1l1juvpsDM+nE/PDqRyh6flRCkCXODTwxEhyv+RS5ehAZQhLAPzOsiM6g50eFyhp9uT
         Gc5A==
X-Gm-Message-State: AOAM531AFIiyAbLVtJM0Z8sW+8KJQtX/T6lVsJ7NQ6SGYNdY98kEoGIw
        XZ0NTfdmZ8LDW2jt54/LPuxdLixZWHZf+A==
X-Google-Smtp-Source: ABdhPJyw4zrksYfKLhTU+rL8qKL+sw7BKKmN88IeuPkxxVzeNz+OPpKYHNhsMwtXI24uHtyo5HPDPg==
X-Received: by 2002:a17:90a:19d2:: with SMTP id 18mr4652485pjj.167.1603313660635;
        Wed, 21 Oct 2020 13:54:20 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id q8sm3178087pfg.118.2020.10.21.13.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 13:54:20 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 6/7] platform/chrome: cros_ec_typec: Parse partner PD ID VDOs
Date:   Wed, 21 Oct 2020 13:53:15 -0700
Message-Id: <20201021205317.708008-7-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021205317.708008-1-pmalani@chromium.org>
References: <20201021205317.708008-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use EC_CMD_TYPE_DISCOVERY to retrieve and store the discovery data for
the port partner. With that data, update the PD Identity VDO values for
the partner, which were earlier not initialized.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 60 ++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 98d22720b365..53d0b4b4fcd7 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -14,6 +14,7 @@
 #include <linux/platform_data/cros_usbpd_notify.h>
 #include <linux/platform_device.h>
 #include <linux/usb/pd.h>
+#include <linux/usb/pd_vdo.h>
 #include <linux/usb/typec.h>
 #include <linux/usb/typec_altmode.h>
 #include <linux/usb/typec_dp.h>
@@ -51,6 +52,7 @@ struct cros_typec_port {
 
 	/* Flag indicating that PD discovery data parsing is completed. */
 	bool disc_done;
+	struct ec_response_typec_discovery *sop_disc;
 };
 
 /* Platform-specific data for the Chrome OS EC Type C controller. */
@@ -298,6 +300,12 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 				port_num);
 
 		cros_typec_register_port_altmodes(typec, port_num);
+
+		cros_port->sop_disc = devm_kzalloc(dev, EC_PROTO2_MAX_RESPONSE_SIZE, GFP_KERNEL);
+		if (!cros_port->sop_disc) {
+			ret = -ENOMEM;
+			goto unregister_ports;
+		}
 	}
 
 	return 0;
@@ -582,6 +590,51 @@ static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
 				     sizeof(req), resp, sizeof(*resp));
 }
 
+static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+	struct ec_response_typec_discovery *sop_disc = port->sop_disc;
+	struct ec_params_typec_discovery req = {
+		.port = port_num,
+		.partner_type = TYPEC_PARTNER_SOP,
+	};
+	int ret = 0;
+	int i;
+
+	if (!port->partner) {
+		dev_err(typec->dev,
+			"SOP Discovery received without partner registered, port: %d\n",
+			port_num);
+		ret = -EINVAL;
+		goto disc_exit;
+	}
+
+	memset(sop_disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
+	ret = cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
+				    sop_disc, EC_PROTO2_MAX_RESPONSE_SIZE);
+	if (ret < 0) {
+		dev_err(typec->dev, "Failed to get SOP discovery data for port: %d\n", port_num);
+		goto disc_exit;
+	}
+
+	/* First, update the PD identity VDOs for the partner. */
+	if (sop_disc->identity_count > 0)
+		port->p_identity.id_header = sop_disc->discovery_vdo[0];
+	if (sop_disc->identity_count > 1)
+		port->p_identity.cert_stat = sop_disc->discovery_vdo[1];
+	if (sop_disc->identity_count > 2)
+		port->p_identity.product = sop_disc->discovery_vdo[2];
+
+	/* Copy the remaining identity VDOs till a maximum of 6. */
+	for (i = 3; i < sop_disc->identity_count && i < VDO_MAX_OBJECTS; i++)
+		port->p_identity.vdo[i - 3] = sop_disc->discovery_vdo[i];
+
+	ret = typec_partner_set_identity(port->partner);
+
+disc_exit:
+	return ret;
+}
+
 static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num)
 {
 	struct ec_response_typec_status resp;
@@ -602,7 +655,12 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
 
 	/* Handle any events appropriately. */
 	if (resp.events & PD_STATUS_EVENT_SOP_DISC_DONE) {
-		dev_dbg(typec->dev, "SOP Discovery done for port: %d\n", port_num);
+		ret = cros_typec_handle_sop_disc(typec, port_num);
+		if (ret < 0) {
+			dev_err(typec->dev, "Couldn't parse SOP Disc data, port: %d\n", port_num);
+			return;
+		}
+
 		typec->ports[port_num]->disc_done = true;
 	}
 }
-- 
2.29.0.rc1.297.gfa9743e501-goog

