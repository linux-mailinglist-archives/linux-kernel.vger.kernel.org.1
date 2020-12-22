Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE7EE2E071B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 09:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgLVIN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 03:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgLVIN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 03:13:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F987C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 00:12:48 -0800 (PST)
Date:   Tue, 22 Dec 2020 08:12:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608624764;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ae4GG/wEhEmS/wAKi+uUI/n/3TqvK8GqfCBncKz/lTA=;
        b=duP1r8G7XNXZasOg62VkWgr4ba5vT5Wo2w4tjrdAV6NDEwbPFiP5hJOMy5CcL9OyAhXQMQ
        inew5vIB5H07Pd17hrSz60R564DikhX//TlMfWhjbhxs8DVmnGs47aUg4H2cYfQiHpywgl
        p8B3E6kR/wipZ+TTz04DWDYFijLvmdjlvO1BDYPKWzmmdnkGjHQCtD7WIdGsI9cdtALXkC
        nd8KJSzR4dRW5qIcyILac5+WaVl+xIYF9Ax3tiXM2o9pUxTZLbMe5zEQWNXrLaPqG8P3B0
        3qvwbJ8v8MUOgxZJoKgDJNCnz6BVtGiHxcsZIg0yXVTXPyJz9x7NEEEPY1O+Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608624764;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ae4GG/wEhEmS/wAKi+uUI/n/3TqvK8GqfCBncKz/lTA=;
        b=L3R2XB9G6KgyLnizd3nj5/NG7ydOgqQffWu/DvyA5FZLLDorvA9cQN9DagKWVd7jVDxci0
        l9Ec6C9yWCUhAbBA==
From:   "irqchip-bot for John Garry" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] driver core: platform: Add extra error
 check in devm_platform_get_irqs_affinity()
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        John Garry <john.garry@huawei.com>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <1608561055-231244-1-git-send-email-john.garry@huawei.com>
References: <1608561055-231244-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <160862476339.414.17626678568765447822.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     e1dc20995cb9fa04b46e8f37113a7203c906d2bf
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/e1dc20995cb9fa04b46e8f37113a7203c906d2bf
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Mon, 21 Dec 2020 22:30:55 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 22 Dec 2020 08:06:38 

driver core: platform: Add extra error check in devm_platform_get_irqs_affinity()

The current check of nvec < minvec for nvec returned from
platform_irq_count() will not detect a negative error code in nvec.

This is because minvec is unsigned, and, as such, nvec is promoted to
unsigned in that check, which will make it a huge number (if it contained
-EPROBE_DEFER).

In practice, an error should not occur in nvec for the only in-tree
user, but add a check anyway.

Fixes: e15f2fa959f2 ("driver core: platform: Add devm_platform_get_irqs_affinity()")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1608561055-231244-1-git-send-email-john.garry@huawei.com
---
 drivers/base/platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index ea8add1..74c97b6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -351,6 +351,8 @@ int devm_platform_get_irqs_affinity(struct platform_device *dev,
 		return -ERANGE;
 
 	nvec = platform_irq_count(dev);
+	if (nvec < 0)
+		return nvec;
 
 	if (nvec < minvec)
 		return -ENOSPC;
