Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E322D688B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 21:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390493AbgLJUT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 15:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390127AbgLJUTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 15:19:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F02C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 12:18:24 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607631502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XUizVUdSL7/vvz9vnbsjRE/PNIgtT8MGKEUbe5J8TUE=;
        b=MGoaIX5wr0Wk1EYPMyH+jTczQw27FX/IVeMSX3IuccfsmLjJLQd2MNDirMU42EzEYUgXzm
        e5uH0PsQL6yz5A9lTg+Y0CvsA/3XRV08v5XotV678mMs1GqTPmbAtWOpzAWwYQDx6v7lIy
        bGcl9u7bCNOxK2+OLnCA/LsSji0Sc+08Ct5TIyoWU06EQ0muVkSnBB2pG1fCGlpb8cYSET
        jK7EDqh7KUnPV/l4TJnoXx5wuKxlrL+3+js3cesjr2dyBuSlgf6VUT86JFHVwPFzWMprWk
        oDBXtUBvYrRBf7z9xQtQ5V36gOlqCvmi10EcfDXOggc5x4j803Ky7PjmFFdZJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607631503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=XUizVUdSL7/vvz9vnbsjRE/PNIgtT8MGKEUbe5J8TUE=;
        b=MPcPa/cswxKxwawfDwlHHSEKPnJkYNA4/q03kCjjWZf8WTANSqEow9xo7vMyVpkbS/Yy8/
        cnH3uok+l9dJkOAA==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Ming Lei <ming.lei@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH] x86/apic/vector: Fix ordering in vector assignment
Date:   Thu, 10 Dec 2020 21:18:22 +0100
Message-ID: <87ft4djtyp.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prarit reported that depending on the affinity setting the

 ' irq $N: Affinity broken due to vector space exhaustion.'

message is showing up in dmesg, but the vector space on the CPUs in the
affinity mask is definitely not exhausted.

Shung-Hsi provided traces and analysis which pinpoints the problem:

The ordering of trying to assign an interrupt vector in
assign_irq_vector_any_locked() is simply wrong if the interrupt data has a
valid node assigned. It does:

 1) Try the intersection of affinity mask and node mask
 2) Try the node mask
 3) Try the full affinity mask
 4) Try the full online mask

Obviously #2 and #3 are in the wrong order as the requested affinity
mask has to take precedence.

In the observed cases #1 failed because the affinity mask did not contain
CPUs from node 0. That made it allocate a vector from node 0, thereby
breaking affinity and emitting the misleading message.

Revert the order of #2 and #3 so the full affinity mask without the node
intersection is tried before actually affinity is broken.

If no node is assigned then only the full affinity mask and if that fails
the full online mask is tried.

Fixes: d6ffc6ac83b1 ("x86/vector: Respect affinity mask in irq descriptor")
Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Reported-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/apic/vector.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -273,20 +273,24 @@ static int assign_irq_vector_any_locked(
 	const struct cpumask *affmsk = irq_data_get_affinity_mask(irqd);
 	int node = irq_data_get_node(irqd);
 
-	if (node == NUMA_NO_NODE)
-		goto all;
-	/* Try the intersection of @affmsk and node mask */
-	cpumask_and(vector_searchmask, cpumask_of_node(node), affmsk);
-	if (!assign_vector_locked(irqd, vector_searchmask))
-		return 0;
-	/* Try the node mask */
-	if (!assign_vector_locked(irqd, cpumask_of_node(node)))
-		return 0;
-all:
+	if (node != NUMA_NO_NODE) {
+		/* Try the intersection of @affmsk and node mask */
+		cpumask_and(vector_searchmask, cpumask_of_node(node), affmsk);
+		if (!assign_vector_locked(irqd, vector_searchmask))
+			return 0;
+	}
+
 	/* Try the full affinity mask */
 	cpumask_and(vector_searchmask, affmsk, cpu_online_mask);
 	if (!assign_vector_locked(irqd, vector_searchmask))
 		return 0;
+
+	if (node != NUMA_NO_NODE) {
+		/* Try the node mask */
+		if (!assign_vector_locked(irqd, cpumask_of_node(node)))
+			return 0;
+	}
+
 	/* Try the full online mask */
 	return assign_vector_locked(irqd, cpu_online_mask);
 }
