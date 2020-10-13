Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1109028CBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbgJMKaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:30:39 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:62266 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729241AbgJMKai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:30:38 -0400
X-IronPort-AV: E=Sophos;i="5.77,370,1596492000"; 
   d="scan'208";a="472338857"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 12:30:36 +0200
Date:   Tue, 13 Oct 2020 12:30:36 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
cc:     cocci@systeme.lip6.fr, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        Gilles.Muller@lip6.fr
Subject: Re: [Cocci] [PATCH V2] coccinelle: iterators: Add for_each_child.cocci
 script
In-Reply-To: <20201012171909.ihbx73evyj5dosxl@adolin>
Message-ID: <alpine.DEB.2.22.394.2010131226130.2674@hadrien>
References: <20201012171909.ihbx73evyj5dosxl@adolin>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have one more change to suggest.  This one only affects the patch case,
as the other cases just point to a problem but don't ompletely specify
what to do about it.

> +@ruleone depends on patch && !context && !org && !report@
> +
> +local idexpression r.n;
> +iterator r.i,i1;
> +expression e;
> +expression list [r.n1] es;
> +statement S;
> +@@
> +
> + i(es,n,...) {
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
> ++  of_node_put(n);
> +?  return ...;
> +)
> +   ... when any
> + }

There is one occurrence of the following code:

        for_each_available_child_of_node(search, child) {
                name = of_get_property(child, "regulator-compatible", NULL);
                if (!name)
                        name = child->name;

                if (!strcmp(desc->of_match, name)) {
                        of_node_put(search);
                        return of_node_get(child);
                }
        }

In this case, the for_each_available_child_of_node has incremented the
reference count of child by 1, and then the return increments it again.
It would be ok to put an of_not_put before the return, which is done by
the above rule, but the code would be even simpler if it would just leave
the reference count as is.  So before the current return case, you can put
another return case that does the following:

-  return of_node_get(n);
+  return n;

julia
