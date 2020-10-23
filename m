Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FB8297952
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 00:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757171AbgJWWcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 18:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757162AbgJWWb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 18:31:58 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66383C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:31:58 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l18so2478688pgg.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p7f2Y7e3pDJ0zcvjaLyJc9HvdP+zaApAMaxFg92KhII=;
        b=FMG+Cx15Oo4zY3XT4WnGlKFTCfZjZQJeOsuzVUs2dN1Ac6MucfJa6ylZYts8CjvBlS
         hUVlzqRitEZxnhYUDQ9i35fs2H9QQejdgi/cJxNUHvca3VYiUgnvtjFQehL5TdutbP3U
         npRkD1ookO+fEjJpwCM8vyhMJRA4cPvXWLxJ2UbtkfRAmtYQnlXX7JiKsJ3W6CwPWyQZ
         m+pNTEo7bU7gchWr8WLoB6h3FjF8g5Y3G96qmJp0CK4BWuPqJR3VMt3XTP52QXnOn+yZ
         gKiOLD8KLNj5S+zy3otVzCFFUuGYw/UbwKeTgACDlsn2AAjEcxQo9xTuEUMDYhsOvK1u
         Kl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p7f2Y7e3pDJ0zcvjaLyJc9HvdP+zaApAMaxFg92KhII=;
        b=Ro+udpxHN96mUs76Ei1qDfvONWQG+PbGTBfts0HfzuRHyeeB7LSlvJcnlrzPXCkpHO
         EfWn6j8R0wga4lFPiTDXAaPGCGK1cAph/s6UQrHrFBMsz9Si6aIv5RvyDqx+ol1O8a/K
         eE8TaFamku28FkFDJ7/keexcPC25rNhJurW3asLsK9330EmMmkso2QHsEoeJy0zKsIkl
         BPhWMQYeVs0wrrTUjezRxyFjgTU5NH3znAalcEYCimSX87C7RLcSJG9d+vH1IY4EV1Vx
         fpaexWFUrZHK6vl6EQ15lXm2nQ5izMdLVIDx9cpRRz8qrk1KTlD951kVlK5DtKtIiL2V
         Ub1w==
X-Gm-Message-State: AOAM532D6TsssytJNmMWElZyXDYSAJG9bAxiphGZrv5pfKosP+zxNKis
        iB/hvCIh7fGDAIvkbos1DXtdyg==
X-Google-Smtp-Source: ABdhPJwtGm1UrXqWLRKlF9e72YkRhmI7leMNiNo4jpNfVqZ4RfAIjuXDJwYruPsRJpolYiNNKEXNDw==
X-Received: by 2002:a17:90a:de5:: with SMTP id 92mr4808164pjv.179.1603492317886;
        Fri, 23 Oct 2020 15:31:57 -0700 (PDT)
Received: from lx2k.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id o15sm3406457pfp.91.2020.10.23.15.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 15:31:55 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        soc@kernel.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 5/5] ARM: SoC defconfig updates
Date:   Fri, 23 Oct 2020 15:31:22 -0700
Message-Id: <20201023223122.19189-6-olof@lixom.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201023223122.19189-1-olof@lixom.net>
References: <20201023223122.19189-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We keep this in a separate branch to avoid cross-branch conflicts, but
most of the material here is fairly boring -- some new drivers turned on
for hardware since they were merged, and some refreshed files due to
time having moved a lot of entries around.


Conflicts: None

----------------------------------------------------------------

The following changes since commit cf625fc0396296bd644672666bc1a96d7e06118b:

  Merge tag 'armsoc-dt' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-defconfig

for you to fetch changes up to 4550e2c8d3e03ddffdcbfeeecc63e7c68dbec296:

  Merge tag 'qcom-arm64-defconfig-for-5.10' of https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux into arm/defconfig

----------------------------------------------------------------

Andreas Kemnade (1):
      ARM: omap2plus_defconfig: enable twl4030_madc as a loadable module

Biju Das (1):
      ARM: shmobile: defconfig: Enable TOUCHSCREEN_STMPE

Bjorn Andersson (1):
      arm64: defcondfig: Enable USB ACM and FTDI drivers

Christophe Kerello (1):
      ARM: multi_v7_defconfig: add FMC2 EBI controller support

