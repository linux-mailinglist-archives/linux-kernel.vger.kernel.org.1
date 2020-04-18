Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECBD1AECC0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 15:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDRNhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 09:37:53 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:52293 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbgDRNhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 09:37:52 -0400
X-IronPort-AV: E=Sophos;i="5.72,399,1580770800"; 
   d="scan'208";a="445728780"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2020 15:37:48 +0200
Date:   Sat, 18 Apr 2020 15:37:48 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] scripts: coccicheck: Fix invalid download link
In-Reply-To: <1587200408-32602-1-git-send-email-yangtiezhu@loongson.cn>
Message-ID: <alpine.DEB.2.21.2004181537130.9868@hadrien>
References: <1587200408-32602-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Apr 2020, Tiezhu Yang wrote:

> When I use coccicheck, it fails with the message "spatch is part of the
> Coccinelle project and is available at http://coccinelle.lip6.fr/", but
> I can not download the source code of spatch due to the URL [1] was not
> found on this server.
>
> Use the download link of GitHub mirror directly to fix it.
>
> [1] http://coccinelle.lip6.fr/distrib/coccinelle-1.0.8.tar.gz

NACK.  I will try to fix the link instead.

Thanks for reporting in any case.

julia

>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  scripts/coccicheck | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index e04d328..14608a8 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -11,7 +11,7 @@ DIR="$(dirname $(readlink -f $0))/.."
>  SPATCH="`which ${SPATCH:=spatch}`"
>
>  if [ ! -x "$SPATCH" ]; then
> -    echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
> +    echo 'spatch is part of the Coccinelle project and is available at https://github.com/coccinelle/coccinelle/releases'
>      exit 1
>  fi
>
> --
> 2.1.0
>
>
