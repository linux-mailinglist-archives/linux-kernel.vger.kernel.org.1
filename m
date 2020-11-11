Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A4B2AE8BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 07:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgKKGUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 01:20:00 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:43188 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgKKGTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 01:19:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UEx57L3_1605075591;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEx57L3_1605075591)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 11 Nov 2020 14:19:51 +0800
Subject: Re: [PATCH] audit: remove unused macros
To:     Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
References: <1604651482-9780-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201110152310.GB55411@madcap2.tricolour.ca>
 <CAHC9VhQiQoZh8in+zoYa5hbTN_yL-=mt7nTQFN9GAyQZ+tz-Ww@mail.gmail.com>
 <20201111030359.GB55072@madcap2.tricolour.ca>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <bae6d2fa-64d9-623b-6729-3827d745ed7a@linux.alibaba.com>
Date:   Wed, 11 Nov 2020 14:19:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201111030359.GB55072@madcap2.tricolour.ca>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for comments!
So here is the v2 according to your suggestion!

From 033425b6072ff4cee05d6bbffc97cd6a4c13166c Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Fri, 6 Nov 2020 16:31:22 +0800
Subject: [PATCH v2] kernel/audit: fix macros warning

Some unused macros could cause gcc warning:
kernel/audit.c:68:0: warning: macro "AUDIT_UNINITIALIZED" is not used
[-Wunused-macros]
kernel/auditsc.c:104:0: warning: macro "AUDIT_AUX_IPCPERM" is not used
[-Wunused-macros]
kernel/auditsc.c:82:0: warning: macro "AUDITSC_INVALID" is not used
[-Wunused-macros]

AUDIT_UNINITIALIZED and AUDITSC_INVALID are still meaningful and could
be used in code.

Just remove AUDIT_AUX_IPCPERM.

Thanks comments from Richard Guy Briggs and Paul Moore.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>
Cc: linux-audit@redhat.com
Cc: linux-kernel@vger.kernel.org
---
 kernel/audit.c   |  2 +-
 kernel/auditsc.c | 10 ++++------
 2 files changed, 5 insertions(+), 7 deletions(-)

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
index 183d79cc2e12..ea0ed81ddee0 100644
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
@@ -1488,7 +1486,7 @@ static void audit_log_exit(void)
 			 context->arch, context->major);
 	if (context->personality != PER_LINUX)
 		audit_log_format(ab, " per=%lx", context->personality);
-	if (context->return_valid)
+	if (context->return_valid != AUDITSC_INVALID)
 		audit_log_format(ab, " success=%s exit=%ld",
 				 (context->return_valid==AUDITSC_SUCCESS)?"yes":"no",
 				 context->return_code);
@@ -1625,7 +1623,7 @@ void __audit_free(struct task_struct *tsk)
 	 * need to log via audit_log_exit().
 	 */
 	if (tsk == current && !context->dummy && context->in_syscall) {
-		context->return_valid = 0;
+		context->return_valid = AUDITSC_INVALID;
 		context->return_code = 0;
 
 		audit_filter_syscall(tsk, context,
-- 
1.8.3.1

