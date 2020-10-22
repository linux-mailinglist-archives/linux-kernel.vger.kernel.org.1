Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F05296042
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900437AbgJVNrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:47:10 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:41634 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2900350AbgJVNrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:47:10 -0400
X-IronPort-AV: E=Sophos;i="5.77,404,1596492000"; 
   d="scan'208";a="473874482"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 15:47:08 +0200
Date:   Thu, 22 Oct 2020 15:47:08 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Izabela Bakollari <izabela.bakollari@gmail.com>
cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging/wlan-ng: Fix line that exceeds
 100 columns
In-Reply-To: <20201022130807.212454-1-izabela.bakollari@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2010221545480.5113@hadrien>
References: <20201022130807.212454-1-izabela.bakollari@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Oct 2020, izabela.bakollari@gmail.com wrote:

> From: Izabela Bakollari <izabela.bakollari@gmail.com>
>
> Rearrange comment that exceeds 100 columns length. Issue reported
> by checkpatch.pl
>
> Signed-off-by: Izabela Bakollari <izabela.bakollari@gmail.com>
> ---
>  drivers/staging/wlan-ng/cfg80211.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> index 759e475e303c..5fad37a49aa5 100644
> --- a/drivers/staging/wlan-ng/cfg80211.c
> +++ b/drivers/staging/wlan-ng/cfg80211.c
> @@ -366,7 +366,8 @@ static int prism2_scan(struct wiphy *wiphy,
>  					  msg2.beaconperiod.data,
>  					  ie_buf,
>  					  ie_len,
> -					  (msg2.signal.data - 65536) * 100, /* Conversion to signed type */
> +					  (msg2.signal.data - 65536) * 100,
> +					  /* Conversion to signed type */

I think that the comment is in the wrong place.  GFP_KERNEL has to do with
whether the allocation can wait in case of insufficient memory, and not
with signed types.  The signed type thing must be the argument before.  Si
it would be better to put the comment above that code.

julia


>  					  GFP_KERNEL);
>
>  		if (!bss) {
> --
> 2.18.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20201022130807.212454-1-izabela.bakollari%40gmail.com.
>
