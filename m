Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455A02B5223
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbgKPUNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbgKPUNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:13:17 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF0DC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:13:17 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w14so15201615pfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6KrG9tRhir5L1GUg30ALQcT/RDb/5YylxoplKqcEFfw=;
        b=MAytxneIq/7RufgdAa300IWC9MCTfwLsZ0ye7HvC/QBmn45dTOXRO+jE4ub2qz4Xam
         vXYu1wT3RVCvZirC1ck9b2Gs79EkN54vRjru4qpJUJn1pVMPAAJc81ux5phjKGrVD6lr
         fWJVXU7mQMp4Mfe/Ch5Ay2MpilYNy3fp4cnz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6KrG9tRhir5L1GUg30ALQcT/RDb/5YylxoplKqcEFfw=;
        b=CpBXdmnXLmDCMZJzaksUnt89UejpDItiA1itdgXTuHov7RkA5Yr38Xj6mvCXj964fN
         IgHDx2/+EyRToNRp+Y2nh32xcSbhLK17x/vUjVTMXZ4lb0q37A6xsnQ9mmDsw+2/hqmS
         I6HYQ0NBSLNh67kSC4SqlbInc7fsfKV8TBGiBtWlHk74lnlEb/k8clQaZC2qgtwfYmHp
         CnyxaniKcUVhfi+F28X78kELQnrcVVjNoANIqonFsxgVNxFjv/7roOsmqLvfTzS+pn5e
         tp4wjpNbeRT3me7J1/QsCC28q/P/jlgUWUeDTERLppfRIJAjLPBXBsZ4JFN0APhLwGFn
         ws4Q==
X-Gm-Message-State: AOAM530rVC64ZTTibS5L/5eKCf3jUmiJ+OJjfHN5+e+nun9Qsgj+B7U9
        S5sLMOE2EIFrrCVGlWIB8q3VcZiQaTd0Rw==
X-Google-Smtp-Source: ABdhPJzJR0snbvciAIXOOeLQJa3CelPB9OUtxn4ERrUapXSzy2lIBqqkNKvG1TMJ7eFUPbfFjTTuvA==
X-Received: by 2002:a17:90a:d913:: with SMTP id c19mr584421pjv.231.1605557596588;
        Mon, 16 Nov 2020 12:13:16 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id a12sm234577pjh.48.2020.11.16.12.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 12:13:16 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        enric.balletbo@collabora.com
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 06/11] platform/chrome: cros_ec_typec: Rename discovery struct
Date:   Mon, 16 Nov 2020 12:11:48 -0800
Message-Id: <20201116201150.2919178-7-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201116201150.2919178-1-pmalani@chromium.org>
References: <20201116201150.2919178-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the sop_disc data struct which is used to store PD discovery data
to the more generic name of disc_data. It can then be re-used to store
and process cable discovery data.

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
2.29.2.299.gdc1121823c-goog

