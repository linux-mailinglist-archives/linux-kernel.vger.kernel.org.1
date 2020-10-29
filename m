Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B08829F7F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgJ2W2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJ2W2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:28:01 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03EFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:28:01 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id z24so3530245pgk.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gRSBM46Kbfh+Vqv33AXIqs5J3rU5osrvAGxFGVOsG/Y=;
        b=Z1b345xwH1ZHoakT5Uw1tRj1LG8JY405Tv54SdB9yaIXbj6H0mVzQpye5r+cFkyQt5
         BesaqdEeaunSP8NtAWPvjgjIjaXaWN2jowZzjP9L/6lyakVPjw/NqamDA5F7mE5ujlro
         gwwHtVErD4CXyIalvK2vifUf9PmjjWbARfVzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gRSBM46Kbfh+Vqv33AXIqs5J3rU5osrvAGxFGVOsG/Y=;
        b=YK1I0lY2Zbks6CLi7fHEJSA+WZlsixDrv+JuE0BIKpAz6hjWMNO3nrQ1TI+PC8LFtq
         znzZOHRtAAXDRYOOnkBK2O3HMNUPdqL49P6kIK7WjzoBAZd/M57+ZbmxPiYizbozOkrn
         kfhYbENqITO2gu+MsVSDrzkbaQPWHXsg4Mecacor40uPblmEnZ/aE9MNkgL+wN2B94uh
         lux43h9CawEqHIz6qNtcr96BO92GTP7Zum614oxn3MMv1H4A7JmRWpxx9MJ5DIeXbYzq
         jkNtSKjaHxjFWoRxmlQcJVMQ9MMiDhbINg6LGh1X5x2N6DgpUExhlToasMLMQAI165Wa
         Yjwg==
X-Gm-Message-State: AOAM530ieoeF2P7eSrEdU5dtrMDsk9fZCiPqFqqt+obt4Hll7rNSD27b
        vX2EvvAvpJr97VlA0LtDy6MDb3D3UvmBmQ==
X-Google-Smtp-Source: ABdhPJxy7+SubVngtlCgGXjKO7e/ldSM6An4691Yhep20LHyU06Vfm9jABzdLlefcHlTZ1bu8bkNZA==
X-Received: by 2002:a63:380b:: with SMTP id f11mr5789411pga.198.1604010480875;
        Thu, 29 Oct 2020 15:28:00 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id f5sm3573886pgi.86.2020.10.29.15.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 15:28:00 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, dzigterman@chromium.org,
        alevkoy@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>
Subject: [PATCH v2 1/7] platform/chrome: cros_ec_typec: Relocate set_port_params_v*() functions
Date:   Thu, 29 Oct 2020 15:27:30 -0700
Message-Id: <20201029222738.482366-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201029222738.482366-1-pmalani@chromium.org>
References: <20201029222738.482366-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the cros_typec_set_port_params_v0/v1() functions closer to the
place where they are called, cros_typec_port_update().

While we are performing the relocation, also move cros_typec_get_mux_info()
closer to its call-site.

No functional changes are introduced by this commit.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 136 ++++++++++++------------
 1 file changed, 68 insertions(+), 68 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 31be31161350..49083e21317d 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -329,74 +329,6 @@ static int cros_typec_ec_command(struct cros_typec_data *typec,
 	return ret;
 }
 
