Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E079F2D7923
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437850AbgLKPYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:24:41 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:58147 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437820AbgLKPXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:23:43 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Csvg12GJLz9v0BR;
        Fri, 11 Dec 2020 16:22:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wd5pGtPFX2xY; Fri, 11 Dec 2020 16:22:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Csvg11DsHz9v0BQ;
        Fri, 11 Dec 2020 16:22:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AD5E68B86D;
        Fri, 11 Dec 2020 16:22:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lPuwoqgJFjrM; Fri, 11 Dec 2020 16:22:54 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0EE778B869;
        Fri, 11 Dec 2020 16:22:54 +0100 (CET)
Subject: Re: [PATCH] net: ethernet: fs-enet: remove casting dma_alloc_coherent
To:     Xu Wang <vulab@iscas.ac.cn>, pantelis.antoniou@gmail.com,
        davem@davemloft.net, kuba@kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20201211085212.85457-1-vulab@iscas.ac.cn>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <34548188-67f4-d3ef-c2e3-871fc520e838@csgroup.eu>
Date:   Fri, 11 Dec 2020 16:22:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201211085212.85457-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/12/2020 à 09:52, Xu Wang a écrit :
> Remove casting the values returned by dma_alloc_coherent.

Can you explain more in the commit log ?

As far as I can see, dma_alloc_coherent() doesn't return __iomem, and ring_base member is __iomem

Christophe

> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>   drivers/net/ethernet/freescale/fs_enet/mac-fec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
> index 99fe2c210d0f..3ae345676e50 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
> @@ -131,7 +131,7 @@ static int allocate_bd(struct net_device *dev)
>   	struct fs_enet_private *fep = netdev_priv(dev);
>   	const struct fs_platform_info *fpi = fep->fpi;
>   
> -	fep->ring_base = (void __force __iomem *)dma_alloc_coherent(fep->dev,
> +	fep->ring_base = dma_alloc_coherent(fep->dev,
>   					    (fpi->tx_ring + fpi->rx_ring) *
>   					    sizeof(cbd_t), &fep->ring_mem_addr,
>   					    GFP_KERNEL);
> 
