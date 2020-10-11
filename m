Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F142A28A7D0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 16:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbgJKOmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 10:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:35124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388019AbgJKOmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 10:42:40 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4AEC20774;
        Sun, 11 Oct 2020 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602427359;
        bh=lF4a1I9ZVW9Lg4QdRVkWBYpQaijCheE3u9HaK8JoALI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E9p/NYg9lKM4xP5m8vIyV0qi6AxEcrypQcTL4bCHZziIhYK67DvBVqVexpJjYctEV
         88NY8dH1wW6JS9vDkZKTC+Hr/Xu05srT+Ccg/DQ+M31i6LIbfQDELD3D2mgmbdAXXv
         SW5zaPFWHEGXoP7pNA3imErekvEOIzM/mKfOyFdg=
Date:   Sun, 11 Oct 2020 16:42:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Roger Quadros <rogerq@ti.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/18] dt-bindings: usb: usb-hcd: Add "wireless"
 maximum-speed property value
Message-ID: <20201011144236.GA271079@kroah.com>
References: <20201010224121.12672-1-Sergey.Semin@baikalelectronics.ru>
 <20201010224121.12672-3-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201010224121.12672-3-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 01:41:05AM +0300, Serge Semin wrote:
> It appears that the "maximum-speed" property can also accept the
> "wireless" value. Add it to the enumeration of the possible property
> values then.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> ---
>  Documentation/devicetree/bindings/usb/usb-hcd.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.yaml b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> index 815de24127db..e1a82a2b3295 100644
> --- a/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> +++ b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> @@ -28,7 +28,7 @@ properties:
>       isn't passed via DT, USB controllers should default to their maximum HW
>       capability.
>     $ref: /schemas/types.yaml#/definitions/string
> -   enum: ["low-speed", "full-speed", "high-speed", "super-speed",
> +   enum: ["low-speed", "full-speed", "high-speed", "wireless", "super-speed",
>            "super-speed-plus"]

Are you sure?  wireless usb has been removed from the kernel, where do
you see a user of this?  If it's still in there, we need to just drop
it.

thanks,

greg k-h
