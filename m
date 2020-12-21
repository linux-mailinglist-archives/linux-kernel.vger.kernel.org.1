Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7F42E0101
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 20:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgLUT36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 14:29:58 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:34825 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgLUT35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 14:29:57 -0500
Received: by mail-ot1-f51.google.com with SMTP id i6so9866308otr.2;
        Mon, 21 Dec 2020 11:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M1MxrPIQn2j84Hy9VX0ZfS3TWh8t1dtQ7AGoSL/X1GM=;
        b=t1yGlnpLDY19kQT4KFsWZQpPYQm6xVxmN//yokxcezWQc+ToEkgJEQAXYFoTfvTM8/
         oGj3/gvIGo/pWVcnV9Jj7+BOIKXWXfS+4/4XDjN4mYxA0IKMD1a48sjEX/whwXcBhxJj
         QHi1vWQMzElS6w3E4lqUh1GHK5g69sRnTffVFRNU3e5tFp+LWEy32SHbfO/mkoZUb8aR
         r4EwIMM2S2zJX2VzpRy4GRflcxmENQOtNiZXGTN7TyCIiMODxDz0l7yQdVpvqSzHGbIc
         QfjVo8izBFq8g0Y/TbJB6ybyPWrAMoU2EHc1+Y8P9RISpHPhOJ2YIibiojeOQeVdKUmY
         VUtQ==
X-Gm-Message-State: AOAM531RXoWnfwRZmxbNaj8CpGVompZQKrCSjkeeZ2KzaC4xK6u91ns1
        0HRT+bQ+4TE4JFaSxzb9zw==
X-Google-Smtp-Source: ABdhPJw47d1FoUkv7savdsGWx47OEshyMKCpowzXUs9f12OxLeVSkNOEAHPrCHH9GkcIRCtcQXgHvw==
X-Received: by 2002:a05:6830:1c3d:: with SMTP id f29mr13151677ote.47.1608578956645;
        Mon, 21 Dec 2020 11:29:16 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s24sm549274oij.20.2020.12.21.11.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 11:29:15 -0800 (PST)
Received: (nullmailer pid 409990 invoked by uid 1000);
        Mon, 21 Dec 2020 19:29:13 -0000
Date:   Mon, 21 Dec 2020 12:29:13 -0700
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>,
        Ikjoon Jang <ikjn@chromium.org>
Subject: Re: [PATCH 1/3] dt-bindings: usb: mtk-xhci: add a new property for
 broken streams
Message-ID: <20201221192913.GA407645@robh.at.kernel.org>
References: <20201216115125.5886-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216115125.5886-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 07:51:23PM +0800, Chunfeng Yun wrote:
> The 0.96 xHCI controller on some platforms does not support
> bulk stream even HCCPARAMS says supporting, due to MaxPSASize
> is set a non-zero default value by mistake, so add a new
> property "mediatek,broken_streams_quirk" to fix it.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> this patch depends on:
>   https://patchwork.kernel.org/project/linux-mediatek/list/?series=402773
>   [v4,09/11] dt-bindings: usb: convert mediatek, mtk-xhci.txt to YAML schema
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> index e5e03f902802..330f7294bf34 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> @@ -120,6 +120,11 @@ properties:
>      description: The mask to disable u3ports, bit0 for u3port0,
>        bit1 for u3port1, ... etc
>  
> +  mediatek,broken_streams_quirk:

You should imply this from the compatible property.

(Also, don't use '_' in property names).

> +    description: set if the controller doesn't support bulk stream but
> +      HCCPARAMS says support.
> +    type: boolean
> +
>    "#address-cells":
>      const: 1
>  
> -- 
> 2.18.0
