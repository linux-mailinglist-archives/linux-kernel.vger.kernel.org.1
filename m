Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18EC276ED3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 12:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgIXKfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 06:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgIXKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 06:35:10 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2A9C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 03:35:10 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id y14so1630670pgf.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 03:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=KmL8vyp508qdUeyaBVJz9l+cgP9HDZJMrQi87MgxIv4=;
        b=DUmmxAMHLA6Y6oxNLR2+SJoV/M+GCSY+YgJ0JwuJLuqCHyNxGqcfGE7MzvPvC/J0SA
         s7hMLn+miAtVg6f7c+L0mZ9PwbJbnlhwlcc7ATP/jtFGrRjWkA7FM3N3gDyWcZsh47uO
         ASsQWM4RO5y2CW4ZzUlwYMSgwqte8vLf0Kl9p07GDcl8BqBxSTNBJ3J5wTlyYQAYItex
         7RTAvxRWISz5QdW4LOkxZbmxulxkXv8OpqvlsLNIvB7yXPC1f4NLetx3dcT057h15lGs
         RZ31yy3JnIdsEXlTRtcSv9gh5N+MHTtJ6GPA3R+IQs1BiJJWzvB8GdYExl1AykDJwhaC
         B7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KmL8vyp508qdUeyaBVJz9l+cgP9HDZJMrQi87MgxIv4=;
        b=Slro4nrWw7QacCrg1zbycLUA+SFsnh+xabUNQ4Uc6t79em4VA2jt0PXERmWK5rNnqo
         JucQvT6Q7ujP3/KUPxRxKQddF0KgEAThWkA9QT0Pt3XveF9eLih6due+iuibO8J8wxxX
         28phuR1d35eWosD1o+IJqg3rZXLNt0Ya/cvnK1GU8dHmgLSZ2ph6yyAzcZaeaM4xDmWd
         rYrG4qyHlYBDb23W3UsuYFgHMhRlTDA/Z0Jn4QvzTrsfuPbQzjADMEiIA7T1NaCfPcw6
         gSReAxKKMJsaUlaQqo0cgegt6OJEEBSpy23WoLqD9TF0HxuL0C3RmjPJsdloCBjDMGws
         m7ZQ==
X-Gm-Message-State: AOAM532T5AvVxr5yiUNvk6XgSa821xx+3aNPHmDRamLsW47Y/g5+L1LV
        Om/71NJqsR7o2sq/tjwcCNk1p/lehopS5snW
X-Google-Smtp-Source: ABdhPJytKP3vyuFyNa5Y6imfCslsQO3tcklFOkHwdlUx8Ztc787slznKAU0VMbgxGRDZ1sd1bgahDw==
X-Received: by 2002:aa7:8583:0:b029:13f:7096:5eb with SMTP id w3-20020aa785830000b029013f709605ebmr4044342pfn.0.1600943709678;
        Thu, 24 Sep 2020 03:35:09 -0700 (PDT)
Received: from adolin ([49.207.208.43])
        by smtp.gmail.com with ESMTPSA id nl10sm1816511pjb.11.2020.09.24.03.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 03:35:09 -0700 (PDT)
Date:   Thu, 24 Sep 2020 16:05:04 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     cocci@systeme.lip6.fr
Cc:     Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, michal.lkml@markovi.net
Subject: [PATCH] [Cocci] coccinelle: iterators: Add for_each_child.cocci
 script
Message-ID: <20200924103504.2ceibylmerdzgmct@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While iterating over child nodes with the for_each functions, if
control is transferred from the middle of the loop, as in the case
of a break or return or goto, there is no decrement in the
reference counter thus ultimately resulting in a memory leak.

Add this script to detect potential memory leaks caused by
the absence of of_node_put() before break, goto, or, return
statements which transfer control outside the loop.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 .../coccinelle/iterators/for_each_child.cocci | 348 ++++++++++++++++++
 1 file changed, 348 insertions(+)
 create mode 100644 scripts/coccinelle/iterators/for_each_child.cocci

