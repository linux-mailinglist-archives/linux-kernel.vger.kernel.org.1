Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B497242860
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 12:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgHLKx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 06:53:29 -0400
Received: from mail1.windriver.com ([147.11.146.13]:62510 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgHLKxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 06:53:25 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 07CAprU3008905
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 12 Aug 2020 03:51:54 -0700 (PDT)
Received: from ztang-OptiPlex-5070.wrs.com (128.224.162.245) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.3.487.0; Wed, 12 Aug 2020 03:51:53 -0700
From:   <zhantao.tang@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <bigeasy@linutronix.de>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <linux-rt-users@vger.kernel.org>
Subject: [PATCH linux-5.2.y-rt only] hrtimer: correct the logic for grab expiry lock
Date:   Wed, 12 Aug 2020 18:50:53 +0800
Message-ID: <20200812105053.602-1-zhantao.tang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhantao Tang <zhantao.tang@windriver.com>

In commit: 47b6de0b7f22 ("hrtimer: Add a missing bracket and hide `migration_base' on !SMP")
a inline function is_migration_base() is introduced. But
the logic of the hrtimer_grab_expiry_lock was changed.

This patch is to correct it.

Signed-off-by: Zhantao Tang <zhantao.tang@windriver.com>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b3adac366fd1..6b47e310c68e 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -944,7 +944,7 @@ void hrtimer_grab_expiry_lock(const struct hrtimer *timer)
 {
 	struct hrtimer_clock_base *base = READ_ONCE(timer->base);
 
-	if (timer->is_soft && is_migration_base(base)) {
+	if (timer->is_soft && !is_migration_base(base)) {
 		spin_lock(&base->cpu_base->softirq_expiry_lock);
 		spin_unlock(&base->cpu_base->softirq_expiry_lock);
 	}
-- 
2.17.1

