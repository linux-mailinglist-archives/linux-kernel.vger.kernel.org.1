Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8342E2B56
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 12:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgLYLcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 06:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgLYLcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 06:32:01 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A21C061573
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 03:31:21 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4D2PsJ5Vxbz9sWF; Fri, 25 Dec 2020 22:31:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1608895876;
        bh=Bza2QCTskwBGmQFwhL52iy63R4zodFdgPTlcDZdgiJQ=;
        h=From:To:Cc:Subject:Date:From;
        b=maQ/VtfF96emL2+LWZwjq4Hgu7XjY4RBJn3gTQiLqye1O9J7kuQyeJ9sndqM8zDvy
         rA+i1+FqPXypb1BWXK4YGXcS0St98Ps9oukoCWtpsN22A3daakx+GR9pwEaZKNe232
         Nks8XveZc6DVon2wOkyJHegD5ZP7X004ShPfrDh3/s+wMiiWwJl+06a3VUUJ18XK/4
         QhTtkYaLCqCkZN+ytRN/D3AxhFGhZ4zb70VIvAJ3fN2uXXhq3YjzAmTU/VJRNchMni
         MA99P+qXcGZhvT7ZUpJarnDuvtFvp44ghd+Aumju9If/Jpg+bHpXxkTIuBASM+l8fW
         h8qG8EzNQOgjg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     torvalds@linux-foundation.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@ozlabs.org
Subject: [PATCH] genirq: Fix export of irq_to_desc() for powerpc KVM
Date:   Fri, 25 Dec 2020 22:30:58 +1100
Message-Id: <20201225113058.2430951-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 64a1b95bb9fe ("genirq: Restrict export of irq_to_desc()")
removed the export of irq_to_desc() unless powerpc KVM is being built,
because there is still a use of irq_to_desc() in modular code there.

However it used:

  #ifdef CONFIG_KVM_BOOK3S_64_HV

Which doesn't work when that symbol is =m, leading to a build failure:

  ERROR: modpost: "irq_to_desc" [arch/powerpc/kvm/kvm-hv.ko] undefined!

Fix it by checking for the definedness of the correct symbol which is
CONFIG_KVM_BOOK3S_64_HV_MODULE.

Fixes: 64a1b95bb9fe ("genirq: Restrict export of irq_to_desc()")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 kernel/irq/irqdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 3d0bc38a0bcf..cc1a09406c6e 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -352,7 +352,7 @@ struct irq_desc *irq_to_desc(unsigned int irq)
 {
 	return radix_tree_lookup(&irq_desc_tree, irq);
 }
-#ifdef CONFIG_KVM_BOOK3S_64_HV
+#ifdef CONFIG_KVM_BOOK3S_64_HV_MODULE
 EXPORT_SYMBOL_GPL(irq_to_desc);
 #endif
 
-- 
2.25.1

