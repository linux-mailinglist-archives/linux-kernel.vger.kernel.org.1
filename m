Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AD82EBFDC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbhAFOwT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Jan 2021 09:52:19 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:44989 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbhAFOwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:52:18 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 5739E1C0002;
        Wed,  6 Jan 2021 14:51:35 +0000 (UTC)
Date:   Wed, 6 Jan 2021 15:51:33 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mtd: st_spi_fsm: use resource_size
Message-ID: <20210106155133.7f901871@xps13>
In-Reply-To: <20210106131847.443-1-zhengyongjun3@huawei.com>
References: <20210106131847.443-1-zhengyongjun3@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Zheng Yongjun <zhengyongjun3@huawei.com> wrote on Wed, 6 Jan 2021
21:18:47 +0800:

> Use resource_size rather than a verbose computation on
> the end and start fields.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/mtd/devices/st_spi_fsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
> index 1888523d9745..983999c020d6 100644
> --- a/drivers/mtd/devices/st_spi_fsm.c
> +++ b/drivers/mtd/devices/st_spi_fsm.c
> @@ -924,7 +924,7 @@ static int stfsm_read_status(struct stfsm *fsm, uint8_t cmd,
>  	BUG_ON(bytes != 1 && bytes != 2);
>  
>  	seq->seq_opc[0] = (SEQ_OPC_PADS_1 | SEQ_OPC_CYCLES(8) |
> -			   SEQ_OPC_OPCODE(cmd)),
> +			   SEQ_OPC_OPCODE(cmd));
>  
>  	stfsm_load_seq(fsm, seq);
>  

Same remark again, description and actual change do not match.

Thanks,
Miquèl
