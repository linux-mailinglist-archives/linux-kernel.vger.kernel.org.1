Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7032DC48A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 17:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgLPQpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 11:45:53 -0500
Received: from netrider.rowland.org ([192.131.102.5]:43887 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726772AbgLPQpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:45:52 -0500
Received: (qmail 241407 invoked by uid 1000); 16 Dec 2020 11:45:11 -0500
Date:   Wed, 16 Dec 2020 11:45:11 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/8] usb: host: ehci-tegra: Remove the driver
Message-ID: <20201216164511.GB238371@rowland.harvard.edu>
References: <20201215202113.30394-1-digetx@gmail.com>
 <20201215202113.30394-8-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215202113.30394-8-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 11:21:12PM +0300, Dmitry Osipenko wrote:
> The ChipIdea driver now provides USB2 host mode support for NVIDIA Tegra
> SoCs. The ehci-tegra driver is obsolete now, remove it.
> 
> Tested-by: Matt Merhar <mattmerhar@protonmail.com>
> Tested-by: Nicolas Chauvet <kwizart@gmail.com>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/usb/host/Kconfig      |   9 -
>  drivers/usb/host/Makefile     |   1 -
>  drivers/usb/host/ehci-tegra.c | 604 ----------------------------------
>  3 files changed, 614 deletions(-)
>  delete mode 100644 drivers/usb/host/ehci-tegra.c
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 31e59309da1f..9c9e6ff9c43a 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -266,15 +266,6 @@ config USB_EHCI_HCD_AT91
>  	  Enables support for the on-chip EHCI controller on
>  	  Atmel chips.
>  
> -config USB_EHCI_TEGRA
> -	tristate "NVIDIA Tegra HCD support"
> -	depends on ARCH_TEGRA
> -	select USB_EHCI_ROOT_HUB_TT
> -	select USB_TEGRA_PHY
> -	help
> -	  This driver enables support for the internal USB Host Controllers
> -	  found in NVIDIA Tegra SoCs. The controllers are EHCI compliant.

For people upgrading from earlier kernel versions, do you think it
would help to add a pointer here telling them which Kconfig option
they need to enable now in order to get this functionality?

Alan Stern
