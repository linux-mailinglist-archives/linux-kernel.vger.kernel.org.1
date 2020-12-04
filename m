Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDFB2CEC70
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387769AbgLDKpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:45:35 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:35499 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbgLDKpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:45:35 -0500
X-Originating-IP: 93.34.118.233
Received: from uno.localdomain (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4544E601C1;
        Fri,  4 Dec 2020 10:44:49 +0000 (UTC)
Date:   Fri, 4 Dec 2020 11:44:56 +0100
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: bcm2835: fix vchiq_mmal dependencies
Message-ID: <20201204104456.hhu76as6ruf5vmqq@uno.localdomain>
References: <20201203223836.1362313-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201203223836.1362313-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Dec 03, 2020 at 11:38:30PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When the MMAL code is built-in but the vchiq core config is
> set to =m, the mmal code never gets built, which in turn can
> lead to link errors:

My bad, I repetedly ignored the error report received from the 'kernel
test robot' about this. Thanks for fixing.

For my eduction, why would the vchiq-mmal code not get build if
vchiq-core is set to M ? I mean, that configuration is indeed wrong,
as vchiq-mmal uses symbols from vchiq-core and I would expect that to
fail when building the kernel image, not have the other modules (as
bcm2835-camera) fail as a consequence when building modules.

>
> ERROR: modpost: "vchiq_mmal_port_set_format" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
> ERROR: modpost: "vchiq_mmal_port_disable" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
> ERROR: modpost: "vchiq_mmal_port_parameter_set" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
> ERROR: modpost: "vchiq_mmal_component_finalise" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
> ERROR: modpost: "vchiq_mmal_port_connect_tunnel" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
> ERROR: modpost: "vchiq_mmal_component_enable" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
> ERROR: modpost: "vchiq_mmal_finalise" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
> ERROR: modpost: "vchiq_mmal_component_init" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
> ERROR: modpost: "vchiq_mmal_component_disable" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
> ERROR: modpost: "mmal_vchi_buffer_init" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
> ERROR: modpost: "vchiq_mmal_port_enable" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
> ERROR: modpost: "vchiq_mmal_version" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
> ERROR: modpost: "vchiq_mmal_submit_buffer" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
> ERROR: modpost: "vchiq_mmal_init" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
> ERROR: modpost: "mmal_vchi_buffer_cleanup" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
> ERROR: modpost: "vchiq_mmal_port_parameter_get" [drivers/staging/vc04_services/bcm2835-camera/bcm2835-v4l2.ko] undefined!
>
> Change the Kconfig to depend on BCM2835_VCHIQ like the other drivers,
> and remove the now redundant dependencies.
>
> Fixes: b18ee53ad297 ("staging: bcm2835: Break MMAL support out from camera")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jacopo Mondi <jacopo@jmondi.org>

If you noticed this from the same error notification I recevied it
might be fair to report:
Reported-by: kernel test robot <lkp@intel.com>

Thanks
   j

> ---
>  drivers/staging/vc04_services/vchiq-mmal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/vc04_services/vchiq-mmal/Kconfig b/drivers/staging/vc04_services/vchiq-mmal/Kconfig
> index 500c0d12e4ff..c99525a0bb45 100644
> --- a/drivers/staging/vc04_services/vchiq-mmal/Kconfig
> +++ b/drivers/staging/vc04_services/vchiq-mmal/Kconfig
> @@ -1,6 +1,6 @@
>  config BCM2835_VCHIQ_MMAL
>  	tristate "BCM2835 MMAL VCHIQ service"
> -	depends on (ARCH_BCM2835 || COMPILE_TEST)
> +	depends on BCM2835_VCHIQ
>  	help
>  	  Enables the MMAL API over VCHIQ interface as used for the
>  	  majority of the multimedia services on VideoCore.
> --
> 2.27.0
>
