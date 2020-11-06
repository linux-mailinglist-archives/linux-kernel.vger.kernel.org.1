Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEDB2A8C18
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732860AbgKFB26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732220AbgKFB26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:28:58 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB517C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:28:56 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id r10so2660678pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDgkjHesXQa0DfL621MhE/9nkzhT4wjXa6dD/JLRLy8=;
        b=TFysZU2WkUGt0mgtM2Afp3/U5xa2HRvoslDXzUeXNAhOiWss2vVB6P6yAJzQenw3OL
         DXBNhqp9yMatK9IGv1pya7eKoafHCzk/B2jzl67ANjIZZImV4l7ziNj5Ug7xw3PPqFxv
         hTxoKspbO3UIRhQNdzsslfxkg6cDCKLgeWoA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDgkjHesXQa0DfL621MhE/9nkzhT4wjXa6dD/JLRLy8=;
        b=IJmEivUKmwltnZ0Porj1QXXeUJUych8qzvnkF4wub7tDrM7eGRx5wP6I6USos69vhb
         jN/5PE9zEuDbcoKaHG50c6QBy6ah9rAE1CEJuutwWWxsq389jV+maZ1yIchiM8wDrDbP
         Ra6GwEjULaOe8Px2HhbEc2dXRVCJVKWTPzrjjiePIJrFadZaXPUj42l63IybVv3DlWOy
         5lByNTNRPk1nybju9iv/FQSuMyZHdsu5cXKWDhcGaT3lSnrU1DJ5iJ5dDavLvQaWl43e
         MXnsKjW5/3XMcebHGSD1NSdB/A105LbOSAeaRtVuWfTSu8rOL3+kijAFVMb3p0VQmSxi
         HUQw==
X-Gm-Message-State: AOAM530Rt273eD6gQ6RTp7dOWi2H7lrxQniFWgsIyJnE362zr/X9B0zK
        XPHjh+ZQZdkws8XT7h4OObc6lcRajY3ehg==
X-Google-Smtp-Source: ABdhPJzRMCp85aFSTDGMWByTpytkntrkHq8fhyRINbbBgmNcb7+/jtm24qskxKfYuLO8aj2dS8b7qg==
X-Received: by 2002:a62:643:0:b029:18a:b225:155 with SMTP id 64-20020a6206430000b029018ab2250155mr5366252pfg.56.1604626136198;
        Thu, 05 Nov 2020 17:28:56 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id e2sm3567887pgd.27.2020.11.05.17.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 17:28:55 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, dzigterman@chromium.org,
        alevkoy@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 3/6] platform/chrome: cros_ec_typec: Rename discovery struct
Date:   Thu,  5 Nov 2020 17:27:57 -0800
Message-Id: <20201106012758.525472-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106012758.525472-1-pmalani@chromium.org>
References: <20201106012758.525472-1-pmalani@chromium.org>
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

