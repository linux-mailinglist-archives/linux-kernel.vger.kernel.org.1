Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8AB1A63EB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbgDMHzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 03:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbgDMHzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:55:45 -0400
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB360C008609
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 00:55:44 -0700 (PDT)
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 96D5C25496347253FFA5;
        Mon, 13 Apr 2020 15:55:42 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 13 Apr 2020
 15:55:35 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <peterz@infradead.org>,
        <jpoimboe@redhat.com>, <shile.zhang@linux.alibaba.com>,
        <yanaijie@huawei.com>, <linux-kernel@vger.kernel.org>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] x86/unwind/orc: make some symbols static
Date:   Mon, 13 Apr 2020 16:22:03 +0800
Message-ID: <20200413082203.22853-1-yanaijie@huawei.com>
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

arch/x86/kernel/unwind_orc.c:19:5: warning: symbol 'cur_orc_ip_table'
was not declared. Should it be static?
arch/x86/kernel/unwind_orc.c:20:18: warning: symbol 'cur_orc_table' was
not declared. Should it be static?
arch/x86/kernel/unwind_orc.c:22:14: warning: symbol 'lookup_num_blocks'
was not declared. Should it be static?
arch/x86/kernel/unwind_orc.c:23:6: warning: symbol 'orc_init' was not
declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 arch/x86/kernel/unwind_orc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index e9cc182aa97e..0dbabc469ce2 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -16,11 +16,11 @@ extern struct orc_entry __start_orc_unwind[];
 extern struct orc_entry __stop_orc_unwind[];
 
 static DEFINE_MUTEX(sort_mutex);
-int *cur_orc_ip_table = __start_orc_unwind_ip;
-struct orc_entry *cur_orc_table = __start_orc_unwind;
+static int *cur_orc_ip_table = __start_orc_unwind_ip;
+static struct orc_entry *cur_orc_table = __start_orc_unwind;
 
-unsigned int lookup_num_blocks;
-bool orc_init;
+static unsigned int lookup_num_blocks;
+static bool orc_init;
 
 static inline unsigned long orc_ip(const int *ip)
 {
-- 
2.21.1

