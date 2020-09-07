Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1175C25FA29
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 14:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgIGMJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 08:09:35 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:40645
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729194AbgIGMA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:00:29 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="358282836"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 14:00:19 +0200
Date:   Mon, 7 Sep 2020 14:00:19 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Markus Elfring <Markus.Elfring@web.de>
cc:     Coccinelle <cocci@systeme.lip6.fr>,
        Dejin Zheng <zhengdejin5@gmail.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re=3A_=5BCocci=5D_=5BPATCH=5D_Coccinelle=3A_api=3A_Ad?=
 =?UTF-8?Q?d_SmPL_script_=E2=80=9Cuse=5Fdevm=5Fplatform=5Fget=5Fand?=
 =?UTF-8?Q?=5Fioremap=5Fresource=2Ecocci=E2=80=9D?=
In-Reply-To: <5f9fdd59-4b0b-1cb5-c3a2-92efc5bb3841@web.de>
Message-ID: <alpine.DEB.2.22.394.2009071357140.2476@hadrien>
References: <25b804fd-0d04-475d-f614-26c03c9fd544@web.de> <5f9fdd59-4b0b-1cb5-c3a2-92efc5bb3841@web.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Sep 2020, Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 7 Sep 2020 13:14:44 +0200
>
> Another wrapper function is available since the commit 890cc39a879906b63912482dfc41944579df2dc6
> ("drivers: provide devm_platform_get_and_ioremap_resource()").
> Provide design options for the adjustment of affected source code
> by the means of the semantic patch language (Coccinelle software).
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  ...vm_platform_get_and_ioremap_resource.cocci | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci
>
> diff --git a/scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci b/scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci
> new file mode 100644
> index 000000000000..8e67359f6b76
> --- /dev/null
> +++ b/scripts/coccinelle/api/use_devm_platform_get_and_ioremap_resource.cocci
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/// Simplify a function call combination by using a known wrapper function.
> +//
> +// Keywords: wrapper function conversion ioremap resources
> +// Confidence: High
> +
> +virtual context, patch, report, org
> +
> +@display depends on context@
> +expression base, device1, device2, index, private, resource;
> +@@
> +(
> +*resource = platform_get_resource(device1, IORESOURCE_MEM, index);
> + base =
> +*       devm_ioremap_resource
> +                             (&device1->dev, resource);

Why do you require these statements to be next to each other?

> +|
> +*private->res = platform_get_resource(device1, IORESOURCE_MEM, index);
> + base =
> +*       devm_ioremap_resource
> +                             (device2, private->res);

Why do you have this special case?

> +)
> +
> +@replacement depends on patch@
> +expression base, device1, device2, index, private, resource;
> +@@
> +(
> +-resource = platform_get_resource(device1, IORESOURCE_MEM, index);
> + base =
> +-       devm_ioremap_resource
> ++       devm_platform_get_and_ioremap_resource
> +                             (
> +-                             &
> +                               device1
> +-                                     ->dev
> +                              ,
> +-                             resource
> ++                             index, &resource
> +                             );
> +|
> +-private->res = platform_get_resource(device1, IORESOURCE_MEM, index);
> + base =
> +-       devm_ioremap_resource
> ++       devm_platform_get_and_ioremap_resource
> +                             (device2,

It is very suspicious that in one case you change the first argument of
devm_platform_get_and_ioremap_resource and in one case you don't.  If you
don't know how to make the change in some cases, it would be better to do
nothing at all.

julia

> +-                             private->res
> ++                             index, &private->res
> +                             );
> +)
> +
> +@or depends on org || report@
> +expression base, device1, device2, index, private, resource;
> +position p;
> +@@
> +(
> + resource = platform_get_resource(device1, IORESOURCE_MEM, index);
> + base = devm_ioremap_resource@p(&device1->dev, resource);
> +|
> + private->res = platform_get_resource(device1, IORESOURCE_MEM, index);
> + base = devm_ioremap_resource@p(device2, private->res);
> +)
> +
> +@script:python to_do depends on org@
> +p << or.p;
> +@@
> +coccilib.org.print_todo(p[0], "WARNING: opportunity for devm_platform_get_and_ioremap_resource()")
> +
> +@script:python reporting depends on report@
> +p << or.p;
> +@@
> +coccilib.report.print_report(p[0], "WARNING: opportunity for devm_platform_get_and_ioremap_resource()")
> --
> 2.28.0
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
