Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFCA2953AA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 22:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505568AbgJUUxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 16:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505561AbgJUUxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:53:45 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28B8C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:53:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x13so2211954pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZDxyqIBYfF76YFfN7mzFeXrX8KsY6tdi2bZpHwh+nk=;
        b=KLhJm6PItFLkkVNoh+3muYoUdSbYO+KwLTwNUjKaVKgVRB5vkhUNYDMwf7tAC8gIyt
         0BFXfPZ1dw3swR5U19m72g7Z0nB73qHTdd03fS1EmJufFxwz11Ll3dKBq0nNdzdrG+1u
         0PHItLNNw1x4XvgOi7yjos03TrmYCWZc8uG/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZDxyqIBYfF76YFfN7mzFeXrX8KsY6tdi2bZpHwh+nk=;
        b=cYam1eskkLSPWsUA1ghV5Y2QHfcqKg4/KTtxnF/yJ8GQCqtJ3x94RO80LUjBQYeiE+
         Lm5QVdGEA0HzzWYzL6/Q0Xga5qioUAMJlGZExBbTYhKQ6E6xVHC95CMwoZNJg3ixwIbJ
         fm3cZIo1hH8hIXHA5XRT0qO5s405LgHz20g3OClPT6am2r8Pix/+ycAIbQpNQrC2+FJz
         1XbFOLACBQjnydy+bOTWFMy5WvHjfma5/Qbkt1bMV4BJ8uU3+VR+52Pqv3yldrwesH4n
         P5yHs8Lq0YTWYE79Cxt691sHKVKhygYktJPh0w4c7u2RQ7rAsCbbHaqc756he0QK0YGq
         tbTw==
X-Gm-Message-State: AOAM533Q/WphQoVQq6/dRb0dLBviPOmkqsl535BKXiRzwV8CKG41wNJi
        Qm0WtHSsvSNxlGU/cYWzlL1OEMssdiwSjg==
X-Google-Smtp-Source: ABdhPJxLAO0BTs0GBNLio6T8Sy9AEd4ezFtJtFDe8TTYUm62cZmq8ckZ3tDv3iOmKxaowiJqlIavPw==
X-Received: by 2002:aa7:9358:0:b029:152:b349:8af7 with SMTP id 24-20020aa793580000b0290152b3498af7mr5198231pfn.18.1603313622998;
        Wed, 21 Oct 2020 13:53:42 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id q8sm3178087pfg.118.2020.10.21.13.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 13:53:42 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>
Subject: [PATCH 1/7] platform/chrome: cros_ec_typec: Relocate set_port_params_v*() functions
Date:   Wed, 21 Oct 2020 13:53:10 -0700
Message-Id: <20201021205317.708008-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021205317.708008-1-pmalani@chromium.org>
References: <20201021205317.708008-1-pmalani@chromium.org>
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
2.29.0.rc1.297.gfa9743e501-goog

