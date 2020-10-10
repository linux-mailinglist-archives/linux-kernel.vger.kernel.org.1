Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAC728A3CF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389855AbgJJWzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:54 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:54249 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731480AbgJJT1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:27:23 -0400
X-IronPort-AV: E=Sophos;i="5.77,360,1596492000"; 
   d="scan'208";a="471939804"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2020 21:27:22 +0200
Date:   Sat, 10 Oct 2020 21:27:21 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: api: kfree_sensitive: print memset
 position
In-Reply-To: <20201009125453.31217-1-efremov@linux.com>
Message-ID: <alpine.DEB.2.22.394.2010102127100.2691@hadrien>
References: <20201009125453.31217-1-efremov@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 9 Oct 2020, Denis Efremov wrote:

> Print memset() call position in addition to the kfree() position to
> ease issues identification.
>
> Signed-off-by: Denis Efremov <efremov@linux.com>

Applied, thanks.

julia

> ---
>  scripts/coccinelle/api/kfree_sensitive.cocci | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/coccinelle/api/kfree_sensitive.cocci b/scripts/coccinelle/api/kfree_sensitive.cocci
> index e4a066a0b77d..8d980ebf3223 100644
> --- a/scripts/coccinelle/api/kfree_sensitive.cocci
> +++ b/scripts/coccinelle/api/kfree_sensitive.cocci
> @@ -85,14 +85,16 @@ type T;
>
>  @script:python depends on report@
>  p << r.p;
> +m << r.m;
>  @@
>
> -coccilib.report.print_report(p[0],
> -  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
> +msg = "WARNING opportunity for kfree_sensitive/kvfree_sensitive (memset at line %s)"
> +coccilib.report.print_report(p[0], msg % (m[0].line))
>
>  @script:python depends on org@
>  p << r.p;
> +m << r.m;
>  @@
>
> -coccilib.org.print_todo(p[0],
> -  "WARNING: opportunity for kfree_sensitive/kvfree_sensitive")
> +msg = "WARNING opportunity for kfree_sensitive/kvfree_sensitive (memset at line %s)"
> +coccilib.org.print_todo(p[0], msg % (m[0].line))
> --
> 2.26.2
>
>
