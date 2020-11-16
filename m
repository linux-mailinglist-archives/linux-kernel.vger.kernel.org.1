Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E562B5232
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732080AbgKPUOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbgKPUOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:14:40 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA157C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:14:38 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w14so15205289pfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lkeW7kPlf1ZJfdTSvhZEdTM2alKEpZYKM6J6Duyeiqs=;
        b=G0fda/1l3vepLRgMrXn4mch8EcJ0mX5Dze/zlKrH5DG0q6a+c/RqkNhhYwcBzFALi+
         hw7A01l/r9XQ97Amocua3nNwt9wwTPlUEk+Vl2AO/JLQO9WMQFr9O39wt93DkBOvlolV
         2Xuoy0o4h0reg7VTA6kXhU7A9BKxdD26nTmIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lkeW7kPlf1ZJfdTSvhZEdTM2alKEpZYKM6J6Duyeiqs=;
        b=Ni+3LtMq21+k4TXc0ymqTag4ulKESCsWSMs8duadd4hwf4zuibvFM3JeWhOR3z+SF0
         TQUaOLKZvHEA2owtWd3GVzJp7//3WydILpeaRgamUmmcBJPozuQUZ/DLdyzcekIzFNrM
         48r9vaQTmgUEeUpxYCXH3O4lY5Os2uaZKOgrldrRmKJlLDxJrAHk+2LPCs5z8rSkVlXY
         m2ppfS8Ca4W4uyUhODy3KKnV5Lk6zxxW7YSsorMIVFskY1b2fm0vHSM6QZ2ZvqlMgry5
         a/mBPtJMxLXKNK7tdz6JwvJ5c0e6Hy0SyOb3HKefdl5WGD8nu6/0+krHFsKS5HBucKsQ
         JvSg==
X-Gm-Message-State: AOAM533mljMEn+2Z34QZXUPYhQ/b4WrP+2MdYbMcHDbBULtZ+e+cwcXG
        uXFN/LCxm9TbRh0J2WEjgG68bu20taLNyQ==
X-Google-Smtp-Source: ABdhPJyBUYAv0LeYlNPttfY6zlgdK/h8V3kY6Q7TgNcf9A2mST28n0XqbVwvx8vqeqw4pXCRo6CuHw==
X-Received: by 2002:a17:90b:1490:: with SMTP id js16mr592093pjb.215.1605557678027;
        Mon, 16 Nov 2020 12:14:38 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id a12sm234577pjh.48.2020.11.16.12.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 12:14:37 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        enric.balletbo@collabora.com
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 10/11] platform/chrome: cros_ec_typec: Register SOP' cable plug
Date:   Mon, 16 Nov 2020 12:11:56 -0800
Message-Id: <20201116201150.2919178-11-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201116201150.2919178-1-pmalani@chromium.org>
References: <20201116201150.2919178-1-pmalani@chromium.org>
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

Changes in v3:
- Re-arranged patch order and combined it with related series of
  patches.

No version v2.

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
2.29.2.299.gdc1121823c-goog

