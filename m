Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 932D728B067
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgJLIib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:38:31 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:5449 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgJLIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:38:31 -0400
X-IronPort-AV: E=Sophos;i="5.77,366,1596492000"; 
   d="scan'208";a="472083358"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 10:38:29 +0200
Date:   Mon, 12 Oct 2020 10:38:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
cc:     Julia.Lawall@lip6.fr, michal.lkml@markovi.net,
        linux-doc@vger.kernel.org, Gilles.Muller@lip6.fr, corbet@lwn.net,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v4 1/3] scripts: coccicheck: Add quotes to improve
 portability
In-Reply-To: <76ca49efc2ec4b8279e70c4bc4052fb7b543bc86.1602410019.git.sylphrenadin@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2010121038200.2901@hadrien>
References: <cover.1602410019.git.sylphrenadin@gmail.com> <76ca49efc2ec4b8279e70c4bc4052fb7b543bc86.1602410019.git.sylphrenadin@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Oct 2020, Sumera Priyadarsini wrote:

> While fetching the number of threads per core with lscpu,
> the [:digit:] set is used for translation of digits from 0-9.
> However, using [:digit:] instead of "[:digit:]" does not seem
> to work uniformly for some shell types and configurations
> (such as zsh).
>
> Therefore, modify coccicheck to use double quotes around the
> [:digit:] set for uniformity and better portability.
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

Applied, thanks.

> ---
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index 6789751607f5..d67907b8a38b 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -76,7 +76,7 @@ else
>      fi
>
>      # Use only one thread per core by default if hyperthreading is enabled
> -    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd [:digit:])
> +    THREADS_PER_CORE=$(lscpu | grep "Thread(s) per core: " | tr -cd "[:digit:]")
>      if [ -z "$J" ]; then
>          NPROC=$(getconf _NPROCESSORS_ONLN)
>  	if [ $THREADS_PER_CORE -gt 1 -a $NPROC -gt 2 ] ; then
> --
> 2.25.1
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
