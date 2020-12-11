Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837C22D7B31
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389428AbgLKQoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:44:11 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:54299 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389370AbgLKQnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:43:46 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CsxRT3xzLzB09b7;
        Fri, 11 Dec 2020 17:43:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id C73GqEBCrzBF; Fri, 11 Dec 2020 17:43:01 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CsxRT2BQczB09Zs;
        Fri, 11 Dec 2020 17:43:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4ECDF8B86D;
        Fri, 11 Dec 2020 17:43:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GfDfkE2H2mL7; Fri, 11 Dec 2020 17:43:01 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D11DF8B869;
        Fri, 11 Dec 2020 17:42:57 +0100 (CET)
Subject: Re: [PATCH] net: ethernet: fs-enet: remove casting dma_alloc_coherent
To:     David Laight <David.Laight@ACULAB.COM>,
        Xu Wang <vulab@iscas.ac.cn>,
        "pantelis.antoniou@gmail.com" <pantelis.antoniou@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201211085212.85457-1-vulab@iscas.ac.cn>
 <34548188-67f4-d3ef-c2e3-871fc520e838@csgroup.eu>
 <6fc4b62ee7754d78b8f7b9c2275bc47e@AcuMS.aculab.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <4a1c2852-781f-e125-afcb-69387660b6af@csgroup.eu>
Date:   Fri, 11 Dec 2020 17:42:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <6fc4b62ee7754d78b8f7b9c2275bc47e@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 11/12/2020 à 17:07, David Laight a écrit :
> From: Christophe Leroy
>> Sent: 11 December 2020 15:22
>>
>> Le 11/12/2020 à 09:52, Xu Wang a écrit :
>>> Remove casting the values returned by dma_alloc_coherent.
>>
>> Can you explain more in the commit log ?
>>
>> As far as I can see, dma_alloc_coherent() doesn't return __iomem, and ring_base member is __iomem
> 
> Which is probably wrong - that is the kernel address of kernel memory.
> So it shouldn't have the __iomem marker.

That's where the buffer descriptors are, the driver accesses to the content of the buffer 
descriptors using the IO accessors in_be16()/out_be16(). Is it not correct ?

Christophe

> 
> I wonder what else is wrong....
> 
> 	David
> 
>>
>> Christophe
>>
>>>
>>> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
>>> ---
>>>    drivers/net/ethernet/freescale/fs_enet/mac-fec.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
>> b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
>>> index 99fe2c210d0f..3ae345676e50 100644
>>> --- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
>>> +++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
>>> @@ -131,7 +131,7 @@ static int allocate_bd(struct net_device *dev)
>>>    	struct fs_enet_private *fep = netdev_priv(dev);
>>>    	const struct fs_platform_info *fpi = fep->fpi;
>>>
>>> -	fep->ring_base = (void __force __iomem *)dma_alloc_coherent(fep->dev,
>>> +	fep->ring_base = dma_alloc_coherent(fep->dev,
>>>    					    (fpi->tx_ring + fpi->rx_ring) *
>>>    					    sizeof(cbd_t), &fep->ring_mem_addr,
>>>    					    GFP_KERNEL);
>>>
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
