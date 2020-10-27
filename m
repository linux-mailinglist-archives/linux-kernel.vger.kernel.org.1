Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916BC29C68E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1826340AbgJ0STR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:19:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:59308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S367983AbgJ0ODo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:03:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C0534AF54;
        Tue, 27 Oct 2020 14:03:43 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jeyu@kernel.org
Cc:     linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] module: set MODULE_STATE_GOING state when a module fails to load
Date:   Tue, 27 Oct 2020 15:03:36 +0100
Message-Id: <20201027140336.15409-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a module fails to load due to an error in prepare_coming_module(),
the following error handling in load_module() runs with
MODULE_STATE_COMING in module's state. Fix it by correctly setting
MODULE_STATE_GOING under "bug_cleanup" label.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 kernel/module.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/module.c b/kernel/module.c
index a4fa44a652a7..b34235082394 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3991,6 +3991,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 				     MODULE_STATE_GOING, mod);
 	klp_module_going(mod);
  bug_cleanup:
+	mod->state = MODULE_STATE_GOING;
 	/* module_bug_cleanup needs module_mutex protection */
 	mutex_lock(&module_mutex);
 	module_bug_cleanup(mod);
-- 
2.29.0

