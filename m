Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8279E273119
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgIURrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:47:05 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:15944 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726537AbgIURrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:47:04 -0400
X-IronPort-AV: E=Sophos;i="5.77,287,1596492000"; 
   d="scan'208";a="468823752"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 19:47:02 +0200
Date:   Mon, 21 Sep 2020 19:47:02 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] coccinelle: misc: add excluded_middle.cocci script
In-Reply-To: <20200921152850.59194-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2009211946480.2630@hadrien>
References: <20200902151859.403354-1-efremov@linux.com> <20200921152850.59194-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Sep 2020, Denis Efremov wrote:

> Check for !A || A && B condition. It's equivalent to !A || B.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied, thanks.

> ---
> Changes in v2:
>  - spelling mistake fixed
>  - position variable moved on the && operator
>  - patch pattern changed to - (A && B)
>  - word "condition" removed from warning message
>
>  scripts/coccinelle/misc/excluded_middle.cocci | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/excluded_middle.cocci
>
> diff --git a/scripts/coccinelle/misc/excluded_middle.cocci b/scripts/coccinelle/misc/excluded_middle.cocci
> new file mode 100644
> index 000000000000..ab28393e4843
> --- /dev/null
> +++ b/scripts/coccinelle/misc/excluded_middle.cocci
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Condition !A || A && B is equivalent to !A || B.
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +
> +virtual patch
> +virtual context
> +virtual org
> +virtual report
> +
> +@r depends on !patch@
> +expression A, B;
> +position p;
> +@@
> +
> +* !A || (A &&@p B)
> +
> +@depends on patch@
> +expression A, B;
> +@@
> +
> +  !A ||
> +-       (A && B)
> ++       B
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0], "WARNING !A || A && B is equivalent to !A || B")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0], "WARNING !A || A && B is equivalent to !A || B")
> --
> 2.26.2
>
>
