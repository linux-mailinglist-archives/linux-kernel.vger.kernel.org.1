Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6B91AEA30
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 08:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgDRGiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 02:38:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2404 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbgDRGiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 02:38:54 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F4D33666557344A2AD2;
        Sat, 18 Apr 2020 14:38:48 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Apr 2020
 14:38:40 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <keescook@chromium.org>, <re.emese@gmail.com>,
        <kernel-hardening@lists.openwall.com>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] gcc-plugins: structleak: remove unneeded variable 'ret'
Date:   Sat, 18 Apr 2020 15:05:05 +0800
Message-ID: <20200418070505.10715-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

scripts/gcc-plugins/structleak_plugin.c:177:14-17: Unneeded variable:
"ret". Return "0" on line 207

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 scripts/gcc-plugins/structleak_plugin.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/gcc-plugins/structleak_plugin.c b/scripts/gcc-plugins/structleak_plugin.c
index e89be8f5c859..fdff6278eda0 100644
--- a/scripts/gcc-plugins/structleak_plugin.c
+++ b/scripts/gcc-plugins/structleak_plugin.c
@@ -174,7 +174,6 @@ static void initialize(tree var)
 static unsigned int structleak_execute(void)
 {
 	basic_block bb;
-	unsigned int ret = 0;
 	tree var;
 	unsigned int i;
 
@@ -204,7 +203,7 @@ static unsigned int structleak_execute(void)
 			initialize(var);
 	}
 
-	return ret;
+	return 0;
 }
 
 #define PASS_NAME structleak
-- 
2.21.1

