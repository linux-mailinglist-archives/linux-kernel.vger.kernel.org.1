Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84D92B5220
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgKPUM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgKPUM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:12:57 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2856CC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:12:57 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w14so15200684pfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n4b+ds1Fe+TXuvmcjAO9zzkmygh5sQ/IQkjDCJxp9mk=;
        b=WS2G1M0wgzgMtOa+VULHym7vC8s+ANdoApBkc+zmQ+Cn4L2jklHLB7ij1gANegN7Vn
         5NedFXA+ahgH4cuVvkxKBgMCCY67avPHnam5T5WlTnwv5gSFZGqHOj1RPcUCdRDj1JFn
         nnCdbid5PlRqPBMYx7MoDe1Vo29/ahsUmZnSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n4b+ds1Fe+TXuvmcjAO9zzkmygh5sQ/IQkjDCJxp9mk=;
        b=A4VR9YkE0y37cVB1ogh0KDy7geKt/yVfDC8+gSs5Ny7k4GHT2zgLlekTnOr5i2VJ1F
         Vw8VaSFJled++PrRajS87f4if7KL54R9H6veVySj70yeZg5FxDj50SaVN/5pc6Ey2sPi
         VJDhdmabcjiLbOCX6LP4A1v0iJTC13xYb+x4Z1cAIPOk2CvkwqjfdWRRLsnF8Gmz+tn9
         8zig92Hef2hNELJGdx/svD1V5DeE+cUoDe9lreP/zxuTPJ25Anr11fRU+y3GiHW+F5C/
         JNLgbpPNOdEF+Yvh7iEn8FgcdNLkUCKlCXTv9/NMGfBwtvh5o+IKopM2V4YrOT1aIH4b
         qqpQ==
X-Gm-Message-State: AOAM533lgqbyQoV1n7kh15dnwveFF7pAeQHreXmkd7JiNa4ob8bHR2wZ
        6i2ZCnbX3zmkCTjuOuGocgbgpkSxgdwh7A==
X-Google-Smtp-Source: ABdhPJweZoDIArS64rJtCe3Pkpd8uUBGRPfvPHVQRnPuouIOsSaicaeFqIlDzY/kdDwRvwyVYchVQQ==
X-Received: by 2002:a17:90a:9a1:: with SMTP id 30mr653175pjo.52.1605557576232;
        Mon, 16 Nov 2020 12:12:56 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id a12sm234577pjh.48.2020.11.16.12.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 12:12:55 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com,
        enric.balletbo@collabora.com
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 04/11] platform/chrome: cros_ec_typec: Make disc_done flag partner-only
Date:   Mon, 16 Nov 2020 12:11:44 -0800
Message-Id: <20201116201150.2919178-5-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201116201150.2919178-1-pmalani@chromium.org>
References: <20201116201150.2919178-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the disc_done flag, which indicates whether PD discovery is
complete, to sop_disc_done instead, since we will process SOP and SOP'
discovery data separately.

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

 drivers/platform/chrome/cros_ec_typec.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index ce031a10eb1b..801c3d2c1fbd 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -57,8 +57,8 @@ struct cros_typec_port {
 	/* Port alt modes. */
 	struct typec_altmode p_altmode[CROS_EC_ALTMODE_MAX];
 
-	/* Flag indicating that PD discovery data parsing is completed. */
-	bool disc_done;
+	/* Flag indicating that PD partner discovery data parsing is completed. */
+	bool sop_disc_done;
 	struct ec_response_typec_discovery *sop_disc;
 	struct list_head partner_mode_list;
 };
@@ -210,7 +210,7 @@ static void cros_typec_remove_partner(struct cros_typec_data *typec,
 	typec_unregister_partner(port->partner);
 	port->partner = NULL;
 	memset(&port->p_identity, 0, sizeof(port->p_identity));
-	port->disc_done = false;
+	port->sop_disc_done = false;
 }
 
 static void cros_unregister_ports(struct cros_typec_data *typec)
@@ -727,18 +727,13 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
 		return;
 	}
 
-	if (typec->ports[port_num]->disc_done)
-		return;
-
 	/* Handle any events appropriately. */
-	if (resp.events & PD_STATUS_EVENT_SOP_DISC_DONE) {
+	if (resp.events & PD_STATUS_EVENT_SOP_DISC_DONE && !typec->ports[port_num]->sop_disc_done) {
 		ret = cros_typec_handle_sop_disc(typec, port_num);
-		if (ret < 0) {
+		if (ret < 0)
 			dev_err(typec->dev, "Couldn't parse SOP Disc data, port: %d\n", port_num);
-			return;
-		}
-
-		typec->ports[port_num]->disc_done = true;
+		else
+			typec->ports[port_num]->sop_disc_done = true;
 	}
 }
 
-- 
2.29.2.299.gdc1121823c-goog

