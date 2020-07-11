Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1744A21C472
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 15:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgGKNkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 09:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbgGKNkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 09:40:19 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 697B720725;
        Sat, 11 Jul 2020 13:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594474819;
        bh=Nb+UnQWtb7OEOzFqoOtTG1iHkJ3S/FvVJ+QwmaPPR9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qfvqAXJQXxfuhNcpB8FrsLx3l7676+lCpBc5R7erWeDfvgduXsdK+7zKwNnzRqKu6
         C6xyPR3XFqOpFT0zg7e73L6HKu2KvJPIAkgcs5NmmUbYBsOe80i9NwroWJ6/wgDeYM
         3k7LIggAPo+s9cN0TtFpsY2jPZkNIkAm26xX7o94=
Date:   Sat, 11 Jul 2020 21:40:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, kernel@puri.sm, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        mchehab@kernel.org, Anson.Huang@nxp.com, agx@sigxcpu.org,
        angus@akkea.ca, broonie@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] MAINTAINERS: Add Purism Librem 5 section to the
 list
Message-ID: <20200711134010.GD21277@dragon>
References: <20200617073821.16737-1-martin.kepplinger@puri.sm>
 <20200617073821.16737-2-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617073821.16737-2-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 09:38:21AM +0200, Martin Kepplinger wrote:
> Add development information for the devicetree files for hardware
> by Purism SPC.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b045b70e54df..0f6f18c477db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13881,6 +13881,13 @@ T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/admin-guide/media/pulse8-cec.rst
>  F:	drivers/media/cec/usb/pulse8/
>  
> +PURISM LIBREM 5
> +M:	Purism Kernel Team <kernel@puri.sm>
> +S:	Supported
> +B:	https://source.puri.sm/Librem5/linux-next/issues
> +T:	https://source.puri.sm/Librem5/linux-next
> +F:	arch/arm64/boot/dts/freescale/imx8mq-librem5*
> +

We do not generally patch MAINTAINERS for every single board.  Do you
really want it?

Shawn

>  PVRUSB2 VIDEO4LINUX DRIVER
>  M:	Mike Isely <isely@pobox.com>
>  L:	pvrusb2@isely.net	(subscribers-only)
> -- 
> 2.20.1
> 
