Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6AE2BA121
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 04:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgKTD1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 22:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgKTD1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 22:27:10 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FD8C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 19:27:08 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id p12so8555918ljc.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 19:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fqn08+QfMXXA0wyLDJZny72GR+5yc4I41ZsdzMIQxEI=;
        b=QSQT9GTqnDt2d59Jscrlg1jfUicDIQxu4P6sOB+YstjUJsDDTUv5VQQYJA8QRKjt3+
         n5hOOzT2w6WoMNH2yPji10UInHviBo1xSK5yux/QosPm40BRVa+4dkJ6PI8WHcAEIBHy
         g6vYjx3r+5SW8QoH9SrmY2YwgSmrgXnXXPB6rgDYk6hIvCfvI/fUKspLwKfhCV0lOb8B
         /Z52P+fDY0RvamChMgho3pc3xL0OwpdWodl4vgN0wT+ANxfsrTsZSnlfZV+RUYdVHFTv
         BnoqfY/bkCnc/74/iWjI7QnzSXY0OqLS5H7GTLLmQXso1TzqEUj01t7L6nrS2/YZ24Nd
         9RSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fqn08+QfMXXA0wyLDJZny72GR+5yc4I41ZsdzMIQxEI=;
        b=VgiSgVclcBB92QFwt6wZdrREoRc7O75aoSWDrkGfCdhv0DkaXXPI6iatwjyZPuz5kE
         sPrDVYw830e2Dd3WagI/7pvOkiKzSJ5u8do0Mo+kaJArsJYtZVYFMZMl4LZCj97zk06O
         3LXbqJnBw0QbDlaJUg5U9yXssErZGi/kfvSlS9c4EqCvys8AmClpewe+6KoJGkDy6Fu6
         61ubmsEFiYerePg2qUlvHoN0MPczfADZdWKDv2Dzhp3RDBaYXStgxqKmDz68f8nZyot9
         12cwC8vpKqhJHsF4fiIcVMF40XsYwpvBa/rGAWiKvR9U/7NBHRX4RQfH1x3x8Aw+gvj7
         f5Cw==
X-Gm-Message-State: AOAM530aOYCUDXuY0jbaZgrPc9lQFoNh8EKOUoKqLOXsH7GXxZ/kz29V
        80nmxRmAMk4Bl1IL++9iCGqEo18xN+DW7J1G
X-Google-Smtp-Source: ABdhPJxTs4t98C90I5qm0dbb3G80E/eQ8N7BnPM3lQeJgjr6k+T3T8OBpKGGm5LGmYH/us7HDgRRPw==
X-Received: by 2002:a2e:b0c4:: with SMTP id g4mr7327273ljl.20.1605842826727;
        Thu, 19 Nov 2020 19:27:06 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id s26sm153647lji.31.2020.11.19.19.27.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Nov 2020 19:27:06 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v2 4/4] mmc: sdhci-xenon: introduce ACPI support
Date:   Fri, 20 Nov 2020 04:26:39 +0100
Message-Id: <20201120032639.24386-5-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201120032639.24386-1-mw@semihalf.com>
References: <20201120032639.24386-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous patches dropped the strict dependency on the OF_*
in the sdhci-xenon driver. As a result the ACPI support
can be introduced (except for the XENON_A3700 variant)
by adding the necessary ID's in the acpi_match_table.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/mmc/host/sdhci-xenon.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index dfc3b5f62a6d..6d4f588d4c11 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -11,6 +11,7 @@
  * Special thanks to Video BG4 project team.
  */
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
 #include <linux/module.h>
@@ -698,11 +699,22 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_xenon_dt_ids);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id sdhci_xenon_acpi_ids[] = {
+	{ .id = "MRVL0002", XENON_AP806},
+	{ .id = "MRVL0003", XENON_AP807},
+	{ .id = "MRVL0004", XENON_CP110},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, sdhci_xenon_acpi_ids);
+#endif
+
 static struct platform_driver sdhci_xenon_driver = {
 	.driver	= {
 		.name	= "xenon-sdhci",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_xenon_dt_ids,
+		.acpi_match_table = ACPI_PTR(sdhci_xenon_acpi_ids),
 		.pm = &sdhci_xenon_dev_pm_ops,
 	},
 	.probe	= xenon_probe,
-- 
2.29.0

