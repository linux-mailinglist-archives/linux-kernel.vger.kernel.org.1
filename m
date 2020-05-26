Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A87A1AD728
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 09:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgDQHNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 03:13:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2393 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728846AbgDQHNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:13:19 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7935C3C806E0D8ADCC05
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 15:13:13 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 15:13:05 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <yanaijie@huawei.com>, <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] samples/trace_printk: make some symbols static
Date:   Fri, 17 Apr 2020 15:39:32 +0800
Message-ID: <20200417073932.45616-1-yanaijie@huawei.com>
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

Fix the following sparse warning:

samples/trace_printk/trace-printk.c:7:6: warning: symbol
'trace_printk_test_global_str' was not declared. Should it be static?
samples/trace_printk/trace-printk.c:10:6: warning: symbol
'trace_printk_test_global_str_irq' was not declared. Should it be
static?
samples/trace_printk/trace-printk.c:13:6: warning: symbol
'trace_printk_test_global_str_fmt' was not declared. Should it be
static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 samples/trace_printk/trace-printk.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/trace_printk/trace-printk.c b/samples/trace_printk/trace-printk.c
index cfc159580263..e9bae541905e 100644
--- a/samples/trace_printk/trace-printk.c
+++ b/samples/trace_printk/trace-printk.c
@@ -4,13 +4,13 @@
 #include <linux/irq_work.h>
 
 /* Must not be static to force gcc to consider these non constant */
-char *trace_printk_test_global_str =
+static char *trace_printk_test_global_str =
 	"This is a dynamic string that will use trace_puts\n";
 
-char *trace_printk_test_global_str_irq =
+static char *trace_printk_test_global_str_irq =
 	"(irq) This is a dynamic string that will use trace_puts\n";
 
-char *trace_printk_test_global_str_fmt =
+static char *trace_printk_test_global_str_fmt =
 	"%sThis is a %s that will use trace_printk\n";
 
 static struct irq_work irqwork;
-- 
2.21.1

