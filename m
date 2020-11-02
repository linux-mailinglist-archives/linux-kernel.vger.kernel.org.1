Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787152A2AB3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgKBM34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgKBM34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:29:56 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19D7C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 04:29:55 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c18so9211380wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 04:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4ILeNdi6oZHwCJ6iUbV3quJceEqtA1JSpxIiTg6qDXc=;
        b=G1YSAkrhaSYGxB3ZzXLFbutEnLIugxjFS/MnHvwogKJ/2z9t6lYistGV8bYmpqP6tr
         bblR8mBLvTeJ1fhCVf6rwZPdXoxj0ggzYVdS/Boub9l/Km3XhxqMjTeRGteaeIHEtb3y
         5jgrMQkRG7MiScwoe8GTo5azdVwCfrm8jFEXmgReGPv3Ml7rzoBYDu36ZD8wM0NkUniP
         4DiPp1ycgkolSM8Mkibl4pMVti5RxZN+FpPQgCUCmECtLqib47VmUFugMi+22C6rHGuj
         a3IDhz7wmWyxQVj7oDiyBIav9n4OAS+RiRevgZv23EvNPhBofheeruXXF74Sp8fz0+ri
         aj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4ILeNdi6oZHwCJ6iUbV3quJceEqtA1JSpxIiTg6qDXc=;
        b=YM43UQAr5n8UywHAjLbrlc8GqQwLcZ/Xvcap43zLlEcy995PfJFdZ3pmo2BPMkAaqt
         +NTePfFEpM73au0bqypCT4cLlQ9WGKLf8/diwQrdHL4eTuz1j6REigTMnQLrXz7zb0Or
         8nObqzqLD790XkdzH5wYzneCmKtSivxQabfNUBUpku44NE3ZNwFshmzkzzKli5FoW8R5
         OIl0bjZOrorKzY6X3HrdZ8H+ZZJlrW7XIRFharQcSGw2J1nEX9iJJtqFJ0WorPUArAdu
         7rATnatiQ8IFH/3v5GQOD8x5SdHXFS7e01PHNpSR0ZsLZqoVjRy1AjxBudZloycYdFmN
         8ZzQ==
X-Gm-Message-State: AOAM5328B5ZBZ2scrlOVm3DqSJoHC9+faUKxTBih+J1fKyEnKefh240Y
        DlYExwc2btfs/UzxTp7EUJUoFQ==
X-Google-Smtp-Source: ABdhPJwUIfYXvZE9GcYuAEbLNWA2EEvj2uHM3TWkdRQSTGZfJMk9FgilHnSAFA8PxIJijlcW1NsSSw==
X-Received: by 2002:a7b:c015:: with SMTP id c21mr17247812wmb.22.1604320194705;
        Mon, 02 Nov 2020 04:29:54 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id p13sm21671382wrt.73.2020.11.02.04.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 04:29:54 -0800 (PST)
Date:   Mon, 2 Nov 2020 12:29:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Codrin.Ciubotariu@microchip.com
Cc:     Nicolas.Ferre@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        richard.genoud@gmail.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com
Subject: Re: [PATCH] ARM: dts: at91: add serial MFD sub-node for usart
Message-ID: <20201102122952.GB4488@dell>
References: <20201030110702.886638-1-codrin.ciubotariu@microchip.com>
 <b054ce5c-58fd-dd86-2cb6-1e1f06a0899e@microchip.com>
 <20201102090122.GF4127@dell>
 <780303c7-2c32-f2e1-c9ce-1e2ee6bf0533@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <780303c7-2c32-f2e1-c9ce-1e2ee6bf0533@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020, Codrin.Ciubotariu@microchip.com wrote:

> On 02.11.2020 11:01, Lee Jones wrote:
> > On Fri, 30 Oct 2020, Nicolas Ferre wrote:
> > 
> >> On 30/10/2020 at 12:07, Codrin Ciubotariu wrote:
> >>> The "atmel,at91sam9260-usart" driver is a MFD driver, so it needs sub-nodes
> >>> to match the registered platform device. For this reason, we add a serial
> >>> subnode to all the "atmel,at91sam9260-usart" serial compatible nods. This
> >>> will also remove the boot warning:
> >>> "atmel_usart_serial: Failed to locate of_node [id: -2]"
> >>
> >> I don't remember this warning was raised previously even if the MFD driver
> >> was added a while ago (Sept. 2018).
> >>
> >> I would say it's due to 466a62d7642f ("mfd: core: Make a best effort attempt
> >> to match devices with the correct of_nodes") which was added on mid August
> >> and corrected with 22380b65dc70 ("mfd: mfd-core: Ensure disabled devices are
> >> ignored without error") but maybe not covering our case.
> >>
> >> So, well, I don't know what's the best option to this change. Moreover, I
> >> would say that all other USART related properties go into the child not if
> >> there is a need for one.
> >>
> >> Lee, I suspect that we're not the only ones experiencing this ugly warning
> >> during the boot log: can you point us out how to deal with it for our
> >> existing atmel_serial.c users?
> > 
> > You should not be instantiating drivers through Device Tree which are
> > not described there.  If the correct representation of the H/W already
> > exists in Device Tree i.e. no SPI and UART IP really exists, use the
> > MFD core API to register them utilising the platform API instead.
> > 
> > This should do it:
> > 
> > diff --git a/drivers/mfd/at91-usart.c b/drivers/mfd/at91-usart.c
> > index 6a8351a4588e2..939bd2332a4f6 100644
> > --- a/drivers/mfd/at91-usart.c
> > +++ b/drivers/mfd/at91-usart.c
> > @@ -17,12 +17,10 @@
> > 
> >   static const struct mfd_cell at91_usart_spi_subdev = {
> >          .name = "at91_usart_spi",
> > -       .of_compatible = "microchip,at91sam9g45-usart-spi",
> >   };
> > 
> >   static const struct mfd_cell at91_usart_serial_subdev = {
> >          .name = "atmel_usart_serial",
> > -       .of_compatible = "atmel,at91rm9200-usart-serial",
> >   };
> > 
> >   static int at91_usart_mode_probe(struct platform_device *pdev)
> 
> [snip]
> 
> Hi Lee, thank you for looking through our usart driver and for sharing 
> your thoughts. Removing the usage of compatible string means that for 
> similar serial/SPI IPs we would need to create new platform drivers. 

Why would you need to do that?

> This is not ideal, but it's a solution. What I proposed is more 
> flexible, but, as you pointed out, I am not sure it correctly describes 
> the HW, because the decision of whether to use this IP as a serial or a 
> SPI is a configurable one.
> 
> Thanks and best regards,
> Codrin

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
