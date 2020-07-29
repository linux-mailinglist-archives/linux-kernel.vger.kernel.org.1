Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16472321F3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 17:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgG2Pts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 11:49:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbgG2Pts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:49:48 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 332E61107CF368C86491;
        Wed, 29 Jul 2020 23:49:45 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Wed, 29 Jul 2020 23:49:35 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>, Tomer Tayar <ttayar@habana.ai>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] habanalabs: make some functions static
Date:   Wed, 29 Jul 2020 23:59:25 +0800
Message-ID: <20200729155925.34131-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/misc/habanalabs/gaudi/gaudi.c:6275:5: warning:
 symbol 'gaudi_ctx_init' was not declared. Should it be static?
drivers/misc/habanalabs/goya/goya.c:5228:5: warning:
 symbol 'goya_ctx_init' was not declared. Should it be static?

Those functions are not used outside of source file, so this
commit marks them static.

Fixes: a04b7cd97eef ("habanalabs: create internal CB pool")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 drivers/misc/habanalabs/goya/goya.c | 2 +-
 2 file changed, 2 insertion(+), 2 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index d4b3b995f69d..00a0a7238d81 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6272,7 +6272,7 @@ static enum hl_device_hw_state gaudi_get_hw_state(struct hl_device *hdev)
 	return RREG32(mmHW_STATE);
 }
 
-int gaudi_ctx_init(struct hl_ctx *ctx)
+static int gaudi_ctx_init(struct hl_ctx *ctx)
 {
 	return 0;
 }
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index dedcd2211fb7..85030759b2af 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5225,7 +5225,7 @@ static enum hl_device_hw_state goya_get_hw_state(struct hl_device *hdev)
 	return RREG32(mmHW_STATE);
 }
 
-int goya_ctx_init(struct hl_ctx *ctx)
+static int goya_ctx_init(struct hl_ctx *ctx)
 {
 	return 0;
 }

