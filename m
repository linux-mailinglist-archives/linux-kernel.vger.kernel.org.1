Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE422F99E2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbhARG2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbhARG1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 01:27:34 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA39C061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 22:26:54 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id c6so9125649ede.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 22:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=To9xHF+bvRND4e71EX/eoQPj9g3Y0QQk/55jMKeNBsU=;
        b=H9ke33h73Dz/hXk+091/y2aCEuAF4HAK5fzpBEcvGvOV9MBBsbGHuWO7IM74zsCiM+
         5reA5U6qiCKCjJNhu6fdXrxOA/nHOlQwV/MNpsEe4VaiEg04jh7m56uE+r5BHvy+OL8g
         GQ+WqWVI8oP5Y6qm/sno30mopz4bFufqSVmu6ExGYwintYzFhJxeUod+oXiJjvFoYBg0
         QcAk0OngibTFQ+LowDmVIie8su5iQ6AI4RHgn4jfTqtgoYQX6whlbfe5ho22qX18dTb2
         1JHUaM6CLVcxzD8vrxfaeKy7ws7NIULzZzVgtOE4P+p2J2PRK7jTiJLjHqZMoOE3IG3x
         q7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=To9xHF+bvRND4e71EX/eoQPj9g3Y0QQk/55jMKeNBsU=;
        b=tmfa+JoNCa0EBMNj62GE7fqF03QtPMe5I6rNluc4E1+ZODwik3LoDixdBZ/+EON75j
         x6EBNJTFumLz2U2UyF7g5rxOsObep3YvOmxFOApHhlgHt0o/ykLGLc2IjfotGesOJqtY
         SdbBrDfKQxypjeCZKEBpesagAb2/E9MRJorziasmWndT377uwK3MyJUqZtuDk2y+rdiP
         79PIQpAqnezXTfDLQTHPbzj7tl0g5mpxI+cvhuDakjk+rMLg2HGr/t5e+KVskRLexhqh
         ts7/L/eZXP1EUKgTCvDbmaoTDb+J1o3omlLjgL1xIemiAl3dqBv634C+0/0xG6itRYdx
         bnWQ==
X-Gm-Message-State: AOAM530Hg658fm9RN6TGZPThem+bKBTOOIrKz2grZ8NFJpg5g1kkZSU3
        5RaJBq5JyVmnrvfWNK3cWDc/Yo+d0gGwwxhW9R00cA==
X-Google-Smtp-Source: ABdhPJwEYA4GhPJYVZbHMYbOYdZ8nrU3dK1YvRgwQiN7LijA78JUWQJcYCEZ8hVKZjXizOt+jkyTAEAt5QD9KpjjYj0=
X-Received: by 2002:a05:6402:1c0b:: with SMTP id ck11mr8573153edb.35.1610951213080;
 Sun, 17 Jan 2021 22:26:53 -0800 (PST)
