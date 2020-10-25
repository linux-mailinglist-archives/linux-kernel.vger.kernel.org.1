Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712D7298312
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418071AbgJYS2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:28:05 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:57034
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732784AbgJYS2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:28:04 -0400
X-IronPort-AV: E=Sophos;i="5.77,416,1596492000"; 
   d="scan'208";a="362719074"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2020 19:28:02 +0100
Date:   Sun, 25 Oct 2020 19:28:01 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Coccinelle <cocci@systeme.lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re=3A_=5BCocci=5D_=5BPATCH=5D_Coccinelle=3A_null=3A_O?=
 =?UTF-8?Q?ptimise_disjunctions_in_SmPL_script_=E2=80=9Ceno=2Eco?=
 =?UTF-8?Q?cci=E2=80=9D?=
In-Reply-To: <0d1575b0-ab37-663e-2464-278fd76280b5@web.de>
Message-ID: <alpine.DEB.2.22.394.2010251924290.2714@hadrien>
References: <0d1575b0-ab37-663e-2464-278fd76280b5@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-685740588-1603650482=:2714"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-685740588-1603650482=:2714
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Sun, 25 Oct 2020, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 25 Oct 2020 18:54:36 +0100
>
> A disjunction is applied by this script for the semantic patch language.
> This construct uses short-circuit evaluation. It has got the consequence
> that the last element of the specified condition will only be checked
> if all previous parts did not match. Such a technical detail leads to
> a recommended ordering of condition parts if you would like to care for
> optimal run time characteristics of SmPL code.
>
> An usage incidence was determined for the specified identifiers in source
> files from the software “Linux next-20201023” by another SmPL script.
>
> See also:
> Determination of an usage statistic for memory allocation calls
> https://lore.kernel.org/cocci/2774601.u91sIFNy1E@sonne/
>
> This analysis result indicates a clear ranking for such function calls.
> Thus reorder the SmPL disjunction items according to their usage incidence.

Did you actually test this before and after the change and see a
difference in performance?  On my laptop, I see absolutely no difference,
for the patch mode and for the context mode.  I didn't try the other
cases.

Before the change:

patch: 440.182u 2.049s 1:53.12 390.9%	0+0k 0+232io 4pf+0w
context: 392.931u 2.164s 1:41.53 389.1%	0+0k 432+360io 5pf+0w

After the change:

patch: 442.182u 2.090s 1:54.13 389.2%	0+0k 0+240io 4pf+0w
context: 392.742u 2.035s 1:41.37 389.4%	0+0k 0+360io 4pf+0w

julia

>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  scripts/coccinelle/null/eno.cocci | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/coccinelle/null/eno.cocci b/scripts/coccinelle/null/eno.cocci
> index 81584ff87956..969cab5116a9 100644
> --- a/scripts/coccinelle/null/eno.cocci
> +++ b/scripts/coccinelle/null/eno.cocci
> @@ -17,8 +17,16 @@ virtual report
>  @depends on patch@
>  expression x,E;
>  @@
> -
> -x = \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\)(...)
> + x =
> +(kzalloc
> +|kmalloc
> +|kcalloc
> +|kmem_cache_alloc
> +|kmem_cache_zalloc
> +|kzalloc_node
> +|kmalloc_node
> +|kmem_cache_alloc_node
> +)(...)
>  ... when != x = E
>  - IS_ERR(x)
>  + !x
> @@ -27,8 +35,7 @@ x = \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|kmem_cache
>  expression x,E;
>  position p1,p2;
>  @@
> -
> -*x = \(kmalloc@p1\|kzalloc@p1\|kcalloc@p1\|kmem_cache_alloc@p1\|kmem_cache_zalloc@p1\|kmem_cache_alloc_node@p1\|kmalloc_node@p1\|kzalloc_node@p1\)(...)
> +*x = \(kzalloc@p1\|kmalloc@p1\|kcalloc@p1\|kmem_cache_alloc@p1\|kmem_cache_zalloc@p1\|kzalloc_node@p1\|kmalloc_node@p1\|kmem_cache_alloc_node@p1\)(...)
>  ... when != x = E
>  * IS_ERR@p2(x)
>
> --
> 2.29.1
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
--8323329-685740588-1603650482=:2714--
