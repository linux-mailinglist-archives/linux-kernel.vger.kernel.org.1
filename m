Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EDF29F7FE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgJ2W3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgJ2W3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:29:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4BAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:29:03 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o129so3586323pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AL6bc4JXBQj7VOdOG7p2V9Qp28jEf6yhcQGxqCF+RYo=;
        b=XKe5FKCJ45HUs+9mdk6ZWuk90VD/wTZZ7pep615Elz5B62tpdPhSJ+1X3AmIHk+WAZ
         rxovV5+CdWZ+rvLgkWCqeP/NR5f2MtJlU+Y1S474KetdvmF4YzhBO3gcO0mwkIOJovRG
         JYRRizHXz0clso/AWgujHrVEDxiBpxwzUnHNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AL6bc4JXBQj7VOdOG7p2V9Qp28jEf6yhcQGxqCF+RYo=;
        b=N16RFn3vL/fadMmKbWSKO8DO8TlvXzRwn53n9xZoUp8avZVqsrgsKoVn1YbythZSNs
         fsGii17c2Xjq6xQPq1GRSA/Ro+etWM4ICf0lPpZvNtQ6tPQfbWsxyUmaFrJPZduaM4fM
         X7XTB8Bbv/OsYbmnprU1B9Qk9QN0BH5wFHvEdTqAMvvFBQ7nbbMR5QnpwR6Geqj+lgJJ
         4XoWG+cUv2YSE1cxt/3Ygui62ZbAh8GxIVgqd6bJFqLcMyRv+uIRVWVbsWnQ4kYr/XHY
         35PIgg7VkfMmpId32C/nyCAsV9laJAx55gPSxzsyJADRRhuCMYs2LOwKRdKuL/O/DMu3
         a8PQ==
X-Gm-Message-State: AOAM532KL5DJTdSpk30tL8Z+eppRap3yTFKhwW3p63b0KV4ZLh9K2NXP
        bRUrvAi10EhrBky1qBahFCtJV50HazHfvw==
X-Google-Smtp-Source: ABdhPJy9xA42CCYL7UD6VpFINQnSqqtejA5AaH9+kyKRHDghq3ole7LxO2DbBwr9UfuFLZbXXrCj0Q==
X-Received: by 2002:a17:90b:148c:: with SMTP id js12mr1356251pjb.175.1604010543118;
        Thu, 29 Oct 2020 15:29:03 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id f5sm3573886pgi.86.2020.10.29.15.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 15:29:02 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, dzigterman@chromium.org,
        alevkoy@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 6/7] platform/chrome: cros_ec_typec: Parse partner PD ID VDOs
Date:   Thu, 29 Oct 2020 15:27:40 -0700
Message-Id: <20201029222738.482366-7-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201029222738.482366-1-pmalani@chromium.org>
References: <20201029222738.482366-1-pmalani@chromium.org>
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

Changes in v2:
- No changes

 drivers/platform/chrome/cros_ec_typec.c | 60 ++++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index f578d0bfbe5a..f14550dac614 100644
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
2.29.1.341.ge80a0c044ae-goog

