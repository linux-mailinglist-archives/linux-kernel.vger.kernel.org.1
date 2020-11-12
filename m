Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A381C2AFCAB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgKLBlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:41:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728243AbgKLBZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 20:25:54 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A4FC061A04
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:24:37 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id y22so1926523plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41X4qdq1QStAhs6bWw06Pe1Ece1bEX2YsPzbBS2o1yE=;
        b=AOyYNkE2Ru0MG53w1GH5O3Ed5uldH1DWQ1oMnk1ZxmxhAAWqeY6EysMHeUflfmTEEc
         vuOol3gYVLR23NUyynScunka9XTMYp8ZmQFwclu9K7wc8rv7vL/ftJ3/HjZlx2HDjPQd
         bubuwjNu6GefOhgMlPUK36TkLuhpJH96fZsfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41X4qdq1QStAhs6bWw06Pe1Ece1bEX2YsPzbBS2o1yE=;
        b=YBIypbcU8q8sdz506bltKajDmq4k1Eidm9lG4RhKqiz/JIFzzQ1VuYS+eTiINKpe8U
         QXkZyG5MMxkg/+wItkCUbWAgSXGUA+B0SlADN0OOIsyf432W8nV5NNbQwQ1A4Eu1xAGy
         HaLr/yDX0xsGQAvggnh5AOLnsSIHe/iwUhavSlSh/MDstsV2XNcJTypNyxsnlSASE6rD
         Z2eKrJSbVJ4RJu3it8ERBA09AA4Ib7d8JtNzrgWLR+kWg5hwdaj+jCTS/5pBAipFWlb0
         bTBiKDC7To458Ki/krElpJyrRXmldU7iLAjJPqkxkm0CRRLpX2jn0sMenOufDpJZmyHc
         PNTw==
X-Gm-Message-State: AOAM532IbPe/l1KSeA/Fq2a/Ev3ynJQ8twfgoWjs37I+8gJkjTUgucGw
        HxXt3TlfPSB/MBLrT5XeHVgdH1KH1ibRDA==
X-Google-Smtp-Source: ABdhPJzDukbrL5oVwXy+hp1AxW4UGWx6XraSVpU65CQNjG3tXOmq35Uuw/P7xzqf774B49HMtMX9hA==
X-Received: by 2002:a17:902:b945:b029:d5:f385:237e with SMTP id h5-20020a170902b945b02900d5f385237emr310501pls.84.1605144276416;
        Wed, 11 Nov 2020 17:24:36 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id k25sm4057227pfi.42.2020.11.11.17.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 17:24:35 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        enric.balletbo@collabora.com
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 2/3] platform/chrome: cros_ec_typec: Register SOP' cable plug
Date:   Wed, 11 Nov 2020 17:23:30 -0800
Message-Id: <20201112012329.1364975-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201112012329.1364975-1-pmalani@chromium.org>
References: <20201112012329.1364975-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to register cable alternate modes, we need to first register a
plug object. Use the Type C connector class framework to register a SOP'
plug for this purpose.

Since a cable and plug go hand in hand, we can handle the registration
and removal together.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 35 ++++++++++++++++++-------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index ad5e37bfd45d..d2e154ae2362 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -45,6 +45,8 @@ struct cros_typec_port {
 	struct typec_capability caps;
 	struct typec_partner *partner;
 	struct typec_cable *cable;
+	/* SOP' plug. */
+	struct typec_plug *plug;
 	/* Port partner PD identity info. */
 	struct usb_pd_identity p_identity;
 	/* Port cable PD identity info. */
@@ -222,6 +224,8 @@ static void cros_typec_remove_cable(struct cros_typec_data *typec,
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 
+	typec_unregister_plug(port->plug);
+	port->plug = NULL;
 	typec_unregister_cable(port->cable);
 	port->cable = NULL;
 	memset(&port->c_identity, 0, sizeof(port->c_identity));
@@ -712,7 +716,8 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 	struct ec_response_typec_discovery *disc = port->disc_data;
-	struct typec_cable_desc desc = {};
+	struct typec_cable_desc c_desc = {};
+	struct typec_plug_desc p_desc;
 	struct ec_params_typec_discovery req = {
 		.port = port_num,
 		.partner_type = TYPEC_PARTNER_SOP_PRIME,
@@ -735,32 +740,44 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
 		cable_plug_type = VDO_TYPEC_CABLE_TYPE(port->c_identity.vdo[0]);
 		switch (cable_plug_type) {
 		case CABLE_ATYPE:
-			desc.type = USB_PLUG_TYPE_A;
+			c_desc.type = USB_PLUG_TYPE_A;
 			break;
 		case CABLE_BTYPE:
-			desc.type = USB_PLUG_TYPE_B;
+			c_desc.type = USB_PLUG_TYPE_B;
 			break;
 		case CABLE_CTYPE:
-			desc.type = USB_PLUG_TYPE_C;
+			c_desc.type = USB_PLUG_TYPE_C;
 			break;
 		case CABLE_CAPTIVE:
-			desc.type = USB_PLUG_CAPTIVE;
+			c_desc.type = USB_PLUG_CAPTIVE;
 			break;
 		default:
-			desc.type = USB_PLUG_NONE;
+			c_desc.type = USB_PLUG_NONE;
 		}
-		desc.active = PD_IDH_PTYPE(port->c_identity.id_header) == IDH_PTYPE_ACABLE;
+		c_desc.active = PD_IDH_PTYPE(port->c_identity.id_header) == IDH_PTYPE_ACABLE;
 	}
 
-	desc.identity = &port->c_identity;
+	c_desc.identity = &port->c_identity;
 
-	port->cable = typec_register_cable(port->port, &desc);
+	port->cable = typec_register_cable(port->port, &c_desc);
 	if (IS_ERR(port->cable)) {
 		ret = PTR_ERR(port->cable);
 		port->cable = NULL;
+		goto sop_prime_disc_exit;
+	}
+
+	p_desc.index = TYPEC_PLUG_SOP_P;
+	port->plug = typec_register_plug(port->cable, &p_desc);
+	if (IS_ERR(port->plug)) {
+		ret = PTR_ERR(port->plug);
+		port->plug = NULL;
+		goto sop_prime_disc_exit;
 	}
 
+	return 0;
+
 sop_prime_disc_exit:
+	cros_typec_remove_cable(typec, port_num);
 	return ret;
 }
 
-- 
2.29.2.222.g5d2a92d10f8-goog

