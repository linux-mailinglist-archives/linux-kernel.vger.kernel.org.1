Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2AC28B183
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 11:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbgJLJ1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 05:27:49 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:12106 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387393AbgJLJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 05:27:49 -0400
X-IronPort-AV: E=Sophos;i="5.77,366,1596492000"; 
   d="scan'208";a="472098834"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 11:27:17 +0200
Date:   Mon, 12 Oct 2020 11:27:17 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
cc:     cocci@systeme.lip6.fr, Julia.Lawall@lip6.fr,
        michal.lkml@markovi.net, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, Gilles.Muller@lip6.fr
Subject: Re: [Cocci] [PATCH] coccinelle: iterators: Add for_each_child.cocci
 script
In-Reply-To: <20200924103504.2ceibylmerdzgmct@adolin>
Message-ID: <alpine.DEB.2.22.394.2010121123490.2901@hadrien>
References: <20200924103504.2ceibylmerdzgmct@adolin>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Sep 2020, Sumera Priyadarsini wrote:

> While iterating over child nodes with the for_each functions, if
> control is transferred from the middle of the loop, as in the case
> of a break or return or goto, there is no decrement in the
> reference counter thus ultimately resulting in a memory leak.
>
> Add this script to detect potential memory leaks caused by
> the absence of of_node_put() before break, goto, or, return
> statements which transfer control outside the loop.
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
>  .../coccinelle/iterators/for_each_child.cocci | 348 ++++++++++++++++++
>  1 file changed, 348 insertions(+)
>  create mode 100644 scripts/coccinelle/iterators/for_each_child.cocci
>
> diff --git a/scripts/coccinelle/iterators/for_each_child.cocci b/scripts/coccinelle/iterators/for_each_child.cocci
> new file mode 100644
> index 000000000000..0abc12ca2ad3
> --- /dev/null
> +++ b/scripts/coccinelle/iterators/for_each_child.cocci
> @@ -0,0 +1,348 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Adds missing of_node_put() before return/break/goto statement within a for_each iterator for child nodes.
> +//# False positives can be due to function calls within the for_each
> +//# loop that may encapsulate an of_node_put.
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Sumera Priyadarsini
> +// URL: http://coccinelle.lip6.fr

As Markus suggested, adding

+// Options: --no-includes --include-headers

would be useful.  The processing of .c files does not need to see header
files for this issue.  At the same time, if the problem occurs in a header
files, it could be useful to treat it.


> +@rulethree depends on patch && !context && !org && !report exists@
> +
> +local idexpression r.n;
> +iterator r.i,i1,i2;
> +expression e,e1;
> +identifier l;
> +expression list [r.n1] es;
> +statement S,S2;
> +@@
> +
> + i(es,n,...) {
> +   ...
> +(
> +   of_node_put(n);
> +|
> +   e = n
> +|
> +   i1(...,n,...) S
> +|
> ++  of_node_put(n);
> +?  goto l;
> +)
> +   ... when any
> + }
> +... when exists
> +l: ... when != n
> +       when strict

A when forall is needed under the when strict.  The idea here is that when
the goto is taken, we need to check all of the possible execution paths to
see if there is any reference to n.

All of the rules that involve break and goto need to be checked for this
issue.

julia

