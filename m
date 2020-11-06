Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93FB82A9C94
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgKFSl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbgKFSl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:41:58 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58789C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 10:41:58 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id x13so2146603pfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 10:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XeYdtp0accnvA282EGyKNiLUJ2oXayxLKluUy6e2Lcw=;
        b=nQa6i0RJCQB07WIpfmxyQT/17YrFmbUVIoptN9h7XwkTEPBoaE8/L+4Cg3aZ1STUf/
         saL6DU/0jXXGXqlekniKYJaJh0D4xakhzAUCsevAofzhIs1f9nbLEVE6Fl4pu2CdiSqI
         Z/wNkzG5gNRM5ap5jN9hN28mLQDEwucJFGb68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XeYdtp0accnvA282EGyKNiLUJ2oXayxLKluUy6e2Lcw=;
        b=pf7mSD4X79iR79CgN6gE4OwZHUGVzYbVydETCiqPFhjbaZ7zdt1lOugsYtmTvOVYRS
         bq0FBX+c1HinBurtnMwlGGjSHnJGsQmmHjKUXIsqYESSBme4zOcrxT02GGEIveajDr7I
         7n/mXLdr69ogfrdOy3c6BQ1Wwu775JyW3hVShx8VmzPM9Ka5kmvauYH7gR/MecvZj2C8
         f0EWp4X7rROpJUdEVvvgkYy+TOuOx+RycvNlfkEtQgT6VlfJZ54NPMCAYXwIiy31sp02
         k5wXGOekUuAkktTUj5HiIE/NjXXwEBOWy4CJpAT7u6tsIg2citluCVnP0gSbR6sP4Xp5
         CE1g==
X-Gm-Message-State: AOAM533QdeiWuZ7XaP8L/NAZLq+QHX34AP8IslxeSaIBDXeOpcap+0Qo
        vOeF3QrXp/EYIp53Tl9mTUdTprCqk4UKlQ==
X-Google-Smtp-Source: ABdhPJyEYplM6gN85L78WJ0voo+lWqX77lX5OJRSbzensgU5sFXRNOfpZXpMd77wTX2/0ROhBmtEEQ==
X-Received: by 2002:a17:90a:11:: with SMTP id 17mr991022pja.66.1604688117767;
        Fri, 06 Nov 2020 10:41:57 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id b6sm3246143pjq.42.2020.11.06.10.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:41:57 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 3/6] platform/chrome: cros_ec_typec: Rename discovery struct
Date:   Fri,  6 Nov 2020 10:41:04 -0800
Message-Id: <20201106184104.939284-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106184104.939284-1-pmalani@chromium.org>
References: <20201106184104.939284-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the sop_disc data struct which is used to store PD discovery data
to the more generic name of disc_data. It can then be re-used to store
and process cable discovery data.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- No changes.

 drivers/platform/chrome/cros_ec_typec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index f6d3c37c2c27..3c8ff07c8803 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -59,7 +59,7 @@ struct cros_typec_port {
 
 	/* Flag indicating that PD partner discovery data parsing is completed. */
 	bool sop_disc_done;
-	struct ec_response_typec_discovery *sop_disc;
+	struct ec_response_typec_discovery *disc_data;
 	struct list_head partner_mode_list;
 };
 
@@ -323,8 +323,8 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 
 		cros_typec_register_port_altmodes(typec, port_num);
 
-		cros_port->sop_disc = devm_kzalloc(dev, EC_PROTO2_MAX_RESPONSE_SIZE, GFP_KERNEL);
-		if (!cros_port->sop_disc) {
+		cros_port->disc_data = devm_kzalloc(dev, EC_PROTO2_MAX_RESPONSE_SIZE, GFP_KERNEL);
+		if (!cros_port->disc_data) {
 			ret = -ENOMEM;
 			goto unregister_ports;
 		}
@@ -617,7 +617,7 @@ static int cros_typec_get_mux_info(struct cros_typec_data *typec, int port_num,
 static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_num)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
-	struct ec_response_typec_discovery *sop_disc = port->sop_disc;
+	struct ec_response_typec_discovery *sop_disc = port->disc_data;
 	struct cros_typec_altmode_node *node;
 	struct typec_altmode_desc desc;
 	struct typec_altmode *amode;
@@ -682,7 +682,7 @@ static void cros_typec_parse_pd_identity(struct usb_pd_identity *id,
 static int cros_typec_handle_sop_disc(struct cros_typec_data *typec, int port_num)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
-	struct ec_response_typec_discovery *sop_disc = port->sop_disc;
+	struct ec_response_typec_discovery *sop_disc = port->disc_data;
 	struct ec_params_typec_discovery req = {
 		.port = port_num,
 		.partner_type = TYPEC_PARTNER_SOP,
-- 
2.29.1.341.ge80a0c044ae-goog

