Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615E21BB4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 05:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgD1DnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 23:43:14 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:52015 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726047AbgD1DnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:43:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TwuT2Lw_1588045391;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TwuT2Lw_1588045391)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Apr 2020 11:43:11 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     jeyu@kernel.org
Cc:     linux-kernel@vger.kernel.org, tianjia.zhang@linux.alibaba.com
Subject: [PATCH] module: Allow to disable modsign in kernel cmdline
Date:   Tue, 28 Apr 2020 11:43:10 +0800
Message-Id: <20200428034310.44035-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change allows to disable modsign completely at the beginning,
and turn off by set the kernel cmdline `no_modsig_enforce` when
CONFIG_MODULE_SIG_FORCE is enabled.

Yet another change allows to always show the current status of
modsign through `/sys/module/module/parameters/sig_enforce`.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 kernel/module.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/module.c b/kernel/module.c
index 646f1e2330d2..0e68e1286377 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -269,6 +269,14 @@ static void module_assert_mutex_or_preempt(void)
 
 static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
 module_param(sig_enforce, bool_enable_only, 0644);
+#ifdef CONFIG_MODULE_SIG_FORCE
+static int __init set_no_modsig_enforce(char *str)
+{
+	sig_enforce = false;
+	return 1;
+}
+__setup("no_modsig_enforce", set_no_modsig_enforce);
+#endif /* !CONFIG_MODULE_SIG_FORCE */
 
 /*
  * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
-- 
2.17.1

