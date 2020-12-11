Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61F42D721E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392397AbgLKInr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:43:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9514 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436980AbgLKInT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:43:19 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CskmR6KXczhpld;
        Fri, 11 Dec 2020 16:41:59 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 16:42:25 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <paul@paul-moore.com>, <linux-audit@redhat.com>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] kernel/audit: convert comma to semicolon
Date:   Fri, 11 Dec 2020 16:42:54 +0800
Message-ID: <20201211084254.2038-1-zhengyongjun3@huawei.com>
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
 kernel/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 68cee3bc8cfe..c8497115be35 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2282,7 +2282,7 @@ static void audit_log_set_loginuid(kuid_t koldloginuid, kuid_t kloginuid,
 
 	uid = from_kuid(&init_user_ns, task_uid(current));
 	oldloginuid = from_kuid(&init_user_ns, koldloginuid);
-	loginuid = from_kuid(&init_user_ns, kloginuid),
+	loginuid = from_kuid(&init_user_ns, kloginuid);
 	tty = audit_get_tty();
 
 	audit_log_format(ab, "pid=%d uid=%u", task_tgid_nr(current), uid);
-- 
2.22.0

