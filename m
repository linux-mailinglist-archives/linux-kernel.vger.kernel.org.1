Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4201AEC53
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 14:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDRMLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 08:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725873AbgDRMLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 08:11:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF30C061A0C;
        Sat, 18 Apr 2020 05:11:04 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F00092A0FCA;
        Sat, 18 Apr 2020 13:11:01 +0100 (BST)
Date:   Sat, 18 Apr 2020 14:10:58 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Duda <sebastian.duda@fau.de>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH RESEND] MAINTAINERS: adjust to renaming
 physmap_of_versatile.c
Message-ID: <20200418141058.567a80d7@collabora.com>
In-Reply-To: <20200418100933.8012-1-lukas.bulwahn@gmail.com>
References: <20200418100933.8012-1-lukas.bulwahn@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ MTD maintainers and the MTD ML

On Sat, 18 Apr 2020 12:09:33 +0200
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 6ca15cfa0788 ("mtd: maps: Rename physmap_of_{versatile, gemini}
> into physmap-{versatile, gemini}") renamed physmap_of_versatile.c to
> physmap-versatile.c, but did not adjust the MAINTAINERS entry.
> 
> Since then, ./scripts/get_maintainer.pl --self-test complains:
> 
>   warning: no file matches F: drivers/mtd/maps/physmap_of_versatile.c
> 
> Rectify the ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT entry and now
> also cover drivers/mtd/maps/physmap-versatile.h while at it.
> 
> Co-developed-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Sebastian Duda <sebastian.duda@fau.de>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Boris, please pick or ack this patch.
> applies cleanly on current master and next-20200417

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> 
> v1: https://lore.kernel.org/lkml/20200228063338.4099-1-lukas.bulwahn@gmail.com/
>   - was wrongly sent to old boris.brezillon@bootlin.com address

Please Cc the MTD ML and maintainers next time.

>   - got Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Linus' reviewed is missing in this version.

> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c77f02282044..52bb8819230a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1342,7 +1342,7 @@ F:	arch/arm/plat-versatile/
>  F:	drivers/clk/versatile/
>  F:	drivers/i2c/busses/i2c-versatile.c
>  F:	drivers/irqchip/irq-versatile-fpga.c
> -F:	drivers/mtd/maps/physmap_of_versatile.c
> +F:	drivers/mtd/maps/physmap-versatile.*
>  F:	drivers/power/reset/arm-versatile-reboot.c
>  F:	drivers/soc/versatile/
>  

