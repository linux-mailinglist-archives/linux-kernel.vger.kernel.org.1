Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CFF23417B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 10:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbgGaIsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 04:48:22 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:58752 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgGaIsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:48:22 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 24B66FB04;
        Fri, 31 Jul 2020 10:48:21 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OBDVOmHfYedR; Fri, 31 Jul 2020 10:48:20 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id ADBF44537D; Fri, 31 Jul 2020 10:48:19 +0200 (CEST)
Date:   Fri, 31 Jul 2020 10:48:19 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     linux-kernel@vger.kernel.org, l.stach@pengutronix.de,
        lukas@mntmn.com, dri-devel@lists.freedesktop.org, linux-imx@nxp.com
Subject: Re: [PATCH v9 4/5] MAINTAINERS: Add entry for i.MX 8MQ DCSS driver
Message-ID: <20200731084819.GB12560@bogon.m.sigxcpu.org>
References: <20200731081836.3048-1-laurentiu.palcu@oss.nxp.com>
 <20200731081836.3048-5-laurentiu.palcu@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200731081836.3048-5-laurentiu.palcu@oss.nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Fri, Jul 31, 2020 at 11:18:32AM +0300, Laurentiu Palcu wrote:
> From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> 
> The driver is part of DRM subsystem and is located in drivers/gpu/drm/imx/dcss.
> 
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>

Reviewed-by: Guido G�nther <agx@sigxcpu.org> 

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2c669c07fa35..1a22038f2869 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12281,6 +12281,14 @@ F:	drivers/iio/gyro/fxas21002c_core.c
>  F:	drivers/iio/gyro/fxas21002c_i2c.c
>  F:	drivers/iio/gyro/fxas21002c_spi.c
>  
> +NXP i.MX 8MQ DCSS DRIVER
> +M:	Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> +R:	Lucas Stach <l.stach@pengutronix.de>
> +L:	dri-devel@lists.freedesktop.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> +F:	drivers/gpu/drm/imx/dcss/
> +
>  NXP SGTL5000 DRIVER
>  M:	Fabio Estevam <festevam@gmail.com>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> -- 
> 2.23.0
> 
