Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559C62D8110
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405777AbgLKVTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393412AbgLKVTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:19:13 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF4DC06179C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:18:14 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u18so15227317lfd.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=orV6Jiq3kXB0bcDgP4wZM6ASqt9ALseXlLi8MU8P7Ns=;
        b=Y/Sb4BbQENjqsYlg1fDVvuON5YE+C4L3JZGFp1VhKJkJjAeDP0tezXoP49VoxIsmLZ
         DrlCyH1yE+w1cfnsNG0PpnmwkIrPegtOCAy7zlnQ9D+17sdPJ/x1Ed1LQy0UncQV6LXO
         3ZtWXbXDho2IQG+gr9MkG8PGe+oH2rOEOExWl0bgRd6yA1g4jm1VYJJt3/3mHMSLdLNw
         in+HIWdSQx4MxjXqBclslBFEW0kGjLFkqoBHjY76G6kdZOZOtJQNa6i26eA3gT/bWxrm
         rvP65YF8jRpa4y1i92b6F4Q9O7ISNwN8zLScKxppeyWPU6xmAoCOwIy60OjtqqcQ0HgY
         L2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=orV6Jiq3kXB0bcDgP4wZM6ASqt9ALseXlLi8MU8P7Ns=;
        b=sC3zNeMmTtwvNMLzm2lPg4dmwKfgRgXjYGKbfch3FjuDzL2aGzGO5XPJeLup8LZe3/
         cA42ShDABdy9veCqDuOuaPJTMOsowdrf2orWUyZ5sj+p5drilAqo1bqrCITmtSGkRMOJ
         DdsmKrJ+lo8ofSlbUNhH5KVgg2s78MoVMBw1Hc9FrWzq44tQOJjnxx7teY/PedC+q7EF
         3iuecbh5skDbW4XTf+vi7rT0f/RH0Sn4xNOXHKe2dlHgZKYQRpqLKIat9WmgJzWjPQQp
         GtDaREqSmby1+ckktRyf8rtED6foix4Y9roGtEcp03ybVIGcr2IL/N9acQNEY1r5D1HX
         H9+Q==
X-Gm-Message-State: AOAM531LiKBd1wEmZPHWD2cQprQOoNCB1x1iYqSg906+lfGGQJsDYMbZ
        XYnIQNguT8lqL/zhOfqZLhNv/g==
X-Google-Smtp-Source: ABdhPJyttESJdu/GkalVmYRVZcpwh1cHRonw6XxjwGa1UnPEd8DFWTgp2osz7o/izFoAktU+CHAKjw==
X-Received: by 2002:a19:f60b:: with SMTP id x11mr5758697lfe.156.1607721492841;
        Fri, 11 Dec 2020 13:18:12 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id g190sm833904lfd.72.2020.12.11.13.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 13:18:12 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/2] usb: dwc3: drd: Improve dwc3_get_extcon() style
Date:   Fri, 11 Dec 2020 23:19:16 +0200
Message-Id: <20201211211916.6259-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211211916.6259-1-semen.protsenko@linaro.org>
References: <20201211211916.6259-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c73b41955ee4 ("usb: dwc3: drd: Avoid error when extcon is
missing") changed the code flow in dwc3_get_extcon() function, leading
to unnecessary if-branch. This patch does housekeeping by reworking the
code for obtaining extcon device from the "port" node. While at it, add
the  comment from mentioned code block, explaining how checking the port
availability helps to avoid the misleading error.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes in v3:
  - Split patch into two patches: logic diff and style diff

 drivers/usb/dwc3/drd.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 312a4d060e80..eaf389d3f3c5 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -441,8 +441,8 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
 static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 {
 	struct device *dev = dwc->dev;
-	struct device_node *np_phy, *np_conn;
-	struct extcon_dev *edev;
+	struct device_node *np_phy;
+	struct extcon_dev *edev = NULL;
 	const char *name;
 
 	if (device_property_read_bool(dev, "extcon"))
@@ -462,18 +462,22 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
 		return edev;
 	}
 
+	/*
+	 * Try to get extcon device from USB PHY controller's "port" node.
+	 * Check if it has the "port" node first, to avoid printing the error
+	 * message from underlying code, as it's a valid case: extcon device
+	 * (and "port" node) may be missing in case of "usb-role-switch" or OTG
+	 * mode.
+	 */
 	np_phy = of_parse_phandle(dev->of_node, "phys", 0);
-	if (of_graph_is_present(np_phy))
-		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
-	else
-		np_conn = NULL;
+	if (of_graph_is_present(np_phy)) {
+		struct device_node *np_conn;
 
-	if (np_conn)
-		edev = extcon_find_edev_by_node(np_conn);
-	else
-		edev = NULL;
-
-	of_node_put(np_conn);
+		np_conn = of_graph_get_remote_node(np_phy, -1, -1);
+		if (np_conn)
+			edev = extcon_find_edev_by_node(np_conn);
+		of_node_put(np_conn);
+	}
 	of_node_put(np_phy);
 
 	return edev;
-- 
2.29.2

