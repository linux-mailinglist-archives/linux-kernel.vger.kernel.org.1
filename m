Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A354C27817A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbgIYH0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:44282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgIYH0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:26:00 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5BE42086A;
        Fri, 25 Sep 2020 07:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601018759;
        bh=wGB5w4gO/unnniGON8j7h/PiBcLOT5xCHGPMg1d6iH0=;
        h=From:To:Cc:Subject:Date:From;
        b=WmJ/GoaN55ZSvsvckkVBJJNmo/L6RFQiBmJRqEmESCvP59fLC00NKfvwIzmn7nNuk
         nMaqGPuPKHtm0t7LuI4WgSHj6IAl9fKMOSO9u+a/uew6Dbts08SB1hd8WM/8Ubf05U
         /IPnSzlf8+POs1Pd+tugoEQs1hb0FZ4cPkZjuM8E=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] mmc: sdhci-s3c: hide forward declaration of of_device_id behind CONFIG_OF
Date:   Fri, 25 Sep 2020 09:25:32 +0200
Message-Id: <20200925072532.10272-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct of_device_id is not defined with !CONFIG_OF so its forward
declaration should be hidden to as well.  This should address clang
compile warning:

  drivers/mmc/host/sdhci-s3c.c:464:34: warning: tentative array definition assumed to have one element

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/sdhci-s3c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index cb5f87be7535..f48a788a9d3d 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -461,7 +461,9 @@ static int sdhci_s3c_parse_dt(struct device *dev,
 }
 #endif
 
+#ifdef CONFIG_OF
 static const struct of_device_id sdhci_s3c_dt_match[];
+#endif
 
 static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
 			struct platform_device *pdev)
-- 
2.17.1

