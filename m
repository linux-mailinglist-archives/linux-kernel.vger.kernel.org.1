Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D040D2DC0D4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgLPNLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:11:33 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9215 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPNLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:11:33 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CwwTP1qRyzkWVQ;
        Wed, 16 Dec 2020 21:10:01 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 21:10:39 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <dvhart@infradead.org>, <andy@infradead.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] platform: intel-mid: device_libs: convert comma to semicolon
Date:   Wed, 16 Dec 2020 21:11:07 +0800
Message-ID: <20201216131107.14339-1-zhengyongjun3@huawei.com>
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
 arch/x86/platform/intel-mid/device_libs/platform_bt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/intel-mid/device_libs/platform_bt.c b/arch/x86/platform/intel-mid/device_libs/platform_bt.c
index 31dda18bb370..2930b6e9473e 100644
--- a/arch/x86/platform/intel-mid/device_libs/platform_bt.c
+++ b/arch/x86/platform/intel-mid/device_libs/platform_bt.c
@@ -88,8 +88,8 @@ static int __init bt_sfi_init(void)
 	memset(&info, 0, sizeof(info));
 	info.fwnode	= ddata->dev->fwnode;
 	info.parent	= ddata->dev;
-	info.name	= ddata->name,
-	info.id		= PLATFORM_DEVID_NONE,
+	info.name	= ddata->name;
+	info.id		= PLATFORM_DEVID_NONE;
 
 	pdev = platform_device_register_full(&info);
 	if (IS_ERR(pdev))
-- 
2.22.0

