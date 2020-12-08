Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D322D1FE2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 02:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgLHBUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 20:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgLHBUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 20:20:23 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5073BC061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 17:19:43 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id s2so6095218plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 17:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lFbuQKLeAhpAAfgYiFKXrW7VWl8h2CMcWnPvP0ViZ/4=;
        b=uxUBtVmrMtQ5jQorGj0gobnzg71+HD0mvLX7WlgSaDnuvVEeLunog/VsCzRw2GLLuC
         RAyAYHLdpm/w/csWMtw19quePNvzc4rDWkjjgNtxqBIeR7EUde2mFAV9GYDJo8Dl12PI
         CPVQFapQV7PVZQrahrPmfUu3vtUhd2ypQ+BZXbsrdMBz4AYN8zH9GLW97c5ghobIpJBO
         VexuUo5wWJ8vtOVq4TY2X7qsH0mR9vJp7KpN/16f3NXaezsUiNDj7S2UBP+mbm0wRE2j
         zpVMJln0m4vuiW3JzmgxWsSvBWYYGrkuiSLAfdNwDHBINaFzWBZ0P83Z3gd2L4BBiE8j
         x9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lFbuQKLeAhpAAfgYiFKXrW7VWl8h2CMcWnPvP0ViZ/4=;
        b=P+fy9WbAxcNn2r8Rld6s7LOtMaDWfyaXKn5jJj+XtKFDE9idOtDp1RBIAG5nm75mbw
         z+bjPTgiZ7I1oM+qer9ZB5Vavydp00tOjpcar0TT6MeSTfB4oU1k76sFSuNszk40Si3M
         gljDU8bv27x37UKc5lF+2YsoGFx804e4A2Lq5Nro3vmgqBYZWH3UU+k3U+8acMJGEYWc
         rJ9L7a4EELvKZ89mTj2FinmGz6ulNEclwRBaqotZf30U46V8R3DAYbiKcGn2Cw6rlNu1
         Aw+aXFAEQDwByRlT8obxGsv/9u0I5x6vcJyuROhvdoDqnV5vIE+5qC74HkrsTj8SHYiC
         quqg==
X-Gm-Message-State: AOAM533R662tmlc5HZZlxQm8auGKC5F7FgZQQ4DOPRecW9gthqVK5OPN
        DjZFSBa5TjhJ1ZHZh8TlNLk=
X-Google-Smtp-Source: ABdhPJzKGVZDeflu26vkS5pCHroCNG0RjvHZTgh+6J2ah4TzDpxmXD1Dvm32CJnGbybS1z20Xbw14g==
X-Received: by 2002:a17:902:ac90:b029:da:fd0c:53ba with SMTP id h16-20020a170902ac90b02900dafd0c53bamr6110596plr.23.1607390382566;
        Mon, 07 Dec 2020 17:19:42 -0800 (PST)
Received: from DESKTOP-8REGVGF.localdomain ([124.13.157.5])
        by smtp.gmail.com with ESMTPSA id mj5sm472656pjb.20.2020.12.07.17.19.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Dec 2020 17:19:42 -0800 (PST)
Date:   Tue, 8 Dec 2020 09:19:38 +0800
From:   Sieng Piaw Liew <liew.s.piaw@gmail.com>
To:     Tudor.Ambarus@microchip.com
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: macronix: enable 4-bit BP support for
 MX25L6405D
Message-ID: <20201208011938.GB12175@DESKTOP-8REGVGF.localdomain>
References: <20201207024612.1318-1-liew.s.piaw@gmail.com>
 <cc1a8c52-6319-2d37-8df8-f6205bdbfb37@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc1a8c52-6319-2d37-8df8-f6205bdbfb37@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 05:53:20PM +0000, Tudor.Ambarus@microchip.com wrote:
> Hi, Sieng,
> 
> On 12/7/20 4:46 AM, Sieng Piaw Liew wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Enable 4-bit Block Protect support for MX256405D and its variants using
> > the same ID.
> > 
> > Tested on Innacom W3400V6 router with MX25L6406E chip.
> 
> :) What kind of tests did you exactly make?

OpenWrt cannot write into spi-nor after first boot.
After hacking 4-bit BP support into OpenWrt's kernel v5.4, writing works.

> 
> > https://github.com/openwrt/openwrt/pull/3501
> > 
> > Signed-off-by: Sieng Piaw Liew <liew.s.piaw@gmail.com>
> > ---
> >  drivers/mtd/spi-nor/macronix.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
> > index 9203abaac229..7aa8b1ee9daa 100644
> > --- a/drivers/mtd/spi-nor/macronix.c
> > +++ b/drivers/mtd/spi-nor/macronix.c
> > @@ -42,7 +42,8 @@ static const struct flash_info macronix_parts[] = {
> >         { "mx25l1606e",  INFO(0xc22015, 0, 64 * 1024,  32, SECT_4K) },
> >         { "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
> >         { "mx25l3255e",  INFO(0xc29e16, 0, 64 * 1024,  64, SECT_4K) },
> > -       { "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128, SECT_4K) },
> > +       { "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128,
> > +                             SECT_4K | SPI_NOR_4BIT_BP) },
> 
> I assume this won't work because it misses the SPI_NOR_HAS_LOCK flag.
> 
> Cheers,
> ta

Yes, I'll have v2 patch sent shortly.

> 
> >         { "mx25u2033e",  INFO(0xc22532, 0, 64 * 1024,   4, SECT_4K) },
> >         { "mx25u3235f",  INFO(0xc22536, 0, 64 * 1024,  64,
> >                               SECT_4K | SPI_NOR_DUAL_READ |
> > --
> > 2.17.1
> > 
> 
