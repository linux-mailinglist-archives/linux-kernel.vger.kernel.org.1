Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023A32C7CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 03:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgK3CWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 21:22:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726376AbgK3CWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 21:22:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606702850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+xbRADCNKOvYBKYT87lWC6tQYrlTC4el3mQzUGbbMk=;
        b=MS61W6n32NwMf2OnkwhoLPn+4u8seCqHxe4gvtRXLZfUPyrKijWQyNurkr2kKQgCywJBc1
        ocM40dcyAlxEe5of7ttt5WVbVMdSvD8cMX3Ia9Dl6F9KPBN6wT0bXZvfZ9yPD40clK2zIe
        TPKJl0RyDTMrbU+K0DtalPnpKkHHzdw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-SwTHeKNcM1CxPpFYeZtw7A-1; Sun, 29 Nov 2020 21:20:46 -0500
X-MC-Unique: SwTHeKNcM1CxPpFYeZtw7A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F1C1D107AD50;
        Mon, 30 Nov 2020 02:20:44 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F3F560657;
        Mon, 30 Nov 2020 02:20:35 +0000 (UTC)
Subject: Re: [PATCH] vdpa: ifcvf: Use dma_set_mask_and_coherent to simplify
 code
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>, mst@redhat.com,
        lingshan.zhu@intel.com, eli@mellanox.com, parav@mellanox.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20201129125434.1462638-1-christophe.jaillet@wanadoo.fr>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <4576b2bb-d4d3-6413-c2cb-54e7d781eebf@redhat.com>
Date:   Mon, 30 Nov 2020 10:20:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201129125434.1462638-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/29 下午8:54, Christophe JAILLET wrote:
> 'pci_set_dma_mask()' + 'pci_set_consistent_dma_mask()' can be replaced by
> an equivalent 'dma_set_mask_and_coherent()' which is much less verbose.
>
> While at it, fix a typo (s/confiugration/configuration)
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---


Acked-by: Jason Wang <jasowang@redhat.com>


>   drivers/vdpa/ifcvf/ifcvf_main.c | 11 ++---------
>   1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 8b4028556cb6..fa1af301cf55 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -417,16 +417,9 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		return ret;
>   	}
>   
> -	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>   	if (ret) {
> -		IFCVF_ERR(pdev, "No usable DMA confiugration\n");
> -		return ret;
> -	}
> -
> -	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> -	if (ret) {
> -		IFCVF_ERR(pdev,
> -			  "No usable coherent DMA confiugration\n");
> +		IFCVF_ERR(pdev, "No usable DMA configuration\n");
>   		return ret;
>   	}
>   

