Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59B92B77F7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgKRICs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgKRICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:02:48 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26621C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 00:02:48 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id i13so635327pgm.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 00:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=1MznaoaWYPhILjK6Iw2zxEvLXxblXieEgx/j6qplbWo=;
        b=OZEH5p2/Ey6xsEgcxVjk2KnO7FcOPg7SgJQiypZusHEOEdM2i2T/NzHudHqZrk/iD6
         cWYDciD29PDUBxrX001+qFsD2d5q0hZUEUUeXCSdbO3y493BY8NwvQat6DpEXXqvFG3q
         /Q4JIh+Pkzt/HApb8uSkY7ye3WGi3DxxuOhQJbaUDb0GE9uW0PnoaOYAEEmTJC4HuvoK
         g9fndS1D8Suk7JhiH53v6OoW9pfgqHIG9rbEnzwSwshIVBZJ/G1UGAarBdoU6KDleSoK
         ioqxVT8sk1ht+aMUPk2CmfEMJ2qgxmMHPNEfb/RNzEpO1XAIZZpH/wDSdyJbhS/NkPvp
         fEsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=1MznaoaWYPhILjK6Iw2zxEvLXxblXieEgx/j6qplbWo=;
        b=DfHAhNytYezrUdBjpvNix1O535mO48nMGKMuxKK0mEeSYU+6BY2WpD1dp522bBbCvB
         wHcd/nK+mJkkKP0om64zYu2PrtAlc8I/OrppmHGATbtIOprC+MulMCPhyXX5yN27Y6bX
         mMX6Wg1oy/7wm1ZbIfrnlZKsaA8CmnpMjaWc5uGMdYK8FQfHbdfsxMGhG5aijNhcalyR
         fafEpb/saghzc7ipoHHJ9ghltx59MzsdyErz+wImo5wuo1uZ+e/20+Jl3LcpXyTct9C8
         zauI72G9qRa6lPzHU0Yyctknrr06+VP0pkz9hPxagVtBNQS4SDdP8BaWMs5kR0rOfAAv
         DePQ==
X-Gm-Message-State: AOAM533xdnE7ivSYb/+zl8YX058gaoz6lINMYY7faAHm9nim5RjL+eux
        uRxY1E+UzwsrQFwdWSU6Q9I=
X-Google-Smtp-Source: ABdhPJwxwr5pDZsF+oXOFKlhhkSq+JDhp7dwTvj+0ac39w/2ikbtuX2Ic6nJMYhy6zZV5GNnHeUX5Q==
X-Received: by 2002:a63:1901:: with SMTP id z1mr6775411pgl.87.1605686567722;
        Wed, 18 Nov 2020 00:02:47 -0800 (PST)
Received: from adolin ([49.207.220.203])
        by smtp.gmail.com with ESMTPSA id q19sm24924365pfh.37.2020.11.18.00.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 00:02:47 -0800 (PST)
Date:   Wed, 18 Nov 2020 13:32:42 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     Julia.Lawall@lip6.fr
Cc:     Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] coccinelle: locks: Add balancedlock.cocci script
Message-ID: <20201118080242.t6u6lchj5ww2fac4@adolin>
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
Changes in v2(as suggested by Markus):
- Modify usage of position variable
- Modify comments
- Add dependencies for rules
---
 scripts/coccinelle/locks/balancedlock.cocci | 164 ++++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 scripts/coccinelle/locks/balancedlock.cocci

diff --git a/scripts/coccinelle/locks/balancedlock.cocci b/scripts/coccinelle/locks/balancedlock.cocci
new file mode 100644
index 000000000000..9684a9920f79
--- /dev/null
+++ b/scripts/coccinelle/locks/balancedlock.cocci
@@ -0,0 +1,164 @@
+/// Sometimes, locks that are acquired under certain conditions may have
+/// missing unlocks leading to a potential deadlock situation. This
+/// semantic patch detects such cases.
+//# False positives may be generated due to locks released within a nested
+//# function call or a goto block.
+///
+// Confidence: Moderate
+// Copyright: (C) 2020 Julia Lawall INRIA/LIP6
+// Copyright: (C) 2020 Sumera Priyadarsini
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
+mutex_lock@p(E);
+|
+read_lock@p(E);
+|
+write_lock@p(E);
+|
+spin_lock@p(E);
+|
+spin_lock_bh@p(E);
+|
+spin_lock_irqsave@p(E, ...);
+|
+read_lock_irqsave@p(E, ...);
+|
+write_lock_irqsave@p(E, ...);
+|
+raw_spin_lock@p(E);
+|
+raw_spin_lock_irq@p(E);
+|
+raw_spin_lock_bh@p(E);
+|
+local_lock@p(E);
+|
+local_lock_irq@p(E);
+|
+local_lock_irqsave@p(E, ...);
+|
+read_lock_irq@p(E);
+|
+read_lock_bh@p(E);
+|
+write_lock_bh@p(E);
+)
+
+@balanced@ depends on context || org || report@
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
+lock@p(E, ...)
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
+* lock@j0@p(E, ...);
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

