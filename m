Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2652F1C14
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 18:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389305AbhAKRRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 12:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728677AbhAKRRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:17:35 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21878C061794;
        Mon, 11 Jan 2021 09:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=w77NvkyhVe01jYdKlHVfsoJZzz8kazo4ynUnMPEyO1U=; b=sGPkof8OnX0wbFnjD7Dt/HAFr6
        XLQuv6PhR2CaguRrKWu5gY+CnQ8iNdn2p0Bp/D4OfMQKumo9iDoQIZ8mTGu+MIWhAk0GeTah0UVaD
        Qac4vqDokPe23qcXljh40F59HlcABw8W1zPrwvtX0uiXtvOUgIkIuOw/VXoGGN9KN/0IVZAQO153Y
        pNtGyXcfzj0H794gItlfkz5P5JYfYGQeA/CxJn9gdsW23OSz8LIJwsAcBp6/dAMzirnCbywgQlHhd
        4tphxcLugS06JxJ7BZQkZmm8ju96tQ79WF4bsFft/57QDmd1Y2d7SIH07objEfpoJHDh4ycj/6BvE
        Ha3jAwdw==;
Received: from [2601:1c0:6280:3f0::79df]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kz0oG-0005DL-NT; Mon, 11 Jan 2021 17:16:53 +0000
Subject: Re: [PATCH] usb: cdnsp: fixes undefined reference to cdns_remove
To:     Pawel Laszczak <pawell@cadence.com>, peter.chen@nxp.com
Cc:     a-govindraju@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kurahul@cadence.com
References: <20210111144226.16372-1-pawell@cadence.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7aa22b3c-f56f-b215-2f84-348e24a48044@infradead.org>
Date:   Mon, 11 Jan 2021 09:16:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210111144226.16372-1-pawell@cadence.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/21 6:42 AM, Pawel Laszczak wrote:
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

Yep, that works. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


> ---
>  drivers/usb/cdns3/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> index 3f9b7fa8a594..be906910f98b 100644
> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -26,7 +26,11 @@ obj-$(CONFIG_USB_CDNS3_TI)			+= cdns3-ti.o
>  obj-$(CONFIG_USB_CDNS3_IMX)			+= cdns3-imx.o
>  
>  cdnsp-udc-pci-y					:= cdnsp-pci.o
> +ifeq ($(CONFIG_USB),m)
> +obj-m						+= cdnsp-udc-pci.o
> +else
>  obj-$(CONFIG_USB_CDNSP_PCI) 			+= cdnsp-udc-pci.o
> +endif
>  cdnsp-udc-pci-$(CONFIG_USB_CDNSP_GADGET)	+= cdnsp-ring.o cdnsp-gadget.o \
>  						   cdnsp-mem.o cdnsp-ep0.o
>  
> 


-- 
~Randy

