Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D850D27B7D1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgI1XSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgI1XSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:18:43 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AD3C0613D5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 14:59:42 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g7so2736633iov.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjICLRW9zp7rjH1xxoqaPHr2CQZArUV9GhyHT31ELGc=;
        b=U/ceRJP4prYsl1z6Mjv27nfa9g31wiRYeH8gnIUfwpMuG/XMqA0qlOPjPZzGB/iHX1
         zpd2YB294YeuVT70cg+FF+9eHHR6d7d/xII2W6nKYbq34jXfPPFUUC4Ao+sVO/QRHAtA
         D6/oVD6slmKRA1hYYC0ausIGumCep2lg9f1sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjICLRW9zp7rjH1xxoqaPHr2CQZArUV9GhyHT31ELGc=;
        b=bvewgoxYMRIpuQvrXT5qW9YmWnUfq8hxZueshokVBfKm1b1ZrVsK0QBGDYBiV1fbzo
         NpminYvGyhuxXXat50TcVzCTFwxsPJ0za0cL8RtjioKrLF3YupNFJT8GNWha14G4ijSr
         lZOUoYVNjzEABUGyGqPpNc6lT3U977mhm4EUvpIEvdfx5oBcXg8WrY1DD5YR52+WQqOW
         aQPeqi3y035Pw6lhWvxus6W7rSnfifFy1JmxnPnyi0rMvyVOqFbI8tij88J1P4skavaZ
         e16wu+BMLB5d4T+vFgcIvl5bEa6VioZaANQbPhQ318DOdX2G9TiQ7RrKtp38cvD8mKzf
         jwzg==
X-Gm-Message-State: AOAM533TRJCAGdczJ7Z3UEF2tEBBxD7cqZNGQvvq5F7DidQtnQkjxjKv
        hgFONFCM+SD0dkp1GZhFKdinKw==
X-Google-Smtp-Source: ABdhPJw0+Evjo5ZoC31YDnlrZyShOTdhQBJg05NH4MEG/JlH9UM2itcwa/hE5ffodBOww+6QviQhdg==
X-Received: by 2002:a02:3b27:: with SMTP id c39mr579779jaa.95.1601330382021;
        Mon, 28 Sep 2020 14:59:42 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id 64sm972782iob.36.2020.09.28.14.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:59:41 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-mmc@vger.kernel.org, adrian.hunter@intel.com
Cc:     Shirish.S@amd.com, Akshu.Agrawal@amd.com,
        Nehal-bakulchandra.Shah@amd.com, chris.wang@amd.com,
        Raul E Rangel <rrangel@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: sdhci-acpi: AMDI0040: Set SDHCI_QUIRK2_PRESET_VALUE_BROKEN
Date:   Mon, 28 Sep 2020 15:59:20 -0600
Message-Id: <20200928154718.1.Icc21d4b2f354e83e26e57e270dc952f5fe0b0a40@changeid>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes HS400 tuning for devices with invalid presets.

SDHCI presets are not currently used for eMMC HS/HS200/HS400, but are
used for DDR52. The HS400 retuning sequence is:

    HS400->DDR52->HS->HS200->Perform Tuning->HS->HS400

This means that when HS400 tuning happens, we transition through DDR52
for a very brief period. This causes presets to be enabled
unintentionally and stay enabled when transitioning back to HS200 or
HS400. Some firmware has invalid presets, so we end up with driver
strengths that can cause I/O problems.

Fixes: 34597a3f60b1 ("mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400")
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---
I decided to abandon adding the preset_value_support for now. Enabling
presets for the AMD controller currently results in using invalid
presets for HS400. This is because sdhci_get_preset_value is using a
non-standard HS400 register that the AMD controller does not support.

I think preset_value_support also needs more thought. Since HS400
re-tuning requires switching to HS, DDR52, and HS200, if one of those
timings is not in the list, we would need to disable presets.

I chose this approach to avoid any additional complexity.

 drivers/mmc/host/sdhci-acpi.c | 37 +++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 284cba11e2795..d335a34ad05b3 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -662,6 +662,43 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
 	    (host->mmc->caps & MMC_CAP_1_8V_DDR))
 		host->mmc->caps2 = MMC_CAP2_HS400_1_8V;
 
+	/*
+	 * There are two types of presets out in the wild:
+	 * 1) Default/broken presets.
+	 *    These presets have two sets of problems:
+	 *    a) The clock divisor for SDR12, SDR25, and SDR50 is too small.
+	 *       This results in clock frequencies that are 2x higher than
+	 *       acceptable. i.e., SDR12 = 25 MHz, SDR25 = 50 MHz, SDR50 =
+	 *       100 MHz.x
+	 *    b) The HS200 and HS400 driver strengths don't match.
+	 *       By default, the SDR104 preset register has a driver strength of
+	 *       A, but the (internal) HS400 preset register has a driver
+	 *       strength of B. As part of initializing HS400, HS200 tuning
+	 *       needs to be performed. Having different driver strengths
+	 *       between tuning and operation is wrong. It results in different
+	 *       rise/fall times that lead to incorrect sampling.
+	 * 2) Firmware with properly initialized presets.
+	 *    These presets have proper clock divisors. i.e., SDR12 => 12MHz,
+	 *    SDR25 => 25 MHz, SDR50 => 50 MHz. Additionally the HS200 and
+	 *    HS400 preset driver strengths match.
+	 *
+	 *    Enabling presets for HS400 doesn't work for the following reasons:
+	 *    1) sdhci_set_ios has a hard coded list of timings that are used
+	 *       to determine if presets should be enabled.
+	 *    2) sdhci_get_preset_value is using a non-standard register to
+	 *       read out HS400 presets. The AMD controller doesn't support this
+	 *       non-standard register. In fact, it doesn't expose the HS400
+	 *       preset register anywhere in the SDHCI memory map. This results
+	 *       in reading a garbage value and using the wrong presets.
+	 *
+	 *       Since HS400 and HS200 presets must be identical, we could
+	 *       instead use the the SDR104 preset register.
+	 *
+	 *    If the above issues are resolved we could remove this quirk for
+	 *    firmware that that has valid presets (i.e., SDR12 <= 12 MHz).
+	 */
+	host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+
 	host->mmc_host_ops.select_drive_strength = amd_select_drive_strength;
 	host->mmc_host_ops.set_ios = amd_set_ios;
 	host->mmc_host_ops.execute_tuning = amd_sdhci_execute_tuning;
-- 
2.28.0.709.gb0816b6eb0-goog

