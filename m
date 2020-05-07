Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173341C8792
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 13:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgEGLHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 07:07:42 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38992 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbgEGLHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:07:41 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E066BDDB11D6676765FA;
        Thu,  7 May 2020 19:07:38 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 7 May 2020
 19:07:28 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <jason.wessel@windriver.com>, <daniel.thompson@linaro.org>,
        <dianders@chromium.org>, <kgdb-bugreport@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] kgdb: Return true in kgdb_nmi_poll_knock()
Date:   Thu, 7 May 2020 19:06:49 +0800
Message-ID: <20200507110649.37426-1-yanaijie@huawei.com>
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

include/linux/kgdb.h:301:54-55: WARNING: return of 0/1 in function
'kgdb_nmi_poll_knock' with return type bool

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 include/linux/kgdb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index b072aeb1fd78..042828aeb73d 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -298,7 +298,7 @@ extern bool kgdb_nmi_poll_knock(void);
 #else
 static inline int kgdb_register_nmi_console(void) { return 0; }
 static inline int kgdb_unregister_nmi_console(void) { return 0; }
-static inline bool kgdb_nmi_poll_knock(void) { return 1; }
+static inline bool kgdb_nmi_poll_knock(void) { return true; }
 #endif
 
 extern int kgdb_register_io_module(struct kgdb_io *local_kgdb_io_ops);
-- 
2.21.1

