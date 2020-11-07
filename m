Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5BA2AA3D3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 09:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgKGIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 03:24:10 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:12963 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgKGIYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 03:24:10 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id B06F9666740;
        Sat,  7 Nov 2020 16:24:07 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] locking: remove duplicate include of percpu-rwsem.h
Date:   Sat,  7 Nov 2020 16:24:03 +0800
Message-Id: <1604737443-16241-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSh4dQklKHxpJSBlKVkpNS09MSExPT0NLSUpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mhg6Cgw4Vj8YIxwvHyhITQMW
        Hi8aFD9VSlVKTUtPTEhMT09DT0tLVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKSExKNwY+
X-HM-Tid: 0a75a1ce37d89373kuwsb06f9666740
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header include which is unnecessary.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/locking/locktorture.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 62d215b..af99e9c 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -27,7 +27,6 @@
 #include <linux/moduleparam.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/percpu-rwsem.h>
 #include <linux/torture.h>
 
 MODULE_LICENSE("GPL");
-- 
2.7.4

