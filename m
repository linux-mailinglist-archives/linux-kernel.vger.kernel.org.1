Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF033027C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbhAYQZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:25:46 -0500
Received: from netrider.rowland.org ([192.131.102.5]:56689 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730702AbhAYQXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:23:12 -0500
Received: (qmail 147065 invoked by uid 1000); 25 Jan 2021 11:22:30 -0500
Date:   Mon, 25 Jan 2021 11:22:30 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: ehci-tegra: fix Kconfig depencies
Message-ID: <20210125162230.GA145777@rowland.harvard.edu>
References: <20210125113248.2268952-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125113248.2268952-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 12:32:30PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Selecting the chipidea driver from the old Kconfig symbol
> can lead to a missing dependency:

Arnd:

I found this whole patch a little confusing.  For example, in the 
sentence above, what does "the old Kconfig symbol" refer to?

Comparing the various Kconfig files, I see what the problem is.  The 
commit which this one fixes made CONFIG_EHCI_TEGRA select 
CONFIG_USB_CHIPIDEA, but it didn't make EHCI_TEGRA depend on the things 
that USB_CHIPIDEA depends on.  Can you please state this more explicitly 
in the patch description?

> WARNING: unmet direct dependencies detected for USB_CHIPIDEA
>   Depends on [m]: USB_SUPPORT [=y] && (USB_EHCI_HCD [=y] && USB_GADGET [=m] || USB_EHCI_HCD [=y] && !USB_GADGET [=m] || !USB_EHCI_HCD [=y] && USB_GADGET [=m]) && HAS_DMA [=y]
>   Selected by [y]:
>   - USB_EHCI_TEGRA [=y] && USB_SUPPORT [=y] && USB [=y] && USB_EHCI_HCD [=y] && ARCH_TEGRA [=y]
> aarch64-linux-ld: drivers/usb/chipidea/otg.o: in function `ci_handle_vbus_change':
> otg.c:(.text+0x3c8): undefined reference to `usb_gadget_vbus_connect'
> aarch64-linux-ld: otg.c:(.text+0x42c): undefined reference to `usb_gadget_vbus_disconnect'
> aarch64-linux-ld: drivers/usb/chipidea/otg.o: in function `ci_otg_work':
> otg.c:(.text+0x5d4): undefined reference to `usb_gadget_vbus_disconnect'
> ...
> 
> Duplicate the dependency to ensure that this driver can
> only be a loadable module if one of its dependencies is.
> 
> Fixes: c3590c7656fb ("usb: host: ehci-tegra: Remove the driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/host/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 160e5d3927e2..66b01b619ecd 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -269,6 +269,7 @@ config USB_EHCI_HCD_AT91
>  config USB_EHCI_TEGRA
>  	tristate "NVIDIA Tegra HCD support"
>  	depends on ARCH_TEGRA
> +	depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
>  	select USB_CHIPIDEA
>  	select USB_CHIPIDEA_HOST
>  	select USB_CHIPIDEA_TEGRA

Isn't there at least one other missing dependency?  This entry selects 
USB_CHIPIDEA_TEGRA, which depends on OF.  So shouldn't this entry also 
depend on OF?  Or does the Kconfig system detect that for us?

Also, while I'm no expert on the Kconfig language, it seems that the new 
"depends" line could be a lot easier to understand if it was refactored 
with some comments added.  Yes, I realize you just copied the existing 
dependency from the USB_CHIPIDEA entry -- that one could stand to be 
cleaned up as well.

For instance, how about putting the HAS_DMA part into a separate line, 
since it's unrelated to the other stuff?  And the rest looks like it 
could be changed to:

	depends on USB_EHCI_HCD || USB_GADGET

although that probably isn't quite valid.  Still, can't it be changed to 
something simpler than

	(USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD && !USB_GADGET) ||
			(!USB_EHCI_HCD && USB_GADGET)

?

Alan Stern
