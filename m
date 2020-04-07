Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34691A1083
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 17:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgDGPqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 11:46:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:59520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgDGPqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:46:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6FA54AB89;
        Tue,  7 Apr 2020 15:46:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9018F1E1233; Tue,  7 Apr 2020 17:46:47 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrei Vagin <avagin@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH] ucount: Make sure ucounts in /proc/sys/user don't regress again
Date:   Tue,  7 Apr 2020 17:46:43 +0200
Message-Id: <20200407154643.10102-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 769071ac9f20 "ns: Introduce Time Namespace" broke reporting of
inotify ucounts (max_inotify_instances, max_inotify_watches) in
/proc/sys/user because it has added UCOUNT_TIME_NAMESPACES into enum
ucount_type but didn't properly update reporting in
kernel/ucount.c:setup_userns_sysctls(). This problem got fixed in commit
eeec26d5da82 "time/namespace: Add max_time_namespaces ucount". Add
BUILD_BUG_ON to catch a similar problem in the future.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 kernel/ucount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index a53cc2b4179c..3da4d868e452 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -81,6 +81,8 @@ bool setup_userns_sysctls(struct user_namespace *ns)
 {
 #ifdef CONFIG_SYSCTL
 	struct ctl_table *tbl;
+
+	BUILD_BUG_ON(ARRAY_SIZE(user_table) != UCOUNT_COUNTS + 1);
 	setup_sysctl_set(&ns->set, &set_root, set_is_seen);
 	tbl = kmemdup(user_table, sizeof(user_table), GFP_KERNEL);
 	if (tbl) {
-- 
2.16.4

