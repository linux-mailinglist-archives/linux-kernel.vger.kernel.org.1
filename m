Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6762773FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgIXOcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:32:33 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:60645
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728088AbgIXOcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:32:33 -0400
X-IronPort-AV: E=Sophos;i="5.77,298,1596492000"; 
   d="scan'208";a="359963308"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2020 16:32:30 +0200
Date:   Thu, 24 Sep 2020 16:32:30 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: iterators: Add for_each_child.cocci
 script
In-Reply-To: <67ad40bd-c0c0-8c5c-54b2-c750cfeefd44@web.de>
Message-ID: <alpine.DEB.2.22.394.2009241631310.2615@hadrien>
References: <67ad40bd-c0c0-8c5c-54b2-c750cfeefd44@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Sep 2020, Markus Elfring wrote:

> > +@ruletwo depends on patch && !context && !org && !report@
>
> How do you think about to combine code from two SmPL rules
> by using another SmPL disjunction like the following?

What is the goal of doing this?

It seems substantially harder to understand than three rules that each
take care of a specific case.

julia


>
> @addition_rule depends on patch && !context && !org && !report@
> local idexpression r.n;
> expression e,e1;
> expression list [r.n1] es;
> iterator r.i,i1,i2;
> statement S,S2;
> @@
> (
>  i(es,n,...) {
>  ...
> (of_node_put(n);
> |e = n
> |return n;
> |i1(...,n,...) S
> |
> +of_node_put(n);
> ?return ...;
> )
>  ... when any
>  }
> |
>  i(es,n,...) {
>  ...
> (of_node_put(n);
> |e = n
> |i1(...,n,...) S
> |
> +of_node_put(n);
> ?break;
> )
>  ... when any
>  }
>  ... when != n
>      when strict
> (n = e1;
> |
> ?i2(...,n,...) S2
> )
> )
>
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
