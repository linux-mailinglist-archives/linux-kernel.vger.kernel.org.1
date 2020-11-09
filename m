Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748252AC0B8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbgKIQWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:22:44 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:56239 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729791AbgKIQWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:22:44 -0500
X-IronPort-AV: E=Sophos;i="5.77,463,1596492000"; 
   d="scan'208";a="476643258"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 17:22:42 +0100
Date:   Mon, 9 Nov 2020 17:22:42 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Peter Zijlstra <peterz@infradead.org>
cc:     xiakaixu1987@gmail.com, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] perf intel-bts: Use true,false for bool variable
In-Reply-To: <20201109113912.GH2594@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.22.394.2011091722170.3017@hadrien>
References: <1604644146-598-1-git-send-email-kaixuxia@tencent.com> <20201109113912.GH2594@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Nov 2020, Peter Zijlstra wrote:

> On Fri, Nov 06, 2020 at 02:29:06PM +0800, xiakaixu1987@gmail.com wrote:
> > From: Kaixu Xia <kaixuxia@tencent.com>
> >
> > Fix the following coccinelle reports:
> >
> > ./tools/perf/util/intel-bts.c:472:3-13: WARNING: Assignment of 0/1 to bool variable
> > ./tools/perf/util/intel-bts.c:515:3-13: WARNING: Assignment of 0/1 to bool variable
> >
> > Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> > Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
>
> Here, I've fixed it differently.

I applied this version, but removed the above text from the log message.

julia

>
> ---
> Subject: coccinelle: Remove broken check
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Nov 9 12:32:00 CET 2020
>
> Get rid of the endless stream of patches that complain about:
>
>   "WARNING: Assignment of 0/1 to bool variable"
>
> Which is perfectly valid C.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  scripts/coccinelle/misc/boolinit.cocci |  195 ---------------------------------
>  1 file changed, 195 deletions(-)
>
> --- a/scripts/coccinelle/misc/boolinit.cocci
> +++ /dev/null
> @@ -1,195 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/// Bool initializations should use true and false.  Bool tests don't need
> -/// comparisons.  Based on contributions from Joe Perches, Rusty Russell
> -/// and Bruce W Allan.
> -///
> -// Confidence: High
> -// Copyright: (C) 2012 Julia Lawall, INRIA/LIP6.
> -// Copyright: (C) 2012 Gilles Muller, INRIA/LiP6.
> -// URL: http://coccinelle.lip6.fr/
> -// Options: --include-headers
> -
> -virtual patch
> -virtual context
> -virtual org
> -virtual report
> -
> -@boolok@
> -symbol true,false;
> -@@
> -(
> -true
> -|
> -false
> -)
> -
> -@depends on patch@
> -bool t;
> -@@
> -
> -(
> -- t == true
> -+ t
> -|
> -- true == t
> -+ t
> -|
> -- t != true
> -+ !t
> -|
> -- true != t
> -+ !t
> -|
> -- t == false
> -+ !t
> -|
> -- false == t
> -+ !t
> -|
> -- t != false
> -+ t
> -|
> -- false != t
> -+ t
> -)
> -
> -@depends on patch disable is_zero, isnt_zero@
> -bool t;
> -@@
> -
> -(
> -- t == 1
> -+ t
> -|
> -- t != 1
> -+ !t
> -|
> -- t == 0
> -+ !t
> -|
> -- t != 0
> -+ t
> -)
> -
> -@depends on patch && boolok@
> -bool b;
> -@@
> -(
> - b =
> -- 0
> -+ false
> -|
> - b =
> -- 1
> -+ true
> -)
> -
> -// ---------------------------------------------------------------------
> -
> -@r1 depends on !patch@
> -bool t;
> -position p;
> -@@
> -
> -(
> -* t@p == true
> -|
> -* true == t@p
> -|
> -* t@p != true
> -|
> -* true != t@p
> -|
> -* t@p == false
> -|
> -* false == t@p
> -|
> -* t@p != false
> -|
> -* false != t@p
> -)
> -
> -@r2 depends on !patch disable is_zero, isnt_zero@
> -bool t;
> -position p;
> -@@
> -
> -(
> -* t@p == 1
> -|
> -* t@p != 1
> -|
> -* t@p == 0
> -|
> -* t@p != 0
> -)
> -
> -@r3 depends on !patch && boolok@
> -bool b;
> -position p1;
> -@@
> -(
> -*b@p1 = 0
> -|
> -*b@p1 = 1
> -)
> -
> -@r4 depends on !patch@
> -bool b;
> -position p2;
> -identifier i;
> -constant c != {0,1};
> -@@
> -(
> - b = i
> -|
> -*b@p2 = c
> -)
> -
> -@script:python depends on org@
> -p << r1.p;
> -@@
> -
> -cocci.print_main("WARNING: Comparison to bool",p)
> -
> -@script:python depends on org@
> -p << r2.p;
> -@@
> -
> -cocci.print_main("WARNING: Comparison of 0/1 to bool variable",p)
> -
> -@script:python depends on org@
> -p1 << r3.p1;
> -@@
> -
> -cocci.print_main("WARNING: Assignment of 0/1 to bool variable",p1)
> -
> -@script:python depends on org@
> -p2 << r4.p2;
> -@@
> -
> -cocci.print_main("ERROR: Assignment of non-0/1 constant to bool variable",p2)
> -
> -@script:python depends on report@
> -p << r1.p;
> -@@
> -
> -coccilib.report.print_report(p[0],"WARNING: Comparison to bool")
> -
> -@script:python depends on report@
> -p << r2.p;
> -@@
> -
> -coccilib.report.print_report(p[0],"WARNING: Comparison of 0/1 to bool variable")
> -
> -@script:python depends on report@
> -p1 << r3.p1;
> -@@
> -
> -coccilib.report.print_report(p1[0],"WARNING: Assignment of 0/1 to bool variable")
> -
> -@script:python depends on report@
> -p2 << r4.p2;
> -@@
> -
> -coccilib.report.print_report(p2[0],"ERROR: Assignment of non-0/1 constant to bool variable")
>
