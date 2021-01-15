Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACF62F6F52
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbhAOANK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:13:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:45750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731073AbhAOANK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:13:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5009CABDA;
        Fri, 15 Jan 2021 00:12:29 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     paul@paul-moore.com
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] audit: Remove leftover reference to the audit_tasklet
Date:   Thu, 14 Jan 2021 16:12:01 -0800
Message-Id: <20210115001201.116832-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was replaced with a kauditd_wait kthread long ago,
back in:

     b7d1125817c (AUDIT: Send netlink messages from a separate kernel thread)

Update the stale comment.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 1ffc2e059027..8fd735190c12 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2365,7 +2365,7 @@ int audit_signal_info(int sig, struct task_struct *t)
  *
  * We can not do a netlink send inside an irq context because it blocks (last
  * arg, flags, is not set to MSG_DONTWAIT), so the audit buffer is placed on a
- * queue and a tasklet is scheduled to remove them from the queue outside the
+ * queue and a kthread is scheduled to remove them from the queue outside the
  * irq context.  May be called in any context.
  */
 void audit_log_end(struct audit_buffer *ab)
-- 
2.26.2

