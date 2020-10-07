Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40EE4285681
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 03:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgJGBv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 21:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgJGBv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:51:28 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A2BC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 18:51:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b69so869305qkg.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 18:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DhT5192mGIN04lhJQKpHcHO54yzKIALf8GZavNFgKps=;
        b=Hffk7LYCHuRT4fwBiH02KWrywWC4XMNDBL0iY0bvlLeZtyPRI1ZFYMDIOJrZNUdQCa
         3v5C+9WWM9EP9YH42m6jfBxJ0U5H8lyPvCzVKOV+kzDfyseytSN05hvW3KA4kJJrZzqX
         wXUpBNC2WB6tA37LTs6mw+MWawOqDklG+sSSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DhT5192mGIN04lhJQKpHcHO54yzKIALf8GZavNFgKps=;
        b=goJCrRLlSg0OYbf6WDUIh1jllsTzUxcruzS1PfUFU3o4E+brHiCzoa4I6fqAYm3He4
         4DJ9YpjQIjzpY4FaI1mrXCHJYbNMmYyEnr25s+Ez5jKgviXRE+qjYqJsdQMQnXuqvAI8
         Md7ZLzdy149czgD6qdP4S/Vp9OmDR5+puqCAjdI1kUCyG74djV24VGkkbWq4FT8rGhbB
         Tz8cimQd2f9Rl3tfl3upMO+0XuKWJ9S3Oqu1xcmHJUwyVpWDeZbB82Gny3KvlXZqcGKA
         XUbaYtQVdJBqsH5yiA6bvkvzc5YlivQvZp5X+FLkcznai81JhF+VEmOFMc9ZWMhCUG9y
         ZoGA==
X-Gm-Message-State: AOAM5313Xf2e3CziXx162MfJQ1274LULh9EZRMXJ+v3RoU1wQESwy9YD
        ql6yzx8q5T0LOYhS6H6ZJjpYvwCubn/AJ3IUKLU=
X-Google-Smtp-Source: ABdhPJxFMdJlBX+/LRa3e7NAJmDb4iEWSAKzYbDMp6aTkrAOrOw6u96cKjLozMg5OBgEU09Hsuq6vZ2a/PlAdj8aNqk=
X-Received: by 2002:a37:c404:: with SMTP id d4mr630341qki.273.1602035487238;
 Tue, 06 Oct 2020 18:51:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201004213204.11584-1-bert@biot.com>
In-Reply-To: <20201004213204.11584-1-bert@biot.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 7 Oct 2020 01:51:15 +0000
Message-ID: <CACPK8XceL_QHCQOhfus27rei0vwfRJAFjfL6JkVw9pwxJj2d6Q@mail.gmail.com>
Subject: Re: [PATCH v2] mtd: spi-nor: Fix address width on flash chips > 16MB
To:     Bert Vermeulen <bert@biot.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Oct 2020 at 21:33, Bert Vermeulen <bert@biot.com> wrote:
>
> If a flash chip has more than 16MB capacity but its BFPT reports
> BFPT_DWORD1_ADDRESS_BYTES_3_OR_4, the spi-nor framework defaults to 3.
>
> The check in spi_nor_set_addr_width() doesn't catch it because addr_width
> did get set. This fixes that check.
>
> Signed-off-by: Bert Vermeulen <bert@biot.com>

After replying to the other thread, I just saw this one.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Joel Stanley <joel@jms.id.au>

Thanks Bert!

Cheers,

Joel

> ---
>  drivers/mtd/spi-nor/core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 0369d98b2d12..a2c35ad9645c 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3009,13 +3009,15 @@ static int spi_nor_set_addr_width(struct spi_nor *nor)
>                 /* already configured from SFDP */
>         } else if (nor->info->addr_width) {
>                 nor->addr_width = nor->info->addr_width;
> -       } else if (nor->mtd.size > 0x1000000) {
> -               /* enable 4-byte addressing if the device exceeds 16MiB */
> -               nor->addr_width = 4;
>         } else {
>                 nor->addr_width = 3;
>         }
>
> +       if (nor->addr_width == 3 && nor->mtd.size > 0x1000000) {
> +               /* enable 4-byte addressing if the device exceeds 16MiB */
> +               nor->addr_width = 4;
> +       }
> +
>         if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
>                 dev_dbg(nor->dev, "address width is too large: %u\n",
>                         nor->addr_width);
> --
> 2.17.1
>
