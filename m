Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E7B2B5E2E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgKQLWz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 06:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQLWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:22:55 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400EDC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 03:22:55 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kez4X-0007Gt-Td; Tue, 17 Nov 2020 12:22:53 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kez4X-00088v-L0; Tue, 17 Nov 2020 12:22:53 +0100
Message-ID: <0c6a3ced0012d05bb33bb3ea765de359e480ad4a.camel@pengutronix.de>
Subject: Re: [PATCH 41/42] gpu/ipu-v3/ipu-di: Strip out 2 unused
 'di_sync_config' entries
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org
Date:   Tue, 17 Nov 2020 12:22:53 +0100
In-Reply-To: <20201116174112.1833368-42-lee.jones@linaro.org>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
         <20201116174112.1833368-42-lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Mon, 2020-11-16 at 17:41 +0000, Lee Jones wrote:
> They're taking up too much space on the stack.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/ipu-v3/ipu-di.c: In function ‘ipu_di_sync_config_noninterlaced’:
>  drivers/gpu/ipu-v3/ipu-di.c:391:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/ipu-v3/ipu-di.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/gpu/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-di.c
> index b4a31d506fccf..e617f60afeea3 100644
> --- a/drivers/gpu/ipu-v3/ipu-di.c
> +++ b/drivers/gpu/ipu-v3/ipu-di.c
> @@ -310,10 +310,6 @@ static void ipu_di_sync_config_noninterlaced(struct ipu_di *di,
>  			/* unused */
>  		} , {
>  			/* unused */
> -		} , {
> -			/* unused */
> -		} , {
> -			/* unused */
>  		},
>  	};
>  	/* can't use #7 and #8 for line active and pixel active counters */

Thank you, applied to imx-drm/next.

regards
Philipp
