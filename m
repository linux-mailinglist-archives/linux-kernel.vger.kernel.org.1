Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B1D2AD168
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbgKJIjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:39:19 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7476 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJIjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:39:19 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CVh9M4zCWzhjMk;
        Tue, 10 Nov 2020 16:39:03 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Tue, 10 Nov 2020 16:39:00 +0800
From:   Luo Meng <luomeng12@huawei.com>
To:     <jbacik@fb.com>, <ast@kernel.org>, <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>, <luomeng12@huawei.com>
Subject: [PATCH] fail_function: remove a redundant mutex unlock
Date:   Tue, 10 Nov 2020 16:42:45 +0800
Message-ID: <20201110084245.3067324-1-luomeng12@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a mutex_unlock() issue where before copy_from_user() is
not called mutex_locked.

Fixes: 4b1a29a7f542 ("error-injection: Support fault injection framework")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Luo Meng <luomeng12@huawei.com>
---
 kernel/fail_function.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 63b349168da7..b0b1ad93fa95 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -253,7 +253,7 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
 
 	if (copy_from_user(buf, buffer, count)) {
 		ret = -EFAULT;
-		goto out;
+		goto out_free;
 	}
 	buf[count] = '\0';
 	sym = strstrip(buf);
@@ -307,8 +307,9 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
 		ret = count;
 	}
 out:
-	kfree(buf);
 	mutex_unlock(&fei_lock);
+out_free:
+	kfree(buf);
 	return ret;
 }
 
-- 
2.25.4

