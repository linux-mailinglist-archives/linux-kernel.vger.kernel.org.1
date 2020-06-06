Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711A21F0708
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 16:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgFFOjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jun 2020 10:39:17 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:62183
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726340AbgFFOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 10:39:17 -0400
X-IronPort-AV: E=Sophos;i="5.73,480,1583190000"; 
   d="scan'208";a="350775451"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2020 16:39:14 +0200
Date:   Sat, 6 Jun 2020 16:39:13 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] coccinelle: api: add kvfree script
In-Reply-To: <119d91fd-1ad0-8842-10eb-ee8fa16da1b0@web.de>
Message-ID: <alpine.DEB.2.21.2006061634130.19534@hadrien>
References: <119d91fd-1ad0-8842-10eb-ee8fa16da1b0@web.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1629768455-1591454354=:19534"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1629768455-1591454354=:19534
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sat, 6 Jun 2020, Markus Elfring wrote:

> > +@choice@
> > +expression E, E1;
> > +position kok, vok;
> > +@@
> > +
> > +(
> > +  if (...) {
> > +    ...
> > +    E = \(kmalloc@kok\|…\)(...)
>
> Further implementation details from this SmPL script caught my software
> development attention.
>
> * Is there a need to add the specification “when any” to the SmPL ellipses
>   before such assignment statements?

Having multiple assignments to kmalloc in one if seems unlikely, and
perhaps one would want to think about such a case differently, so it seems
ok as is.

>
> * A limited search approach was expressed. Will additional source code variations
>   become relevant?
>   + switch statement
>   + if branches with single statements
>   + conditional operator

The point is that there is a kmalloc in one branch and a vmalloc in
another branch, so a if with a single branch doesn't seem relevant.

The other cases sem highly improbable.

>
> > +@opportunity depends on !patch …@
> …
> > +  E = \(kmalloc\|…\)(..., size, ...)
> > +  ... when != E = E1
> > +      when != size = E1
>
> I wonder that two assignments should be excluded here according to
> the same expression metavariable.

Doesn't matter.  The metavariables are considered separately in the
different whens.

>
> +@pkfree depends on patch exists@
> …
> +- \(kfree\|kvfree\)(E)
> ++ vfree(E)
>
> Would you like to use a SmPL code variant like the following
> at any more places?
> (Is it occasionally helpful to increase the change precision?)
>
> +-\(kfree\|kvfree\)
> ++vfree
> +      (E)

"increase the change precision" seems to be an obscure way to say "improve
the formatting".  Indeed, leaving (E) as is would have the effect of not
changing the formatting.  But the problem seems unlikely for a functoin
with such a short name.  And this presentation will likely run afoul of
the fact that you can't attach + code to a disjunction.  So the original
presentation was more concise, and should be fine in practice.

julia
--8323329-1629768455-1591454354=:19534--
