Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452AF2A95A2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgKFLpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbgKFLpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:45:18 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23980C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 03:45:18 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id u4so732339pgr.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 03:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=HaNt2mlRAlAoxF2Isj0xFsjd9qFUKQsVcJVP+Hd1+Yg=;
        b=D13VE9SiFm7G2w85lTPA58/efrmgeq0KEUoo8rDWGCaTzISsI2n/LJm/H65GapPWBn
         9f7EqpVFHYtBMW9DBr2AGfwenOjJkrCTV3v7FJoJwnFCwYFZqeJEa2dmP6S9u213vNQp
         UfK0KYnH/JZx1/QwzYzRGWMurGv7giYHl3i/nxKB+tAtWDxqSBIuVXmqm5YGu6fCvllk
         RjRP20cFNIX35M7Ho8nGi2OWnBJc1TcMoumCq2gvMq8jaPitJGsCezj3MBq/hCszenYz
         Vxpas2Vcq2twwLkAYUsGsEWpedVZH+2IMsiJ2Suo/W2ysKypwh0Bdxl1UcEWCO90Vsd1
         9iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HaNt2mlRAlAoxF2Isj0xFsjd9qFUKQsVcJVP+Hd1+Yg=;
        b=kJUP4lPLbQaMuWRODS71w5acCXgcWSzsdUYJn2pZh0vJPdjL/l7Wcq7beZHtR0EK/r
         X1enExXbKv1u5NGehNAG/u/zoSdL2lCbscEqxTvQ7L9qPv3ctnB3ShpRGQxPCPyPdYrO
         7LVrIhpBR3kzDXxw9de+QBPGBk79NzY7gswPpxdNjLPFXrvqBB0ABKaKHi3QqMn50f+W
         hn8QfzW+avy5VT/oTDPzaC/lgcKUDy/yNLZObz/1vd9Zib4TcgDie1QW7gLIAPEpkyJL
         eOVp5tigui0wKob86kvVrHJrfUD5LjVWVNOHeAtBcMPAtfCbD0ZW5QhdUbdC025jcI4e
         qzsg==
X-Gm-Message-State: AOAM5337cfmEvEVVhtL597eDfXs3UTrUwUGepqxliqroCwNkfj901NaR
        TK7BApcmFgMutBLe1hsPIyY=
X-Google-Smtp-Source: ABdhPJzYL2CRGS46Smu81347M0aNgCYBfOQG4Kkh6nFjwQgun6GImM0Fru0ryXyYHitrVv6JcutKUg==
X-Received: by 2002:a63:af08:: with SMTP id w8mr1409766pge.419.1604663117680;
        Fri, 06 Nov 2020 03:45:17 -0800 (PST)
Received: from adolin ([49.207.192.29])
        by smtp.gmail.com with ESMTPSA id p15sm2061638pjv.44.2020.11.06.03.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 03:45:17 -0800 (PST)
Date:   Fri, 6 Nov 2020 17:15:12 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH] coccinelle: locks: Add balancedlock.cocci script
Message-ID: <20201106114512.fl22zzewvnimfxnb@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When acquiring locks under certain conditions, they must be released
under the same conditions as well. However, sometimes, there may be
missing unlocks which may lead to a potential deadlock.

Add this script to detect such code segments and avoid potential
deadlock situations.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 scripts/coccinelle/locks/balancedlock.cocci | 162 ++++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 scripts/coccinelle/locks/balancedlock.cocci

