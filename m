Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 691292A8C13
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbgKFB2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732701AbgKFB2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:28:32 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7D9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:28:32 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t14so2684743pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Isl/WzUuPljZe1UXO1RGJXR4af+lyqHxbfYjSyUmTkQ=;
        b=GxVvL+MS9hLkAgTYVlotm7VFLMcrEv7IN1lbn7z4vA8niPlW7ShKz01QQGDywB8JQA
         9101aQF4fD+5MQUWb3yRDq2L+BG0PeGz/YbjEwpXSjaxnnSSaqeB4TQQo4MLzLOVpoMK
         TD8MHX7GCV0SA0+0TiJCubI2WO+XBdAk0lirw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Isl/WzUuPljZe1UXO1RGJXR4af+lyqHxbfYjSyUmTkQ=;
        b=KE+Ub3Zlr/QOtnA8kKchvXT31BvaG4iZGxbX7Cm6jlG5javSO4/9OxRxRYdf4ufQNt
         ZKB/GeOIgNj/Zb6nYArpuRheB//b7bFv+KVCGBWUairUdnngDrChpzOd8u+BI8IIKH22
         G2eAH4eHzNsYPwFaSSE1smevwoREdgU0UFe0/z1oQXy5MxfHp5VyAJxVazrTmeZFQQCJ
         6TRqY4V5f1hXUX5BzHYREGGke7kYfQb0XRB2dwxbW2UWZkRD6oqUYqw6BIrQSUqf7Qh4
         4BKMWjirFf1p4y8zTa35SPtFoIcLtvNclxzocazfHSxOBHV+dG7+4DDtEdF9Rsx9ESrW
         Fafg==
X-Gm-Message-State: AOAM533y0EUmWpn90Oj/4lubBmRk+/6AFJTuMBHWZhANLVUhmO5x/ppr
        A3VyFKnk7tmLEeKNCPOXLJQYXv6WX3PcEA==
X-Google-Smtp-Source: ABdhPJxlLCFCJ/JcONTp3MdrmBI/FubXi07TSbaMEbkuhAwR7QX9NX8DKdtYbY5LrycHI/e2SvoSHA==
X-Received: by 2002:a17:90b:d18:: with SMTP id n24mr5512719pjz.206.1604626111708;
        Thu, 05 Nov 2020 17:28:31 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id e2sm3567887pgd.27.2020.11.05.17.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 17:28:30 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, dzigterman@chromium.org,
        alevkoy@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM)
Subject: [PATCH 1/6] platform/chrome: cros_ec_typec: Make disc_done flag partner-only
Date:   Thu,  5 Nov 2020 17:27:53 -0800
Message-Id: <20201106012758.525472-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201106012758.525472-1-pmalani@chromium.org>
References: <20201106012758.525472-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the disc_done flag, which indicates whether PD discovery is
complete, to sop_disc_done instead, since we will process SOP and SOP'
discovery data separately.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
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
2.29.1.341.ge80a0c044ae-goog

