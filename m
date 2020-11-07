Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0CB42AA237
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 03:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgKGChy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 21:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgKGChy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 21:37:54 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7220C0613CF;
        Fri,  6 Nov 2020 18:37:53 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id n15so3177177otl.8;
        Fri, 06 Nov 2020 18:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3iGGvZ4MOhZ9Vlb3IwkY6Xy1dzWVJpLQcmjoEo088I=;
        b=V4DdLwGMhkEQGYRwYrlkai78aeZjXDcojRbqOrPczv7GO+JwyDyfUcB/tdl1s3MKJI
         pS1dgMImw+ZMu5sWht5lsm/LIGA6kgq80PYGKJ394Pp3C3cFNbcjkQaB0HBmr+35T6Vq
         Okx0UTt+DzsQNkbAEyoEQi5g7d8WJMQRfNt1urkLLEvJ4/YC+Hb+V+1C3sOFJrAG38SA
         S0kzdCx4yROcJZwzWC36E01P3wEUl2/JHMsIrPX3BK/MhO6QEzzgUlcq6D6Hn5bL8bNi
         ot4Vdrws0CK34NZapwpCO79voikvSQ3fzRh1f04qcTA0g+dgqQw1rqEHWu1or/PBS592
         XL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3iGGvZ4MOhZ9Vlb3IwkY6Xy1dzWVJpLQcmjoEo088I=;
        b=MwXIOdfwFlVTOdIaOzVuvtlWV0pDvyPrbD3/PWy999Tp+wMq/O7YY46KfK9HDCBV7d
         kLfTbVKoHWvrCbztlnru9kA9daMlAJ07W87lAqcJJDlWVhPIxM0Rae/ICW+/u0W7zgTe
         GKu7mTtY1fm10l0xgAUJ0RI6sfVyh9lofgHyeWi/hSb7H8zg9A/3YeWhgA/Bcnxodw8A
         EwmQfQL8T2lrqdzuguibXjnTh5eEp9YZRzFnK3t375+jD9M0BK0gClSdWh3udjONM/mb
         L6BiuqgUiXrAhB09prB5LQ74AB6BgJtlhvhQUMlGld/Bx9GMO6Xbr1nmy6SSmux0WR83
         US7g==
X-Gm-Message-State: AOAM530JTQyQQCy+QmZr9udlFJp3MIkt6jnjdpVa3RD7pEsc3qazYhc3
        /xTgJmkg2bEbZ+epBV1uZlsdgmqyFcZZufGMdoAM+Tn9nc5XSA==
X-Google-Smtp-Source: ABdhPJyBiw9tpyYWFxlG3UROhYkatqalKMsTqX2rkPC1iOYy0agKpq0Odkbnj6qeoc1JZ+fczQvioNqOu2oUtHzOmHM=
X-Received: by 2002:a9d:6c94:: with SMTP id c20mr3269790otr.151.1604716672873;
 Fri, 06 Nov 2020 18:37:52 -0800 (PST)
MIME-Version: 1.0
References: <20200902181234.13955-1-lindsey.stanpoor@gmail.com>
In-Reply-To: <20200902181234.13955-1-lindsey.stanpoor@gmail.com>
From:   Lindsey Stanpoor <lindsey.stanpoor@gmail.com>
Date:   Fri, 6 Nov 2020 18:37:40 -0800
Message-ID: <CAEr9=gsH2UhjMO_55FKmGKS0DYrT_-XKf0iwCKCNc93epbiXNw@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: usb: add rk3328 dwc3 docs
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, heiko@sntech.de,
        balbi@kernel.org, cnemo@tutanota.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 11:12 AM <lindsey.stanpoor@gmail.com> wrote:
>
> From: Cameron Nemo <cnemo@tutanota.com>
>
> Document compatible for dwc3 on the Rockchip rk3328 platform.

Hi all,

Wanted to give this patch submission a gentle ping.

Rob Herring acked the documentation changes, but I have not heard
anything
from the USB or Rockchip maintainers. This patchset would facilitate USB3
support for Rockchip rk3328 devices like the Pine Rock64.

If there is anything I can do to help move this along, please let me know.

Thank you,
Cameron

>
> Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt          | 1 +
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.txt | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index d03edf9d3935..d625cd5966e9 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -25,6 +25,7 @@ Exception for clocks:
>      "ti,am437x-dwc3"
>      "ti,dwc3"
>      "ti,keystone-dwc3"
> +    "rockchip,rk3328-dwc3"
>      "rockchip,rk3399-dwc3"
>      "xlnx,zynqmp-dwc3"
>
> diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> index 94520493233b..b41f30a61be6 100644
> --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
> @@ -1,7 +1,8 @@
>  Rockchip SuperSpeed DWC3 USB SoC controller
>
>  Required properties:
> -- compatible:  should contain "rockchip,rk3399-dwc3" for rk3399 SoC
> +- compatible:  should contain "rockchip,rk3328-dwc3" for rk3328 SoC
> +               or "rockchip,rk3399-dwc3" for rk3399 SoC
>  - clocks:      A list of phandle + clock-specifier pairs for the
>                 clocks listed in clock-names
>  - clock-names: Should contain the following:
> --
> 2.28.0
>