diff --git a/scripts/coccinelle/locks/balancedlock.cocci b/scripts/coccinelle/locks/balancedlock.cocci
new file mode 100644
index 000000000000..fe7bc2dfeb29
--- /dev/null
+++ b/scripts/coccinelle/locks/balancedlock.cocci
@@ -0,0 +1,162 @@
+/// Sometimes, locks that are acquired under certain conditions may have missing unlocks
+/// leading to a potential deadlock situation. This patch detects such cases.
+//# False positives may be generated due to locks released within a nested
+//# function call or a goto block.
+///
+// Confidence: Moderate
+// Copyright: (C) 2020 Julia Lawall INRIA/LIP6
+
+virtual context
+virtual org
+virtual report
+
+
+@prelocked@
+expression E;
+position p;
+@@
+
+(
+mutex_lock(E@p);
+|
+read_lock(E@p);
+|
+write_lock(E@p);
+|
+spin_lock(E@p);
+|
+spin_lock_bh(E@p);
+|
+spin_lock_irqsave(E@p, ...);
+|
+read_lock_irqsave(E@p, ...);
+|
+write_lock_irqsave(E@p, ...);
+|
+raw_spin_lock(E@p);
+|
+raw_spin_lock_irq(E@p);
+|
+raw_spin_lock_bh(E@p);
+|
+local_lock(E@p);
+|
+local_lock_irq(E@p);
+|
+local_lock_irqsave(E@p, ...);
+|
+read_lock_irq(E@p);
+|
+read_lock_bh(E@p);
+|
+write_lock_bh(E@p);
+)
+
+@balanced@
+position prelocked.p;
+position pif;
+expression e,prelocked.E;
+statement S1,S2;
+identifier lock;
+identifier unlock={mutex_unlock,
+                   spin_unlock,
+                   spin_unlock_bh,
+                   spin_unlock_irqrestore,
+                   read_unlock_irqrestore,
+                   write_unlock_irqrestore,
+                   raw_spin_unlock,
+                   raw_spin_unlock_irq,
+                   raw_spin_unlock_bh,
+                   local_unlock,
+                   local_unlock_irq,
+                   local_unlock_irqrestore,
+                   read_unlock_irq,
+                   read_unlock_bh,
+                   write_unlock_bh
+                   };
+@@
+
+if (e) {
+ ... when any
+lock(E@p, ...)
+ ... when != E
+     when any
+} else S1
+... when != E
+    when any
+if@pif (e) {
+ ... when != E
+     when any
+ unlock(E, ...);
+ ... when any
+} else S2
+...  when != E
+     when any
+
+// ----------------------------------------------------------------------------
+
+@balanced2 depends on context || org || report@
+identifier lock, unlock = {mutex_unlock,
+                           spin_unlock,
+                           spin_unlock_bh,
+                           spin_unlock_irqrestore,
+                           read_unlock_irqrestore,
+                           write_unlock_irqrestore,
+                           raw_spin_unlock,
+                           raw_spin_unlock_irq,
+                           raw_spin_unlock_bh,
+                           local_unlock,
+                           local_unlock_irq,
+                           local_unlock_irqrestore,
+                           read_unlock_irq,
+                           read_unlock_bh,
+                           write_unlock_bh
+                           };
+expression E, f, x;
+statement S1, S2, S3, S4;
+position prelocked.p, balanced.pif;
+position j0, j1, j2, j3;
+@@
+
+* lock@j0(E@p, ...);
+... when != E;
+    when != if@pif (...) S1 else S2
+    when any
+x@j1 = f(...);
+* if (<+...x...+>)
+{
+  ... when != E;
+      when forall
+      when != if@pif (...) S3 else S4
+*  return@j2 ...;
+}
+... when any
+* unlock@j3(E, ...);
+
+// ----------------------------------------------------------------------------
+
+@script:python balanced2_org depends on org@
+j0 << balanced2.j0;
+j1 << balanced2.j1;
+j2 << balanced2.j2;
+j3 << balanced2.j3;
+@@
+
+msg = "This code segment might have an unbalanced lock."
+coccilib.org.print_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+coccilib.org.print_link(j2[0], "")
+coccilib.org.print_link(j3[0], "")
+
+// ----------------------------------------------------------------------------
+
+@script:python balanced2_report depends on report@
+j0 << balanced2.j0;
+j1 << balanced2.j1;
+j2 << balanced2.j2;
+j3 << balanced2.j3;
+@@
+
+msg = "This code segment might have an unbalanced lock around lines %s,%s,%s." % (j1[0].line,j2[0].line,j3[0].line)
+coccilib.report.print_report(j0[0], msg)
+
-- 
2.25.1

