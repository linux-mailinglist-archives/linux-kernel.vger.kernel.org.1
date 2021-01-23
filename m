Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8870D3012C5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 04:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbhAWDqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 22:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbhAWDp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 22:45:56 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97932C061352
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 19:44:35 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id cq1so5005843pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 19:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ub3HDIGcGN9X98CN8/+sRfhCxNd7htSlAnp6McU6Vl8=;
        b=c4K/CpgL2OEAm5HKCZdSOkGLE+2LP12JHtnZH1E7VVnD+OVE1va+XuLLP4qnJCpChO
         5wVaEwIAitUDXGSRbX6GXUURo561HFOY8aq+EIGY767Vkn/JLB/mqyQh6ZpnyOCF1Tzz
         6DZxjQt4K7KOvCpbZatqPfAP7r6oTSE9oRDvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ub3HDIGcGN9X98CN8/+sRfhCxNd7htSlAnp6McU6Vl8=;
        b=sDGBDWr7kc7B6wF957m8XBBxWjrrnss7Pc/7Cl1Ik2eqzl5gt926UkjzGAWFzMjr1c
         8J3XSK1pwxE59uj2lFNqrkQuDE3X4luNWXiO1ixdmxElt0265IlNPXpvGJS1MR5OuGdL
         M1amemJTiiVZIFDhuYUxrCioCwkH3j22fKMrNSawHIKhw3bQh1ArRgxmKZvIj9d6wvsp
         CIAGOJmlOwMN/sja2BF0ifJS1LzlFEVeaGLmMmZ3LmOW/O1cat4jhQppd9lPy7DWlok5
         pcK133tFs4stmGtMGI+0CqXjVyLcJuDhHPslw/nWC90kmhYerxN37tSi+X4e5AdUhxl7
         VHXg==
X-Gm-Message-State: AOAM532EbUK50PV+hUZFrmy7//ktqVqdIVhlU6BJe017rwO607tTLEQ9
        oCyyNUAyHGAqyroPtyM3q1P2Ww==
X-Google-Smtp-Source: ABdhPJxQN2vek2DR+91n81FNJwfjyXjxDRkHHmje05Ec810oHF9xUj+nyLklqYq3FeTc2+wIm7YB3g==
X-Received: by 2002:a17:902:8e82:b029:dc:3182:e0b7 with SMTP id bg2-20020a1709028e82b02900dc3182e0b7mr8170599plb.78.1611373475161;
        Fri, 22 Jan 2021 19:44:35 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id gf23sm10480343pjb.42.2021.01.22.19.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 19:44:34 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-omap@vger.kernel.org
Subject: [PATCH v2 2/6] drivers: net: davinci_mdio: Use of_device_get_match_data()
Date:   Fri, 22 Jan 2021 19:44:24 -0800
Message-Id: <20210123034428.2841052-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210123034428.2841052-1-swboyd@chromium.org>
References: <20210123034428.2841052-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the more modern API to get the match data out of the of match table.
This saves some code, lines, and nicely avoids referencing the match
table when it is undefined with configurations where CONFIG_OF=n.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <linux-omap@vger.kernel.org>
---

Please ack so Rob can apply.

 drivers/net/ethernet/ti/davinci_mdio.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index cfff3d48807a..a4efd5e35158 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -358,20 +358,16 @@ static int davinci_mdio_probe(struct platform_device *pdev)
 	}
 
 	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
-		const struct of_device_id	*of_id;
+		const struct davinci_mdio_of_param *of_mdio_data;
 
 		ret = davinci_mdio_probe_dt(&data->pdata, pdev);
 		if (ret)
 			return ret;
 		snprintf(data->bus->id, MII_BUS_ID_SIZE, "%s", pdev->name);
 
-		of_id = of_match_device(davinci_mdio_of_mtable, &pdev->dev);
-		if (of_id) {
-			const struct davinci_mdio_of_param *of_mdio_data;
-
-			of_mdio_data = of_id->data;
-			if (of_mdio_data)
-				autosuspend_delay_ms =
+		of_mdio_data = of_device_get_match_data(&pdev->dev);
+		if (of_mdio_data) {
+			autosuspend_delay_ms =
 					of_mdio_data->autosuspend_delay_ms;
 		}
 	} else {
-- 
https://chromeos.dev

