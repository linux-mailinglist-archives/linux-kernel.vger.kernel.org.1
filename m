Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2812953AE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 22:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505605AbgJUUyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 16:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505597AbgJUUyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:54:08 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C7EC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:54:08 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e15so2208426pfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHN2I79nfV0iUt35JEYrOchNYf3ShyCYP1914/Rerw8=;
        b=ITwvOVs5ZD8pJnqyf6ZJiLy797EBa6ExtV96Tz9vEuywXrTyt1rJ7bVVsCiNHamjXO
         GhknnZ119CDZlOSzQ09Wf5eaOkSwza2gcBM/T+hjPaDSLKkZLEw4dVq1eSnUC/yQuAOJ
         A5ZTJOY685O919AIEXHc0w4xIcIXkfRaRbMFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHN2I79nfV0iUt35JEYrOchNYf3ShyCYP1914/Rerw8=;
        b=q6/X4WPLxnuJUgna5Y1NY4mCvw9HoeYVh15Qb5q8XDX3V3lNMQb1NRdXl0BT54KetS
         33zJlN3QkTroZ55adWItSHNrtRKgG2DoDgw/ifOzFJh1S3Ey1oAdPoWyX0/5dd2sgpKN
         c7F+xFXvgyHLQ+oCOeevU99N2d8y3Etnpymt160dUrDpvna8nUmNvrqWzgp9prevMUo/
         U7fCQF2JbuuKqJB+kwKTN33orDWenjyLdU6zOczvEvVx6R8mFDvKqgLVK3Yif4Vha0Ga
         4nhJiwUn395ChFd3wLp4foC++T+KYQ0SA8jIMOOeEQVEPEx5hCgOMrNdkvF2pxCgOtXu
         N/SQ==
X-Gm-Message-State: AOAM532JZ6zRD1+vkiWG9LpC22tvjYWnz823g9ID6uPbOrtZsaA+4ozr
        SEHUYmd3EPztZwzMsORiQ8mcxzaR/mX2zw==
X-Google-Smtp-Source: ABdhPJz+8S+JxQsCf1tUHInuHtBAZwbVoVzJVSHLVtmvF+rr5qjBBg0wBhf8d3JkGc71wInh8fzlvA==
X-Received: by 2002:a63:3d8c:: with SMTP id k134mr4835697pga.22.1603313647912;
        Wed, 21 Oct 2020 13:54:07 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id q8sm3178087pfg.118.2020.10.21.13.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 13:54:07 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 5/7] platform/chrome: cros_ec_typec: Introduce TYPEC_STATUS
Date:   Wed, 21 Oct 2020 13:53:14 -0700
Message-Id: <20201021205317.708008-6-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021205317.708008-1-pmalani@chromium.org>
References: <20201021205317.708008-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a call to the newly introduced EC_CMD_TYPEC_STATUS command.
Currently we just check to see if the SOP (port-partner) discovery was
done and emit a debug level print for it.

Subsequent patches will retrieve and parse the discovery data and fill
out the Type C connector class data structures.

Also check the EC_FEATURE_TYPEC_CMD feature flag at probe, and only call
the new TYPEC_STATUS command if the feature flag is supported.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 52 +++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index faef56bcb9c5..98d22720b365 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -48,6 +48,9 @@ struct cros_typec_port {
 
 	/* Port alt modes. */
 	struct typec_altmode p_altmode[CROS_EC_ALTMODE_MAX];
+
+	/* Flag indicating that PD discovery data parsing is completed. */
+	bool disc_done;
 };
 
 /* Platform-specific data for the Chrome OS EC Type C controller. */
@@ -60,6 +63,7 @@ struct cros_typec_data {
 	struct cros_typec_port *ports[EC_USB_PD_MAX_PORTS];
 	struct notifier_block nb;
 	struct work_struct port_work;
+	bool typec_cmd_supported;
 };
 
 static int cros_typec_parse_port_props(struct typec_capability *cap,
@@ -182,6 +186,7 @@ static void cros_typec_remove_partner(struct cros_typec_data *typec,
 	typec_unregister_partner(port->partner);
 	port->partner = NULL;
 	memset(&port->p_identity, 0, sizeof(port->p_identity));
+	port->disc_done = false;
 }
 
 static void cros_unregister_ports(struct cros_typec_data *typec)
@@ -577,6 +582,31 @@ static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
 				     sizeof(req), resp, sizeof(*resp));
 }
 
+static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num)
+{
+	struct ec_response_typec_status resp;
+	struct ec_params_typec_status req = {
+		.port = port_num,
+	};
+	int ret;
+
+	ret = cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_STATUS, &req, sizeof(req),
+				    &resp, sizeof(resp));
+	if (ret < 0) {
+		dev_warn(typec->dev, "EC_CMD_TYPEC_STATUS failed for port: %d\n", port_num);
+		return;
+	}
+
+	if (typec->ports[port_num]->disc_done)
+		return;
+
+	/* Handle any events appropriately. */
+	if (resp.events & PD_STATUS_EVENT_SOP_DISC_DONE) {
+		dev_dbg(typec->dev, "SOP Discovery done for port: %d\n", port_num);
+		typec->ports[port_num]->disc_done = true;
+	}
+}
+
 static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 {
 	struct ec_params_usb_pd_control req;
@@ -613,6 +643,9 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 		cros_typec_set_port_params_v0(typec, port_num,
 			(struct ec_response_usb_pd_control *) &resp);
 
+	if (typec->typec_cmd_supported)
+		cros_typec_handle_status(typec, port_num);
+
 	/* Update the switches if they exist, according to requested state */
 	ret = cros_typec_get_mux_info(typec, port_num, &mux_resp);
 	if (ret < 0) {
@@ -661,6 +694,23 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
 	return 0;
 }
 
+/* Check the EC feature flags to see if TYPEC_* commands are supported. */
+int cros_typec_cmds_supported(struct cros_typec_data *typec)
+{
+	struct ec_response_get_features resp = {};
+	int ret;
+
+	ret = cros_typec_ec_command(typec, 0, EC_CMD_GET_FEATURES, NULL, 0,
+				    &resp, sizeof(resp));
+	if (ret < 0) {
+		dev_warn(typec->dev,
+			 "Failed to get features, assuming typec commands unsupported.\n");
+		return 0;
+	}
+
+	return resp.flags[EC_FEATURE_TYPEC_CMD / 32] & EC_FEATURE_MASK_1(EC_FEATURE_TYPEC_CMD);
+}
+
 static void cros_typec_port_work(struct work_struct *work)
 {
 	struct cros_typec_data *typec = container_of(work, struct cros_typec_data, port_work);
@@ -720,6 +770,8 @@ static int cros_typec_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	typec->typec_cmd_supported = !!cros_typec_cmds_supported(typec);
+
 	ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
 				    &resp, sizeof(resp));
 	if (ret < 0)
-- 
2.29.0.rc1.297.gfa9743e501-goog

