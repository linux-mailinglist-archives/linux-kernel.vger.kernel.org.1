Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862882BA570
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgKTJGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:06:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7713 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgKTJF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:05:59 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CcrHH06xVzkcQN;
        Fri, 20 Nov 2020 17:05:31 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 17:05:00 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <mpm@selenic.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 4/4] MAINTAINERS: Move HiSilicon TRNG V2 driver
Date:   Fri, 20 Nov 2020 17:02:34 +0800
Message-ID: <1605862954-38300-4-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1605862954-38300-1-git-send-email-qianweili@huawei.com>
References: <1605862954-38300-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move HiSilicon TRNG V2 driver into 'drivers/crypto/hisilicon/trng'
with some updating on 'MAINTAINERS'.

Signed-off-by: Weili Qian <qianweili@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b..a835a74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7999,7 +7999,7 @@ F:	drivers/staging/hikey9xx/
 HISILICON TRUE RANDOM NUMBER GENERATOR V2 SUPPORT
 M:	Zaibo Xu <xuzaibo@huawei.com>
 S:	Maintained
-F:	drivers/char/hw_random/hisi-trng-v2.c
+F:	drivers/crypto/hisilicon/trng/trng.c
 
 HISILICON V3XX SPI NOR FLASH Controller Driver
 M:	John Garry <john.garry@huawei.com>
-- 
2.8.1

