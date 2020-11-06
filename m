Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9E02A8C1C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732926AbgKFB3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbgKFB3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:29:53 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EF7C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:29:53 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t14so2686999pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3E/tMh1RoiWxzTOYA6iJN9YAuxEAgDZEecBg/7kWAcI=;
        b=GoJ7fZgx8RPKt6OlUQVPnWSWhooBqaUl8sI6hTgX0Xw7lL+L2sJrti226Zk/TK/ki2
         U3BCd05bSmIW22f5dwVo3ph+ohYcqWO0NjzmFN5YXJRHOCDCGt1et6vyZ/z2ibigtEW2
         /8bi1ilKtNwoOIBCNB4MZQY0dIeRA8QmFl9QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3E/tMh1RoiWxzTOYA6iJN9YAuxEAgDZEecBg/7kWAcI=;
        b=GGwUiXYeugkMIqYthkL5yMNRbRweWWMabHQDEi1moq6ZRz6uF6CCDaHnnGiUd5gXla
         Yw61wBCffvlNf1ov50bqA3jGSoesQQj8+4LX2dzyVtbluszNKN+AJlAxWElSY+HgiKQj
         Ng/EYyGtSEFL+Ow4/FWsNyMt5l4lV8WSSwtdgzIU/W+K/OlvhyFTScX5t9UxSuVRyJ9Z
         /Hvv97SePuEpOmF+6axa6Fcd9/RPpADQRoPw9zQbrm6lxBAFG/yXDlvY6o71c2SqcEij
         zgzbZUT4qPfp7KpQIV/C15nOEh+GKdjeELVJw/oM3PJGGW+wxzXK+x1BsbYrS5Ct1+pR
         3uuw==
X-Gm-Message-State: AOAM5319UN8Fk61iDZ9pLQwdhSmAD/bJpvTp64mq4DjaXjdXxSDhcHJH
        CSIlGE+mt+d5IPQusySFcWBNMBKJmED9Dw==
X-Google-Smtp-Source: ABdhPJxbX0i1fYtrFJQfVTmYypvqBOz3vEF/LF9ojB5Frj2JAuCT6R0w5w89ezTWnNc4NXosHIB7QQ==
X-Received: by 2002:aa7:8055:0:b029:15f:cbe9:1aad with SMTP id y21-20020aa780550000b029015fcbe91aadmr5043086pfm.71.1604626192374;
        Thu, 05 Nov 2020 17:29:52 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id e2sm3567887pgd.27.2020.11.05.17.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 17:29:52 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, dzigterman@chromium.org,
        alevkoy@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 6/6] platform/chrome: cros_ec_typec: Store cable plug type
Date:   Thu,  5 Nov 2020 17:28:03 -0800
Message-Id: <20201106012758.525472-7-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106012758.525472-1-pmalani@chromium.org>
References: <20201106012758.525472-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the PD VDO Type C cable plug type macro to retrieve and store the
cable plug type in the cable descriptor.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 5e7f0b4ebbec..0a2a8b0f8115 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -709,6 +709,7 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
 		.port = port_num,
 		.partner_type = TYPEC_PARTNER_SOP_PRIME,
 	};
+	uint32_t cable_plug_type;
 	int ret = 0;
 
 	memset(disc, 0, EC_PROTO2_MAX_RESPONSE_SIZE);
@@ -722,8 +723,26 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
 	/* Parse the PD identity data, even if only 0s were returned. */
 	cros_typec_parse_pd_identity(&port->c_identity, disc);
 
-	if (disc->identity_count != 0)
+	if (disc->identity_count != 0) {
+		cable_plug_type = VDO_TYPEC_CABLE_TYPE(port->c_identity.vdo[0]);
+		switch (cable_plug_type) {
+		case CABLE_ATYPE:
+			desc.type = USB_PLUG_TYPE_A;
+			break;
+		case CABLE_BTYPE:
+			desc.type = USB_PLUG_TYPE_B;
+			break;
+		case CABLE_CTYPE:
+			desc.type = USB_PLUG_TYPE_C;
+			break;
+		case CABLE_CAPTIVE:
+			desc.type = USB_PLUG_CAPTIVE;
+			break;
+		default:
+			desc.type = USB_PLUG_NONE;
+		}
 		desc.active = PD_IDH_PTYPE(port->c_identity.id_header) == IDH_PTYPE_ACABLE;
+	}
 
 	desc.identity = &port->c_identity;
 
-- 
2.29.1.341.ge80a0c044ae-goog