Dmitry Baryshkov (3):
      arm64: defconfig: enable INTERCONNECT for Qualcomm chipsets
      arm64: defconfig: qcom: enable GPU clock controller for SM8[12]50
      arm64: defconfig: enable Qualcomm ASoC modules

Dong Aisheng (2):
      ARM: multi_v7_defconfig: Enable i.MX6SLL SoC
      ARM: multi_v7_defconfig: Enable i.MX7ULP SoC

Fabio Estevam (1):
      arm64: defconfig: Enable the eLCDIF and Raydium RM67191 drivers

Geert Uytterhoeven (2):
      ARM: shmobile: defconfig: Refresh for v5.9-rc1
      arm64: defconfig: Enable RPC-IF support

Grygorii Strashko (1):
      ARM: omap2plus_defconfig: enable generic net options

Guido Günther (2):
      arm64: defconfig: re-sync DRM related defconfig bits
      arm64: defconfig: Enable imx8mq-librem5-devkit display stack

Horia Geantă (1):
      ARM: multi_v7_defconfig: enable caam crypto module

Joel Stanley (3):
      ARM: config: aspeed: Fix selection of media drivers
      ARM: config: aspeed-g5: Enable I2C GPIO mux driver
      ARM: config: aspeed_g5: Enable IBM OP Panel driver

Krzysztof Kozlowski (2):
      arm64: defconfig: Enable clock driver for ROHM BD718x7 PMIC
      arm64: defconfig: Enable Samsung S3FWRN5 NFC driver

Lad Prabhakar (3):
      arm64: defconfig: Enable R-Car PCIe endpoint driver
      ARM: multi_v7_defconfig: Enable CONFIG_PCIE_RCAR_HOST
      ARM: shmobile: defconfig: Enable CONFIG_PCIE_RCAR_HOST

Linus Walleij (2):
      ARM: configs: Update Versatile defconfig
      ARM: configs: Update Realview defconfig

Manivannan Sadhasivam (1):
      arm64: defconfig: Enable Qcom SNPS Femto PHY

Marek Szyprowski (1):
      ARM: exynos_defconfig: enable platform media drivers

Michael Walle (1):
      arm64: defconfig: enable the sl28cpld board management controller

Olof Johansson (7):
      Merge tag 'renesas-arm-defconfig-for-v5.10-tag1' of git://git.kernel.org/.../geert/renesas-devel into arm/defconfig
      Merge tag 'aspeed-5.10-defconfig' of git://git.kernel.org/.../joel/aspeed into arm/defconfig
      Merge tag 'tegra-for-5.10-arm64-defconfig' of git://git.kernel.org/.../tegra/linux into arm/defconfig
      Merge tag 'samsung-defconfig-5.10' of https://git.kernel.org/.../krzk/linux into arm/defconfig
      Merge tag 'omap-for-v5.10/defconfig-signed' of git://git.kernel.org/.../tmlind/linux-omap into arm/defconfig
      Merge tag 'imx-defconfig-5.10' of git://git.kernel.org/.../shawnguo/linux into arm/defconfig
      Merge tag 'qcom-arm64-defconfig-for-5.10' of https://git.kernel.org/.../qcom/linux into arm/defconfig

Peng Fan (1):
      ARM: imx_v6_v7_defconfig: Support i.MX8MN/P/Q

Sameer Pujar (2):
      arm64: defconfig: Build AHUB component drivers
      arm64: defconfig: Build ADMA and ACONNECT driver

Vinod Koul (1):
      arm64: defconfig: Enable Lontium LT9611 driver


 arch/arm/configs/aspeed_g4_defconfig |  3 +-
 arch/arm/configs/aspeed_g5_defconfig |  7 ++++-
 arch/arm/configs/exynos_defconfig    |  8 ++---
 arch/arm/configs/imx_v6_v7_defconfig |  6 ++++
 arch/arm/configs/multi_v7_defconfig  |  6 +++-
 arch/arm/configs/omap2plus_defconfig | 12 ++++++++
 arch/arm/configs/realview_defconfig  | 18 +++++++-----
 arch/arm/configs/shmobile_defconfig  |  5 ++--
 arch/arm/configs/versatile_defconfig |  5 ++--
 arch/arm64/configs/defconfig         | 49 ++++++++++++++++++++++++++++++-
 10 files changed, 98 insertions(+), 21 deletions(-)
