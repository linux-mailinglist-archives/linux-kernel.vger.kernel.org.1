Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FE528B065
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgJLIiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:38:17 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:5416 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgJLIiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:38:16 -0400
X-IronPort-AV: E=Sophos;i="5.77,366,1596492000"; 
   d="scan'208";a="472083300"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 10:38:14 +0200
Date:   Mon, 12 Oct 2020 10:38:14 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
cc:     Julia.Lawall@lip6.fr, michal.lkml@markovi.net,
        linux-doc@vger.kernel.org, Gilles.Muller@lip6.fr, corbet@lwn.net,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v4 2/3] scripts: coccicheck: Change default
 condition for parallelism
In-Reply-To: <13de95fe3959459ac9ae8c74d99eb7e3c5702a2d.1602410019.git.sylphrenadin@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2010121038040.2901@hadrien>
References: <cover.1602410019.git.sylphrenadin@gmail.com> <13de95fe3959459ac9ae8c74d99eb7e3c5702a2d.1602410019.git.sylphrenadin@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Oct 2020, Sumera Priyadarsini wrote:

> Currently, Coccinelle uses at most one thread per core by default in
> machines with more than 2 hyperthreads. However, for systems with only 4
> hyperthreads, this does not improve performance.
>
> Modify coccicheck to use all available threads in machines with
> upto 4 hyperthreads.
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

Applied, thanks.

> ---
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index d67907b8a38b..209bb0427b43 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -79,7 +79,7 @@ else
>      THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
>      if [ -z "$J" ]; then
>          NPROC=$(getconf _NPROCESSORS_ONLN)
> -	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
> +	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 4 ] ; then
>  		NPROC=$((NPROC/2))
>  	fi
>      else
> --
> 2.25.1
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
