Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5303B2B08C4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgKLPqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728545AbgKLPqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:46:25 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB80C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:46:25 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id y9so5682075ilb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 07:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbBMIBt9sbY15L3rVTIesjSgzRJgQSWEsSg7nW8xxNU=;
        b=br8jZAC5NF3NhlltWjsxhVx5tNYAcrAOAWSCiJ0MFiY0sdIZgXpPKrVWrbDGLH6keW
         dLZN26/U6irDM1gpiamZGYlPz2MRsbuo0YzVM0Ba0UutMXE/CXpTmp55QT07JWxgWtN3
         nVq5oIu/rEDx3U9udwUlM+uj51+ll4MXNbemuFx0tbdv9b1+9a+SrLZ49vMfDyayA0g1
         ychESt5+uHSRj9kYT/KEAf7jHIol4pyGcfEqLQJuP+e6osINY6BKtKq8jggRQ7TCa53+
         MutXhSJJX4Xt8KtY/bC6uTLSENoNnuG8edHpOeAtWxpjnKqJphvyQGzEmyJnjk7wo9Nn
         wRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbBMIBt9sbY15L3rVTIesjSgzRJgQSWEsSg7nW8xxNU=;
        b=m9N5a4ziuuDE90/TGodv7pArEtkOCTxAc9kPyLUNCvTZa/2YspFBOa8SeXrcLJJGbh
         lZ85G59iD16gJBl4N/Z20qC7jIpyQi6N4KxXSUp9YwJdJeUtsFs3jnMI7OdJkBo8wIaS
         j2eYYJ2tKcMqRpKIaGm4FAnhLAu5+5sxgX95HWdlWMZfCTRlmhTAvWwJSYL7rxH46MzG
         2ewJVbISGX5jERPT94ARuzYaFKAuClrH9blVRwecPZBfrDiCbUgp8FUnzHLD1FCG4wHx
         3cBuQEgkWA2N2LJA5ngFaF97KB0jnOcv4VEDHirOecmQ18GyqGUeogLTmM9YqLJmR+iS
         KNkw==
X-Gm-Message-State: AOAM533BOjep+FDoou/+aDhc5XKhLMNXFmHzL/BDJ78arpr0EYV5DXbq
        Zz8zwarbECorMuFT9/bd8mNDua74MWYiGo8ZZ5o=
X-Google-Smtp-Source: ABdhPJzLsAmh7B3AUAYxQXWIfVsLw152OgwoE1qgVkib6BkMuLWGNsAm5+1rGfOvyjjIwkFsJzDwLduOnhthTOBcm2I=
X-Received: by 2002:a92:c6c6:: with SMTP id v6mr73479ilm.119.1605195984197;
 Thu, 12 Nov 2020 07:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20201106213655.1838861-1-lee.jones@linaro.org> <20201106213655.1838861-14-lee.jones@linaro.org>
In-Reply-To: <20201106213655.1838861-14-lee.jones@linaro.org>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Thu, 12 Nov 2020 10:46:13 -0500
Message-ID: <CAC=U0a24oQasGEPGHeJfG7J4U-F-a8Q54oEPKGQfhrsd0iPhfw@mail.gmail.com>
Subject: Re: [PATCH v2 13/23] mtd: nand: raw: brcmnand: brcmnand: Demote
 non-conformant kernel-doc headers
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 4:37 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=1 kernel build warning(s):
>
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'host' not described in 'brcmnand_edu_trans'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'addr' not described in 'brcmnand_edu_trans'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'buf' not described in 'brcmnand_edu_trans'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'len' not described in 'brcmnand_edu_trans'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1854: warning: Function parameter or member 'cmd' not described in 'brcmnand_edu_trans'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'host' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'desc' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'addr' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'buf' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'len' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'dma_cmd' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'begin' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'end' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1951: warning: Function parameter or member 'next_desc' not described in 'brcmnand_fill_dma_desc'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1977: warning: Function parameter or member 'host' not described in 'brcmnand_dma_run'
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c:1977: warning: Function parameter or member 'desc' not described in 'brcmnand_dma_run'
>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: Kamal Dasu <kdasu.kdev@gmail.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: bcm-kernel-feedback-list@broadcom.com
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

> ---
>  drivers/mtd/nand/raw/brcmnand/brcmnand.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/brcmnand/brcmnand.c b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> index 2da39ab892869..659eaa6f0980c 100644
> --- a/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> +++ b/drivers/mtd/nand/raw/brcmnand/brcmnand.c
> @@ -1846,7 +1846,7 @@ static void brcmnand_write_buf(struct nand_chip *chip, const uint8_t *buf,
>         }
>  }
>
> -/**
> +/*
>   *  Kick EDU engine
>   */
>  static int brcmnand_edu_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
> @@ -1937,7 +1937,7 @@ static int brcmnand_edu_trans(struct brcmnand_host *host, u64 addr, u32 *buf,
>         return ret;
>  }
>
> -/**
> +/*
>   * Construct a FLASH_DMA descriptor as part of a linked list. You must know the
>   * following ahead of time:
>   *  - Is this descriptor the beginning or end of a linked list?
> @@ -1970,7 +1970,7 @@ static int brcmnand_fill_dma_desc(struct brcmnand_host *host,
>         return 0;
>  }
>
> -/**
> +/*
>   * Kick the FLASH_DMA engine, with a given DMA descriptor
>   */
>  static void brcmnand_dma_run(struct brcmnand_host *host, dma_addr_t desc)
> --
> 2.25.1
>
