Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A5527B7D5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgI1XSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgI1XSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:18:43 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA1CC0613D7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 14:59:43 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id u6so2761493iow.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 14:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3iVoZz4LPLXcD3ObX5Wdg7gmG0g3PTuNak4a1fGnsho=;
        b=fkSDlWy78hY5FJpMqklZKIdBafKlpwKwacui8jlbDg6A7yns39H/DbvJhAtgfKu7Yj
         /Qn0qDHBP6AIyNJYRAqT93zGfQyJxif6eSnaD1ZwcpdD0IrKao/9H8B0z1KAJl9q3T3z
         NwI9cNy2ZGiuCjWcyVNjKFHg2Vn7VX/7a4NOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3iVoZz4LPLXcD3ObX5Wdg7gmG0g3PTuNak4a1fGnsho=;
        b=Bo8Lq3EtcecLvvshLjyncWnKQPHhpZ7L6EI1R9vlw8rWcDOQud+yFBU0ya9bXN2M1K
         ukyLG1bJwXVqWwlefXoCZS+DGEQ0beHJhEBrGHIsWidA6ZMblwBPFk8jxODIqp/dc7d9
         HgZmbhaWhzwXagfTx2uPTltBZiG6mAk9O8/I8thS4HbcwXCH5DBGG+lHZL+l2IBup2WJ
         T6OMMraU9m6mM9MDnVnnxQ42puU6aCqSUKcn6oQlMj11JbEW2c+chcUUydsQmimqDMxX
         O+EkzUljpdbqw38GVkNlXmt0f4WyhHX/Hxo8n34r/V2YirkPqWAxi0DAixsHPl/o4nlN
         r0ew==
X-Gm-Message-State: AOAM533YjnrpTnDxVun/+XwsXUIyHzY9Cq4/OFBSDhXSWAX2M3gp9WMB
        0mg1H/WA7+p7HoaIadOVjrNM4Q==
X-Google-Smtp-Source: ABdhPJzlEr/qw0libv0a7Eqb6Gy5PvyembzhqhHIRRsVf5kxgY5X0DIbHXD4jYKzt9vW0QaknS7GPQ==
X-Received: by 2002:a5d:8846:: with SMTP id t6mr247881ios.123.1601330383014;
        Mon, 28 Sep 2020 14:59:43 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id 64sm972782iob.36.2020.09.28.14.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:59:42 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc:     Shirish.S@amd.com, Akshu.Agrawal@amd.com,
        Nehal-bakulchandra.Shah@amd.com, chris.wang@amd.com,
        Raul E Rangel <rrangel@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mmc: sdhci-acpi: AMDI0040: Allow changing HS200/HS400 driver strength
Date:   Mon, 28 Sep 2020 15:59:21 -0600
Message-Id: <20200928154718.2.Ic6b6031366f090393d00a53fd69e1ada31ceb29e@changeid>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
In-Reply-To: <20200928154718.1.Icc21d4b2f354e83e26e57e270dc952f5fe0b0a40@changeid>
References: <20200928154718.1.Icc21d4b2f354e83e26e57e270dc952f5fe0b0a40@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change will allow platform designers better control over signal
integrity by allowing them to tune the HS200 and HS400 driver strengths.

The driver strength was previously hard coded to A to solve boot
problems with certain platforms. This driver strength does not
universally apply to all platforms so we need a knob to adjust it.

All older platforms currently have the SDR104 preset hard coded to A in
the firmware. This means that switching from the hard coded value in
the kernel to reading the SDR104 preset is a no-op for these platforms.
Newer platforms will have properly set presets. So this change will
support both new and old platforms.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/host/sdhci-acpi.c | 39 ++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index d335a34ad05b3..5c9a041af5b4b 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -545,10 +545,43 @@ struct amd_sdhci_host {
 
 static int amd_select_drive_strength(struct mmc_card *card,
 				     unsigned int max_dtr, int host_drv,
-				     int card_drv, int *drv_type)
+				     int card_drv, int *host_driver_strength)
 {
-	*drv_type = MMC_SET_DRIVER_TYPE_A;
-	return MMC_SET_DRIVER_TYPE_A;
+	struct sdhci_host *host = mmc_priv(card->host);
+	u16 preset, preset_driver_strength;
+
+	/*
+	 * This method is only called by mmc_select_hs200 so we only need to
+	 * read from the HS200 (SDR104) preset register.
+	 *
+	 * Firmware that has "invalid/default" presets return a driver strength
+	 * of A. This matches the previously hard coded value.
+	 */
+	preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR104);
+	preset_driver_strength =
+		(preset & SDHCI_PRESET_DRV_MASK) >> SDHCI_PRESET_DRV_SHIFT;
+
+	/*
+	 * We want the controller driver strength to match the card's driver
+	 * strength so they have similar rise/fall times.
+	 *
+	 * The controller driver strength set by this method is sticky for all
+	 * timings after this method is called. This unfortunately means that
+	 * while HS400 tuning is in progress we end up with mismatched driver
+	 * strengths between the controller and the card. HS400 tuning requires
+	 * switching from HS400->DDR52->HS->HS200->HS400. So the driver mismatch
+	 * happens while in DDR52 and HS modes. This has not been observed to
+	 * cause problems. Enabling presets would fix this issue.
+	 */
+	*host_driver_strength = preset_driver_strength;
+
+	/*
+	 * The resulting card driver strength is only set when switching the
+	 * card's timing to HS200 or HS400. The card will use the default driver
+	 * strength (B) for any other mode.
+	 */
+	return preset_driver_strength;
+
 }
 
 static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host, bool enable)
-- 
2.28.0.709.gb0816b6eb0-goog

