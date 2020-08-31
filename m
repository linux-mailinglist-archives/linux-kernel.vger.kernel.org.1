Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A5625785B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 13:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgHaL1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 07:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgHaLXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 07:23:34 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E60C0619C0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 04:11:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so3165070ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 04:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JeV1i5lWS5ilgVHVwdjZqOEdjNx7M/tcM6QuH1mqWxI=;
        b=oeeE/PuRPNM0RLwf6s3xs1I8wmqzw/mMxpN5x0dgQOh1WJNugozsHSXKZy0ulJi9Tw
         lTguqxtZHQPiAka5zspnfcNDRChLgkaHAEdAtE2xXRnA3kNC3ckWkomiR8ojp4KAOqQQ
         Dw7DhLiw/CDMM3/V440PqlKDv/URSPrL75PfRbsvmT2eYSxzCufL4a58nNsEjKHDewgp
         HLjjkCjIhXMzyVwDUdvhD2tWo1ppV5dGDuJ3dDFnM2GCjk4oBRaNOq4d6rT1YBopYPHG
         A8hrsMsU0IbsJh6CxtVDpvXxnvPOi14aavTZ0Q1ZYS9mN8Bq0OT+Y1p3P7qktoCQPOTE
         7DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JeV1i5lWS5ilgVHVwdjZqOEdjNx7M/tcM6QuH1mqWxI=;
        b=tyPz1Zrm8q/ClS3H+3gwV3mN96cKAuB2WedBIywHYkvoEgU//DbwOIm7ua+64R/nhx
         baUgiXoFLD+X1g8ZanqayqHX7AtWJqzr/8S2FbcNQnnAffyeuKmrKNZaTJX5ojZydLmX
         yC2Z/tMqL3nmqyqiCSswF35yNZcFWrFDvPwlCfYiOBWvwPCmXE+1zbkjaqZ4ahkfML7f
         qng5ZBiOMiekEdh/QY93flnYitUaZn3yyogd7N/1G+Io1xljEHY8CaIMeEnqpsx7CcFW
         OpQuM7io+mNs40FGyqapkl9jEQZj5l8/GIs1tfsoK5bNZiAJgILcIxFie16z0LKMj0LN
         ERLg==
X-Gm-Message-State: AOAM531zeD7lbvm9N0wxO/Kf0UGqY/+BoxJzN+2kSw0d0jhfWfdUozOy
        LOv1SAsG0pbpxjNOqPQNx/nGHG/Rz2wlvdJ+
X-Google-Smtp-Source: ABdhPJxLcxE20sCGKOJbR/9yyDZnWfHcBcCwucZsZbu1c9zAD3CLOcuo1I6y7bEJJQUzr0tzk87Egg==
X-Received: by 2002:a2e:a49c:: with SMTP id h28mr447582lji.234.1598872303781;
        Mon, 31 Aug 2020 04:11:43 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id g63sm1891215lfd.28.2020.08.31.04.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 04:11:42 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.9-rc4
Date:   Mon, 31 Aug 2020 13:11:41 +0200
Message-Id: <20200831111141.19238-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.9-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc1

for you to fetch changes up to 8048822bac01936fda2c7b924a52131da81e6198:

  sdhci: tegra: Add missing TMCLK for data timeout (2020-08-28 10:31:39 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-acpi: Fix HS400 tuning for AMDI0040
 - sdhci-pci: Fix reset of CQHCI for Intel GLK-based controllers
 - sdhci-tegra: Use correct timeout clock for Tegra186/194/210
 - mtk-sd: Fix eMMC mounting on mt7622/Bpi-64

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-pci: Fix SDHCI_RESET_ALL for CQHCI for Intel GLK-based controllers

Michal Simek (1):
      dt-bindings: mmc: Add missing description for clk_in/out_sd1

Raul E Rangel (1):
      mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040

Sowjanya Komatineni (7):
      sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra210
      sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra186
      dt-bindings: mmc: tegra: Add tmclk for Tegra210 and later
      arm64: tegra: Add missing timeout clock to Tegra210 SDMMC
      arm64: tegra: Add missing timeout clock to Tegra186 SDMMC nodes
      arm64: tegra: Add missing timeout clock to Tegra194 SDMMC nodes
      sdhci: tegra: Add missing TMCLK for data timeout

Wenbin Mei (3):
      mmc: dt-bindings: Add resets/reset-names for Mediatek MMC bindings
      mmc: mediatek: add optional module reset property
      arm64: dts: mt7622: add reset node for mmc device

 .../devicetree/bindings/mmc/arasan,sdhci.yaml      | 10 +++-
 Documentation/devicetree/bindings/mmc/mtk-sd.txt   |  2 +
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 32 ++++++++++-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |  2 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 20 ++++---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           | 15 +++--
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 20 ++++---
 drivers/mmc/host/mtk-sd.c                          | 13 +++++
 drivers/mmc/host/sdhci-acpi.c                      | 67 ++++++++++++++++++----
 drivers/mmc/host/sdhci-pci-core.c                  | 10 +++-
 drivers/mmc/host/sdhci-tegra.c                     | 55 ++++++++++++++++--
 11 files changed, 203 insertions(+), 43 deletions(-)
