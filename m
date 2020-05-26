Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93511AD4A5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 04:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgDQC4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 22:56:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2384 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729380AbgDQC4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 22:56:54 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6BF7ABC77059A6E3C900;
        Fri, 17 Apr 2020 10:56:51 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Apr 2020 10:56:45 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <kasan-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] kcsan: Use GFP_ATOMIC under spin lock
Date:   Fri, 17 Apr 2020 02:58:37 +0000
Message-ID: <20200417025837.49780-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A spin lock is taken here so we should use GFP_ATOMIC.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 kernel/kcsan/debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 1a08664a7fab..023e49c58d55 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -230,7 +230,7 @@ static ssize_t insert_report_filterlist(const char *func)
 		/* initial allocation */
 		report_filterlist.addrs =
 			kmalloc_array(report_filterlist.size,
-				      sizeof(unsigned long), GFP_KERNEL);
+				      sizeof(unsigned long), GFP_ATOMIC);
 		if (report_filterlist.addrs == NULL) {
 			ret = -ENOMEM;
 			goto out;
@@ -240,7 +240,7 @@ static ssize_t insert_report_filterlist(const char *func)
 		size_t new_size = report_filterlist.size * 2;
 		unsigned long *new_addrs =
 			krealloc(report_filterlist.addrs,
-				 new_size * sizeof(unsigned long), GFP_KERNEL);
+				 new_size * sizeof(unsigned long), GFP_ATOMIC);
 
 		if (new_addrs == NULL) {
 			/* leave filterlist itself untouched */





