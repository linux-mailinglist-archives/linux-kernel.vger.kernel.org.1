Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAEA19EF0E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 03:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgDFBUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 21:20:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43259 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgDFBUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 21:20:14 -0400
Received: by mail-qk1-f196.google.com with SMTP id 13so2415478qko.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 18:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PsmsZgemCvhriIQAgZ8Jrnu1V0u0Uy80i+4ks6YOumc=;
        b=HBkyOKI64T1XZ3uIg75dUY22JSUM5cbP/qn1UGHhdCmjF6sSrR7GhfznJT9SM18EX/
         B8iSH7m45ijOV4k+bl14QNVToBrmSm8lS+yfkMmLvmb02xYDo7M1o7hCikdokcKz1pez
         aOf8ZZ2Os4xtY2wKma46hfx3yoTH4wNjTBwvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PsmsZgemCvhriIQAgZ8Jrnu1V0u0Uy80i+4ks6YOumc=;
        b=qaqzQ3gxZiLQkAWfxDEEkaztkCxg8Hmoa3QKmjOkPJoRO61MaITXWArxIBz0Evtb9i
         xhiL85KMzf38mdT3TeJ1c2sIN8NXVmXLv+5PDCYEfZul3YvF3gMvgqfpl8rHBUxHjZd6
         oo1h1e9zn/7hPBIopWhBl5M6pfyDiqXQxAazq1AM6J++JpghZbwVitWKPIkO5LiceIDx
         yjNptvzcqrafgQw9Yo/TJUz/7Zob7F1lHtbaIJaLCqzXBlu30rd+TcX5LjYIgB4XxC1C
         TgptPfLV1RktzNG0ZQEoIsGC77hrZ26lQJmlfKmKNNyhSEjYD6fOoMFq+ekLKMwCDLTQ
         m9tQ==
X-Gm-Message-State: AGi0Puakg4DndxZyYC0PYQlx5agrn68zCO7N58S0FfvX9wh5PhCd3Uq3
        LeLOjfczrU2UYvnNPtdEW1/+r4cQwJQa0I/4BM8=
X-Google-Smtp-Source: APiQypJ3e6qTmPGYSNjcv8HM2bboVabW4Mrp2r84r0j7tlusts/GgMm6UHPe2ubJX85/zQRv4hnNIBAI+Hss+FJs/DI=
X-Received: by 2002:a37:2f43:: with SMTP id v64mr7863822qkh.330.1586136013201;
 Sun, 05 Apr 2020 18:20:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200404153631.103549-1-linux@roeck-us.net>
In-Reply-To: <20200404153631.103549-1-linux@roeck-us.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 6 Apr 2020 01:20:01 +0000
Message-ID: <CACPK8Xdmjp0qg0JHHnR1MJp7zmuZHCHTOs7+qn5_16oLbe+r+g@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Compile files in controllers/ directory
To:     Guenter Roeck <linux@roeck-us.net>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Apr 2020 at 15:37, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Commit a0900d0195d2 ("mtd: spi-nor: Prepare core / manufacturer code
> split") moved various files into a new directory, but did not add the new
> directory to its parent directory Makefile. The moved files no longer
> build, and affected flash chips no longer instantiate.
>
> Adding the new directory to the parent directory Makefile fixes the
> problem.
>
> Fixes: a0900d0195d2 ("mtd: spi-nor: Prepare core / manufacturer code split")
> Cc: Boris Brezillon <bbrezillon@kernel.org>
> Cc: Tudor Ambarus <tudor.ambarus@microchip.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Thanks Guenter. I just discovered this too.

Acked-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/mtd/spi-nor/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> index 7ddb742de1fe..653923896205 100644
> --- a/drivers/mtd/spi-nor/Makefile
> +++ b/drivers/mtd/spi-nor/Makefile
> @@ -18,3 +18,5 @@ spi-nor-objs                  += winbond.o
>  spi-nor-objs                   += xilinx.o
>  spi-nor-objs                   += xmc.o
>  obj-$(CONFIG_MTD_SPI_NOR)      += spi-nor.o
> +
> +obj-$(CONFIG_MTD_SPI_NOR)      += controllers/
> --
> 2.17.1
>
