Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400DF2B4B81
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbgKPQnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:43:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731504AbgKPQnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:43:14 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E42D20E65;
        Mon, 16 Nov 2020 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605544994;
        bh=V5QwWmgQEpcmp1ciPrr90tFzh9JhUdRTcacl9J/mEsc=;
        h=From:To:Cc:Subject:Date:From;
        b=GsSI1x29T+EDTkywJWV3ZBf/nseIKDA35nuna8YpwKi1LhfNg+RtLVmPocknN1rcv
         qT8OlZvGEvHqZZ0js7fmXCL13kOvVvnN01WfGeSWGz5Nnx2p1iXjElyPzYzqeceAqj
         OPrpTABvZIAudxlnsMJvR4LAR/iEQtQBSdYeu8MY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild-all@lists.01.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] mmc: tmio: do not print real IOMEM pointer
Date:   Mon, 16 Nov 2020 17:42:52 +0100
Message-Id: <20201116164252.44078-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Printing kernel pointers is discouraged because they might leak kernel
memory layout.  This fixes smatch warning:

    drivers/mmc/host/tmio_mmc.c:177 tmio_mmc_probe() warn: argument 3 to %08lx specifier is cast from pointer

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/tmio_mmc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index d2d3b8df1bbe..b55a29c53d9c 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -174,8 +174,7 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto host_remove;
 
-	pr_info("%s at 0x%08lx irq %d\n", mmc_hostname(host->mmc),
-		(unsigned long)host->ctl, irq);
+	pr_info("%s at 0x%p irq %d\n", mmc_hostname(host->mmc), host->ctl, irq);
 
 	return 0;
 
-- 
2.25.1

