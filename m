Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDF52AB752
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgKILkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKILkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:40:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B84D0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5WbKJaWsJyjVtGho2FoinmY2B47/1CPzPBCfXjuiVLg=; b=tc3Oq5HkfRG66hVS+QANsS564P
        /aSRgWMQgxdsV1YEKIc/dPaNk2Thm7Sm0Cq3uahVC1+3DZfwMcHVN5VOpo9Tx7Wr7tespL6kX/DMn
        zuWSKybIO2NSW4kuiP1XYIU4gfh5fk+cnJka7uh+ef5duHzZeTkkg5O0Oi9tXJhrdqlKs4FI3eJhW
        3Znvj3OgdR25GgPSxZ4W/Pe2siWa9x6742joQSwokYbqioHQqNUE1qvXCsf6WVye7u8DYlFodL8E0
        R7pcFE1WJxxKshh9oDcN1UeORdy7XBFAL9CZUZlnrUUGDnzoEIF1cSOgjpmlbFiq9z32tOpfBXCbT
        0CSd7GVQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc5W0-0007Rx-Th; Mon, 09 Nov 2020 11:39:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C0D3300455;
        Mon,  9 Nov 2020 12:39:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 453B6203E223A; Mon,  9 Nov 2020 12:39:12 +0100 (CET)
Date:   Mon, 9 Nov 2020 12:39:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     xiakaixu1987@gmail.com
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>,
        Julia.Lawall@lip6.fr
Subject: Re: [PATCH] perf intel-bts: Use true,false for bool variable
Message-ID: <20201109113912.GH2594@hirez.programming.kicks-ass.net>
References: <1604644146-598-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604644146-598-1-git-send-email-kaixuxia@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 02:29:06PM +0800, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> Fix the following coccinelle reports:
> 
> ./tools/perf/util/intel-bts.c:472:3-13: WARNING: Assignment of 0/1 to bool variable
> ./tools/perf/util/intel-bts.c:515:3-13: WARNING: Assignment of 0/1 to bool variable
> 
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Here, I've fixed it differently.

---
Subject: coccinelle: Remove broken check
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Nov 9 12:32:00 CET 2020

Get rid of the endless stream of patches that complain about:

  "WARNING: Assignment of 0/1 to bool variable"

Which is perfectly valid C.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 scripts/coccinelle/misc/boolinit.cocci |  195 ---------------------------------
 1 file changed, 195 deletions(-)

--- a/scripts/coccinelle/misc/boolinit.cocci
+++ /dev/null
@@ -1,195 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/// Bool initializations should use true and false.  Bool tests don't need
-/// comparisons.  Based on contributions from Joe Perches, Rusty Russell
-/// and Bruce W Allan.
-///
-// Confidence: High
-// Copyright: (C) 2012 Julia Lawall, INRIA/LIP6.
-// Copyright: (C) 2012 Gilles Muller, INRIA/LiP6.
-// URL: http://coccinelle.lip6.fr/
-// Options: --include-headers
-
-virtual patch
-virtual context
-virtual org
-virtual report
-
-@boolok@
-symbol true,false;
-@@
-(
-true
-|
-false
-)
-
-@depends on patch@
-bool t;
-@@
-
-(
-- t == true
-+ t
-|
-- true == t
-+ t
-|
-- t != true
-+ !t
-|
-- true != t
-+ !t
-|
-- t == false
-+ !t
-|
-- false == t
-+ !t
-|
-- t != false
-+ t
-|
-- false != t
-+ t
-)
-
-@depends on patch disable is_zero, isnt_zero@
-bool t;
-@@
-
-(
-- t == 1
-+ t
-|
-- t != 1
-+ !t
-|
-- t == 0
-+ !t
-|
-- t != 0
-+ t
-)
-
-@depends on patch && boolok@
-bool b;
-@@
-(
- b =
-- 0
-+ false
-|
- b =
-- 1
-+ true
-)
-
-// ---------------------------------------------------------------------
-
-@r1 depends on !patch@
-bool t;
-position p;
-@@
-
-(
-* t@p == true
-|
-* true == t@p
-|
-* t@p != true
-|
-* true != t@p
-|
-* t@p == false
-|
-* false == t@p
-|
-* t@p != false
-|
-* false != t@p
-)
-
-@r2 depends on !patch disable is_zero, isnt_zero@
-bool t;
-position p;
-@@
-
-(
-* t@p == 1
-|
-* t@p != 1
-|
-* t@p == 0
-|
-* t@p != 0
-)
-
-@r3 depends on !patch && boolok@
-bool b;
-position p1;
-@@
-(
-*b@p1 = 0
-|
-*b@p1 = 1
-)
-
-@r4 depends on !patch@
-bool b;
-position p2;
-identifier i;
-constant c != {0,1};
-@@
-(
- b = i
-|
-*b@p2 = c
-)
-
-@script:python depends on org@
-p << r1.p;
-@@
-
-cocci.print_main("WARNING: Comparison to bool",p)
-
-@script:python depends on org@
-p << r2.p;
-@@
-
-cocci.print_main("WARNING: Comparison of 0/1 to bool variable",p)
-
-@script:python depends on org@
-p1 << r3.p1;
-@@
-
-cocci.print_main("WARNING: Assignment of 0/1 to bool variable",p1)
-
-@script:python depends on org@
-p2 << r4.p2;
-@@
-
-cocci.print_main("ERROR: Assignment of non-0/1 constant to bool variable",p2)
-
-@script:python depends on report@
-p << r1.p;
-@@
-
-coccilib.report.print_report(p[0],"WARNING: Comparison to bool")
-
-@script:python depends on report@
-p << r2.p;
-@@
-
-coccilib.report.print_report(p[0],"WARNING: Comparison of 0/1 to bool variable")
-
-@script:python depends on report@
-p1 << r3.p1;
-@@
-
-coccilib.report.print_report(p1[0],"WARNING: Assignment of 0/1 to bool variable")
-
-@script:python depends on report@
-p2 << r4.p2;
-@@
-
-coccilib.report.print_report(p2[0],"ERROR: Assignment of non-0/1 constant to bool variable")
