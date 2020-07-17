Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEDF2238B3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 11:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgGQJth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 05:49:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbgGQJth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:49:37 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 353781F895A657737A23;
        Fri, 17 Jul 2020 17:49:18 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Jul 2020 17:49:09 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <hubcap@omnibond.com>, <martin@omnibond.com>
CC:     <devel@lists.orangefs.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] orangefs: remove unnecessary assignment to variable ret
Date:   Fri, 17 Jul 2020 17:52:59 +0800
Message-ID: <20200717095259.111076-1-jingxiangfeng@huawei.com>
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

The variable ret is guaranteed to be 0 in this if (). So we can remove
this assignement.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 fs/orangefs/orangefs-mod.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/orangefs/orangefs-mod.c b/fs/orangefs/orangefs-mod.c
index 289b648ae196..74a3d6337ef4 100644
--- a/fs/orangefs/orangefs-mod.c
+++ b/fs/orangefs/orangefs-mod.c
@@ -149,7 +149,6 @@ static int __init orangefs_init(void)
 		pr_info("%s: module version %s loaded\n",
 			__func__,
 			ORANGEFS_VERSION);
-		ret = 0;
 		goto out;
 	}
 
-- 
2.17.1

