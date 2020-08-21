Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E8824E21D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 22:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHUUeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 16:34:19 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:2759 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725831AbgHUUeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:34:18 -0400
X-IronPort-AV: E=Sophos;i="5.76,338,1592863200"; 
   d="scan'208";a="464264063"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 22:34:17 +0200
Date:   Fri, 21 Aug 2020 22:34:16 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v2] coccinelle: api: add kobj_to_dev.cocci
 script
In-Reply-To: <20200821201137.446423-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2008212234060.2486@hadrien>
References: <20200821153100.434332-1-efremov@linux.com> <20200821201137.446423-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Aug 2020, Denis Efremov wrote:

> Use kobj_to_dev() instead of container_of().
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied, thanks.

julia

> ---
> Changes in v2:
>  - "symbol kobj;" added to the rule r
>
>  scripts/coccinelle/api/kobj_to_dev.cocci | 45 ++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 scripts/coccinelle/api/kobj_to_dev.cocci
>
> diff --git a/scripts/coccinelle/api/kobj_to_dev.cocci b/scripts/coccinelle/api/kobj_to_dev.cocci
> new file mode 100644
> index 000000000000..cd5d31c6fe76
> --- /dev/null
> +++ b/scripts/coccinelle/api/kobj_to_dev.cocci
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Use kobj_to_dev() instead of container_of()
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +// Keywords: kobj_to_dev, container_of
> +//
> +
> +virtual context
> +virtual report
> +virtual org
> +virtual patch
> +
> +
> +@r depends on !patch@
> +expression ptr;
> +symbol kobj;
> +position p;
> +@@
> +
> +* container_of(ptr, struct device, kobj)@p
> +
> +
> +@depends on patch@
> +expression ptr;
> +@@
> +
> +- container_of(ptr, struct device, kobj)
> ++ kobj_to_dev(ptr)
> +
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING opportunity for kobj_to_dev()")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING opportunity for kobj_to_dev()")
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
