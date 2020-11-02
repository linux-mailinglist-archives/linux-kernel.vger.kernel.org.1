Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19122A27C7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgKBKKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:10:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:42842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbgKBKKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:10:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604311847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VredqEs3zsL7zVXAU6Nag2b9EtiI2PI84vk+sy0mICQ=;
        b=FjLzR2S6zs90AlezIG3wQfjvLX7BCp9tUV4Sns3f0aMoq9GlhSTIw4pXXzIuiMs3jHUtE1
        FJldsBRijVKj26LakHUO6N7Db9V7f6toTAen1iVrCrfPs8a+fawUb48TN2KCeN5iJYJo22
        vE+vtvQ6PauCRNSjlwotPa8AI3WtSJE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20F8BACA0;
        Mon,  2 Nov 2020 10:10:47 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Zhang Qiang <Qiang.Zhang@windriver.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: [PATCH] kthread_worker: Document CPU hotplug handling
Date:   Mon,  2 Nov 2020 11:10:39 +0100
Message-Id: <20201102101039.19227-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kthread worker API is simple. In short, it allows to create, use, and
destroy workers. kthread_create_worker_on_cpu() just allows to bind
a newly created worker to a given CPU.

It is up to the API user how to handle CPU hotplug. They have to decide
how to handle pending work items, prevent queuing new ones, and
restore the functionality when the CPU goes off and on. There are
few catches:

   + The CPU affinity gets lost when it is scheduled on an offline CPU.

   + The worker might not exist when the CPU was off when the user
     created the workers.

A good practice is to implement two CPU hotplug callbacks and
destroy/create the worker when CPU goes down/up.

Mention this in the function description.

Link: https://lore.kernel.org/r/20201028073031.4536-1-qiang.zhang@windriver.com
Reported-by: Zhang Qiang <Qiang.Zhang@windriver.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/kthread.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index e29773c82b70..fd3deae3afde 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -786,7 +786,25 @@ EXPORT_SYMBOL(kthread_create_worker);
  * A good practice is to add the cpu number also into the worker name.
  * For example, use kthread_create_worker_on_cpu(cpu, "helper/%d", cpu).
  *
- * Returns a pointer to the allocated worker on success, ERR_PTR(-ENOMEM)
+ * CPU hotplug:
+ * The kthread worker API is simple and generic. It just provides a way
+ * how to create, use, and destroy workers.
+ *
+ * It is up to the API user how to handle CPU hotplug. They have to decide
+ * how to handle pending work items, prevent queuing new ones, and
+ * restore the functionality when the CPU goes off and on. There are
+ * few catches:
+ *
+ *    - CPU affinity gets lost when it is scheduled on an offline CPU.
+ *
+ *    - The worker might not exist when the CPU was off when the user
+ *      created the workers.
+ *
+ * A good practice is to implement two CPU hotplug callbacks and
+ * destroy/create the worker when CPU goes down/up.
+ *
+ * Return:
+ * The pointer to the allocated worker on success, ERR_PTR(-ENOMEM)
  * when the needed structures could not get allocated, and ERR_PTR(-EINTR)
  * when the worker was SIGKILLed.
  */
-- 
2.26.2

