Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B9925E427
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 01:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgIDX0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 19:26:54 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:34872 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbgIDX02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 19:26:28 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id DC54E2ACD6; Fri,  4 Sep 2020 19:26:27 -0400 (EDT)
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Message-Id: <d7c7ee33232cf72a6a6bbb6ef05838b2e2b113c0.1599260540.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1599260540.git.fthain@telegraphics.com.au>
References: <cover.1599260540.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 3/5] powerpc/tau: Remove duplicated set_thresholds() call
Date:   Sat, 05 Sep 2020 09:02:20 +1000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commentary at the call site seems to disagree with the code. The
conditional prevents calling set_thresholds() via the exception handler,
which appears to crash. Perhaps that's because it immediately triggers
another TAU exception. Anyway, calling set_thresholds() from TAUupdate()
is redundant because tau_timeout() does so.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/powerpc/kernel/tau_6xx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/kernel/tau_6xx.c b/arch/powerpc/kernel/tau_6xx.c
index 268205cc347da..b8d7e7d498e0a 100644
--- a/arch/powerpc/kernel/tau_6xx.c
+++ b/arch/powerpc/kernel/tau_6xx.c
@@ -110,11 +110,6 @@ static void TAUupdate(int cpu)
 #ifdef DEBUG
 	printk("grew = %d\n", tau[cpu].grew);
 #endif
-
-#ifndef CONFIG_TAU_INT /* tau_timeout will do this if not using interrupts */
-	set_thresholds(cpu);
-#endif
-
 }
 
 #ifdef CONFIG_TAU_INT
-- 
2.26.2