-static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
-		int port_num, struct ec_response_usb_pd_control *resp)
-{
-	struct typec_port *port = typec->ports[port_num]->port;
-	enum typec_orientation polarity;
-
-	if (!resp->enabled)
-		polarity = TYPEC_ORIENTATION_NONE;
-	else if (!resp->polarity)
-		polarity = TYPEC_ORIENTATION_NORMAL;
-	else
-		polarity = TYPEC_ORIENTATION_REVERSE;
-
-	typec_set_pwr_role(port, resp->role ? TYPEC_SOURCE : TYPEC_SINK);
-	typec_set_orientation(port, polarity);
-}
-
-static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
-		int port_num, struct ec_response_usb_pd_control_v1 *resp)
-{
-	struct typec_port *port = typec->ports[port_num]->port;
-	enum typec_orientation polarity;
-	bool pd_en;
-	int ret;
-
-	if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
-		polarity = TYPEC_ORIENTATION_NONE;
-	else if (!resp->polarity)
-		polarity = TYPEC_ORIENTATION_NORMAL;
-	else
-		polarity = TYPEC_ORIENTATION_REVERSE;
-	typec_set_orientation(port, polarity);
-	typec_set_data_role(port, resp->role & PD_CTRL_RESP_ROLE_DATA ?
-			TYPEC_HOST : TYPEC_DEVICE);
-	typec_set_pwr_role(port, resp->role & PD_CTRL_RESP_ROLE_POWER ?
-			TYPEC_SOURCE : TYPEC_SINK);
-	typec_set_vconn_role(port, resp->role & PD_CTRL_RESP_ROLE_VCONN ?
-			TYPEC_SOURCE : TYPEC_SINK);
-
-	/* Register/remove partners when a connect/disconnect occurs. */
-	if (resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED) {
-		if (typec->ports[port_num]->partner)
-			return;
-
-		pd_en = resp->enabled & PD_CTRL_RESP_ENABLED_PD_CAPABLE;
-		ret = cros_typec_add_partner(typec, port_num, pd_en);
-		if (ret)
-			dev_warn(typec->dev,
-				 "Failed to register partner on port: %d\n",
-				 port_num);
-	} else {
-		if (!typec->ports[port_num]->partner)
-			return;
-		cros_typec_remove_partner(typec, port_num);
-	}
-}
-
-static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
-				   struct ec_response_usb_pd_mux_info *resp)
-{
-	struct ec_params_usb_pd_mux_info req = {
-		.port = port_num,
-	};
-
-	return cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_MUX_INFO, &req,
-				     sizeof(req), resp, sizeof(*resp));
-}
-
 static int cros_typec_usb_safe_state(struct cros_typec_port *port)
 {
 	port->state.mode = TYPEC_STATE_SAFE;
@@ -573,6 +505,74 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
 	return ret;
 }
 
+static void cros_typec_set_port_params_v0(struct cros_typec_data *typec,
+		int port_num, struct ec_response_usb_pd_control *resp)
+{
+	struct typec_port *port = typec->ports[port_num]->port;
+	enum typec_orientation polarity;
+
+	if (!resp->enabled)
+		polarity = TYPEC_ORIENTATION_NONE;
+	else if (!resp->polarity)
+		polarity = TYPEC_ORIENTATION_NORMAL;
+	else
+		polarity = TYPEC_ORIENTATION_REVERSE;
+
+	typec_set_pwr_role(port, resp->role ? TYPEC_SOURCE : TYPEC_SINK);
+	typec_set_orientation(port, polarity);
+}
+
+static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
+		int port_num, struct ec_response_usb_pd_control_v1 *resp)
+{
+	struct typec_port *port = typec->ports[port_num]->port;
+	enum typec_orientation polarity;
+	bool pd_en;
+	int ret;
+
+	if (!(resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED))
+		polarity = TYPEC_ORIENTATION_NONE;
+	else if (!resp->polarity)
+		polarity = TYPEC_ORIENTATION_NORMAL;
+	else
+		polarity = TYPEC_ORIENTATION_REVERSE;
+	typec_set_orientation(port, polarity);
+	typec_set_data_role(port, resp->role & PD_CTRL_RESP_ROLE_DATA ?
+			TYPEC_HOST : TYPEC_DEVICE);
+	typec_set_pwr_role(port, resp->role & PD_CTRL_RESP_ROLE_POWER ?
+			TYPEC_SOURCE : TYPEC_SINK);
+	typec_set_vconn_role(port, resp->role & PD_CTRL_RESP_ROLE_VCONN ?
+			TYPEC_SOURCE : TYPEC_SINK);
+
+	/* Register/remove partners when a connect/disconnect occurs. */
+	if (resp->enabled & PD_CTRL_RESP_ENABLED_CONNECTED) {
+		if (typec->ports[port_num]->partner)
+			return;
+
+		pd_en = resp->enabled & PD_CTRL_RESP_ENABLED_PD_CAPABLE;
+		ret = cros_typec_add_partner(typec, port_num, pd_en);
+		if (ret)
+			dev_warn(typec->dev,
+				 "Failed to register partner on port: %d\n",
+				 port_num);
+	} else {
+		if (!typec->ports[port_num]->partner)
+			return;
+		cros_typec_remove_partner(typec, port_num);
+	}
+}
+
+static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
+				   struct ec_response_usb_pd_mux_info *resp)
+{
+	struct ec_params_usb_pd_mux_info req = {
+		.port = port_num,
+	};
+
+	return cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_MUX_INFO, &req,
+				     sizeof(req), resp, sizeof(*resp));
+}
+
 static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 {
 	struct ec_params_usb_pd_control req;
-- 
2.29.1.341.ge80a0c044ae-goog

