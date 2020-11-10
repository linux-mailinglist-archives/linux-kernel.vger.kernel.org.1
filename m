Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9072ACF83
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgKJGQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729885AbgKJGQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:16:00 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B63FC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 22:15:59 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w14so7822173pfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 22:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ishEzNNk71XyJfj/YS8Ah7LiakzS8LRvxFS16PhxjMY=;
        b=X6pktCSUMDWxfDkhCFCTXugNsW6qfeqofV7+vvb+fvWaMp4XCRc/aOpVtsB8AWTcst
         4NO5zKNASuIyCzCcqBZCse3wrwSmEcJY6SiZ3LKfHW3OlS/hui4yq/Lx1fXbj5D3n6bO
         Bkbpn0YBUU+EaJEdqToxbV/+iG1FL/nI3M0/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ishEzNNk71XyJfj/YS8Ah7LiakzS8LRvxFS16PhxjMY=;
        b=rdsHI5RWnU3WppdPgFm0lv5w7NPBgwPGx3tEB+rVYThZEQyQ0TG7InlLSCy3T1I/N7
         Q/zvQ1v5Wl+ZBNt1qyfiLisaNkThYVYDF84e48RbaKocnezXS8Ckf4lXVxG+G6VxEQvJ
         TY6vHarfnIEpuX8N9vmtFmag9QjuFPLGs0ww4CPbw3ZWzLp0MMEB8ejvthLBMDxk6kNo
         bIaYkzI3vUq2Jg6BsLqg9112URUReJQiU+ukH/MzvbiKA09ejLOSeyT0KpQO6qwrUu/S
         VBVUet+M4RchCcv/SIbjEBS245y4l+6Q0oHEOX/5O1jIX5ZvfyrfI78NkzsW9NozL/mA
         xaXw==
X-Gm-Message-State: AOAM531b2JGbsQZ/5w+age+VCgAQh1ZXKX2e+fP9icaNrj0wonoq9of5
        XI+KsHo+pOPt1wbVjFbewGB414rigdxUow==
X-Google-Smtp-Source: ABdhPJytDIP/l8mvqGh+OKLWODfRdY34xLMN1KtDbXdXLEhLnVxMIyFY+c5F3ny9df8uxNtqxWA3Rg==
X-Received: by 2002:a17:90b:395:: with SMTP id ga21mr3254794pjb.219.1604988958540;
        Mon, 09 Nov 2020 22:15:58 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id gw10sm1499932pjb.24.2020.11.09.22.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 22:15:57 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Set partner num_altmodes
Date:   Mon,  9 Nov 2020 22:15:36 -0800
Message-Id: <20201110061535.2163599-2-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201110061535.2163599-1-pmalani@chromium.org>
References: <20201110061535.2163599-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the number of altmodes available for a registered partner using the
Type C connector class framework routine.

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Patch introduced for the first time in v2.

 drivers/platform/chrome/cros_ec_typec.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index ce031a10eb1b..743a28426f98 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -621,6 +621,7 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
 	struct cros_typec_altmode_node *node;
 	struct typec_altmode_desc desc;
 	struct typec_altmode *amode;
+	int num_altmodes = 0;
 	int ret = 0;
 	int i, j;
 
@@ -647,9 +648,16 @@ static int cros_typec_register_altmodes(struct cros_typec_data *typec, int port_
 
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
2.29.2.222.g5d2a92d10f8-goog

