Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877192A3F75
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgKCI41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbgKCI4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:56:25 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79077C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 00:56:24 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v5so11880274wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 00:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rLDVs90HA1Aa+VugGzlqO4fLN0akysT9yEHAzoqJBD4=;
        b=SZQ67zdvLAgNLnEVBHfuSAHpiveEkSKRczKIGbpt3wBrWTve25M0Eh/H0+UqKG042b
         qSWODOktAM/IYQR9xNOtbV/xSzCknBirpktpfU7EM4M7uJRfgQjft4sXp0TOwqm3lkwz
         EcWHTsqfTrddlouXjbF/5+2aSePLpTDgNfOm0Hw+yO9x/yH+FasQ6DJzabfRqN/8k0nK
         hpRWiaqzaJUXtAoRrc3vi87SQtQveoQM/ihh8QI8TWmbCFzEmjvT7A8VWTmTCrhqs+h0
         zySHsWdRiD+vfWP6Wl8pYmI5xeSMkUEnvbKrVh2eSWZ1Mbr5KWUQURH0G8OWE18oRIKg
         8Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rLDVs90HA1Aa+VugGzlqO4fLN0akysT9yEHAzoqJBD4=;
        b=RIhCRWiaqcM0FsrAMdhb7KbblXjGWQCc+YvKTLr9EYa291plZC2+3qEo742aeosfdJ
         kxbdGcPGn/OfCPShHB5ZalwxB+uXNiqrhs15mgTOSZFqfFwWFQjgkwhhz0lQe8XsWjRE
         BzsnY38VXe0+6Ph1rhnTs0z7DVugR6ufEINd6eUfuA/xPA1+Tbi6XixoUlZQPa2sqfFR
         XgglsrkR6nq8tegm3vwnte7ETJ/NWE8CrQ9KaVACmWDpmlW4yP5Z0nApn8zs6yC1PE3K
         mDBeEeEkbb6g036ca107/N91gUWA2yOdmvIYa/XjQUgJXwqJjtV0kSiwuKrp4UPwNEa2
         PiMw==
X-Gm-Message-State: AOAM530NB+ugCFO75RuSdC5OpKgegCOnSLbfyEo0PDLrNv/IGVqfma10
        BdBhO4T6Z1uAFssHwIh7ZrjYfw==
X-Google-Smtp-Source: ABdhPJwJNIYTW9tTc+Ezdxe0aES7lJBJWFwUM1pZ4XapbFkcE4vbG0IUDESF5nCL8gmLDVjDSEHgSQ==
X-Received: by 2002:a1c:2d8f:: with SMTP id t137mr2344738wmt.26.1604393783224;
        Tue, 03 Nov 2020 00:56:23 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id u195sm2235969wmu.18.2020.11.03.00.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 00:56:22 -0800 (PST)
Date:   Tue, 3 Nov 2020 08:56:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Codrin.Ciubotariu@microchip.com
Cc:     Nicolas.Ferre@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        richard.genoud@gmail.com, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com
Subject: Re: [PATCH] ARM: dts: at91: add serial MFD sub-node for usart
Message-ID: <20201103085620.GM4488@dell>
References: <20201030110702.886638-1-codrin.ciubotariu@microchip.com>
 <b054ce5c-58fd-dd86-2cb6-1e1f06a0899e@microchip.com>
 <20201102090122.GF4127@dell>
 <780303c7-2c32-f2e1-c9ce-1e2ee6bf0533@microchip.com>
 <20201102122952.GB4488@dell>
 <e2b038f0-81ea-3d2f-cb06-dd02f0b84860@microchip.com>
 <9f99dcf1-239d-b3b3-4b7d-e6d628bb3fed@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f99dcf1-239d-b3b3-4b7d-e6d628bb3fed@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Nov 2020, Codrin.Ciubotariu@microchip.com wrote:

> On 02.11.2020 14:55, Codrin.Ciubotariu@microchip.com wrote:
> > On 02.11.2020 14:29, Lee Jones wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>
> >> On Mon, 02 Nov 2020, Codrin.Ciubotariu@microchip.com wrote:
> >>
> >>> On 02.11.2020 11:01, Lee Jones wrote:
> >>>> On Fri, 30 Oct 2020, Nicolas Ferre wrote:
> >>>>
> >>>>> On 30/10/2020 at 12:07, Codrin Ciubotariu wrote:
> >>>>>> The "atmel,at91sam9260-usart" driver is a MFD driver, so it needs sub-nodes
> >>>>>> to match the registered platform device. For this reason, we add a serial
> >>>>>> subnode to all the "atmel,at91sam9260-usart" serial compatible nods. This
> >>>>>> will also remove the boot warning:
> >>>>>> "atmel_usart_serial: Failed to locate of_node [id: -2]"
> >>>>>
> >>>>> I don't remember this warning was raised previously even if the MFD driver
> >>>>> was added a while ago (Sept. 2018).
> >>>>>
> >>>>> I would say it's due to 466a62d7642f ("mfd: core: Make a best effort attempt
> >>>>> to match devices with the correct of_nodes") which was added on mid August
> >>>>> and corrected with 22380b65dc70 ("mfd: mfd-core: Ensure disabled devices are
> >>>>> ignored without error") but maybe not covering our case.
> >>>>>
> >>>>> So, well, I don't know what's the best option to this change. Moreover, I
> >>>>> would say that all other USART related properties go into the child not if
> >>>>> there is a need for one.
> >>>>>
> >>>>> Lee, I suspect that we're not the only ones experiencing this ugly warning
> >>>>> during the boot log: can you point us out how to deal with it for our
> >>>>> existing atmel_serial.c users?
> >>>>
> >>>> You should not be instantiating drivers through Device Tree which are
> >>>> not described there.  If the correct representation of the H/W already
> >>>> exists in Device Tree i.e. no SPI and UART IP really exists, use the
> >>>> MFD core API to register them utilising the platform API instead.
> >>>>
> >>>> This should do it:
> >>>>
> >>>> diff --git a/drivers/mfd/at91-usart.c b/drivers/mfd/at91-usart.c
> >>>> index 6a8351a4588e2..939bd2332a4f6 100644
> >>>> --- a/drivers/mfd/at91-usart.c
> >>>> +++ b/drivers/mfd/at91-usart.c
> >>>> @@ -17,12 +17,10 @@
> >>>>
> >>>>     static const struct mfd_cell at91_usart_spi_subdev = {
> >>>>            .name = "at91_usart_spi",
> >>>> -       .of_compatible = "microchip,at91sam9g45-usart-spi",
> >>>>     };
> >>>>
> >>>>     static const struct mfd_cell at91_usart_serial_subdev = {
> >>>>            .name = "atmel_usart_serial",
> >>>> -       .of_compatible = "atmel,at91rm9200-usart-serial",
> >>>>     };
> >>>>
> >>>>     static int at91_usart_mode_probe(struct platform_device *pdev)
> >>>
> >>> [snip]
> >>>
> >>> Hi Lee, thank you for looking through our usart driver and for sharing
> >>> your thoughts. Removing the usage of compatible string means that for
> >>> similar serial/SPI IPs we would need to create new platform drivers.
> >>
> >> Why would you need to do that?
> > 
> > In the case we will have to support another similar IP, but with a
> > different set of features. Not a new platform driver from scratch, but
> > at least a new struct platform_driver for each variant.
> 
> I guess we could use struct mfd_cell.platform_data to select the 
> features for the serial/SPI. This platform data can be per compatible of 
> our MFD driver. I will send a patch with the changes you suggested. 

Yes, that is what platform data is for.

> Thank you!

NP.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
