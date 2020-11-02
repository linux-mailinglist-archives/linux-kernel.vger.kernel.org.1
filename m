Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BFD2A2B07
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgKBMwp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 07:52:45 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:34221 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgKBMwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:52:44 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id AF340C0011;
        Mon,  2 Nov 2020 12:52:38 +0000 (UTC)
Date:   Mon, 2 Nov 2020 13:52:37 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     vigneshr@ti.com, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Cyril Bur <cyril.bur@au1.ibm.com>,
        linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 23/23] mtd: devices: powernv_flash: Add function names
 to headers and fix 'dev'
Message-ID: <20201102135237.7a03b817@xps13>
In-Reply-To: <20201102115406.1074327-24-lee.jones@linaro.org>
References: <20201102115406.1074327-1-lee.jones@linaro.org>
        <20201102115406.1074327-24-lee.jones@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Lee Jones <lee.jones@linaro.org> wrote on Mon,  2 Nov 2020 11:54:06
+0000:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/mtd/devices/powernv_flash.c:129: warning: Cannot understand  * @mtd: the device
>  drivers/mtd/devices/powernv_flash.c:145: warning: Cannot understand  * @mtd: the device
>  drivers/mtd/devices/powernv_flash.c:161: warning: Cannot understand  * @mtd: the device
>  drivers/mtd/devices/powernv_flash.c:184: warning: Function parameter or member 'dev' not described in 'powernv_flash_set_driver_info'
> 
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Cyril Bur <cyril.bur@au1.ibm.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mtd/devices/powernv_flash.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
> index 0b757d9ba2f6b..32cb0e649096f 100644
> --- a/drivers/mtd/devices/powernv_flash.c
> +++ b/drivers/mtd/devices/powernv_flash.c
> @@ -126,6 +126,8 @@ static int powernv_flash_async_op(struct mtd_info *mtd, enum flash_op op,
>  }
>  
>  /**
> + * powernv_flash_read
> + *

Perhaps we should not add blank lines if the rest of the file does not
already have such spacing (see below).

>   * @mtd: the device
>   * @from: the offset to read from
>   * @len: the number of bytes to read
> @@ -142,6 +144,7 @@ static int powernv_flash_read(struct mtd_info *mtd, loff_t from, size_t len,
>  }
>  
>  /**
> + * powernv_flash_write
>   * @mtd: the device
>   * @to: the offset to write to
>   * @len: the number of bytes to write
> @@ -158,6 +161,7 @@ static int powernv_flash_write(struct mtd_info *mtd, loff_t to, size_t len,
>  }
>  
>  /**
> + * powernv_flash_erase
>   * @mtd: the device
>   * @erase: the erase info
>   * Returns 0 if erase successful or -ERRNO if an error occurred
> @@ -176,7 +180,7 @@ static int powernv_flash_erase(struct mtd_info *mtd, struct erase_info *erase)
>  
>  /**
>   * powernv_flash_set_driver_info - Fill the mtd_info structure and docg3
> - * structure @pdev: The platform device
> + * @dev: The device structure
>   * @mtd: The structure to fill
>   */
>  static int powernv_flash_set_driver_info(struct device *dev,


Thanks,
Miquèl
