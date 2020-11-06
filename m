Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34E32A9C91
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgKFSlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgKFSlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:41:40 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4294EC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 10:41:40 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id g12so1600410pgm.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 10:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wq6Preoru3IfCh2dMMdaJylKOwWTSm5/Yosw2jaNCWA=;
        b=YdIg0K5xvHn3rYHxnyjF69EcZrXG4YQrIsW23NhkkkMfCwd0dny7SQGaI77hv42ag8
         bzvC/KKaGXE0IEQVDyOToDt4AonfC6VQjNadnisCaSQaC7PaJsqzZvqiMtJajvLGiIt1
         II7lzEea/elUf4VaNyXnYIwOlFOvffa1dNLB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wq6Preoru3IfCh2dMMdaJylKOwWTSm5/Yosw2jaNCWA=;
        b=fMOjB/pl0ydfgPXw3TeJym7uJF8/qcuyDKWeiKv+Lw4lJLeU6US+WfzKCxp1iAjY6x
         3OaplzsNiwrlYeKDik2FqkzULb37cb+Bx1OKJ2Lk8rUb+zQlhhTaepM6SZQa+nzgOhmx
         6fFc1Dp1Q0slJ6CyGMD8qEKeP/nm/t2vpiPmmHvo5+ZyLZgdw8vkdrtHxiOAr6vqdjeu
         UO1ovEdaqYOSUuJxMjwZSPGXHvAfK9E4wMTNSu8+0OUgvM/tTK8+VlqMMTCWXAvKEDZx
         d2qZY3k9CWbMuM5M2OpAewuEE2zoBh1h19C0vOx1HTcgU4evQVf6G1oLJy9OC6H5Cqdp
         rGGw==
X-Gm-Message-State: AOAM532wYwaHYt2QjkSuZZLJXYoIhkeoy75q1X25oEjSf/FfMvJkM3p4
        XPLd/lS0w/Ijs9JkfoN4GODpLcbKQ/W7RQ==
X-Google-Smtp-Source: ABdhPJw7Kza5aXwcBCrWlM3szUeapkz0JJMR6hSxnH5Ki/BT0FdWNCIGlPzCXAGvpTw1xbyiy0ZCSg==
X-Received: by 2002:a17:90a:e20f:: with SMTP id a15mr954488pjz.12.1604688099572;
        Fri, 06 Nov 2020 10:41:39 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id b6sm3246143pjq.42.2020.11.06.10.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:41:39 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 2/6] platform/chrome: cros_ec_typec: Factor out PD identity parsing
Date:   Fri,  6 Nov 2020 10:41:01 -0800
Message-Id: <20201106184104.939284-3-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106184104.939284-1-pmalani@chromium.org>
References: <20201106184104.939284-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the PD identity parsing code into a separate function. This
way it can be re-used for Cable PD identity parsing in future patches.

No functional changes are introduced by this patch.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

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
2.29.1.341.ge80a0c044ae-goog

