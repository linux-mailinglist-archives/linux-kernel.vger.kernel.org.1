Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2996F2C2513
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbgKXL5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:57:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:8398 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732852AbgKXL5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:57:34 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CgMvV6254z71pC;
        Tue, 24 Nov 2020 19:57:10 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 24 Nov 2020
 19:57:23 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
To:     <naveen.n.rao@linux.ibm.com>
CC:     <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <cj.chengjian@huawei.com>
Subject: [PATCH] kretprobe: avoid re-registration of the same kretprobe earlier
Date:   Tue, 24 Nov 2020 19:57:19 +0800
Message-ID: <20201124115719.11799-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our system encountered a re-init error when re-registering same kretprobe,
where the kretprobe_instance in rp->free_instances is illegally accessed
after re-init.

Implementation to avoid re-registration has been introduced for kprobe
before, but lags for register_kretprobe(). We must check if kprobe has
been re-registered before re-initializing kretprobe, otherwise it will
destroy the data struct of kretprobe registered, which can lead to memory
leak, system crash, also some unexpected behaviors.

we use check_kprobe_rereg() to check if kprobe has been re-registered
before calling register_kretprobe(), for giving a warning message and
terminate registration process.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
---
 kernel/kprobes.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 41fdbb7953c6..7f54a70136f3 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2117,6 +2117,14 @@ int register_kretprobe(struct kretprobe *rp)
 		}
 	}
 
+	/*
+	 * Return error if it's being re-registered,
+	 * also give a warning message to the developer.
+	 */
+	ret = check_kprobe_rereg(&rp->kp);
+	if (WARN_ON(ret))
+		return ret;
+
 	rp->kp.pre_handler = pre_handler_kretprobe;
 	rp->kp.post_handler = NULL;
 	rp->kp.fault_handler = NULL;
-- 
2.17.1

