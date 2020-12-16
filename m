Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0022DC0E5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgLPNOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:14:30 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9454 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgLPNOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:14:30 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CwwYC3CZXzhrML;
        Wed, 16 Dec 2020 21:13:19 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 21:13:41 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <marek.vasut@gmail.com>, <daniel@zonque.org>,
        <haojian.zhuang@gmail.com>, <robert.jarzmik@free.fr>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] arm: mach-pxa: convert comma to semicolon
Date:   Wed, 16 Dec 2020 21:14:13 +0800
Message-ID: <20201216131413.14554-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 arch/arm/mach-pxa/z2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index 21fd76bb09cd..6511c4304dda 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -537,7 +537,7 @@ static int z2_lbs_spi_setup(struct spi_device *spi)
 	mdelay(180);
 
 	spi->bits_per_word = 16;
-	spi->mode = SPI_MODE_2,
+	spi->mode = SPI_MODE_2;
 
 	spi_setup(spi);
 
-- 
2.22.0

