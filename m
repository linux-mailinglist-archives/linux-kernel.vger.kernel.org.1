Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C3E2A8C19
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732882AbgKFB3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730895AbgKFB3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:29:09 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F91C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:29:09 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c20so2811296pfr.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+aprFeqbjBLbZzk3G0C0v3jxV1PzxWAtqnLo3bEYZpM=;
        b=Rp6PZuzA3vpgW9L9vj9CniOn5viX66sJFg38uvL+T9LK1/i8RGHYwqSfBadjMrlPpR
         Y4xZrofOIGkv+yM+O4TX3AXy6Z6KtEUxWcUW2Xe9878JlkLFsYplumv0or+o5mtb2cnP
         s/kuMZZXLOhj64HyPn0ysiFIc/lAtEbNI8zUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+aprFeqbjBLbZzk3G0C0v3jxV1PzxWAtqnLo3bEYZpM=;
        b=kT51Uj2PqEOZTSeqY+U6Gy6y26vzbeMDvlY6aW6o13MwC0jk0rEWB4PqmtZWMVGiAj
         9kCQ47B+pBi5KSviqpII+BTUxeDlWiZ/75Uw8dBK/xNv/61VCDsGC02VDW9HByLJuEA2
         XZlY6oDQfLGx0pJgA4y3NvoGiZ+coVxrM9IlEoQELjpvSxpg9n9qx7t/z20UieSs6Zkz
         zdtx5YhDGJXkN43L0Wzr2FAPE3oORriwViqrsvf+p/pY+Tp0Zj1MslMcKm5KFyQFf6jS
         nQUpcjk4pRg5CwRGlO0nBu3bUC4iIIxjiSSKTlwg7G0tw3zeUjZcNxWiqQgZXl7oScp6
         iIig==
X-Gm-Message-State: AOAM5302JQAPP92d6o9e9SdsGipiUitJCQflnpZIVbneq+0uiPOPxczP
        gY51C1FMp9trbJFiB/kMqMtOqZnpURqdkg==
X-Google-Smtp-Source: ABdhPJwriF6FVQ9iwgy/52RPZqRNmktxSz1b5ZRJma/gv5MOP6ymUx1s5/7uG/gCc/YssLnrWn4MyQ==
X-Received: by 2002:a17:90a:d584:: with SMTP id v4mr5399731pju.194.1604626148486;
        Thu, 05 Nov 2020 17:29:08 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id e2sm3567887pgd.27.2020.11.05.17.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 17:29:08 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, dzigterman@chromium.org,
        alevkoy@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 4/6] platform/chrome: cros_ec_typec: Register cable
Date:   Thu,  5 Nov 2020 17:27:59 -0800
Message-Id: <20201106012758.525472-5-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106012758.525472-1-pmalani@chromium.org>
References: <20201106012758.525472-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the Chrome Embedded Controller notifies the driver that SOP'
discovery is complete, retrieve the PD discovery data and register a
cable object with the Type C connector class framework.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 67 +++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 3c8ff07c8803..5e7f0b4ebbec 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -44,8 +44,11 @@ struct cros_typec_port {
 	/* Initial capabilities for the port. */
 	struct typec_capability caps;
 	struct typec_partner *partner;
+	struct typec_cable *cable;
 	/* Port partner PD identity info. */
 	struct usb_pd_identity p_identity;
+	/* Port cable PD identity info. */
+	struct usb_pd_identity c_identity;
 	struct typec_switch *ori_sw;
 	struct typec_mux *mux;
 	struct usb_role_switch *role_sw;
@@ -59,6 +62,7 @@ struct cros_typec_port {
 
 	/* Flag indicating that PD partner discovery data parsing is completed. */
 	bool sop_disc_done;
+	bool sop_prime_disc_done;
 	struct ec_response_typec_discovery *disc_data;
 	struct list_head partner_mode_list;
 };
@@ -213,6 +217,17 @@ static void cros_typec_remove_partner(struct cros_typec_data *typec,
 	port->sop_disc_done = false;
 }
 
+static void cros_typec_remove_cable(struct cros_typec_data *typec,
+				    int port_num)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+
+	typec_unregister_cable(port->cable);
+	port->cable = NULL;
+	memset(&port->c_identity, 0, sizeof(port->c_identity));
+	port->sop_prime_disc_done = false;
+}
+
 static void cros_unregister_ports(struct cros_typec_data *typec)
 {
 	int i;
@@ -224,6 +239,9 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
 		if (typec->ports[i]->partner)
 			cros_typec_remove_partner(typec, i);
 
+		if (typec->ports[i]->cable)
+			cros_typec_remove_cable(typec, i);
+
 		usb_role_switch_put(typec->ports[i]->role_sw);
 		typec_switch_put(typec->ports[i]->ori_sw);
 		typec_mux_put(typec->ports[i]->mux);
@@ -600,6 +618,9 @@ static void cros_typec_set_port_params_v1(struct cros_typec_data *typec,
 		if (!typec->ports[port_num]->partner)
 			return;
 		cros_typec_remove_partner(typec, port_num);
+
+		if (typec->ports[port_num]->cable)
+			cros_typec_remove_cable(typec, port_num);
 	}
 }
 
@@ -679,6 +700,43 @@ static void cros_typec_parse_pd_identity(struct usb_pd_identity *id,
 		id->vdo[i - 3] = disc->discovery_vdo[i];
 }
 
+static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int port_num)
+{
+	struct cros_typec_port *port = typec->ports[port_num];
+	struct ec_response_typec_discovery *disc = port->disc_data;
+	struct typec_cable_desc desc = {};
+	struct ec_params_typec_discovery req = {
+		.port = port_num,
+		.partner_type = TYPEC_PARTNER_SOP_PRIME,
+	};
+	int ret = 0;
+
+	memset(disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
+	ret = cros_typec_ec_command(typec, 0, EC_CMD_TYPEC_DISCOVERY, &req, sizeof(req),
+				    disc, EC_PROTO2_MAX_RESPONSE_SIZE);
+	if (ret < 0) {
+		dev_err(typec->dev, "Failed to get SOP' discovery data for port: %d\n", port_num);
+		goto sop_prime_disc_exit;
+	}
+
+	/* Parse the PD identity data, even if only 0s were returned. */
+	cros_typec_parse_pd_identity(&port->c_identity, disc);
+
+	if (disc->identity_count != 0)
+		desc.active = PD_IDH_PTYPE(port->c_identity.id_header) == IDH_PTYPE_ACABLE;
+
+	desc.identity = &port->c_identity;
+
+	port->cable = typec_register_cable(port->port, &desc);
+	if (IS_ERR(port->cable)) {
+		ret = PTR_ERR(port->cable);
+		port->cable = NULL;
+	}
+
+sop_prime_disc_exit:
+	return ret;
+}
+
 static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
@@ -746,6 +804,15 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
 		else
 			typec->ports[port_num]->sop_disc_done = true;
 	}
+
+	if (resp.events & PD_STATUS_EVENT_SOP_PRIME_DISC_DONE &&
+	    !typec->ports[port_num]->sop_prime_disc_done) {
+		ret = cros_typec_handle_sop_prime_disc(typec, port_num);
+		if (ret < 0)
+			dev_err(typec->dev, "Couldn't parse SOP' Disc data, port: %d\n", port_num);
+		else
+			typec->ports[port_num]->sop_prime_disc_done = true;
+	}
 }
 
 static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
-- 
2.29.1.341.ge80a0c044ae-goog

