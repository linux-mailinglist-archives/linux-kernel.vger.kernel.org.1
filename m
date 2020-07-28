Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CAC922FF90
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 04:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgG1CYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 22:24:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8287 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726839AbgG1CYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:24:32 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B5932E0E1DDC06082F49;
        Tue, 28 Jul 2020 10:24:31 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Jul 2020 10:24:28 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] m68k/amiga: missing platform_device_unregister() on error in amiga_init_devices()
Date:   Tue, 28 Jul 2020 10:27:46 +0800
Message-ID: <20200728022746.87612-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing platform_device_unregister() before return
from amiga_init_devices() in the error handling case.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 arch/m68k/amiga/platform.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/amiga/platform.c b/arch/m68k/amiga/platform.c
index d34029d7b..afa2782c6 100644
--- a/arch/m68k/amiga/platform.c
+++ b/arch/m68k/amiga/platform.c
@@ -188,8 +188,10 @@ static int __init amiga_init_devices(void)
 			return PTR_ERR(pdev);
 		error = platform_device_add_data(pdev, &a1200_ide_pdata,
 						 sizeof(a1200_ide_pdata));
-		if (error)
+		if (error) {
+			platform_device_unregister(pdev);
 			return error;
+		}
 	}
 
 	if (AMIGAHW_PRESENT(A4000_IDE)) {
@@ -199,8 +201,10 @@ static int __init amiga_init_devices(void)
 			return PTR_ERR(pdev);
 		error = platform_device_add_data(pdev, &a4000_ide_pdata,
 						 sizeof(a4000_ide_pdata));
-		if (error)
+		if (error) {
+			platform_device_unregister(pdev);
 			return error;
+		}
 	}
 
 
-- 
2.25.1

