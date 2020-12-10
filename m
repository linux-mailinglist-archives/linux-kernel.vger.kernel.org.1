Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED5E2D69AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 22:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394018AbgLJVXi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Dec 2020 16:23:38 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:33291 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404682AbgLJVT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 16:19:57 -0500
X-Originating-IP: 109.220.208.103
Received: from xps13 (lfbn-tou-1-1617-103.w109-220.abo.wanadoo.fr [109.220.208.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id DD2561BF206;
        Thu, 10 Dec 2020 21:19:09 +0000 (UTC)
Date:   Thu, 10 Dec 2020 22:19:08 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mtd: rawnand: simplify the
 cs553x_write_ctrl_byte()
Message-ID: <20201210221908.192623d7@xps13>
In-Reply-To: <20201209093103.20742-1-zhengyongjun3@huawei.com>
References: <20201209093103.20742-1-zhengyongjun3@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yongjun,

Zheng Yongjun <zhengyongjun3@huawei.com> wrote on Wed, 9 Dec 2020
17:31:03 +0800:

> Simplify the return expression.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/mtd/nand/raw/cs553x_nand.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/cs553x_nand.c b/drivers/mtd/nand/raw/cs553x_nand.c
> index 282203debd0c..a616aaa2e3dc 100644
> --- a/drivers/mtd/nand/raw/cs553x_nand.c
> +++ b/drivers/mtd/nand/raw/cs553x_nand.c
> @@ -105,17 +105,12 @@ static int cs553x_write_ctrl_byte(struct cs553x_nand_controller *cs553x,
>  				  u32 ctl, u8 data)
>  {
>  	u8 status;
> -	int ret;
>  
>  	writeb(ctl, cs553x->mmio + MM_NAND_CTL);
>  	writeb(data, cs553x->mmio + MM_NAND_IO);
> -	ret = readb_poll_timeout_atomic(cs553x->mmio + MM_NAND_STS, status,
> -					!(status & CS_NAND_CTLR_BUSY), 1,
> -					100000);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return readb_poll_timeout_atomic(cs553x->mmio + MM_NAND_STS, status,
> +					 !(status & CS_NAND_CTLR_BUSY), 1,
> +					 100000);
>  }
>  
>  static void cs553x_data_in(struct cs553x_nand_controller *cs553x, void *buf,

Sorry but this brings no value and I kind of personally dislike commits
darkening git blames for almost no reason, so if you don't mind I would
like to avoid such change.

Thanks,
Miquèl
