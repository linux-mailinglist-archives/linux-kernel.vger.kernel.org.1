Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B7A2AFC8E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgKLBjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:39:06 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45575 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728098AbgKLAhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:37:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UF10qhn_1605141454;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UF10qhn_1605141454)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Nov 2020 08:37:35 +0800
Subject: Re: [PATCH] audit: remove unused macros
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
References: <1604651482-9780-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201110152310.GB55411@madcap2.tricolour.ca>
 <CAHC9VhQiQoZh8in+zoYa5hbTN_yL-=mt7nTQFN9GAyQZ+tz-Ww@mail.gmail.com>
 <20201111030359.GB55072@madcap2.tricolour.ca>
 <bae6d2fa-64d9-623b-6729-3827d745ed7a@linux.alibaba.com>
 <20201111131759.GD55072@madcap2.tricolour.ca>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <9784a39e-c39f-b3f9-3d05-68d63e560c75@linux.alibaba.com>
Date:   Thu, 12 Nov 2020 08:36:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201111131759.GD55072@madcap2.tricolour.ca>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/11 ÏÂÎç9:17, Richard Guy Briggs Ð´µÀ:
>>  
>>  		audit_filter_syscall(tsk, context,
> This all looks good, but I don't see the initialization of
> context->return_valid in audit_alloc_context() that was mentioned for
> completeness.
> 

Sorry for missing that. Here they are.

From 5fef5f1b7b745b52bedc9c7eec9fc163202ad421 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Fri, 6 Nov 2020 16:31:22 +0800
Subject: [PATCH v3] audit: fix macros warnings

Some unused macros could cause gcc warning:
kernel/audit.c:68:0: warning: macro "AUDIT_UNINITIALIZED" is not used
[-Wunused-macros]
kernel/auditsc.c:104:0: warning: macro "AUDIT_AUX_IPCPERM" is not used
[-Wunused-macros]
kernel/auditsc.c:82:0: warning: macro "AUDITSC_INVALID" is not used
[-Wunused-macros]

AUDIT_UNINITIALIZED and AUDITSC_INVALID are still meaningful and should
be in incorporated.

Just remove AUDIT_AUX_IPCPERM.

Thanks comments from Richard Guy Briggs and Paul Moore.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Richard Guy Briggs <rgb@redhat.com>
Cc: Eric Paris <eparis@redhat.com>
Cc: linux-audit@redhat.com
Cc: linux-kernel@vger.kernel.org
---
 kernel/audit.c   |  2 +-
 kernel/auditsc.c | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index ac0aeaa99937..e22f22bdc000 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -67,7 +67,7 @@
 #define AUDIT_DISABLED		-1
 #define AUDIT_UNINITIALIZED	0
 #define AUDIT_INITIALIZED	1
-static int	audit_initialized;
+static int	audit_initialized = AUDIT_UNINITIALIZED;
 
 u32		audit_enabled = AUDIT_OFF;
 bool		audit_ever_enabled = !!AUDIT_OFF;
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 183d79cc2e12..9cbe6d5437be 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -102,8 +102,6 @@ struct audit_aux_data {
 	int			type;
 };
 
-#define AUDIT_AUX_IPCPERM	0
-
 /* Number of target pids per aux struct. */
 #define AUDIT_AUX_PIDS	16
 
@@ -552,11 +550,11 @@ static int audit_filter_rules(struct task_struct *tsk,
 			break;
 
 		case AUDIT_EXIT:
-			if (ctx && ctx->return_valid)
+			if (ctx && ctx->return_valid != AUDITSC_INVALID)
 				result = audit_comparator(ctx->return_code, f->op, f->val);
 			break;
 		case AUDIT_SUCCESS:
-			if (ctx && ctx->return_valid) {
+			if (ctx && ctx->return_valid != AUDITSC_INVALID) {
 				if (f->val)
 					result = audit_comparator(ctx->return_valid, f->op, AUDITSC_SUCCESS);
 				else
@@ -930,6 +928,7 @@ static inline struct audit_context *audit_alloc_context(enum audit_state state)
 	INIT_LIST_HEAD(&context->killed_trees);
 	INIT_LIST_HEAD(&context->names_list);
 	context->fds[0] = -1;
+	context->return_valid = AUDITSC_INVALID;
 	return context;
 }
 
@@ -1488,7 +1487,7 @@ static void audit_log_exit(void)
 			 context->arch, context->major);
 	if (context->personality != PER_LINUX)
 		audit_log_format(ab, " per=%lx", context->personality);
-	if (context->return_valid)
+	if (context->return_valid != AUDITSC_INVALID)
 		audit_log_format(ab, " success=%s exit=%ld",
 				 (context->return_valid==AUDITSC_SUCCESS)?"yes":"no",
 				 context->return_code);
@@ -1625,7 +1624,7 @@ void __audit_free(struct task_struct *tsk)
 	 * need to log via audit_log_exit().
 	 */
 	if (tsk == current && !context->dummy && context->in_syscall) {
-		context->return_valid = 0;
+		context->return_valid = AUDITSC_INVALID;
 		context->return_code = 0;
 
 		audit_filter_syscall(tsk, context,
-- 
1.8.3.1

