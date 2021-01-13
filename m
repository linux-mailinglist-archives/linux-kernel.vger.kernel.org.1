Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4C72F5180
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbhAMRxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbhAMRxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:53:23 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B396FC061575;
        Wed, 13 Jan 2021 09:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=g97u/LLEJ1YBimCAOlC5uc788cogRUnQO844OVvNDss=; b=DgcoOLZPgBiUJLGzw/INrHwqey
        FzdDNVSIqBba3vN4w8qyAJW9DLvDxUhEq37VKYLT204nN3wJyaLQSERzaKqvNe+KNWwMrp6tRyaBA
        vpbbdDM2fgvWaOKCmVjqNAb/PiGgHCto6g10V8SNB4n0zG0gmvXQ98ISX3LAbQ67NHcGYe6eco8Kd
        +LR0dDs/lHsS+yXsyArrxlmRIoBI+GCc0ZXIcRzvUNS6ahtyKhglNmQInd1MjtT9MGTbR/WTr/ljX
        sG8Wn2EHzd8Hu3DESlkmJ4TZXNzACBy91rgACGfq0aBoxBaUtVI8HFMohJZogCMrSAUOVgI8cethe
        q5myGCPA==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kzkJy-0005q0-2j; Wed, 13 Jan 2021 17:52:38 +0000
Subject: Re: [PATCH v2] usb: cdnsp: fixes undefined reference to cdns_remove
To:     Pawel Laszczak <pawell@cadence.com>, peter.chen@nxp.com
Cc:     a-govindraju@ti.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kurahul@cadence.com, geert@linux-m68k.org
References: <20210113141407.25473-1-pawell@cadence.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <13f338f1-9ba9-c848-0b75-10e73e8c6a7d@infradead.org>
Date:   Wed, 13 Jan 2021 09:52:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210113141407.25473-1-pawell@cadence.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/21 6:14 AM, Pawel Laszczak wrote:
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

After removing the v1 patch and applying this one, my build errors are gone.
Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> changelog:
> v2
> - added missing condition
> 
>  drivers/usb/cdns3/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> index 3f9b7fa8a594..61edb2f89276 100644
> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -26,7 +26,15 @@ obj-$(CONFIG_USB_CDNS3_TI)			+= cdns3-ti.o
>  obj-$(CONFIG_USB_CDNS3_IMX)			+= cdns3-imx.o
>  
>  cdnsp-udc-pci-y					:= cdnsp-pci.o
> +
> +ifdef CONFIG_USB_CDNSP_PCI
> +ifeq ($(CONFIG_USB),m)
> +obj-m						+= cdnsp-udc-pci.o
> +else
>  obj-$(CONFIG_USB_CDNSP_PCI) 			+= cdnsp-udc-pci.o
> +endif
> +endif
> +
>  cdnsp-udc-pci-$(CONFIG_USB_CDNSP_GADGET)	+= cdnsp-ring.o cdnsp-gadget.o \
>  						   cdnsp-mem.o cdnsp-ep0.o
>  
> 


-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
