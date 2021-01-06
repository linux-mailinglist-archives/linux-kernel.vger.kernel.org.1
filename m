Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145942EBFDB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbhAFOvc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Jan 2021 09:51:32 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:57225 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbhAFOvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:51:32 -0500
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 068B510000B;
        Wed,  6 Jan 2021 14:50:48 +0000 (UTC)
Date:   Wed, 6 Jan 2021 15:50:47 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <richard@nod.at>
Subject: Re: [PATCH -next] mtd: rawnand: marvell: use resource_size
Message-ID: <20210106155047.5d39fc42@xps13>
In-Reply-To: <20210106131839.371-1-zhengyongjun3@huawei.com>
References: <20210106131839.371-1-zhengyongjun3@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Zheng Yongjun <zhengyongjun3@huawei.com> wrote on Wed, 6 Jan 2021
21:18:39 +0800:

> Use resource_size rather than a verbose computation on
> the end and start fields.

Same as your previous patch, the description does not match the change.

> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/mtd/nand/raw/marvell_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
> index f5ca2002d08e..3e01b11c87f8 100644
> --- a/drivers/mtd/nand/raw/marvell_nand.c
> +++ b/drivers/mtd/nand/raw/marvell_nand.c
> @@ -2396,7 +2396,7 @@ static int marvell_nfc_setup_interface(struct nand_chip *chip, int chipnr,
>  	 * be greater than that to be sure tCCS delay is respected.
>  	 */
>  	nfc_tmg.tWHR = TO_CYCLES(max_t(int, sdr->tWHR_min, sdr->tCCS_min),
> -				 period_ns) - 2,
> +				 period_ns) - 2;
>  	nfc_tmg.tRHW = TO_CYCLES(max_t(int, sdr->tRHW_min, sdr->tCCS_min),
>  				 period_ns);
>  




Thanks,
Miquèl
