Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2F61CD7CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 13:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgEKLVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 07:21:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46448 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbgEKLVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:21:14 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CF5F05D704CED6D715BE;
        Mon, 11 May 2020 19:21:11 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 19:21:05 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <tj@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <nixiaoming@huawei.com>,
        <wangle6@huawei.com>
Subject: [PATCH] trace: Remove duplicate semicolons at the end of line
Date:   Mon, 11 May 2020 19:21:02 +0800
Message-ID: <1589196062-84310-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate semicolons at the end of line in
include/trace/events/iocost.h

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 include/trace/events/iocost.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
index 7ecaa65b..91297eb 100644
--- a/include/trace/events/iocost.h
+++ b/include/trace/events/iocost.h
@@ -152,7 +152,7 @@
 
 	TP_fast_assign(
 		__assign_str(devname, ioc_name(ioc));
-		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);;
+		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);
 		__entry->new_vrate = new_vrate;
 		__entry->busy_level = ioc->busy_level;
 		__entry->read_missed_ppm = (*missed_ppm)[READ];
-- 
1.8.5.6

