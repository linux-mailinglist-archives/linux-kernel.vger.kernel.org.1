Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6021267B00
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 16:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgILOqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 10:46:04 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:57675
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725925AbgILOnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 10:43:20 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="358800815"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 16:43:13 +0200
Date:   Sat, 12 Sep 2020 16:43:13 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2] coccinelle: misc: add flexible_array.cocci script
In-Reply-To: <20200809212655.58457-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2009121642070.2362@hadrien>
References: <20200806220342.25426-1-efremov@linux.com> <20200809212655.58457-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Aug 2020, Denis Efremov wrote:

> Commit 68e4cd17e218 ("docs: deprecated.rst: Add zero-length and one-element
> arrays") marks one-element and zero-length arrays as deprecated. Kernel
> code should always use "flexible array members" instead.
>
> The script warns about one-element and zero-length arrays in structs.
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Changes in v2:
>  - all uapi headers are now filtered-out. Unfortunately, coccinelle
>    doesn't provide structure names in Location.current_element.
>    For structures the field is always "something_else". Thus, there is
>    no easy way to create a list of existing structures in uapi headers
>    and suppress the warning only for them, but not for the newly added
>    uapi structures.
>  - The pattern doesn't require 2+ fields in a structure/union anymore.
>    Now it also checks single field structures/unions.
>  - The pattern simplified and now uses disjuction in array elements
>    (Thanks, Markus)
>  - Unions are removed from patch mode
>  - one-element arrays are removed from patch mode. Correct patch may
>    involve turning the array to a simple field instead of a flexible
>    array.
>
> On the current master branch, the rule generates:
>  - context: https://gist.github.com/evdenis/e2b4323491f9eff35376372df07f723c
>  - patch: https://gist.github.com/evdenis/46081da9d68ecefd07edc3769cebcf32
>
>  scripts/coccinelle/misc/flexible_array.cocci | 88 ++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 scripts/coccinelle/misc/flexible_array.cocci
>
> diff --git a/scripts/coccinelle/misc/flexible_array.cocci b/scripts/coccinelle/misc/flexible_array.cocci
> new file mode 100644
> index 000000000000..bf6dcda1783e
> --- /dev/null
> +++ b/scripts/coccinelle/misc/flexible_array.cocci
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Zero-length and one-element arrays are deprecated, see
> +/// Documentation/process/deprecated.rst
> +/// Flexible-array members should be used instead.
> +///
> +//
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS.
> +// Comments:
> +// Options: --no-includes --include-headers
> +
> +virtual context
> +virtual report
> +virtual org
> +virtual patch
> +
> +@initialize:python@
> +@@
> +def relevant(positions):
> +    for p in positions:
> +        if "uapi" in p.file:
> +             return False
> +    return True
> +
> +@r depends on !patch@
> +identifier name, array;
> +type T;
> +position p : script:python() { relevant(p) };
> +@@
> +
> +(
> +  struct name {
> +    ...
> +*   T array@p[\(0\|1\)];
> +  };
> +|
> +  struct {
> +    ...
> +*   T array@p[\(0\|1\)];
> +  };
> +|
> +  union name {
> +    ...
> +*   T array@p[\(0\|1\)];
> +  };
> +|
> +  union {
> +    ...
> +*   T array@p[\(0\|1\)];
> +  };
> +)
> +
> +@depends on patch exists@

exists is not necessary here.  There are not multiple control-flow paths
through a structure declaration.

> +identifier name, array;
> +type T;
> +position p : script:python() { relevant(p) };
> +@@
> +
> +(
> +  struct name {
> +    ...
> +    T array@p[
> +-       0
> +    ];
> +  };
> +|
> +  struct {
> +    ...
> +    T array@p[
> +-       0
> +    ];
> +  };
> +)
> +
> +@script: python depends on report@
> +p << r.p;
> +@@
> +
> +msg = "WARNING: use flexible-array member instead"
> +coccilib.report.print_report(p[0], msg)
> +
> +@script: python depends on org@
> +p << r.p;
> +@@
> +
> +msg = "WARNING: use flexible-array member instead"
> +coccilib.org.print_todo(p, msg)

This should be coccilib.org.print_todo(p[0], msg)

julia