MIME-Version: 1.0
References: <20210117132445.562552-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20210117132445.562552-1-christophe.jaillet@wanadoo.fr>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 18 Jan 2021 07:26:42 +0100
Message-ID: <CAMGffEndZKZL26w0kV55Q_-++UnJT_U3ef0us4NiUhn61wJ0Yw@mail.gmail.com>
Subject: Re: [PATCH] scsi: pm80xx: switch from 'pci_' to 'dma_' API
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 2:24 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> The wrappers in include/linux/pci-dma-compat.h should go away.
>
> The patch has been generated with the coccinelle script below and has been
> hand modified to replace GFP_ with a correct flag.
> It has been compile tested.
>
> When memory is allocated in 'pm8001_init_ccb_tag()' GFP_KERNEL can be used
> because this function already uses this flag a few lines above.
>
> While at it, remove "pm80xx: " in a debug message. 'pm8001_dbg()' already
> add the driver name in the message.
>
>
> @@
> @@
> -    PCI_DMA_BIDIRECTIONAL
> +    DMA_BIDIRECTIONAL
>
> @@
> @@
> -    PCI_DMA_TODEVICE
> +    DMA_TO_DEVICE
>
> @@
> @@
> -    PCI_DMA_FROMDEVICE
> +    DMA_FROM_DEVICE
>
> @@
> @@
> -    PCI_DMA_NONE
> +    DMA_NONE
>
> @@
> expression e1, e2, e3;
> @@
> -    pci_alloc_consistent(e1, e2, e3)
> +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
>
> @@
> expression e1, e2, e3;
> @@
> -    pci_zalloc_consistent(e1, e2, e3)
> +    dma_alloc_coherent(&e1->dev, e2, e3, GFP_)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_free_consistent(e1, e2, e3, e4)
> +    dma_free_coherent(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_map_single(e1, e2, e3, e4)
> +    dma_map_single(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_single(e1, e2, e3, e4)
> +    dma_unmap_single(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4, e5;
> @@
> -    pci_map_page(e1, e2, e3, e4, e5)
> +    dma_map_page(&e1->dev, e2, e3, e4, e5)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_page(e1, e2, e3, e4)
> +    dma_unmap_page(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_map_sg(e1, e2, e3, e4)
> +    dma_map_sg(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_unmap_sg(e1, e2, e3, e4)
> +    dma_unmap_sg(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_single_for_cpu(e1, e2, e3, e4)
> +    dma_sync_single_for_cpu(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_single_for_device(e1, e2, e3, e4)
> +    dma_sync_single_for_device(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_sg_for_cpu(e1, e2, e3, e4)
> +    dma_sync_sg_for_cpu(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2, e3, e4;
> @@
> -    pci_dma_sync_sg_for_device(e1, e2, e3, e4)
> +    dma_sync_sg_for_device(&e1->dev, e2, e3, e4)
>
> @@
> expression e1, e2;
> @@
> -    pci_dma_mapping_error(e1, e2)
> +    dma_mapping_error(&e1->dev, e2)
>
> @@
> expression e1, e2;
> @@
> -    pci_set_dma_mask(e1, e2)
> +    dma_set_mask(&e1->dev, e2)
>
> @@
> expression e1, e2;
> @@
> -    pci_set_consistent_dma_mask(e1, e2)
> +    dma_set_coherent_mask(&e1->dev, e2)
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
> If needed, see post from Christoph Hellwig on the kernel-janitors ML:
>    https://marc.info/?l=kernel-janitors&m=158745678307186&w=4
> ---
>  drivers/scsi/pm8001/pm8001_init.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index d21078ca7fb3..bd626ef876da 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -423,7 +423,7 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
>  err_out_nodev:
>         for (i = 0; i < pm8001_ha->max_memcnt; i++) {
>                 if (pm8001_ha->memoryMap.region[i].virt_ptr != NULL) {
> -                       pci_free_consistent(pm8001_ha->pdev,
> +                       dma_free_coherent(&pm8001_ha->pdev->dev,
>                                 (pm8001_ha->memoryMap.region[i].total_len +
>                                 pm8001_ha->memoryMap.region[i].alignment),
>                                 pm8001_ha->memoryMap.region[i].virt_ptr,
> @@ -1197,12 +1197,13 @@ pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha, struct Scsi_Host *shost,
>                 goto err_out_noccb;
>         }
>         for (i = 0; i < ccb_count; i++) {
> -               pm8001_ha->ccb_info[i].buf_prd = pci_alloc_consistent(pdev,
> +               pm8001_ha->ccb_info[i].buf_prd = dma_alloc_coherent(&pdev->dev,
>                                 sizeof(struct pm8001_prd) * PM8001_MAX_DMA_SG,
> -                               &pm8001_ha->ccb_info[i].ccb_dma_handle);
> +                               &pm8001_ha->ccb_info[i].ccb_dma_handle,
> +                               GFP_KERNEL);
>                 if (!pm8001_ha->ccb_info[i].buf_prd) {
>                         pm8001_dbg(pm8001_ha, FAIL,
> -                                  "pm80xx: ccb prd memory allocation error\n");
> +                                  "ccb prd memory allocation error\n");
>                         goto err_out;
>                 }
>                 pm8001_ha->ccb_info[i].task = NULL;
> --
> 2.27.0
>
