Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141D823D2D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 22:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgHEUQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 16:16:46 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:56786 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726013AbgHEQS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:18:56 -0400
X-IronPort-AV: E=Sophos;i="5.75,438,1589234400"; 
   d="scan'208";a="462549311"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 17:55:32 +0200
Date:   Wed, 5 Aug 2020 17:55:32 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
cc:     michal.lkml@markovi.net, Gilles.Muller@lip6.fr,
        gregkh@linuxfoundation.org, nicolas.palix@imag.fr,
        linux-kernel@vger.kernel.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v2] scripts: coccicheck: Add chain mode to list
 of     modes
In-Reply-To: <20200805085740.9263-1-sylphrenadin@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2008051755210.2536@hadrien>
References: <20200805085740.9263-1-sylphrenadin@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Aug 2020, Sumera Priyadarsini wrote:

> This patch adds chain mode to the list of available modes in coccicheck.

Applied, Thanks!

julia

>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
> Changes in v2:
> 	- Change coccinelle to coccicheck as suggested by Julia Lawall.
> ---
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e04d328210ac..6e37cf36caae 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -99,7 +99,7 @@ fi
>  if [ "$MODE" = "" ] ; then
>      if [ "$ONLINE" = "0" ] ; then
>  	echo 'You have not explicitly specified the mode to use. Using default "report" mode.'
> -	echo 'Available modes are the following: patch, report, context, org'
> +	echo 'Available modes are the following: patch, report, context, org, chain'
>  	echo 'You can specify the mode with "make coccicheck MODE=<mode>"'
>  	echo 'Note however that some modes are not implemented by some semantic patches.'
>      fi
> --
> 2.17.1
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
