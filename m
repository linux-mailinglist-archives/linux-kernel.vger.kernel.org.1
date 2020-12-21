Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59812DFC29
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 14:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgLUNEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 08:04:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9634 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLUND7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 08:03:59 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D004T3wcYz15h11;
        Mon, 21 Dec 2020 21:02:33 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 21 Dec 2020 21:03:08 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <keescook@chromium.org>, <anton@enomsg.org>, <ccross@android.com>,
        <tony.luck@intel.com>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] fs/pstore: Add missing unlock to avoid mismatched lock
Date:   Mon, 21 Dec 2020 21:03:43 +0800
Message-ID: <20201221130343.1862-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a missing unlock in the error branch.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 fs/pstore/zone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 3ce89216670c..569404d56db0 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -1403,6 +1403,7 @@ int register_pstore_zone(struct pstore_zone_info *info)
 		goto fail_free;
 	}
 	mutex_unlock(&pstore_zone_cxt.pstore_zone_info_lock);
+	mutex_unlock(&cxt->pstore_zone_info_lock);
 
 	return 0;
 
@@ -1414,6 +1415,7 @@ int register_pstore_zone(struct pstore_zone_info *info)
 fail_out:
 	pstore_zone_cxt.pstore_zone_info = NULL;
 	mutex_unlock(&pstore_zone_cxt.pstore_zone_info_lock);
+	mutex_unlock(&cxt->pstore_zone_info_lock);
 	return err;
 }
 EXPORT_SYMBOL_GPL(register_pstore_zone);
-- 
2.22.0

