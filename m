Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A4D301AA9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 09:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbhAXIhi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 24 Jan 2021 03:37:38 -0500
Received: from aposti.net ([89.234.176.197]:43088 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbhAXIh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 03:37:27 -0500
Date:   Sun, 24 Jan 2021 08:36:29 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] PHY: Ingenic: compile phy-ingenic-usb only if it was
 enabled
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     kishon@ti.com, vkoul@kernel.org, zhouyanjie@wanyeetech.com,
        aric.pzqi@ingenic.com, linux-kernel@vger.kernel.org
Message-Id: <TWJFNQ.UE3BBA1DX3OL@crapouillou.net>
In-Reply-To: <20210123150146.11208-1-hqjagain@gmail.com>
References: <20210123150146.11208-1-hqjagain@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thank you for your patch.


Le sam. 23 janv. 2021 à 23:01, Qiujun Huang <hqjagain@gmail.com> a 
écrit :
> We should compile this driver only if we opened PHY_INGENIC_USB.

'opened' -> 'enable'.

> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>

You will need to add a Fixes: tag and Cc linux-stable, since the 
problem is already in 5.10.

Cheers,
-Paul

> ---
>  drivers/phy/ingenic/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/ingenic/Makefile 
> b/drivers/phy/ingenic/Makefile
> index 65d5ea00fc9d..a00306651423 100644
> --- a/drivers/phy/ingenic/Makefile
> +++ b/drivers/phy/ingenic/Makefile
> @@ -1,2 +1,2 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-y		+= phy-ingenic-usb.o
> +obj-$(PHY_INGENIC_USB)		+= phy-ingenic-usb.o
> --
> 2.25.1
> 


