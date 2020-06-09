Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A2A1F3D45
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 15:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgFINvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 09:51:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728388AbgFINvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:51:35 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BCC10FDE7730327D72A8;
        Tue,  9 Jun 2020 21:51:32 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 9 Jun 2020 21:51:24 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Divya Indi <divya.indi@oracle.com>, <linux-kernel@vger.kernel.org>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] sample-trace-array: Remove trace_array 'sample-instance'
Date:   Tue, 9 Jun 2020 13:52:00 +0000
Message-ID: <20200609135200.2206726-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove trace_array 'sample-instance' if kthread_run fails
in sample_trace_array_init().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 samples/ftrace/sample-trace-array.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/samples/ftrace/sample-trace-array.c b/samples/ftrace/sample-trace-array.c
index 9e437f930280..6aba02a31c96 100644
--- a/samples/ftrace/sample-trace-array.c
+++ b/samples/ftrace/sample-trace-array.c
@@ -115,8 +115,12 @@ static int __init sample_trace_array_init(void)
 	trace_printk_init_buffers();
 
 	simple_tsk = kthread_run(simple_thread, NULL, "sample-instance");
-	if (IS_ERR(simple_tsk))
+	if (IS_ERR(simple_tsk)) {
+		trace_array_put(tr);
+		trace_array_destroy(tr);
 		return -1;
+	}
+
 	return 0;
 }
 
-- 
2.27.0

