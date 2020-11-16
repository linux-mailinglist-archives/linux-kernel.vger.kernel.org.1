Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5E72B522E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbgKPUOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731956AbgKPUN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:13:59 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C19C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:13:59 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 131so4680408pfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ratfCf17pWeTifPqw6qz8fSuUGcC46Cued5E0TpKD5Y=;
        b=Bz5i1nkX8TACC+DpQ312MjVtRNrtax07fBV6j/LqGABPtchYR8h9ZDA5zg3XtkSb9s
         4IKtbpUltiM260HRu9PGELfP094Vz/HHk0q9vJXtypx8Zuf+OMh+qdad05MV4g2o5hj6
         xkLTU3KSIZ6BGckfHMRjlnG+CTTiHns6EE3gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ratfCf17pWeTifPqw6qz8fSuUGcC46Cued5E0TpKD5Y=;
        b=GsLNmNuTZWz1hXLPXUmFyD7HjKtymQ1EOIdYwaXRE5ZjkPbe3X+Ywfy7l0sqrZEIYV
         yntnryMYY3zB3Ep7uEUDj//Kj1orYbZM1Jfr1hmPuZjbyznZPJQizP7tX33cQqvSd3c9
         7sEF1+YdDMWBGICQFxhvYdSpnGiik7YQlRfcdhJctHIGeYWcVvgGXpygEMjZqMixSQvw
         Oi7zVbeJHhDH5Bp/LFq0GIhJAkkkvSy9A6eUyAh9M5jsPPRhtXjFdvbwg5uhF/nakQ7E
         pVZWEw8cDvQ5pIiI6QeaSqLU/I1V2LkFCIJx+Qa5Xm8IciyPxbzs257v1FQQc74Msh16
         b7Tw==
X-Gm-Message-State: AOAM531qDiBPddf9Hrvlv0EZA+wUGeF5RI4dYeWWiFt01o7PeSa7m2y3
        s86OjU1t70fz33u4C6g+r/5FnMygVOBmwg==
X-Google-Smtp-Source: ABdhPJw4CO5OhekTUdu47fZ2cmK8miC8tEAVY5AR1ERw8bdRUUPvqU2+pTmJDArG3RD6XiIpCKlamQ==
X-Received: by 2002:a63:fd0b:: with SMTP id d11mr750236pgh.50.1605557638811;
        Mon, 16 Nov 2020 12:13:58 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id a12sm234577pjh.48.2020.11.16.12.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 12:13:58 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        enric.balletbo@collabora.com
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 09/11] platform/chrome: cros_ec_typec: Set partner num_altmodes
Date:   Mon, 16 Nov 2020 12:11:54 -0800
Message-Id: <20201116201150.2919178-10-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201116201150.2919178-1-pmalani@chromium.org>
References: <20201116201150.2919178-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the number of altmodes available for a registered partner using the
Type C connector class framework routine.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---

Changes in v3:
- Re-arranged patch order and combined it with related series of
  patches.
- Added Reviewed-by tags

Changes in v2:
- Patch introduced for the first time in v2.

 drivers/platform/chrome/cros_ec_typec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index cf609aa10567..ad5e37bfd45d 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -642,6 +642,7 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
 	struct cros_typec_altmode_node *node;
 	struct typec_altmode_desc desc;
 	struct typec_altmode *amode;
+	int num_altmodes = 0;
 	int ret = 0;
 	int i, j;
 
@@ -668,9 +669,16 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
 
 			node->amode = amode;
 			list_add_tail(&node->list, &port->partner_mode_list);
+			num_altmodes++;
 		}
 	}
 
+	ret = typec_partner_set_num_altmodes(port->partner, num_altmodes);
+	if (ret < 0) {
+		dev_err(typec->dev, "Unable to set partner num_altmodes for port: %d\n", port_num);
+		goto err_cleanup;
+	}
+
 	return 0;
 
 err_cleanup:
-- 
2.29.2.299.gdc1121823c-goog

