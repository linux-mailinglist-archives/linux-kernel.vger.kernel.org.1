Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D882F2809F4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 00:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbgJAWWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 18:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgJAWWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 18:22:48 -0400
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E96C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 15:22:48 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kO6yL-00DpSY-8v
        for linux-kernel@vger.kernel.org; Fri, 02 Oct 2020 00:22:45 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:1e1b:dff:fe91:1af5]
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kO6yL-00DpSU-2d; Fri, 02 Oct 2020 00:22:45 +0200
Subject: Re: [PATCH] mtd: spi-nor: Fix 3-or-4 address byte mode logic
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20200930235611.6355-1-bert@biot.com>
 <20201001063421.qcjdikj2tje3jn6k@ti.com>
From:   Bert Vermeulen <bert@biot.com>
Message-ID: <801445c9-4f59-5300-3a03-b48a3d631efe@biot.com>
Date:   Fri, 2 Oct 2020 00:22:44 +0200
MIME-Version: 1.0
In-Reply-To: <20201001063421.qcjdikj2tje3jn6k@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 8:34 AM, Pratyush Yadav wrote:
> So using an address width of 4 here is not necessarily the right thing
> to do. This change would break SMPT parsing for all flashes that use
> 3-byte addressing by default because SMPT parsing can involve register
> reads/writes. One such device is the Cypress S28HS flash. In fact, this
> was what prompted me to write the patch [0].
> 
> Before that patch, how did MX25L25635F decide to use 4-byte addressing?

The SoCs I'm dealing with have an SPI_ADDR_SEL pin, indicating whether it 
should be in 3 or 4-byte mode. The vendor's hacked-up U-Boot sets the mode 
accordingly, as does their BSP. It seems to me like a misfeature, and I want 
to just ignore it and do reasonable JEDEC things, but I have the problem 
that the flash chip can be in 4-byte mode by the time it gets to my spi-nor 
driver.

> Coming out of BFPT parsing addr_width would still be 0. My guess is that
> it would go into spi_nor_set_addr_width() with addr_width still 0 and
> then the check for (nor->mtd.size > 0x1000000) would set it to 4. Do I
> guess correctly?

No, it comes out of that with addr_width=3 because the chip publishes 3_OR_4 
and hence gets 3, even if that's nonsensical for a 32MB chip to publish.

Certainly that's the problem, I just want to solve it in a more general case 
than just a fixup for this chip.

> In that case maybe we can do a better job of deciding what gets priority
> in the if-else chain. For example, giving addr_width from nor->info
> precedence over the one configured by SFDP can solve this problem. Then
> all you have to do is set the addr_width in the info struct, which is
> certainly easier than adding a fixup hook. There may be a more elegant
> solution to this but I haven't given it much thought.

Since Tudor doesn't want the order of sfdp->info changed, how about 
something like this instead?

+++ b/drivers/mtd/spi-nor/core.c
@@ -3028,13 +3028,15 @@ static int spi_nor_set_addr_width(struct spi_nor *nor)
         /* already configured from SFDP */
     } else if (nor->info->addr_width) {
         nor->addr_width = nor->info->addr_width;
-   } else if (nor->mtd.size > 0x1000000) {
-       /* enable 4-byte addressing if the device exceeds 16MiB */
-       nor->addr_width = 4;
     } else {
         nor->addr_width = 3;
     }

+   if (nor->addr_width == 3 && nor->mtd.size > 0x1000000) {
+       /* enable 4-byte addressing if the device exceeds 16MiB */
+       nor->addr_width = 4;
+   }
+

Still fixes the general case, but I'm not sure what the SMPT parsing problem 
is -- would this still trigger it?


-- 
Bert Vermeulen
bert@biot.com
