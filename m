Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D37C296063
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368043AbgJVNuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:50:23 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:41860 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S367998AbgJVNuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:50:10 -0400
X-IronPort-AV: E=Sophos;i="5.77,404,1596492000"; 
   d="scan'208";a="473874968"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 15:50:08 +0200
Date:   Thu, 22 Oct 2020 15:50:08 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Izabela Bakollari <izabela.bakollari@gmail.com>
cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging/wlan-ng: Fix line alignment
In-Reply-To: <20201022132218.235744-1-izabela.bakollari@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2010221547500.5113@hadrien>
References: <20201022132218.235744-1-izabela.bakollari@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Oct 2020, izabela.bakollari@gmail.com wrote:

> From: Izabela Bakollari <izabela.bakollari@gmail.com>
>
> Fix code alignment. Issue reported by checkpatch.pl

Try to find something other than "Fix" to describe what you have done.
What kind of change have you made and why is it a good idea?
>
> Signed-off-by: Izabela Bakollari <izabela.bakollari@gmail.com>
> ---
>  drivers/staging/wlan-ng/prism2mgmt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng/prism2mgmt.c
> index a908ff301707..1bd36dc2b7ff 100644
> --- a/drivers/staging/wlan-ng/prism2mgmt.c
> +++ b/drivers/staging/wlan-ng/prism2mgmt.c
> @@ -1198,8 +1198,8 @@ int prism2mgmt_wlansniff(struct wlandevice *wlandev, void *msgp)
>  			if (wlandev->netdev->type == ARPHRD_ETHER) {
>  				/* Save macport 0 state */
>  				result = hfa384x_drvr_getconfig16(hw,
> -						  HFA384x_RID_CNFPORTTYPE,
> -						  &hw->presniff_port_type);
> +								  HFA384x_RID_CNFPORTTYPE,
> +								  &hw->presniff_port_type);

I think that the code was nicer before.  Staying inside 80 characters is
worth something, and having the arguments lined up with the ( seems lees
important in this case.  It could be a concern if the arguments eg ended
up right under the function name, because that would be easy to misread,
but that is not the case here.

julia

>  				if (result) {
>  					netdev_dbg
>  					(wlandev->netdev,
> --
> 2.18.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20201022132218.235744-1-izabela.bakollari%40gmail.com.
>
