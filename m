Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF202B5229
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbgKPUN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbgKPUN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:13:28 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FD2C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:13:28 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id v12so15180932pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZxKl4KnMpLhS0ObByuvx5Naa8y47uOCjdkpzZuISPg=;
        b=JNd0bE8+dxkH9Y6ebJC0QAcd73IqE4LlS5wACTH7/O9jFwmDqWIqSUr/wo54Fq7/5r
         gr7rMHs1LFQ1SLKSA+nf5xA9A2ve8JUCBC/lJekm5OfQgt2l5G0awla/dAv4aF8BnaHw
         qbLA4AF7kClaC4beqCyNnqieIXttFPWeHhFNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZxKl4KnMpLhS0ObByuvx5Naa8y47uOCjdkpzZuISPg=;
        b=cQkOVCOpukC33IseRUySoBoya0zaAZlo4yUOg4Q0yiaqr3PhfcTS1QXZbe2fr5OCQW
         1i2Pe2YP+8BEwMOo9ZaB1OaAzIr/RKAX3j4zRIzPMADGJgm0+N2i0SvB0o5Z31TNeAT4
         4pSv/z+kYHVmTEAYgHufvimS5aTs6HlGX0QACT7M0q7pIdCTpg2q0Vdl1gNIKm7hBJTC
         QqDFSynjvFBLElNAya3jHSsbqrq654exG2AYKxri4S54TNnj1679QwlfXnEof76M4BLt
         ezqO9NzMBO1rEBLYh238M+f2hXvvlpEaWBayl55WX6LfBOe7QwgT6LMLcPKPDnW3qM14
         cY6A==
X-Gm-Message-State: AOAM532IfsFVj4jkIo3TJgKWdpbyLJ98dzBZh36GhrdmzyWTaBj+3sP4
        6rQbCLgvvrHUa10/xl+MuL855AaQJTrzGA==
X-Google-Smtp-Source: ABdhPJwLGEYmEckqZ667EUw/B0TMmVWDvk1hOtFQNyfqaw8uDscu4OT8/LCQMoy7YMyuYD2D8agRtg==
X-Received: by 2002:a63:2155:: with SMTP id s21mr740412pgm.3.1605557607664;
        Mon, 16 Nov 2020 12:13:27 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id a12sm234577pjh.48.2020.11.16.12.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 12:13:27 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        enric.balletbo@collabora.com
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 07/11] platform/chrome: cros_ec_typec: Register cable
Date:   Mon, 16 Nov 2020 12:11:50 -0800
Message-Id: <20201116201150.2919178-8-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201116201150.2919178-1-pmalani@chromium.org>
References: <20201116201150.2919178-1-pmalani@chromium.org>
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
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---

Changes in v3:
- Re-arranged patch order and combined it with related series of
  patches.
- Added Reviewed-by tags

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
2.29.2.299.gdc1121823c-goog

