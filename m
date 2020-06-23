Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9EF204A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 09:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbgFWHCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 03:02:34 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:34772 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730830AbgFWHCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:02:34 -0400
X-IronPort-AV: E=Sophos;i="5.75,270,1589234400"; 
   d="scan'208";a="456156865"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 09:02:31 +0200
Date:   Tue, 23 Jun 2020 09:02:31 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@inria.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4] coccinelle: misc: add array_size_dup script to detect
 missed overflow checks
In-Reply-To: <4014118b-90a6-68c5-048f-32485fa3e852@web.de>
Message-ID: <alpine.DEB.2.22.394.2006230902210.2367@hadrien>
References: <4014118b-90a6-68c5-048f-32485fa3e852@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1108794673-1592895751=:2367"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1108794673-1592895751=:2367
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

I don't agree with any of these comments.

julia

On Tue, 23 Jun 2020, Markus Elfring wrote:

> > Changes in v2:
> …
> > - assignment operator used
>
> I prefer the distinction for the application of corresponding metavariables.
>
>
> > Changes in v3:
> …
> >  - \(&E1\|&E2\) changed to &\(E1\|E2\)
>
> Would it be more helpful to mention the movement of the ampersand
> before SmPL disjunctions?
>
>
> …
> >+/// Three types of patterns for these functions:
>
> Will another adjustment be needed according to your information “duplicates warning removed”?
>
>
> …
> > +virtual context
> > +virtual report
> > +virtual org
>
> Can the following SmPL code variant ever become more attractive?
>
> +virtual context, report, org
>
>
> …
> > +expression subE1 <= as.E1;
> > +expression subE2 <= as.E2;
> > +expression as.E1, as.E2, E3;
>
> How do you think about the following SmPL code variant?
>
> +expression subE1 <= as.E1,
> +           subE2 <= as.E2,
> +           as.E1, as.E2, E3;
>
>
> …
> > +msg = "WARNING: array_size is used later (line %s) to compute the same size" % (p2[0].line)
> > +coccilib.report.print_report(p1[0], msg)
>
> Please omit the extra Python variable “msg” for the passing of such simple message objects.
>
> What does hinder you to take the proposed script variants better into account?
>
> Regards,
> Markus
>
--8323329-1108794673-1592895751=:2367--
