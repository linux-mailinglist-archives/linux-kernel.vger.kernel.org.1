Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7AE2DB4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgLOT4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:56:51 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:7268 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgLOT4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:56:39 -0500
X-IronPort-AV: E=Sophos;i="5.78,422,1599516000"; 
   d="scan'208";a="367761533"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 20:55:46 +0100
Date:   Tue, 15 Dec 2020 20:55:46 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Maxime Ripard <maxime@cerno.tech>
cc:     Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] coccinnelle: Remove ptr_ret script
In-Reply-To: <20201215122459.283702-1-maxime@cerno.tech>
Message-ID: <alpine.DEB.2.22.394.2012152055380.2879@hadrien>
References: <20201215122459.283702-1-maxime@cerno.tech>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Dec 2020, Maxime Ripard wrote:

> The ptr_ret script script addresses a number of situations where we end up
> testing an error pointer, and if it's an error returning it, or return 0
> otherwise to transform it into a PTR_ERR_OR_ZERO call.
>
> So it will convert a block like this:
>
> if (IS_ERR(err))
>     return PTR_ERR(err);
>
> return 0;
>
> into
>
> return PTR_ERR_OR_ZERO(err);
>
> While this is technically correct, it has a number of drawbacks. First, it
> merges the error and success path, which will make it harder for a reviewer
> or reader to grasp.
>
> It's also more difficult to extend if we were to add some code between the
> error check and the function return, making the author essentially revert
> that patch before adding new lines, while it would have been a trivial
> addition otherwise for the rewiever.
>
> Therefore, since that script is only about cosmetic in the first place,
> let's remove it since it's not worth it.
>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Julia Lawall <julia.lawall@inria.fr>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Applied

> ---
>
> Changes from v1:
>   - Collected the tags
>
>  scripts/coccinelle/api/ptr_ret.cocci | 97 ----------------------------
>  1 file changed, 97 deletions(-)
>  delete mode 100644 scripts/coccinelle/api/ptr_ret.cocci
>
> diff --git a/scripts/coccinelle/api/ptr_ret.cocci b/scripts/coccinelle/api/ptr_ret.cocci
> deleted file mode 100644
> index e76cd5d90a8a..000000000000
> --- a/scripts/coccinelle/api/ptr_ret.cocci
> +++ /dev/null
> @@ -1,97 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -///
> -/// Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> -///
> -// Confidence: High
> -// Copyright: (C) 2012 Julia Lawall, INRIA/LIP6.
> -// Copyright: (C) 2012 Gilles Muller, INRIA/LiP6.
> -// URL: http://coccinelle.lip6.fr/
> -// Options: --no-includes --include-headers
> -//
> -// Keywords: ERR_PTR, PTR_ERR, PTR_ERR_OR_ZERO
> -// Version min: 2.6.39
> -//
> -
> -virtual context
> -virtual patch
> -virtual org
> -virtual report
> -
> -@depends on patch@
> -expression ptr;
> -@@
> -
> -- if (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
> -+ return PTR_ERR_OR_ZERO(ptr);
> -
> -@depends on patch@
> -expression ptr;
> -@@
> -
> -- if (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
> -+ return PTR_ERR_OR_ZERO(ptr);
> -
> -@depends on patch@
> -expression ptr;
> -@@
> -
> -- (IS_ERR(ptr) ? PTR_ERR(ptr) : 0)
> -+ PTR_ERR_OR_ZERO(ptr)
> -
> -@r1 depends on !patch@
> -expression ptr;
> -position p1;
> -@@
> -
> -* if@p1 (IS_ERR(ptr)) return PTR_ERR(ptr); else return 0;
> -
> -@r2 depends on !patch@
> -expression ptr;
> -position p2;
> -@@
> -
> -* if@p2 (IS_ERR(ptr)) return PTR_ERR(ptr); return 0;
> -
> -@r3 depends on !patch@
> -expression ptr;
> -position p3;
> -@@
> -
> -* IS_ERR@p3(ptr) ? PTR_ERR(ptr) : 0
> -
> -@script:python depends on org@
> -p << r1.p1;
> -@@
> -
> -coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> -
> -
> -@script:python depends on org@
> -p << r2.p2;
> -@@
> -
> -coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> -
> -@script:python depends on org@
> -p << r3.p3;
> -@@
> -
> -coccilib.org.print_todo(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> -
> -@script:python depends on report@
> -p << r1.p1;
> -@@
> -
> -coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> -
> -@script:python depends on report@
> -p << r2.p2;
> -@@
> -
> -coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> -
> -@script:python depends on report@
> -p << r3.p3;
> -@@
> -
> -coccilib.report.print_report(p[0], "WARNING: PTR_ERR_OR_ZERO can be used")
> --
> 2.28.0
>
>
