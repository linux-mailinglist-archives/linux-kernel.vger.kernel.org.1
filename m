Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B892F29D3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbhALIQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:16:25 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:44543 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbhALIQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:16:24 -0500
Received: by mail-oo1-f51.google.com with SMTP id j21so392408oou.11;
        Tue, 12 Jan 2021 00:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Nhlg5QFisRejoMRT0fRkCjf1tfZAoZTP+NYQ9XWWTI=;
        b=n/vfu7mlx5LWqfvBki9+vJ2b/NmCqGongVh/fDH443fhh5J8icdO69uODNDA53IDbW
         f69I3EVr0igS7Vd8ATCaJ4BV3ZCgtuF8q9DRyV4bFytwXXhjWTCfpFIvjdDI4w5yqZz/
         6HrDKMFt3QaKjXMWJkm14QQPoqX3Bf1epaesSoMrn8KOZlElNjSOA4XjIneYJaTTochC
         +4m/FVckKVLdOyZDf05kcHYyipWmaXCgX6VKEunwFYbO519VZ105IMcZ6ws3rXtTy2sU
         OXQDrts8X2hr6lVkZYm19vqP2o0iVJ7Q5CNkQ7FpEpWXbb4SbZ8mwzakG9ESBcvgmLZa
         HvQg==
X-Gm-Message-State: AOAM530lRzP4EF5Q8Yvu5MJZpFQ8GTlPEj5P+zEOiIY/M4F6/vfr2SeJ
        F2RvigPjVlWM7QRrYZgDhHIraHCZrjo8tnntaUDnLluC4EA=
X-Google-Smtp-Source: ABdhPJzhw0U1zIBEQrFXqk95oraRyz21olHqiCGRIYe8zn+mcG0n6joZw4PcgZ2qh7iXazilL7snXv87+Ko+tcclmaw=
X-Received: by 2002:a4a:c191:: with SMTP id w17mr2117914oop.1.1610439343492;
 Tue, 12 Jan 2021 00:15:43 -0800 (PST)
MIME-Version: 1.0
References: <20210111144226.16372-1-pawell@cadence.com>
In-Reply-To: <20210111144226.16372-1-pawell@cadence.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jan 2021 09:15:32 +0100
Message-ID: <CAMuHMdXQE+eFV51HdLHF7QfN-A2qXSKZsP6ofZzvOwNZ_N2jHQ@mail.gmail.com>
Subject: Re: [PATCH] usb: cdnsp: fixes undefined reference to cdns_remove
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     Peter Chen <peter.chen@nxp.com>,
        Randy Dunlap <rdunlap@infradead.org>, a-govindraju@ti.com,
        Greg KH <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kurahul@cadence.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

On Tue, Jan 12, 2021 at 8:17 AM Pawel Laszczak <pawell@cadence.com> wrote:
> Patch fixes the following errors:
> ld: drivers/usb/cdns3/cdnsp-pci.o: in function `cdnsp_pci_remove':
> cdnsp-pci.c:(.text+0x80): undefined reference to `cdns_remove'
> ld: drivers/usb/cdns3/cdnsp-pci.o: in function `cdnsp_pci_probe':
> cdnsp-pci.c:(.text+0x34c): undefined reference to `cdns_init'
>
> Issue occurs for USB/CDNS3/CDNSP kernel configuration:
> CONFIG_USB=m
> CONFIG_USB_CDNS_SUPPORT=y
> CONFIG_USB_CDNS3=m
> CONFIG_USB_CDNS3_PCI_WRAP=m
> CONFIG_USB_CDNSP_PCI=y
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Thanks for your patch!

noreply@ellerman.id.au reports for m68k-allmodconfig:

drivers/usb/cdns3/cdnsp-pci.c:92:6: error: implicit declaration of
function 'pci_is_enabled'; did you mean 'pci_acs_enabled'?
[-Werror=implicit-function-declaration]
drivers/usb/cdns3/cdnsp-pci.c:166:6: error: implicit declaration of
function 'pci_dev_run_wake'; did you mean 'pci_enable_wake'?
[-Werror=implicit-function-declaration]
drivers/usb/cdns3/cdnsp-pci.c:248:1: error: type defaults to 'int' in
declaration of 'module_pci_driver' [-Werror=implicit-int]

> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -26,7 +26,11 @@ obj-$(CONFIG_USB_CDNS3_TI)                   += cdns3-ti.o
>  obj-$(CONFIG_USB_CDNS3_IMX)                    += cdns3-imx.o
>
>  cdnsp-udc-pci-y                                        := cdnsp-pci.o
> +ifeq ($(CONFIG_USB),m)
> +obj-m                                          += cdnsp-udc-pci.o

This includes cdnsp-udc-pci.o even if CONFIG_USB_CDNSP_PCI=n,
causing the aforementioned build failure.

> +else
>  obj-$(CONFIG_USB_CDNSP_PCI)                    += cdnsp-udc-pci.o
> +endif
>  cdnsp-udc-pci-$(CONFIG_USB_CDNSP_GADGET)       += cdnsp-ring.o cdnsp-gadget.o \
>                                                    cdnsp-mem.o cdnsp-ep0.o
>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
