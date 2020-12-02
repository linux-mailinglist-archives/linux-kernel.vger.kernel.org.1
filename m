Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55812CC5F5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389710AbgLBSxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388002AbgLBSxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:53:25 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE4AC061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:52:00 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id 142so4984613ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1NuGhfuvRRKOKlvmGuyTpm1ODDVJaYuPLibVtVX+cAw=;
        b=JUgL2AM6DmI2EpgyTDkl59NOl0Zr+9aN1RxFubkrpYhknsvjEYvZCwKqEOsQftX4q7
         nmnFYojGFKsYxdrodt/Zb4BpwK7lwoOclnG8M1DQC1CkFgtL93rPY2anhgGKfgTbRmmq
         z6kDtn5T1mde7VX4pwC6XZJ1NilHmzFTr83/nKMeuQAAJihOH/cfTVmKzQCzKQcnYMiM
         A6y1piNZ3IGCJCc1fDBNskSfLToGTxnk5WiFpiAtY+9rIgDS3AwHnplFmHtBOauJ90AJ
         S5fru9lcUMWcXuabSNdWRm6cdbjSYFeQvzi4JEhwzniTgosrgk4K6L3xlc0V/4++Du9Y
         AouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1NuGhfuvRRKOKlvmGuyTpm1ODDVJaYuPLibVtVX+cAw=;
        b=KDPovQLQ7RjXwijWAMIJX4NNa78iHw6x0sBXoxl5AGlPNSH/ToU+daFn9ZZxXU46mY
         +pyri3vaVu59LZCsCZ9YwN2lyA5pdeHrzlM22inyRDTGff1q9OL/szCE8rtfnfrvgnk7
         H3cf3ui+S+GLAn44q8PvLqXEhoh6fURIzIZ9w3IVNNvWgy4JzZA++imWn6V9604ElaEp
         CuT/HHXeDGWM0/1z6ETH1lISNTBgt+rHM5rv2hB9qJeBmL49wvPbLv8SkK73GXUMAGnw
         dtrpy1Uw/MgQgoJkYJAxXQQHTuvC7Fu3L4la8gDs5hl0YNi5ENpcT9B0WbMTSct5xa6e
         xPfQ==
X-Gm-Message-State: AOAM5335Zbo1pTfOCrfc5vUtLh610MYgXNnMP3M8jhpiexm3w29fsL7F
        Yt+zXqPaO1e745NM9TM0qasjJ7Yzt9jBcZa3
X-Google-Smtp-Source: ABdhPJwrRiEy0fs8Q+QwaCDiefxGize4mIrq4/m6zVpn0hSKS++joUOI79kdZW7mNZmx/jH40RwS+A==
X-Received: by 2002:a05:651c:1121:: with SMTP id e1mr1761753ljo.227.1606935118392;
        Wed, 02 Dec 2020 10:51:58 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id y134sm666365lff.162.2020.12.02.10.51.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:51:57 -0800 (PST)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, huziji@marvell.com,
        adrian.hunter@intel.com, jaz@semihalf.com, tn@semihalf.com,
        ard.biesheuvel@arm.com, kostap@marvell.com,
        Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v3 4/4] mmc: sdhci-xenon: introduce ACPI support
Date:   Wed,  2 Dec 2020 19:51:18 +0100
Message-Id: <20201202185118.29076-5-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201202185118.29076-1-mw@semihalf.com>
References: <20201202185118.29076-1-mw@semihalf.com>
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-xenon.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index cc0fcc646b0e..395f7c3064ce 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -11,6 +11,7 @@
  * Special thanks to Video BG4 project team.
  */
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
 #include <linux/module.h>
@@ -691,11 +692,22 @@ static const struct of_device_id sdhci_xenon_dt_ids[] = {
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

