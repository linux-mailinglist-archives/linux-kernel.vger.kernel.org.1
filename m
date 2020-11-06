Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF312A914F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 09:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgKFIbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 03:31:31 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:57495 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbgKFIbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:31:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UEPYlOn_1604651488;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEPYlOn_1604651488)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Nov 2020 16:31:28 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     paul@paul-moore.com
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] audit: remove unused macros
Date:   Fri,  6 Nov 2020 16:31:22 +0800
Message-Id: <1604651482-9780-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some unused macros could cause gcc warning:
kernel/audit.c:68:0: warning: macro "AUDIT_UNINITIALIZED" is not used
[-Wunused-macros]
kernel/auditsc.c:104:0: warning: macro "AUDIT_AUX_IPCPERM" is not used
[-Wunused-macros]
kernel/auditsc.c:82:0: warning: macro "AUDITSC_INVALID" is not used
[-Wunused-macros]

remove them to tame gcc.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Paul Moore <paul@paul-moore.com> 
Cc: Eric Paris <eparis@redhat.com> 
Cc: linux-audit@redhat.com 
Cc: linux-kernel@vger.kernel.org 
---
 kernel/audit.c   | 1 -
 kernel/auditsc.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index ac0aeaa99937..dfac1e0ca887 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -65,7 +65,6 @@
 /* No auditing will take place until audit_initialized == AUDIT_INITIALIZED.
  * (Initialization happens after skb_init is called.) */
 #define AUDIT_DISABLED		-1
-#define AUDIT_UNINITIALIZED	0
 #define AUDIT_INITIALIZED	1
 static int	audit_initialized;
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 183d79cc2e12..eeb4930d499f 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -80,7 +80,6 @@
 #include "audit.h"
 
 /* flags stating the success for a syscall */
-#define AUDITSC_INVALID 0
 #define AUDITSC_SUCCESS 1
 #define AUDITSC_FAILURE 2
 
@@ -102,8 +101,6 @@ struct audit_aux_data {
 	int			type;
 };
 
-#define AUDIT_AUX_IPCPERM	0
-
 /* Number of target pids per aux struct. */
 #define AUDIT_AUX_PIDS	16
 
-- 
1.8.3.1

