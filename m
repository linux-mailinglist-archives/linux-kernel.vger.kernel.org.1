Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5F21BB6BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 08:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgD1Gdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 02:33:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51102 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbgD1Gdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:33:50 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C86B314957E8B6F55505;
        Tue, 28 Apr 2020 14:33:47 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 14:33:37 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <ccaulfie@redhat.com>, <teigland@redhat.com>, <tglx@linutronix.de>,
        <cluster-devel@redhat.com>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] dlm: remove unneeded semicolon in rcom.c
Date:   Tue, 28 Apr 2020 14:33:03 +0800
Message-ID: <20200428063303.34246-1-yanaijie@huawei.com>
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

fs/dlm/rcom.c:566:2-3: Unneeded semicolon

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/dlm/rcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
index e3d9f72c640d..4daf5dc2b51c 100644
--- a/fs/dlm/rcom.c
+++ b/fs/dlm/rcom.c
@@ -563,7 +563,7 @@ void dlm_receive_rcom(struct dlm_ls *ls, struct dlm_rcom *rc, int nodeid)
 		lock = 1;
 		reply = 1;
 		break;
-	};
+	}
 
 	spin_lock(&ls->ls_recover_lock);
 	status = ls->ls_recover_status;
-- 
2.21.1

