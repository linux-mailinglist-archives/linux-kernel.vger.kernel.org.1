Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EB42F9751
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbhARBXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:23:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11103 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbhARBX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 20:23:27 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DJvBr2X9Nz15v7p
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:21:40 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Mon, 18 Jan 2021
 09:22:37 +0800
From:   Chengyang Fan <cy.fan@huawei.com>
To:     <rafael.j.wysocki@intel.com>
CC:     <guohanjun@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] resource: Remove unneeded semicolon
Date:   Mon, 18 Jan 2021 09:50:00 +0800
Message-ID: <20210118015000.2599677-1-cy.fan@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a superfluous semicolon after function definition.

Signed-off-by: Chengyang Fan <cy.fan@huawei.com>
---
 include/linux/ioport.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index fe48b7840665..803c10f6a6df 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -337,7 +337,7 @@ static inline void irqresource_disabled(struct resource *res, u32 irq)
 #ifdef CONFIG_IO_STRICT_DEVMEM
 void revoke_devmem(struct resource *res);
 #else
-static inline void revoke_devmem(struct resource *res) { };
+static inline void revoke_devmem(struct resource *res) { }
 #endif
 
 #endif /* __ASSEMBLY__ */
-- 
2.25.1

