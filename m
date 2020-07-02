Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03E9213431
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 08:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgGCGah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 02:30:37 -0400
Received: from mail1.windriver.com ([147.11.146.13]:59254 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCGah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:30:37 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 0636U2bb024467
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Thu, 2 Jul 2020 23:30:03 -0700 (PDT)
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 23:29:44 -0700
From:   <qiang.zhang@windriver.com>
To:     <ben.dooks@codethink.co.uk>, <bfields@redhat.com>,
        <cl@rock-chips.com>, <peterz@infradead.org>, <pmladek@suse.com>,
        <tj@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] kthread: Don't cancel a work that is being cancelled
Date:   Thu, 2 Jul 2020 12:43:24 +0800
Message-ID: <20200702044324.32927-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

When canceling a work, if it is found that the work is in
the cancelling state, we should directly exit the cancelled
operation.

Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
---
 kernel/kthread.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa481be3a..1166f2043e67 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1103,6 +1103,9 @@ static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
 	/* Work must not be used with >1 worker, see kthread_queue_work(). */
 	WARN_ON_ONCE(work->worker != worker);
 
+	if (work->canceling)
+		goto out_fast;
+
 	ret = __kthread_cancel_work(work, is_dwork, &flags);
 
 	if (worker->current_work != work)
-- 
2.24.1

