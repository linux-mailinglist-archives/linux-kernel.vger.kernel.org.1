Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB07C202CD1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 22:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbgFUUx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 16:53:28 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:32141 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730663AbgFUUx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 16:53:28 -0400
X-IronPort-AV: E=Sophos;i="5.75,264,1589234400"; 
   d="scan'208";a="455861131"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jun 2020 22:53:24 +0200
Date:   Sun, 21 Jun 2020 22:53:24 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Kees Cook <keescook@chromium.org>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v3] coccinelle: misc: add array_size_dup script
 to     detect missed overflow checks
In-Reply-To: <20200619131313.15468-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2006212251250.2501@hadrien>
References: <20200615102045.4558-1-efremov@linux.com> <20200619131313.15468-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +@as_next@
> +expression subE1 <= as.E1;
> +expression subE2 <= as.E2;
> +expression as.E1, as.E2, E3;
> +assignment operator aop;
> +position p1, p2;
> +@@
> +
> +* E1 * E2@p1
> +  ... when != \(E1\|E2\|subE1\|subE2\) aop E3
> +      when != &\(E1\|E2\|subE1\|subE2\)

You don't need E1 and E2 in the above two lines.  subE1 and subE2 will
match them.  Likewise for the other rules.

> +* array_size(E1, E2)@p2
> +
> +@script:python depends on report@
> +p1 << as_next.p1;
> +p2 << as_next.p2;
> +@@
> +
> +coccilib.report.print_report(p1[0],
> +f"WARNING: array_size is used down the code (line {p2[0].line}) to compute the same size")

I don't think that "down the code" is very understandable.  "Later in the
code" would be fine.  Even just "later" would be fine.

julia