> +(
> + n = e1;
> +|
> +?i2(...,n,...) S2
> +)
> +
> +// ----------------------------------------------------------------------------
> +
> +@ruleone_context depends on !patch && (context || org || report) exists@
> +statement S;
> +expression e;
> +expression list[r.n1] es;
> +iterator r.i, i1;
> +local idexpression r.n;
> +position j0, j1;
> +@@
> +
> + i@j0(es,n,...) {
> +   ...
> +(
> +   of_node_put(n);
> +|
> +   e = n
> +|
> +   return n;
> +|
> +   i1(...,n,...) S
> +|
> +  return @j1 ...;
> +)
> +   ... when any
> + }
> +
> +@ruleone_disj depends on !patch && (context || org || report)@
> +expression list[r.n1] es;
> +iterator r.i;
> +local idexpression r.n;
> +position ruleone_context.j0, ruleone_context.j1;
> +@@
> +
> +*  i@j0(es,n,...) {
> +   ...
> +*return  @j1...;
> +   ... when any
> + }
> +
> +@ruletwo_context depends on !patch && (context || org || report) exists@
> +statement S, S2;
> +expression e, e1;
> +expression list[r.n1] es;
> +iterator r.i, i1, i2;
> +local idexpression r.n;
> +position j0, j2;
> +@@
> +
> + i@j0(es,n,...) {
> +   ...
> +(
> +   of_node_put(n);
> +|
> +   e = n
> +|
> +   i1(...,n,...) S
> +|
> +  break@j2;
> +)
> +   ... when any
> + }
> +... when != n
> +    when strict
> +(
> + n = e1;
> +|
> +?i2(...,n,...) S2
> +)
> +
> +@ruletwo_disj depends on !patch && (context || org || report)@
> +statement S2;
> +expression e1;
> +expression list[r.n1] es;
> +iterator r.i, i2;
> +local idexpression r.n;
> +position ruletwo_context.j0, ruletwo_context.j2;
> +@@
> +
> +*  i@j0(es,n,...) {
> +   ...
> +*break @j2;
> +   ... when any
> + }
> +... when != n
> +    when strict
> +(
> +  n = e1;
> +|
> +?i2(...,n,...) S2
> +)
> +
> +@rulethree_context depends on !patch && (context || org || report) exists@
> +identifier l;
> +statement S,S2;
> +expression e, e1;
> +expression list[r.n1] es;
> +iterator r.i, i1, i2;
> +local idexpression r.n;
> +position j0, j3;
> +@@
> +
> + i@j0(es,n,...) {
> +   ...
> +(
> +   of_node_put(n);
> +|
> +   e = n
> +|
> +   i1(...,n,...) S
> +|
> +  goto l@j3;
> +)
> +  ... when any
> + }
> +... when exists
> +l:
> +... when != n
> +    when strict
> +(
> + n = e1;
> +|
> +?i2(...,n,...) S2
> +)
> +
> +@rulethree_disj depends on !patch && (context || org || report) exists@
> +identifier l;
> +statement S2;
> +expression e1;
> +expression list[r.n1] es;
> +iterator r.i, i2;
> +local idexpression r.n;
> +position rulethree_context.j0, rulethree_context.j3;
> +@@
> +
> +*  i@j0(es,n,...) {
> +   ...
> +*goto l@j3;
> +   ... when any
> + }
> +... when exists
> + l:
> + ... when != n
> +     when strict
> +(
> + n = e1;
> +|
> +?i2(...,n,...) S2
> +)
> +
> +// ----------------------------------------------------------------------------
> +
> +@script:python ruleone_org depends on org@
> +i << r.i;
> +j0 << ruleone_context.j0;
> +j1 << ruleone_context. j1;
> +@@
> +
> +msg = "WARNING: Function \"%s\" should have of_node_put() before return " % (i)
> +coccilib.org.print_safe_todo(j0[0], msg)
> +coccilib.org.print_link(j1[0], "")
> +
> +@script:python ruletwo_org depends on org@
> +i << r.i;
> +j0 << ruletwo_context.j0;
> +j2 << ruletwo_context.j2;
> +@@
> +
> +msg = "WARNING: Function \"%s\" should have of_node_put() before break " % (i)
> +coccilib.org.print_safe_todo(j0[0], msg)
> +coccilib.org.print_link(j2[0], "")
> +
> +@script:python rulethree_org depends on org@
> +i << r.i;
> +j0 << rulethree_context.j0;
> +j3 << rulethree_context.j3;
> +@@
> +
> +msg = "WARNING: Function \"%s\" should have of_node_put() before goto " % (i)
> +coccilib.org.print_safe_todo(j0[0], msg)
> +coccilib.org.print_link(j3[0], "")
> +
> +// ----------------------------------------------------------------------------
> +
> +@script:python ruleone_report depends on report@
> +i << r.i;
> +j0 << ruleone_context.j0;
> +j1 << ruleone_context.j1;
> +@@
> +
> +msg = "WARNING: Function \"%s\" should have of_node_put() before return around line %s." % (i, j1[0].line)
> +coccilib.report.print_report(j0[0], msg)
> +
> +@script:python ruletwo_report depends on report@
> +i << r.i;
> +j0 << ruletwo_context.j0;
> +j2 << ruletwo_context.j2;
> +@@
> +
> +msg = "WARNING: Function \"%s\" should have of_node_put() before break around line %s." % (i,j2[0].line)
> +coccilib.report.print_report(j0[0], msg)
> +
> +@script:python rulethree_report depends on report@
> +i << r.i;
> +j0 << rulethree_context.j0;
> +j3 << rulethree_context.j3;
> +@@
> +
> +msg = "WARNING: Function \"%s\" should have of_node_put() before goto around lines %s." % (i,j3[0].line)
> +coccilib.report.print_report(j0[0], msg)
> --
> 2.25.1
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
