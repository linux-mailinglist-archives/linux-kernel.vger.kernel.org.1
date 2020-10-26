Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3946D299143
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784259AbgJZPke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:40:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773322AbgJZPkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:40:32 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0391D2242A;
        Mon, 26 Oct 2020 15:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603726832;
        bh=KAl+a17RKAP8KypIuISMNDf6rpG0mE1AHoSQdwN/75Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I5Dou+5oBBQu9B6fpTptjbMUWmxlwzDlG9DHDH4lwDGqyPW5GbO+WLe62AnoSr6cW
         fgBgANAJa1WwsZRr3EJTSYsgp4sDA2XbV5nRHA/n789N0HjdBUQCXq80as8CSF+xAg
         /ePe9Z3S3ZwFBJFGrBt1UqibfZMSNiWWJn6T8rWc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] mmc: s3cmci: enable compile testing
Date:   Mon, 26 Oct 2020 16:38:09 +0100
Message-Id: <20201026153810.89512-2-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026153810.89512-1-krzk@kernel.org>
References: <20201026153810.89512-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested to increase build coverage.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 31481c9fcc2e..310e546e5898 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -631,8 +631,8 @@ config MMC_SPI
 
 config MMC_S3C
 	tristate "Samsung S3C SD/MMC Card Interface support"
-	depends on ARCH_S3C24XX
-	depends on S3C24XX_DMAC
+	depends on ARCH_S3C24XX || COMPILE_TEST
+	depends on S3C24XX_DMAC || COMPILE_TEST
 	help
 	  This selects a driver for the MCI interface found in
 	  Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
-- 
2.25.1