> +@script:python depends on org@
> +p1 << as_next.p1;
> +p2 << as_next.p2;
> +@@
> +
> +coccilib.org.print_todo(p1[0],
> +f"WARNING: array_size is used down the code (line {p2[0].line}) to compute the same size")
> +
> +@as_prev@
> +expression subE1 <= as.E1;
> +expression subE2 <= as.E2;
> +expression as.E1, as.E2, E3;
> +assignment operator aop;
> +position p1, p2;
> +@@
> +
> +* array_size(E1, E2)@p1
> +  ... when != \(E1\|E2\|subE1\|subE2\) aop E3
> +      when != &\(E1\|E2\|subE1\|subE2\)
> +* E1 * E2@p2
> +
> +@script:python depends on report@
> +p1 << as_prev.p1;
> +p2 << as_prev.p2;
> +@@
> +
> +coccilib.report.print_report(p2[0],
> +f"WARNING: array_size is already used (line {p1[0].line}) to compute the same size")
> +
> +@script:python depends on org@
> +p1 << as_prev.p1;
> +p2 << as_prev.p2;
> +@@
> +
> +coccilib.org.print_todo(p2[0],
> +f"WARNING: array_size is already used (line {p1[0].line}) to compute the same size")
> +
> +@as_dup@
> +expression subE1 <= as.E1;
> +expression subE2 <= as.E2;
> +expression as.E1, as.E2, E3;
> +assignment operator aop;
> +position p1, p2;
> +@@
> +
> +* array_size(E1, E2)@p1
> +  ... when != \(E1\|E2\|subE1\|subE2\) aop E3
> +      when != &\(E1\|E2\|subE1\|subE2\)
> +* array_size(E1, E2)@p2
> +
> +@script:python depends on report@
> +p1 << as_dup.p1;
> +p2 << as_dup.p2;
> +@@
> +
> +coccilib.report.print_report(p2[0],
> +f"WARNING: same array_size (line {p1[0].line})")
> +
> +@script:python depends on org@
> +p1 << as_dup.p1;
> +p2 << as_dup.p2;
> +@@
> +
> +coccilib.org.print_todo(p2[0],
> +f"WARNING: same array_size (line {p1[0].line})")
> +
> +@as3@
> +expression E1, E2, E3;
> +@@
> +
> +array3_size(E1, E2, E3)
> +
> +@as3_next@
> +expression subE1 <= as3.E1;
> +expression subE2 <= as3.E2;
> +expression subE3 <= as3.E3;
> +expression as3.E1, as3.E2, as3.E3, E4;
> +assignment operator aop;
> +position p1, p2;
> +@@
> +
> +* E1 * E2 * E3@p1
> +  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\) aop E4
> +      when != &\(E1\|E2\|E3\|subE1\|subE2\|subE3\)
> +* array3_size(E1, E2, E3)@p2
> +
> +@script:python depends on report@
> +p1 << as3_next.p1;
> +p2 << as3_next.p2;
> +@@
> +
> +coccilib.report.print_report(p1[0],
> +f"WARNING: array3_size is used down the code (line {p2[0].line}) to compute the same size")
> +
> +@script:python depends on org@
> +p1 << as3_next.p1;
> +p2 << as3_next.p2;
> +@@
> +
> +coccilib.org.print_todo(p1[0],
> +f"WARNING: array3_size is used down the code (line {p2[0].line}) to compute the same size")
> +
> +@as3_prev@
> +expression subE1 <= as3.E1;
> +expression subE2 <= as3.E2;
> +expression subE3 <= as3.E3;
> +expression as3.E1, as3.E2, as3.E3, E4;
> +assignment operator aop;
> +position p1, p2;
> +@@
> +
> +* array3_size(E1, E2, E3)@p1
> +  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\) aop E4
> +      when != &\(E1\|E2\|E3\|subE1\|subE2\|subE3\)
> +* E1 * E2 * E3@p2
> +
> +@script:python depends on report@
> +p1 << as3_prev.p1;
> +p2 << as3_prev.p2;
> +@@
> +
> +coccilib.report.print_report(p2[0],
> +f"WARNING: array3_size is already used (line {p1[0].line}) to compute the same size")
> +
> +@script:python depends on org@
> +p1 << as3_prev.p1;
> +p2 << as3_prev.p2;
> +@@
> +
> +coccilib.org.print_todo(p2[0],
> +f"WARNING: array3_size is already used (line {p1[0].line}) to compute the same size")
> +
> +@as3_dup@
> +expression subE1 <= as3.E1;
> +expression subE2 <= as3.E2;
> +expression subE3 <= as3.E3;
> +expression as3.E1, as3.E2, as3.E3, E4;
> +assignment operator aop;
> +position p1, p2;
> +@@
> +
> +* array3_size(E1, E2, E3)@p1
> +  ... when != \(E1\|E2\|E3\|subE1\|subE2\|subE3\) aop E4
> +      when != &\(E1\|E2\|E3\|subE1\|subE2\|subE3\)
> +* array3_size(E1, E2, E3)@p2
> +
> +@script:python depends on report@
> +p1 << as3_dup.p1;
> +p2 << as3_dup.p2;
> +@@
> +
> +coccilib.report.print_report(p2[0],
> +f"WARNING: same array3_size (line {p1[0].line})")
> +
> +@script:python depends on org@
> +p1 << as3_dup.p1;
> +p2 << as3_dup.p2;
> +@@
> +
> +coccilib.org.print_todo(p2[0],
> +f"WARNING: same array3_size (line {p1[0].line})")
> +
> +@ss@
> +expression E1, E2, E3;
> +@@
> +
> +struct_size(E1, E2, E3)
> +
> +@ss_next@
> +expression subE3 <= ss.E3;
> +expression ss.E1, ss.E2, ss.E3, E4;
> +assignment operator aop;
> +position p1, p2;
> +@@
> +
> +* E1 * E2 + E3@p1
> +  ... when != \(E3\|subE3\) aop E4
> +      when != &\(E3\|subE3\)
> +* struct_size(E1, E2, E3)@p2
> +
> +@script:python depends on report@
> +p1 << ss_next.p1;
> +p2 << ss_next.p2;
> +@@
> +
> +coccilib.report.print_report(p1[0],
> +f"WARNING: struct_size is used down the code (line {p2[0].line}) to compute the same size")
> +
> +@script:python depends on org@
> +p1 << ss_next.p1;
> +p2 << ss_next.p2;
> +@@
> +
> +coccilib.org.print_todo(p1[0],
> +f"WARNING: struct_size is used down the code (line {p2[0].line}) to compute the same size")
> +
> +@ss_prev@
> +expression subE3 <= ss.E3;
> +expression ss.E1, ss.E2, ss.E3, E4;
> +assignment operator aop;
> +position p1, p2;
> +@@
> +
> +* struct_size(E1, E2, E3)@p1
> +  ... when != \(E3\|subE3\) aop E4
> +      when != &\(E3\|subE3\)
> +* E1 * E2 + E3@p2
> +
> +@script:python depends on report@
> +p1 << ss_prev.p1;
> +p2 << ss_prev.p2;
> +@@
> +
> +coccilib.report.print_report(p2[0],
> +f"WARNING: struct_size is already used (line {p1[0].line}) to compute the same size")
> +
> +@script:python depends on org@
> +p1 << ss_prev.p1;
> +p2 << ss_prev.p2;
> +@@
> +
> +coccilib.org.print_todo(p2[0],
> +f"WARNING: struct_size is already used (line {p1[0].line}) to compute the same size")
> +
> +@ss_dup@
> +expression subE3 <= ss.E3;
> +expression ss.E1, ss.E2, ss.E3, E4;
> +assignment operator aop;
> +position p1, p2;
> +@@
> +
> +* struct_size(E1, E2, E3)@p1
> +  ... when != \(E3\|subE3\) aop E4
> +      when != &\(E3\|subE3\)
> +* struct_size(E1, E2, E3)@p2
> +
> +@script:python depends on report@
> +p1 << ss_dup.p1;
> +p2 << ss_dup.p2;
> +@@
> +
> +coccilib.report.print_report(p2[0],
> +f"WARNING: same struct_size (line {p1[0].line})")
> +
> +@script:python depends on org@
> +p1 << ss_dup.p1;
> +p2 << ss_dup.p2;
> +@@
> +
> +coccilib.org.print_todo(p2[0],
> +f"WARNING: same struct_size (line {p1[0].line})")
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
