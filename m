Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53CF217A95
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 23:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgGGVfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 17:35:47 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:9053 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728357AbgGGVfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:35:47 -0400
X-IronPort-AV: E=Sophos;i="5.75,325,1589234400"; 
   d="scan'208";a="353873148"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 23:35:20 +0200
Date:   Tue, 7 Jul 2020 23:35:19 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v3] coccinelle: api: add kzfree script
In-Reply-To: <20200614215414.40034-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2007072333250.32782@hadrien>
References: <20200604140805.111613-1-efremov@linux.com> <20200614215414.40034-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Jun 2020, Denis Efremov wrote:

> Check for memset()/memzero_explicit() followed by kfree()/vfree()/kvfree().
>
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Changes in v2:
>  - memset_explicit() added
>  - kvfree_sensitive() added
>  - forall added to r1
>  - ... between memset and kfree added
> Changes in v3:
>  - Explicit filter for definitions instead of !(file in "...") conditions
>  - type T added to match casts
>  - memzero_explicit() patterns fixed
>  - additional rule "cond" added to filter false-positives
>
>  scripts/coccinelle/api/kzfree.cocci | 90 +++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 scripts/coccinelle/api/kzfree.cocci
>
> diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kzfree.cocci
> new file mode 100644
> index 000000000000..4758ca5a781e
> --- /dev/null
> +++ b/scripts/coccinelle/api/kzfree.cocci
> @@ -0,0 +1,90 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +///
> +/// Use kzfree, kvfree_sensitive rather than memset or
> +/// memzero_explicit followed by kfree
> +///
> +// Confidence: High
> +// Copyright: (C) 2020 Denis Efremov ISPRAS
> +// Options: --no-includes --include-headers
> +//
> +// Keywords: kzfree, kvfree_sensitive
> +//
> +
> +virtual context
> +virtual patch
> +virtual org
> +virtual report
> +
> +@initialize:python@
> +@@
> +# kmalloc_oob_in_memset uses memset to explicitly trigger out-of-bounds access
> +filter = frozenset(['kmalloc_oob_in_memset', 'kzfree', 'kvfree_sensitive'])
> +
> +def relevant(p):
> +    return not (filter & {el.current_element for el in p})
> +
> +@cond@
> +position ok;
> +@@
> +
> +if (...)
> +  \(memset@ok\|memzero_explicit@ok\)(...);
> +
> +@r depends on !patch forall@
> +expression E;
> +position p : script:python() { relevant(p) };
> +position m != cond.ok;
> +type T;
> +@@
> +
> +(
> +* memset@m((T)E, 0, ...);
> +|
> +* memzero_explicit@m((T)E, ...);
> +)
> +  ... when != E
> +      when strict
> +* \(kfree\|vfree\|kvfree\)(E)@p;
> +
> +@rp_memzero depends on patch@
> +expression E, size;
> +position p : script:python() { relevant(p) };
> +type T;
> +@@
> +
> +- memzero_explicit((T)E, size)@p;

This rule also needs a @m, like in the rule above.


> +  ... when != E
> +      when strict
> +- \(kfree\|vfree\|kvfree\)(E);
> ++ kvfree_sensitive(E, size);
> +
> +@rp_memset depends on patch@
> +expression E, size;
> +position p : script:python() { relevant(p) };
> +type T;
> +@@
> +
> +- memset((T)E, size)@p;

This rule also needs a @m.  It was also previously noted that this
call to memset is msising a 0.

julia




> +  ... when != E
> +      when strict
> +(
> +- kfree(E);
> ++ kzfree(E);
> +|
> +- \(vfree\|kvfree\)(E);
> ++ kvfree_sensitive(E, size);
> +)
> +
> +@script:python depends on report@
> +p << r.p;
> +@@
> +
> +coccilib.report.print_report(p[0],
> +  "WARNING: opportunity for kzfree/kvfree_sensitive")
> +
> +@script:python depends on org@
> +p << r.p;
> +@@
> +
> +coccilib.org.print_todo(p[0],
> +  "WARNING: opportunity for kzfree/kvfree_sensitive")
> --
> 2.26.2
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
