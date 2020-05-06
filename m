Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DCF1C6B23
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 10:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgEFINh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 04:13:37 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3815 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728296AbgEFINh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:13:37 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 04979B12EBCE9B3C3C94;
        Wed,  6 May 2020 16:13:35 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 6 May 2020 16:13:27 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <srinivas.kandagatla@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] nvmem: jz4780-efuse: Use PTR_ERR_OR_ZERO() to simplify code
Date:   Wed, 6 May 2020 16:19:37 +0800
Message-ID: <1588753177-37750-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/nvmem/jz4780-efuse.c:214:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 drivers/nvmem/jz4780-efuse.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvmem/jz4780-efuse.c b/drivers/nvmem/jz4780-efuse.c
index 512e187..0b01b84 100644
--- a/drivers/nvmem/jz4780-efuse.c
+++ b/drivers/nvmem/jz4780-efuse.c
@@ -211,10 +211,8 @@ static int jz4780_efuse_probe(struct platform_device *pdev)
 	cfg.priv = efuse;
 
 	nvmem = devm_nvmem_register(dev, &cfg);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static const struct of_device_id jz4780_efuse_match[] = {
-- 
2.6.2

