Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0D42DDD75
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 04:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731953AbgLRDyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 22:54:43 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35277 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726789AbgLRDym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 22:54:42 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0779E5C00D1;
        Thu, 17 Dec 2020 22:53:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Dec 2020 22:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=wwSwX31MmtwgHkrLnUTYMvcRUT
        o1S31FFAv1wRLanEM=; b=GmM7bE4MdWMuu7NHmbXTnbvqSphFDOUT2IKU8QPIrp
        N2wx2iDvc1WHt0n4Jj+fO3X9qdyQm20wMIIQ896U/8rtTyWaj3v/G1Zr6JAQ80C3
        X762CtjSX6olhzXK5SKTFXZrii1a5aCUQzAtAgnKG+DI4/6215tDUl+/TImAp2yX
        nQ7tWXfCk3FMV3VPCLWMb5Yt/QscUCtvPIIm3Ck3KhyrJbdt7Yk5aT9CEiTlUT2m
        zpNneUiUKsXoCgHNsogkfHmXeejQ1JHZNSGtrGdFg7nH+xcrQyAe/W0ruy6K6zIg
        cBY/bvhtS5VJTgRF+iqsnLqiKMp6N/x0Wv7V9rtt931A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=wwSwX31MmtwgHkrLn
        UTYMvcRUTo1S31FFAv1wRLanEM=; b=HdXy/JgbaS0iBcKewhztP4YWr0YXTaCTM
        3cO9Ey0U8ynQysCxoBuIDsRH21EylC7ZgkWQYvkivGY/HGkbkIA4IH6TbGj6xDT5
        fRQVD+RHqGqKLcmKgr3jOx6ksnhJ0Q35DfsKsKPpu1SLyU88Aa0pePEfCsT2CsDz
        9MvASBP/04chEfttMaVQDOxfJV1ENNTCaV2p8fh5UnDzz4zIjE+x0R0OOOnINCE9
        AMxcWj1trkkguwAvrNBmNRkvORTS1jQBVtpM7DAgxxf5lbGqJpp7FLqkj7Cxdj7n
        JLaJ8ApHfGo9Wd+tYvvNhMZDsLqg5qWr7JKRrkvCfRRRIBB5bcqiA==
X-ME-Sender: <xms:0ifcX851fO4n_LOWLFkxQxWyFmmLgcMA5ZIzL5x24NCu26_YmCMw8A>
    <xme:0ifcX95Ys-IKgzIkH7IeaJwTG_0HXZHNiD2ZPCfMRi8aAKeJeZLmgdykHOTCUtjcX
    GR5D4HTjTWwOVBYUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudelhedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehnughrvgifucflvghffhgvrhihuceorghnughrvgifsegrjhdr
    ihgurdgruheqnecuggftrfgrthhtvghrnhepieetheduveelhfdvvdejleeuhfelteevhe
    ffgfeitdefgeekjeefieevgfehhefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghen
    ucfkphepuddvtddrvddtrdejjedrvdduudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:0ifcX7eiPBBgR6UdIA92toKrlOmr5Ixivkyh77zbY_d_DI7UXYY7xw>
    <xmx:0ifcXxIemVvEtnIWeUGneaeEp7UDcvqVJy5mCBGiU6mcFHYkEkHUmg>
    <xmx:0ifcXwK-ESKio1KBN8niHUjfwRU5gBG9i2sHhiC1-yLe26x6Ufe-Bg>
    <xmx:1CfcX5rWPG1IP0B0tx5Kkp4OCDEd0JhBWiI_lRvREV3uzxv0gydslg>
Received: from localhost.localdomain (unknown [120.20.77.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F28E108005B;
        Thu, 17 Dec 2020 22:53:49 -0500 (EST)
From:   Andrew Jeffery <andrew@aj.id.au>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, robh+dt@kernel.org, joel@jms.id.au,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: [PATCH v6 0/6] mmc: sdhci-of-aspeed: Expose phase delay tuning
Date:   Fri, 18 Dec 2020 14:23:32 +1030
Message-Id: <20201218035338.1130849-1-andrew@aj.id.au>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series implements support for the MMC core clk-phase-* devicetree bindings
in the Aspeed SD/eMMC driver. The relevant register was exposed on the AST2600
and is present for both the SD/MMC controller and the dedicated eMMC
controller.

v6 simply removes the typedef from v5 in favour of a struct containing the
phase array.

I've just done a quick build test of v6 given the small change and more
extensive testing done with v5. 

v5 can be found here:

https://lore.kernel.org/linux-mmc/20201208012615.2717412-1-andrew@aj.id.au/

Please review!

Cheers,

Andrew

Andrew Jeffery (6):
  mmc: core: Add helper for parsing clock phase properties
  mmc: sdhci-of-aspeed: Expose clock phase controls
  mmc: sdhci-of-aspeed: Add AST2600 bus clock support
  mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations
  MAINTAINERS: Add entry for the ASPEED SD/MMC driver
  ARM: dts: rainier: Add eMMC clock phase compensation

 MAINTAINERS                                  |   9 +
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts |   1 +
 drivers/mmc/core/host.c                      |  44 ++++
 drivers/mmc/host/Kconfig                     |  14 ++
 drivers/mmc/host/Makefile                    |   1 +
 drivers/mmc/host/sdhci-of-aspeed-test.c      | 100 ++++++++
 drivers/mmc/host/sdhci-of-aspeed.c           | 251 ++++++++++++++++++-
 include/linux/mmc/host.h                     |  13 +
 8 files changed, 422 insertions(+), 11 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-of-aspeed-test.c

-- 
2.27.0

