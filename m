Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D272953B0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 22:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505624AbgJUUy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 16:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439388AbgJUUy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:54:26 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21889C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:54:26 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id r10so1856373plx.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4aTOPGERENR8yUy5wKMQ29EIQ8wp11NWQIWwwsPfDdQ=;
        b=m0jkETXxAdVebtd1UlgZEDuaRKVKKnd2cBynv1JtiyBTm5CoVCRJef80PdjrPnYPI7
         +dgzik0y3VXkzWEwrnv1YVDXaOs0Kt5PNgipATb5su001vXpbe/7xD4u/9/vfLJB5BZw
         F6gTiagXrHTD60krHI6AF6pnBlvA52XeeP9lQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4aTOPGERENR8yUy5wKMQ29EIQ8wp11NWQIWwwsPfDdQ=;
        b=UXGcsNDqehewPL2n6Ufm7rMzOTxEb5wCYo4qE9RaIkdrUM0onIi6k4undiEOE7tJin
         xAH+tarT9wCdrVNXJrtoSUNDLwsygnPBoxtHJTEK4yFQDP8SoIxYP4iPlzAG9zJ77Vlr
         j7aFR8388EyaWeURYNGRyockGUguVMs+6uEImdT+/3EMlgE4BxhcAcM2MxjQhBIP+eO4
         Qb8QZRO07BzYTkC9gjRD1X/7aw5L2xBrm1lt96j1pdIWZelejCafZ9Lr8su5jCclxAdn
         MpOkdi/L4WHvUpcq+Lj5KyrgJ4mf7CW80qgn6xVgYkqmuvhJlNSbv9Zc9WNxO8gkATsl
         7ibg==
X-Gm-Message-State: AOAM5324KEZq8m6yZXiy49bBl6pVjE27OLT1ttZqso21EaTpBHX9WdOd
        biKi9lx+iU7CGx89VgF6q+issPRxpH9IPw==
X-Google-Smtp-Source: ABdhPJw4rPCn18B6ToD+mFyywusIFzISZsFLxQ2austxZugEEVspwfcM2ksHWq+PQgfcTJsn+5vCIw==
X-Received: by 2002:a17:90a:9ec:: with SMTP id 99mr4972222pjo.138.1603313665498;
        Wed, 21 Oct 2020 13:54:25 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id q8sm3178087pfg.118.2020.10.21.13.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 13:54:25 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 7/7] platform/chrome: cros_ec_typec: Register partner altmodes
Date:   Wed, 21 Oct 2020 13:53:16 -0700
Message-Id: <20201021205317.708008-8-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201021205317.708008-1-pmalani@chromium.org>
References: <20201021205317.708008-1-pmalani@chromium.org>
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
 drivers/platform/chrome/cros_ec_typec.c | 79 +++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 53d0b4b4fcd7..57d38570e292 100644
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
@@ -172,11 +180,27 @@ static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
 	return ret;
 }
 
+static void cros_typec_unregister_altmodes(struct cros_typec_data *typec, int port_num)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+	struct cros_typec_altmode_node *node;
+
+	while (!list_empty(&port->partner_mode_list)) {
+		node = list_first_entry(&port->partner_mode_list, struct cros_typec_altmode_node,
+					list);
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
@@ -306,6 +330,8 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 			ret = -ENOMEM;
 			goto unregister_ports;
 		}
+
+		INIT_LIST_HEAD(&cros_port->partner_mode_list);
 	}
 
 	return 0;
@@ -590,6 +616,49 @@ static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
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
@@ -630,6 +699,16 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
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
2.29.0.rc1.297.gfa9743e501-goog

