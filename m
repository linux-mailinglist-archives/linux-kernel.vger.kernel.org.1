Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DEF2AFCAC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgKLBmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:42:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgKLBZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 20:25:54 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6308CC061A48
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:24:49 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w14so2967792pfd.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DcGafbvQqN5zipJdHjKdMsCeDSLUNjhAWjdzvCFrZc=;
        b=T/tVtYvRnLaFMK2pmzumn5f7ZTAvTiButF/Ax1Jt0pH7X3qp3pR2hoeIefvqYBu1Ao
         jnV9/+1QKUrY0tIpFzLla2NR7UsZ1F64A6B7cggFN9mAb/iEEFg7GFs13j8tQyptCf3u
         8s3PYSItYMbIVSZKPIZOIdW/d9KjM0m0OoNLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DcGafbvQqN5zipJdHjKdMsCeDSLUNjhAWjdzvCFrZc=;
        b=gym/EjJGHa1CwQaOUpOzy5AC20pb19TfLqEVvAVlo5tkZH5MSbgsSwjspgXm+/4Pc5
         jP4QFG4NL1e/WMTZiuvlRJrTzGgJoJDr6e342t2EmBZpGEHsZA/jMAfsuldzVqe6qXJ5
         1030UGxtU3U9Ij3BOjGRcqc4wejsYeA+uO4U5/ZhYAhaQMq98rVSrFClp1ib5UcTDeK6
         iISH3CVM7g6uqc/Hqapx87/XDR4/nFGvSRlWkxQu8X0vVN5Sh8IvO91ULWszHZjfikuo
         lcPzmPoHSqZP6VX5AMs90o/N13A9We0D+rjWI4tEtjtvvkP+UnxirFkHLVbPX+B24GvJ
         FDIA==
X-Gm-Message-State: AOAM530jSP3L8Sw9FWYD1lX0Fyq1X6Y18S0iU3ffFqYz9UKj6sG5Jx0P
        4rLNLh80mBhdZ3JNFLRfiYvt55dZ7N6kHw==
X-Google-Smtp-Source: ABdhPJx6m8O9MvxH+06SSms5W0hAk08LkGKFpC/GeQI3hY+4VWoFN6J16BNCzuikI/G++uG3WTT/hw==
X-Received: by 2002:a62:7b4a:0:b029:18b:b3f:3fe6 with SMTP id w71-20020a627b4a0000b029018b0b3f3fe6mr24914159pfc.80.1605144288719;
        Wed, 11 Nov 2020 17:24:48 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id k25sm4057227pfi.42.2020.11.11.17.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 17:24:48 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        enric.balletbo@collabora.com
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 3/3] platform/chrome: cros_ec_typec: Register plug altmodes
Date:   Wed, 11 Nov 2020 17:23:32 -0800
Message-Id: <20201112012329.1364975-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201112012329.1364975-1-pmalani@chromium.org>
References: <20201112012329.1364975-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the altmode registration (and unregistration) code so that it
can be used by both partners and plugs.

Then, add code to register plug altmodes using the newly parameterized
function. Also set the number of alternate modes for the plug using the
associated Type C connector class function
typec_plug_set_num_altmodes().

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 50 ++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index d2e154ae2362..65c5d0090ccd 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -67,6 +67,7 @@ struct cros_typec_port {
 	bool sop_prime_disc_done;
 	struct ec_response_typec_discovery *disc_data;
 	struct list_head partner_mode_list;
+	struct list_head plug_mode_list;
 };
 
 /* Platform-specific data for the Chrome OS EC Type C controller. */
@@ -186,12 +187,15 @@ static int cros_typec_add_partner(struct cros_typec_data *typec, int port_num,
 	return ret;
 }
 
-static void cros_typec_unregister_altmodes(struct cros_typec_data *typec, int port_num)
+static void cros_typec_unregister_altmodes(struct cros_typec_data *typec, int port_num,
+					   bool is_partner)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 	struct cros_typec_altmode_node *node, *tmp;
+	struct list_head *head;
 
