Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26B82D68C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 21:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393813AbgLJUc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 15:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729218AbgLJUcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:32:55 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D0BC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 12:32:15 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id q8so8183395ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 12:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXo/6yTnw0lOEukdPOuRfdTJttQHVNIkXPnDWTx3kM0=;
        b=HGsT2Yjjbr3Pxl7MzGsWp0SS0cjFS+GQryFOo6Lk1X5kNAeR2vY2iVaCfOTeZzijOG
         l5CJ9g6YXwnlNlHjwxs+3n9sMi/xOub+CeiNGC5spwOY5u/qfB99lwDLiASZ1e0OyKsO
         fW8878uS4rE3xZsP/SztjL2q9Po55Tvu4ycUKsHoN7L0IvHuEGXlWLyPNK2kPvQBmD0w
         Hnc+cJePa4FoyzPRxMnD9Cd9ko1VLbkKB3i3Y6VJADx29zXZPTzRcVmDtlNET+OtkdR5
         6jBWeqoSOXWl4aJixDS9oF9c5+f/YWPMiI0zaqAYxpFjGJWkzzNFqCDzMy9tubCDPikj
         l66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JXo/6yTnw0lOEukdPOuRfdTJttQHVNIkXPnDWTx3kM0=;
        b=QDC1ACOq8QmR4d4ihaDFo6QU//bbg913acg7li88WHUZivSMqgZ80l/UN67EYwrd0G
         VWLtCfM3EEqQ0fqlzMEDFo/j/JPWQmliFwLVN4t9CW41g6yInw9GNI0uj6+FltX9PKE8
         G6EomNF3ea1l7jqwNOiDV1VwBe0cVkyw3LMUXAUczW5W6/KOG93NOsQwBGaAiIfbWLNo
         dntCplOoeUcARc+0hO6xBkL4OfK5BgeSZJ3a0a7zjGMBKBOZAyb2F2Ao8dv59jf+sDAt
         q8SQgHqXj1r8cJR2MDsdHsIuFxPvjabG7gW8n+Ux0JDUt7aQELcX/FMXp8KaaVcbirHo
         Lrcw==
X-Gm-Message-State: AOAM533xCdBDbeguRxuOGWT+UvH8jm4KZIZSqlVTqEtvG3m3jNY7LjAj
        WggWKsYYfmJ4B2DNpFlq7ngq6Q==
X-Google-Smtp-Source: ABdhPJwftCg+aMmbLa5OTXlhY7xSWcgK4L9HnLiOYnFNtFo2GlluWUqTS3bC3zH8Vw/NaqK2pvjHdw==
X-Received: by 2002:a2e:93cd:: with SMTP id p13mr3573414ljh.205.1607632333596;
        Thu, 10 Dec 2020 12:32:13 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id n10sm721868ljg.139.2020.12.10.12.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 12:32:13 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] usb: dwc3: drd: Avoid error when extcon is missing
Date:   Thu, 10 Dec 2020 22:33:18 +0200
Message-Id: <20201210203318.6914-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If "port" node is missing in PHY controller node, dwc3_get_extcon()
isn't able to find extcon device. This is perfectly fine in case when
"usb-role-switch" or OTG is used, but next misleading error message is
printed in that case, from of_graph_get_remote_node():

    OF: graph: no port node found in /phy@1234abcd

Avoid printing that message by checking if port node exists in PHY node
before calling of_graph_get_remote_node().

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/usb/dwc3/drd.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 3e1c1aacf002..eaf389d3f3c5 100644
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
@@ -462,15 +462,22 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
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
-	np_conn = of_graph_get_remote_node(np_phy, -1, -1);
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
2.27.0

