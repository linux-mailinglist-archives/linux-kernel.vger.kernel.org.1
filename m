Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA672A9C96
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgKFSmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgKFSmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:42:06 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E78C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 10:42:06 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id w4so1584545pgg.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 10:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5EZhbJ3C4t4hJhEZ2rcWc8jkgRA7J6G3Sqacz6pQbKk=;
        b=GlnjqT95BiH0kFLKse/Vi8e+S3vcjYAnz9KX0JpJpySOh67IwOseV+Ee8ZU2XLQZsE
         5mF9bZmcyk5cH4R2BN0c0CXiFTDVGKFiIZ+a1LD03Gp/fdfMup/q+opDAYE9JCJ2JT27
         /dOIN6XqkRUvFtprXquwMF3znkVU9GAWblpys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5EZhbJ3C4t4hJhEZ2rcWc8jkgRA7J6G3Sqacz6pQbKk=;
        b=LoOv1aOSgJD4yoAU1GCv7yPeyy5Phgsv0SQNcRd52j1Tyj1aCNG2gX/2PdMXvVh1s4
         4oTbdnsfl8d6BEkaVK6CLjleN8qBF57dS9VMnp2iTLSa2Ly337/1khWmw4JtwvApswZt
         xkQvhx3bYFLcy0tfaoohRicg8Lt/rSIyVUoqup+64zDkFAyQbAQDXK3Dzp5iwKad/RrH
         VgGenOw4rTWw8wfxSFB9vnT25N6DB/2W55CTv19dvtEihHovBux64bFV9oTXkRnZQLwF
         sgdJzeJpdsGJiDacDQ32qgdZiVZBF1WEF4zpxn/1nqIWyj1z/LedQShoLmHnZFR+sPVz
         sx1w==
X-Gm-Message-State: AOAM5332wYoMGxXzYJ/Gd0L43LsStMjmGV97Z7q1PruL6NNaso7jFdIz
        D39qiIGacVt4k3fpmhqTGYqrEejxFVXIwQ==
X-Google-Smtp-Source: ABdhPJwyQYX3JnXiI25GTyzm7Y/RJX8OESCJxRkojyHaPRLibqNRGgS2pwlW/TATwH+zDB5DYPbcpg==
X-Received: by 2002:a63:e54a:: with SMTP id z10mr2615528pgj.297.1604688126190;
        Fri, 06 Nov 2020 10:42:06 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id b6sm3246143pjq.42.2020.11.06.10.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:42:05 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 4/6] platform/chrome: cros_ec_typec: Register cable
Date:   Fri,  6 Nov 2020 10:41:06 -0800
Message-Id: <20201106184104.939284-5-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106184104.939284-1-pmalani@chromium.org>
References: <20201106184104.939284-1-pmalani@chromium.org>
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

Changes in v2:
- No changes.

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

