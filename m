Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5BF22FF86
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 04:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgG1CWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 22:22:34 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbgG1CWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:22:34 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D672C817520912E229B5;
        Tue, 28 Jul 2020 10:22:32 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Jul 2020 10:22:28 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ARM: uniphier: use for_each_matching_node() macro
Date:   Tue, 28 Jul 2020 10:25:42 +0800
Message-ID: <20200728022542.86566-1-miaoqinglang@huawei.com>
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

Use for_each_matching_node() macro instead of open coding it.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 arch/arm/mm/cache-uniphier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/cache-uniphier.c b/arch/arm/mm/cache-uniphier.c
index ff2881458..112f19cb3 100644
--- a/arch/arm/mm/cache-uniphier.c
+++ b/arch/arm/mm/cache-uniphier.c
@@ -450,12 +450,12 @@ static int __init __uniphier_cache_init(struct device_node *np,
 
 int __init uniphier_cache_init(void)
 {
-	struct device_node *np = NULL;
+	struct device_node *np;
 	unsigned int cache_level;
 	int ret = 0;
 
 	/* look for level 2 cache */
-	while ((np = of_find_matching_node(np, uniphier_cache_match)))
+	for_each_matching_node(np, uniphier_cache_match)
 		if (!of_property_read_u32(np, "cache-level", &cache_level) &&
 		    cache_level == 2)
 			break;
-- 
2.25.1