-	list_for_each_entry_safe(node, tmp, &port->partner_mode_list, list) {
+	head = is_partner ? &port->partner_mode_list : &port->plug_mode_list;
+	list_for_each_entry_safe(node, tmp, head, list) {
 		list_del(&node->list);
 		typec_unregister_altmode(node->amode);
 		devm_kfree(typec->dev, node);
@@ -203,7 +207,7 @@ static void cros_typec_remove_partner(struct cros_typec_data *typec,
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 
-	cros_typec_unregister_altmodes(typec, port_num);
+	cros_typec_unregister_altmodes(typec, port_num, true);
 
 	port->state.alt = NULL;
 	port->state.mode = TYPEC_STATE_USB;
@@ -224,6 +228,8 @@ static void cros_typec_remove_cable(struct cros_typec_data *typec,
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 
+	cros_typec_unregister_altmodes(typec, port_num, false);
+
 	typec_unregister_plug(port->plug);
 	port->plug = NULL;
 	typec_unregister_cable(port->cable);
@@ -352,6 +358,7 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 		}
 
 		INIT_LIST_HEAD(&cros_port->partner_mode_list);
+		INIT_LIST_HEAD(&cros_port->plug_mode_list);
 	}
 
 	return 0;
@@ -639,7 +646,11 @@ static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
 				     sizeof(req), resp, sizeof(*resp));
 }
 
-static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_num)
+/*
+ * Helper function to register partner/plug altmodes.
+ */
+static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_num,
+					bool is_partner)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 	struct ec_response_typec_discovery *sop_disc = port->disc_data;
@@ -657,7 +668,11 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
 			desc.mode = j;
 			desc.vdo = sop_disc->svids[i].mode_vdo[j];
 
-			amode = typec_partner_register_altmode(port->partner, &desc);
+			if (is_partner)
+				amode = typec_partner_register_altmode(port->partner, &desc);
+			else
+				amode = typec_plug_register_altmode(port->plug, &desc);
+
 			if (IS_ERR(amode)) {
 				ret = PTR_ERR(amode);
 				goto err_cleanup;
@@ -672,21 +687,30 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
 			}
 
 			node->amode = amode;
-			list_add_tail(&node->list, &port->partner_mode_list);
+
+			if (is_partner)
+				list_add_tail(&node->list, &port->partner_mode_list);
+			else
+				list_add_tail(&node->list, &port->plug_mode_list);
 			num_altmodes++;
 		}
 	}
 
-	ret = typec_partner_set_num_altmodes(port->partner, num_altmodes);
+	if (is_partner)
+		ret = typec_partner_set_num_altmodes(port->partner, num_altmodes);
+	else
+		ret = typec_plug_set_num_altmodes(port->plug, num_altmodes);
+
 	if (ret < 0) {
-		dev_err(typec->dev, "Unable to set partner num_altmodes for port: %d\n", port_num);
+		dev_err(typec->dev, "Unable to set %s num_altmodes for port: %d\n",
+			is_partner ? "partner" : "plug", port_num);
 		goto err_cleanup;
 	}
 
 	return 0;
 
 err_cleanup:
-	cros_typec_unregister_altmodes(typec, port_num);
+	cros_typec_unregister_altmodes(typec, port_num, is_partner);
 	return ret;
 }
 
@@ -774,6 +798,12 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
 		goto sop_prime_disc_exit;
 	}
 
+	ret = cros_typec_register_altmodes(typec, port_num, false);
+	if (ret < 0) {
+		dev_err(typec->dev, "Failed to register plug altmodes, port: %d\n", port_num);
+		goto sop_prime_disc_exit;
+	}
+
 	return 0;
 
 sop_prime_disc_exit:
@@ -815,7 +845,7 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
 		goto disc_exit;
 	}
 
-	ret = cros_typec_register_altmodes(typec, port_num);
+	ret = cros_typec_register_altmodes(typec, port_num, true);
 	if (ret < 0) {
 		dev_err(typec->dev, "Failed to register partner altmodes, port: %d\n", port_num);
 		goto disc_exit;
-- 
2.29.2.222.g5d2a92d10f8-goog

