Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92F02B7E28
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 14:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgKRNP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:15:56 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:13181 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725814AbgKRNP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:15:56 -0500
X-IronPort-AV: E=Sophos;i="5.77,486,1596492000"; 
   d="scan'208";a="478177596"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 14:15:54 +0100
Date:   Wed, 18 Nov 2020 14:15:53 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2] coccinelle: locks: Add balancedlock.cocci
 script
In-Reply-To: <62af4a93-dbc3-8aa0-6924-4dc479001d34@web.de>
Message-ID: <alpine.DEB.2.22.394.2011181413280.2641@hadrien>
References: <20201118080242.t6u6lchj5ww2fac4@adolin> <62af4a93-dbc3-8aa0-6924-4dc479001d34@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1777813137-1605705354=:2641"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1777813137-1605705354=:2641
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

> > +++ b/scripts/coccinelle/locks/balancedlock.cocci
> …
> > +//# False positives may be generated due to locks released within a nested
> > +//# function call or a goto block.
> > +///
> > +// Confidence: Moderate
>
> How good does such information fit together?
>

What kind of response do you expect?  There are some concerns, so it's not
High confidence.  It works pretty well so it's not low confidence.  So
it's moderate confidence.  What else is there to say?

> …
> >+ (
> > +mutex_lock@p(E);
> > +|
> > +read_lock@p(E);
> > +|
> …
>
> Why did you not reorder the elements of such a SmPL disjunctions according to
> an usage incidence (which can be determined by another SmPL script like
> “report_lock_calls.cocci”)?

I don't recall ever seeing any evidence that it has an impact for function
calls.  Furthermore, the numbers will change over time.  So why change it?

> …
> > +msg = "This code segment might have an unbalanced lock."
> > +coccilib.org.print_todo(j0[0], msg)
>
> Please pass the string literal directly.
>
> +coccilib.org.print_todo(j0[0], "This code segment might have an unbalanced lock.")

The code is fine as it is.

julia
--8323329-1777813137-1605705354=:2641--
