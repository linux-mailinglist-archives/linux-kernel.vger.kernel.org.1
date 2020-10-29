Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B587929F7FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 23:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgJ2W3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 18:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJ2W3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 18:29:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD8FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:29:15 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so3511935pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wdKDl1LjXQvhQ1AkC6QGURA87mnCJHEgAmHs7Sv9BfA=;
        b=UANId4OxR4AQ/TXYfq+9qY+N50+uQ610bGa7AfWlJjDjEXhkKG9LLC+SQCR3K0YIEJ
         crm7Ogzu5RVLQb7uWiP6zkDB6M8+e6w7xhxe2kdLESomKCTr+ixj4bF7pLNSNCDuc1Tw
         vcOlwjWtxnwvY8JY0l+huoFxnw1OYOk5JAOUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wdKDl1LjXQvhQ1AkC6QGURA87mnCJHEgAmHs7Sv9BfA=;
        b=m7lFF7ID5VBexRHJIdzxkp+/9XpsUW/upMSTdvwL7WAU8S24l7Y0oHQ9724EIrp4CB
         AxYg86hCpIcHRVEXWgSR94WRA0sRGpzEZ5v4fGJmifToxbtsHnSGZxbvsuifh0izcljP
         I+MRTcZYwR0TiPUiU5s4Ge6VVU3J6TwZO7b0LhK41j7RHXcQYzJIWW2y7llSnPv7HtSv
         LrXLOLGsU6GkzHhY3VPx1nxnvGNtXsRyrbdNsVOQvIpcMZNkZOy344w5gKTMvzEUIVop
         u1slUXXmYXv830XsSgGsnEzznDbGDMP2K5XyREzxW+Use4cfk+aa6mBGKv/RFi2Wf93E
         hy3Q==
X-Gm-Message-State: AOAM530o08mF5KQ20fsbW9Ck8R3b+Wpu/4WVD7+PsiU1z5rl6klMGGMe
        I/+vdMgY/+krMnlbwT3F09obLimKw7Eu/A==
X-Google-Smtp-Source: ABdhPJxiSqPui1DlZJfaXq8NXex5UTbYXvSPRXJ7OyaX/6yWlKwowqUeR6vlTwW4EexF+2mxr4ikfQ==
X-Received: by 2002:aa7:9388:0:b029:160:cf7:b2ea with SMTP id t8-20020aa793880000b02901600cf7b2eamr6315653pfe.27.1604010554913;
        Thu, 29 Oct 2020 15:29:14 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id f5sm3573886pgi.86.2020.10.29.15.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 15:29:14 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, dzigterman@chromium.org,
        alevkoy@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 7/7] platform/chrome: cros_ec_typec: Register partner altmodes
Date:   Thu, 29 Oct 2020 15:27:42 -0700
Message-Id: <20201029222738.482366-8-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201029222738.482366-1-pmalani@chromium.org>
References: <20201029222738.482366-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the discovery data from the Chrome EC to register parter altmodes
with the Type C Connector Class framework. Also introduce a node
struct to keep track of the list of registered alt modes.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Changed list traversal during alt mode unregistering to use
  list_for_each_entry_safe() base on review comment.

 drivers/platform/chrome/cros_ec_typec.c | 77 +++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index f14550dac614..ce031a10eb1b 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_data/cros_ec_commands.h>
@@ -31,6 +32,12 @@ enum {
 	CROS_EC_ALTMODE_MAX,
 };
 
+/* Container for altmode pointer nodes. */
+struct cros_typec_altmode_node {
+	struct typec_altmode *amode;
+	struct list_head list;
+};
+
 /* Per port data. */
 struct cros_typec_port {
 	struct typec_port *port;
@@ -53,6 +60,7 @@ struct cros_typec_port {
 	/* Flag indicating that PD discovery data parsing is completed. */
 	bool disc_done;
 	struct ec_response_typec_discovery *sop_disc;
+	struct list_head partner_mode_list;
 };
 
 /* Platform-specific data for the Chrome OS EC Type C controller. */
@@ -172,11 +180,25 @@ static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
 	return ret;
 }
 
+static void cros_typec_unregister_altmodes(struct cros_typec_data *typec, int port_num)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+	struct cros_typec_altmode_node *node, *tmp;
+
+	list_for_each_entry_safe(node, tmp, &port->partner_mode_list, list) {
+		list_del(&node->list);
+		typec_unregister_altmode(node->amode);
+		devm_kfree(typec->dev, node);
+	}
+}
+
 static void cros_typec_remove_partner(struct cros_typec_data *typec,
 				     int port_num)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 
+	cros_typec_unregister_altmodes(typec, port_num);
+
 	port->state.alt = NULL;
 	port->state.mode = TYPEC_STATE_USB;
 	port->state.data = NULL;
@@ -306,6 +328,8 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 			ret = -ENOMEM;
 			goto unregister_ports;
 		}
+
+		INIT_LIST_HEAD(&cros_port->partner_mode_list);
 	}
 
 	return 0;
@@ -590,6 +614,49 @@ static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
 				     sizeof(req), resp, sizeof(*resp));
 }
 
+static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_num)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+	struct ec_response_typec_discovery *sop_disc = port->sop_disc;
+	struct cros_typec_altmode_node *node;
+	struct typec_altmode_desc desc;
+	struct typec_altmode *amode;
+	int ret = 0;
+	int i, j;
+
+	for (i = 0; i < sop_disc->svid_count; i++) {
+		for (j = 0; j < sop_disc->svids[i].mode_count; j++) {
+			memset(&desc, 0, sizeof(desc));
+			desc.svid = sop_disc->svids[i].svid;
+			desc.mode = j;
+			desc.vdo = sop_disc->svids[i].mode_vdo[j];
+
+			amode = typec_partner_register_altmode(port->partner, &desc);
+			if (IS_ERR(amode)) {
+				ret = PTR_ERR(amode);
+				goto err_cleanup;
+			}
+
+			/* If no memory is available we should unregister and exit. */
+			node = devm_kzalloc(typec->dev, sizeof(*node), GFP_KERNEL);
+			if (!node) {
+				ret = -ENOMEM;
+				typec_unregister_altmode(amode);
+				goto err_cleanup;
+			}
+
+			node->amode = amode;
+			list_add_tail(&node->list, &port->partner_mode_list);
+		}
+	}
+
+	return 0;
+
+err_cleanup:
+	cros_typec_unregister_altmodes(typec, port_num);
+	return ret;
+}
+
 static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
@@ -630,6 +697,16 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
 		port->p_identity.vdo[i - 3] = sop_disc->discovery_vdo[i];
 
 	ret = typec_partner_set_identity(port->partner);
+	if (ret < 0) {
+		dev_err(typec->dev, "Failed to update partner PD identity, port: %d\n", port_num);
+		goto disc_exit;
+	}
+
+	ret = cros_typec_register_altmodes(typec, port_num);
+	if (ret < 0) {
+		dev_err(typec->dev, "Failed to register partner altmodes, port: %d\n", port_num);
+		goto disc_exit;
+	}
 
 disc_exit:
 	return ret;
-- 
2.29.1.341.ge80a0c044ae-goog

