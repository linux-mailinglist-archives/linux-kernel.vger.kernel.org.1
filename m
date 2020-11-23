Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08F32C174B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 22:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgKWVGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 16:06:45 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:2421 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729905AbgKWVGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:06:44 -0500
X-IronPort-AV: E=Sophos;i="5.78,364,1599516000"; 
   d="scan'208";a="479042964"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 22:06:42 +0100
Date:   Mon, 23 Nov 2020 22:06:42 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
cc:     linux-kernel@vger.kernel.org, michal.lkml@markovi.net,
        nicolas.palix@imag.fr, cocci@systeme.lip6.fr, Gilles.Muller@lip6.fr
Subject: Re: [Cocci] [PATCH v2] scripts: coccicheck: Correct usage of make
 coccicheck
In-Reply-To: <20201118082705.ympf6ulol6wua4cl@adolin>
Message-ID: <alpine.DEB.2.22.394.2011232204550.2682@hadrien>
References: <20201118082705.ympf6ulol6wua4cl@adolin>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Nov 2020, Sumera Priyadarsini wrote:

> The command "make coccicheck C=1 CHECK=scripts/coccicheck" results in the
> error:
>         ./scripts/coccicheck: line 65: -1: shift count out of range
>
> This happens because every time the C variable is specified,
> the shell arguments need to be "shifted" in order to take only
> the last argument, which is the C file to test. These shell arguments
> mostly comprise flags that have been set in the Makefile. However,
> when coccicheck is specified in the make command as a rule, the
> number of shell arguments is zero, thus passing the invalid value -1
> to the shift command, resulting in an error.
>
> Modify coccicheck to print correct usage of make coccicheck so as to
> avoid the error.
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
> Changes in v2:
> - Move test to only display error message
> ---
>  scripts/coccicheck | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 209bb0427b43..f3b8bf505c5f 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -61,6 +61,18 @@ COCCIINCLUDE=${COCCIINCLUDE// -include/ --include}
>  if [ "$C" = "1" -o "$C" = "2" ]; then
>      ONLINE=1
>
> +    if [[ $# -le 0 ]]; then
> +	    echo ''
> +	    echo 'Specifying both the variable "C" and rule "coccicheck" in the make
> +command results in a shift count error.'
> +	    echo ''
> +	    echo 'Try specifying "scripts/coccicheck" as a value for the CHECK variable instead.'
> +	    echo ''
> +	    echo 'Example:	make C=2 CHECK=scripts/coccicheck drivers/staging/wfx/hi_t.o'

I think that this file doesn't exist any more.  Even though you can't
guarantee that any particular file will be around forever, a file in
staging is probably not a good choice, since they are usually on their way
in or on the way out of the kernel.

julia

> +	    echo ''
> +	    exit 1
> +    fi
> +
>      # Take only the last argument, which is the C file to test
>      shift $(( $# - 1 ))
>      OPTIONS="$COCCIINCLUDE $1"
> --
> 2.25.1
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
