Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065DB29F7FD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgJ2W25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgJ2W24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:28:56 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438B4C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:28:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o3so3501706pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZuL/4Z5oz6PvKJixqjjqZlgz875aywjVq2+QBIc6KnA=;
        b=AmtFYJRQ8+LfSKiXF9d6Fz6bUdk396pAvMC+BpT7jboB5+Lkgy1KBQVltjyi0jLq6+
         NS08XL9zlCAhyGbQjgQGEXHCP5Pz1oQjvt0jOMOUEHuQkPsIeLmZVs285PIHM+82l2Y8
         G2kqHOiR/CGPtmg8k25USmqCKZaZXnPB+OHrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZuL/4Z5oz6PvKJixqjjqZlgz875aywjVq2+QBIc6KnA=;
        b=YdMOA6wjPnc4kejihKnvQgMboaj4bEaGU+xO0IvipRwbrItjnyWeD1XYlwxMe3vTsZ
         AHfoqxCaVDocZ7HM9noq4CEhg04be0vDYpTrWyPPlZZ3VtBhi9YrwLDF6WLjMp6e1zpC
         RUSeRWTX/zOkyA7T95MwZnXzrcvLBEz2kYSbgMH/iLLVTsHWoITbtXHmEuIKQpJihrgH
         gFu+6sXVvbNssg38Lh1VfRKaHM7UMtciiW460iK2/Qyb/PqbVIisu7OGebuVho0JiF35
         XjqgKwJnJwIDCuxWCWLEe4krc79tNUVUS3vlCsA+zVSeB9DgKI03L1fXsOUIKL4kKpX3
         XRQQ==
X-Gm-Message-State: AOAM5305xORbeXC8uZFOSmKU0yUPLE6tpol1x2I6RfQy8IXFSGvX+akm
        c7B0nOaOo245C+M1wWZ0MUEP+E3SW8qeHA==
X-Google-Smtp-Source: ABdhPJx+zI3qV9pFR+8bdNKJcQqUhodM8VSoPhLaVOOGBtD6kUNm+uTWt1FEoqAEqJk0hBpA97LEJg==
X-Received: by 2002:a17:90b:378c:: with SMTP id mz12mr1381135pjb.137.1604010535617;
        Thu, 29 Oct 2020 15:28:55 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id f5sm3573886pgi.86.2020.10.29.15.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 15:28:55 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, dzigterman@chromium.org,
        alevkoy@chromium.org, Prashant Malani <pmalani@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 5/7] platform/chrome: cros_ec_typec: Introduce TYPEC_STATUS
Date:   Thu, 29 Oct 2020 15:27:38 -0700
Message-Id: <20201029222738.482366-6-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201029222738.482366-1-pmalani@chromium.org>
References: <20201029222738.482366-1-pmalani@chromium.org>
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

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Added missing 'static' keyword for cros_typec_cmds_supported()
  function.

 drivers/platform/chrome/cros_ec_typec.c | 52 +++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index faef56bcb9c5..f578d0bfbe5a 100644
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
+static int cros_typec_cmds_supported(struct cros_typec_data *typec)
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
2.29.1.341.ge80a0c044ae-goog

