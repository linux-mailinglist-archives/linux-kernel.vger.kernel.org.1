Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF72B2BC587
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 13:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgKVMBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 07:01:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:34886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbgKVMBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 07:01:01 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A5C320760;
        Sun, 22 Nov 2020 12:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606046461;
        bh=I3DWUk0+LK+ydDC0aqmE7JEsQMt1l8GP+vkzk6BY8RQ=;
        h=From:To:Cc:Subject:Date:From;
        b=O5YD5ythL2AleZsH8SsIXqhZZ+oidLXKa1/eONV0YqDFU31Zv6RoqnIzUCXCx8GKB
         ZzB2wJrRy5b74D2az5OWzU3TzBUIqBkF6VeCUfU6lVC3ykx72vfrT8HT1JLuzaR60I
         oxcPswxkO0UssD1+VWjpIolRK7koq3kZBJXEz178=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mmc: mediatek: depend on COMMON_CLK to fix compile tests
Date:   Sun, 22 Nov 2020 13:00:56 +0100
Message-Id: <20201122120056.100045-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MFD_OMAP_USB_HOST uses Common Clock Framework thus it cannot be
built on platforms without it (e.g. compile test on MIPS with LANTIQ):

    mips-linux-ld: drivers/mmc/host/mtk-sd.o: in function `msdc_ops_set_ios':
    mtk-sd.c:(.text+0x2bbc): undefined reference to `clk_get_parent'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 310e546e5898..bfe912ec8955 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -1023,6 +1023,7 @@ config MMC_BCM2835
 config MMC_MTK
 	tristate "MediaTek SD/MMC Card Interface support"
 	depends on HAS_DMA
+	depends on COMMON_CLK
 	select REGULATOR
 	select MMC_CQHCI
 	help
-- 
2.25.1

