Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0CF2B5222
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbgKPUNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbgKPUNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:13:08 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8851C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:13:07 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id p68so3739775pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RCMqI38F9+XIUIyYtqumHY3HDKRkeDtWdAUlKq29RGI=;
        b=noWTjOQtjRfLv3wqepfM5xq1e0ZWG2Mrqfmq0pDljUMkzwggz9M4QD3VkCUAmMyUga
         GD9KCZiJwDAlwyyb+PRUQBBjlTzRYTiwrwj5rG1DFlYAxsg9ZDLQDdQYknxt+kNPZrmf
         Lt6ssatMc/iYPQqINiMGOks+2d8fO0A+ngRcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RCMqI38F9+XIUIyYtqumHY3HDKRkeDtWdAUlKq29RGI=;
        b=nJFfitiAz+uFv7c08fCCxTuUJehj/E+FO7i9uDDtOhTg83bEod87Odm76WK5vLKWuP
         jNCxmzF01I0YDE7OY3AiCztCZO+4A3QVXtxg5wV3QnoaDIM7cSFptnO6mmjP1L5TGYSo
         GSfAZPQuDMvVVkA/UQgZKvrVyyc4bRkDHchs/NmFHEeN4JS6wK419TxdRR1bgE2kSpVl
         LessKH7d7WPGlvwLq7kdWdEurvN9TUx/0fHG/7MDElb0Em0b6wjPtzdk0neqk+F1zxwK
         74Gb2IPSOLzl3AfeoDn1x5STIhMhlEEBOkTP7OSdcZrdJmgtoX97a2m96GCjpwv7nM67
         Y+qQ==
X-Gm-Message-State: AOAM530tDYR17awKcAL4HHXAexp5to08j0GTHOEfu0RzgeqeGZa6Z5Fu
        M9uBXGhdnq+41BHFtpqNGja7UTgiLUDJRg==
X-Google-Smtp-Source: ABdhPJzfrG0aXm65pJDRx5dMPi1vuZxA7545qoR4CG22WaUZ6ETI97+YibuBEwlGcDLY8toOc1G4eQ==
X-Received: by 2002:a17:90a:9c5:: with SMTP id 63mr586348pjo.195.1605557587242;
        Mon, 16 Nov 2020 12:13:07 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id a12sm234577pjh.48.2020.11.16.12.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 12:13:06 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        enric.balletbo@collabora.com
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 05/11] platform/chrome: cros_ec_typec: Factor out PD identity parsing
Date:   Mon, 16 Nov 2020 12:11:46 -0800
Message-Id: <20201116201150.2919178-6-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201116201150.2919178-1-pmalani@chromium.org>
References: <20201116201150.2919178-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the PD identity parsing code into a separate function. This
way it can be re-used for Cable PD identity parsing in future patches.

No functional changes are introduced by this patch.

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

 drivers/platform/chrome/cros_ec_typec.c | 35 ++++++++++++++++---------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 801c3d2c1fbd..f6d3c37c2c27 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -657,6 +657,28 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
 	return ret;
 }
 
+/*
+ * Parse the PD identity data from the EC PD discovery responses and copy that to the supplied
+ * PD identity struct.
+ */
+static void cros_typec_parse_pd_identity(struct usb_pd_identity *id,
+					 struct ec_response_typec_discovery *disc)
+{
+	int i;
+
+	/* First, update the PD identity VDOs for the partner. */
+	if (disc->identity_count > 0)
+		id->id_header = disc->discovery_vdo[0];
+	if (disc->identity_count > 1)
+		id->cert_stat = disc->discovery_vdo[1];
+	if (disc->identity_count > 2)
+		id->product = disc->discovery_vdo[2];
+
+	/* Copy the remaining identity VDOs till a maximum of 6. */
+	for (i = 3; i < disc->identity_count && i < VDO_MAX_OBJECTS; i++)
+		id->vdo[i - 3] = disc->discovery_vdo[i];
+}
+
 static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
@@ -666,7 +688,6 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
 		.partner_type = TYPEC_PARTNER_SOP,
 	};
 	int ret = 0;
-	int i;
 
 	if (!port->partner) {
 		dev_err(typec->dev,
@@ -684,17 +705,7 @@ static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_nu
 		goto disc_exit;
 	}
 
-	/* First, update the PD identity VDOs for the partner. */
-	if (sop_disc->identity_count > 0)
-		port->p_identity.id_header = sop_disc->discovery_vdo[0];
-	if (sop_disc->identity_count > 1)
-		port->p_identity.cert_stat = sop_disc->discovery_vdo[1];
-	if (sop_disc->identity_count > 2)
-		port->p_identity.product = sop_disc->discovery_vdo[2];
-
-	/* Copy the remaining identity VDOs till a maximum of 6. */
-	for (i = 3; i < sop_disc->identity_count && i < VDO_MAX_OBJECTS; i++)
-		port->p_identity.vdo[i - 3] = sop_disc->discovery_vdo[i];
+	cros_typec_parse_pd_identity(&port->p_identity, sop_disc);
 
 	ret = typec_partner_set_identity(port->partner);
 	if (ret < 0) {
-- 
2.29.2.299.gdc1121823c-goog

