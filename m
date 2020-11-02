Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7272A2AC8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgKBMfC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 07:35:02 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:52879 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgKBMfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:35:02 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C780560002;
        Mon,  2 Nov 2020 12:34:58 +0000 (UTC)
Date:   Mon, 2 Nov 2020 13:34:57 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     vigneshr@ti.com, linux-kernel@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 04/23] mtd: devices: docg3: Fix kernel-doc 'bad line'
 and 'excessive doc' issues
Message-ID: <20201102133457.7d2db57d@xps13>
In-Reply-To: <20201102115406.1074327-5-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
        <20201102115406.1074327-5-lee.jones@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Lee Jones <lee.jones@linaro.org> wrote on Mon,  2 Nov 2020 11:53:47
+0000:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/devices/docg3.c:819: warning: bad line:
>  drivers/mtd/devices/docg3.c:1799: warning: Excess function parameter 'base' description in 'doc_probe_device'
> 
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mtd/devices/docg3.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
> index a030792115bc2..5b0ae5ddad745 100644
> --- a/drivers/mtd/devices/docg3.c
> +++ b/drivers/mtd/devices/docg3.c
> @@ -816,7 +816,7 @@ static void doc_read_page_finish(struct docg3 *docg3)
>  
>  /**
>   * calc_block_sector - Calculate blocks, pages and ofs.
> -
> + *
>   * @from: offset in flash
>   * @block0: first plane block index calculated
>   * @block1: second plane block index calculated
> @@ -1783,10 +1783,9 @@ static int __init doc_set_driver_info(int chip_id, struct mtd_info *mtd)
>  
>  /**
>   * doc_probe_device - Check if a device is available
> - * @base: the io space where the device is probed
> + * @cascade: the cascade of chips this devices will belong to
>   * @floor: the floor of the probed device
>   * @dev: the device
> - * @cascade: the cascade of chips this devices will belong to
>   *
>   * Checks whether a device at the specified IO range, and floor is available.
>   *

You also reorder the parameters in the kdoc which is not stated in the
commit log. But that's nitpicking...

Thanks,
Miquèl