diff --git a/scripts/coccinelle/iterators/for_each_child.cocci b/scripts/coccinelle/iterators/for_each_child.cocci
new file mode 100644
index 000000000000..0abc12ca2ad3
--- /dev/null
+++ b/scripts/coccinelle/iterators/for_each_child.cocci
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Adds missing of_node_put() before return/break/goto statement within a for_each iterator for child nodes.
+//# False positives can be due to function calls within the for_each
+//# loop that may encapsulate an of_node_put.
+///
+// Confidence: High
+// Copyright: (C) 2020 Sumera Priyadarsini
+// URL: http://coccinelle.lip6.fr
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@r@
+local idexpression n;
+expression e1,e2;
+iterator name for_each_node_by_name, for_each_node_by_type,
+for_each_compatible_node, for_each_matching_node,
+for_each_matching_node_and_match, for_each_child_of_node,
+for_each_available_child_of_node, for_each_node_with_property;
+iterator i;
+statement S;
+expression list [n1] es;
+@@
+
+(
+(
+for_each_node_by_name(n,e1) S
+|
+for_each_node_by_type(n,e1) S
+|
+for_each_compatible_node(n,e1,e2) S
+|
+for_each_matching_node(n,e1) S
+|
+for_each_matching_node_and_match(n,e1,e2) S
+|
+for_each_child_of_node(e1,n) S
+|
+for_each_available_child_of_node(e1,n) S
+|
+for_each_node_with_property(n,e1) S
+)
+&
+i(es,n,...) S
+)
+
+@ruleone depends on patch && !context && !org && !report@
+
+local idexpression r.n;
+iterator r.i,i1;
+expression e;
+expression list [r.n1] es;
+statement S;
+@@
+
+ i(es,n,...) {
+   ...
+(
+   of_node_put(n);
+|
+   e = n
+|
+   return n;
+|
+   i1(...,n,...) S
+|
++  of_node_put(n);
+?  return ...;
+)
+   ... when any
+ }
+
+@ruletwo depends on patch && !context && !org && !report@
+
+local idexpression r.n;
+iterator r.i,i1,i2;
+expression e,e1;
+expression list [r.n1] es;
+statement S,S2;
+@@
+
+ i(es,n,...) {
+   ...
+(
+   of_node_put(n);
+|
+   e = n
+|
+   i1(...,n,...) S
+|
++  of_node_put(n);
+?  break;
+)
+   ... when any
+ }
+... when != n
+    when strict
+(
+ n = e1;
+|
+?i2(...,n,...) S2
+)
+
+@rulethree depends on patch && !context && !org && !report exists@
+
+local idexpression r.n;
+iterator r.i,i1,i2;
+expression e,e1;
+identifier l;
+expression list [r.n1] es;
+statement S,S2;
+@@
+
+ i(es,n,...) {
+   ...
+(
+   of_node_put(n);
+|
+   e = n
+|
+   i1(...,n,...) S
+|
++  of_node_put(n);
+?  goto l;
+)
+   ... when any
+ }
+... when exists
+l: ... when != n
+       when strict
+(
+ n = e1;
+|
+?i2(...,n,...) S2
+)
+
+// ----------------------------------------------------------------------------
+
+@ruleone_context depends on !patch && (context || org || report) exists@
+statement S;
+expression e;
+expression list[r.n1] es;
+iterator r.i, i1;
+local idexpression r.n;
+position j0, j1;
+@@
+
+ i@j0(es,n,...) {
+   ...
+(
+   of_node_put(n);
+|
+   e = n
+|
+   return n;
+|
+   i1(...,n,...) S
+|
+  return @j1 ...;
+)
+   ... when any
+ }
+
+@ruleone_disj depends on !patch && (context || org || report)@
+expression list[r.n1] es;
+iterator r.i;
+local idexpression r.n;
+position ruleone_context.j0, ruleone_context.j1;
+@@
+
+*  i@j0(es,n,...) {
+   ...
+*return  @j1...;
+   ... when any
+ }
+
+@ruletwo_context depends on !patch && (context || org || report) exists@
+statement S, S2;
+expression e, e1;
+expression list[r.n1] es;
+iterator r.i, i1, i2;
+local idexpression r.n;
+position j0, j2;
+@@
+
+ i@j0(es,n,...) {
+   ...
+(
+   of_node_put(n);
+|
+   e = n
+|
+   i1(...,n,...) S
+|
+  break@j2;
+)
+   ... when any
+ }
+... when != n
+    when strict
+(
+ n = e1;
+|
+?i2(...,n,...) S2
+)
+
+@ruletwo_disj depends on !patch && (context || org || report)@
+statement S2;
+expression e1;
+expression list[r.n1] es;
+iterator r.i, i2;
+local idexpression r.n;
+position ruletwo_context.j0, ruletwo_context.j2;
+@@
+
+*  i@j0(es,n,...) {
+   ...
+*break @j2;
+   ... when any
+ }
+... when != n
+    when strict
+(
+  n = e1;
+|
+?i2(...,n,...) S2
+)
+
+@rulethree_context depends on !patch && (context || org || report) exists@
+identifier l;
+statement S,S2;
+expression e, e1;
+expression list[r.n1] es;
+iterator r.i, i1, i2;
+local idexpression r.n;
+position j0, j3;
+@@
+
+ i@j0(es,n,...) {
+   ...
+(
+   of_node_put(n);
+|
+   e = n
+|
+   i1(...,n,...) S
+|
+  goto l@j3;
+)
+  ... when any
+ }
+... when exists
+l:
+... when != n
+    when strict
+(
+ n = e1;
+|
+?i2(...,n,...) S2
+)
+
+@rulethree_disj depends on !patch && (context || org || report) exists@
+identifier l;
+statement S2;
+expression e1;
+expression list[r.n1] es;
+iterator r.i, i2;
+local idexpression r.n;
+position rulethree_context.j0, rulethree_context.j3;
+@@
+
+*  i@j0(es,n,...) {
+   ...
+*goto l@j3;
+   ... when any
+ }
+... when exists
+ l:
+ ... when != n
+     when strict
+(
+ n = e1;
+|
+?i2(...,n,...) S2
+)
+
+// ----------------------------------------------------------------------------
+
+@script:python ruleone_org depends on org@
+i << r.i;
+j0 << ruleone_context.j0;
+j1 << ruleone_context. j1;
+@@
+
+msg = "WARNING: Function \"%s\" should have of_node_put() before return " % (i)
+coccilib.org.print_safe_todo(j0[0], msg)
+coccilib.org.print_link(j1[0], "")
+
+@script:python ruletwo_org depends on org@
+i << r.i;
+j0 << ruletwo_context.j0;
+j2 << ruletwo_context.j2;
+@@
+
+msg = "WARNING: Function \"%s\" should have of_node_put() before break " % (i)
+coccilib.org.print_safe_todo(j0[0], msg)
+coccilib.org.print_link(j2[0], "")
+
+@script:python rulethree_org depends on org@
+i << r.i;
+j0 << rulethree_context.j0;
+j3 << rulethree_context.j3;
+@@
+
+msg = "WARNING: Function \"%s\" should have of_node_put() before goto " % (i)
+coccilib.org.print_safe_todo(j0[0], msg)
+coccilib.org.print_link(j3[0], "")
+
+// ----------------------------------------------------------------------------
+
+@script:python ruleone_report depends on report@
+i << r.i;
+j0 << ruleone_context.j0;
+j1 << ruleone_context.j1;
+@@
+
+msg = "WARNING: Function \"%s\" should have of_node_put() before return around line %s." % (i, j1[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+@script:python ruletwo_report depends on report@
+i << r.i;
+j0 << ruletwo_context.j0;
+j2 << ruletwo_context.j2;
+@@
+
+msg = "WARNING: Function \"%s\" should have of_node_put() before break around line %s." % (i,j2[0].line)
+coccilib.report.print_report(j0[0], msg)
+
+@script:python rulethree_report depends on report@
+i << r.i;
+j0 << rulethree_context.j0;
+j3 << rulethree_context.j3;
+@@
+
+msg = "WARNING: Function \"%s\" should have of_node_put() before goto around lines %s." % (i,j3[0].line)
+coccilib.report.print_report(j0[0], msg)
-- 
2.25.1

