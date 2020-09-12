Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AA4267B2F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 17:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgILPIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 11:08:36 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:22313 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgILPIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 11:08:23 -0400
X-IronPort-AV: E=Sophos;i="5.76,359,1592863200"; 
   d="scan'208";a="467361552"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Sep 2020 17:08:19 +0200
Date:   Sat, 12 Sep 2020 17:08:19 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Julia Lawall <julia.lawall@inria.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        alex.dewar90@gmail.com, alexandre.belloni@bootlin.com,
        corbet@lwn.net, mchehab+huawei@kernel.org
Subject: Re: [PATCH] coccinelle: api: update kzfree script to
 kfree_sensitive
In-Reply-To: <20200811074953.73994-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2009121707040.2362@hadrien>
References: <20200604140805.111613-1-efremov@linux.com> <20200811074953.73994-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Aug 2020, Denis Efremov wrote:

> Commit 453431a54934 ("mm, treewide: rename kzfree() to kfree_sensitive()")
> renames kzfree to kfree_sensitive and uses memzero_explicit(...) instead of
> memset(..., 0, ...) internally. Update cocci script to reflect these
> changes.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied, thanks.

> ---
> Julia, I think you can squash this commit with original script, or I can
> resend the whole script since it's not merged to the mainline.
>
>  .../{kzfree.cocci => kfree_sensitive.cocci}   | 29 +++++++++----------
>  1 file changed, 13 insertions(+), 16 deletions(-)
>  rename scripts/coccinelle/api/{kzfree.cocci => kfree_sensitive.cocci} (70%)
>
> diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/api/kfree_sensitive.cocci
> similarity index 70%
> rename from scripts/coccinelle/api/kzfree.cocci
> rename to scripts/coccinelle/api/kfree_sensitive.cocci
> index 33625bd7cec9..e4a066a0b77d 100644
> --- a/scripts/coccinelle/api/kzfree.cocci
> +++ b/scripts/coccinelle/api/kfree_sensitive.cocci
> @@ -1,13 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  ///
> -/// Use kzfree, kvfree_sensitive rather than memset or
> -/// memzero_explicit followed by kfree
> +/// Use kfree_sensitive, kvfree_sensitive rather than memset or
> +/// memzero_explicit followed by kfree.
>  ///
>  // Confidence: High
>  // Copyright: (C) 2020 Denis Efremov ISPRAS
>  // Options: --no-includes --include-headers
>  //
> -// Keywords: kzfree, kvfree_sensitive
> +// Keywords: kfree_sensitive, kvfree_sensitive
>  //
>
>  virtual context
> @@ -18,7 +18,8 @@ virtual report
>  @initialize:python@
>  @@
>  # kmalloc_oob_in_memset uses memset to explicitly trigger out-of-bounds access
> -filter = frozenset(['kmalloc_oob_in_memset', 'kzfree', 'kvfree_sensitive'])
> +filter = frozenset(['kmalloc_oob_in_memset',
> +		    'kfree_sensitive', 'kvfree_sensitive'])
>
>  def relevant(p):
>      return not (filter & {el.current_element for el in p})
> @@ -56,17 +57,13 @@ type T;
>  - memzero_explicit@m((T)E, size);
>    ... when != E
>        when strict
> -// TODO: uncomment when kfree_sensitive will be merged.
> -// Only this case is commented out because developers
> -// may not like patches like this since kzfree uses memset
> -// internally (not memzero_explicit).
> -//(
> -//- kfree(E)@p;
> -//+ kfree_sensitive(E);
> -//|
> +(
> +- kfree(E)@p;
> ++ kfree_sensitive(E);
> +|
>  - \(vfree\|kvfree\)(E)@p;
>  + kvfree_sensitive(E, size);
> -//)
> +)
>
>  @rp_memset depends on patch@
>  expression E, size;
> @@ -80,7 +77,7 @@ type T;
>        when strict
>  (
>  - kfree(E)@p;
> -+ kzfree(E);
> ++ kfree_sensitive(E);
>  |
>  - \(vfree\|kvfree\)(E)@p;
>  + kvfree_sensitive(E, size);
> @@ -91,11 +88,11 @@ p << r.p;
>  @@
>
>  coccilib.report.print_report(p[0],
> -  "WARNING: opportunity for kzfree/kvfree_sensitive")
> +  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
>
>  @script:python depends on org@
>  p << r.p;
>  @@
>
>  coccilib.org.print_todo(p[0],
> -  "WARNING: opportunity for kzfree/kvfree_sensitive")
> +  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
> --
> 2.26.2
>
>
