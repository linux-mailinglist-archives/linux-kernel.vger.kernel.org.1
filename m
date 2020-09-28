Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A6D27B426
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgI1SMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:12:49 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38361 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgI1SMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:12:49 -0400
Received: by mail-ot1-f66.google.com with SMTP id y5so1867943otg.5;
        Mon, 28 Sep 2020 11:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/PtsW+8x2QZLtcNsrjnLIk2PYfpyw6cjz6HIC4oDjYI=;
        b=SR+Loz/9Y3EVx0YuyMAZztVVUmCt+5ctVfHmHgQWdyk6wiD0Uh/FieJ+MVcrpXsSnT
         ezChba7ltpbcA2j42q4pW25V54nZ5RvZzgPa5KJe9PZEEefn2YayU1CijW5Vp0twIbXt
         p0adsEX5zcbcRq3KEKHH80GcOp2erwq0t8jd1H8g0ah7IBU3XDrDWxod0X0uZif0C7mi
         dg+AIY8U0YNYH6/meW41prtxxbsxA3EkRV5NitWtjWeMvXePmbarUpNeuYZZB1gj6XOl
         lHpS2iq/TjcdLX4oniyy+0F63Ijr2QxJpTzDh6Q2N4pPGiTFgNe8TjpZOsn5p7H+5sr6
         2QmA==
X-Gm-Message-State: AOAM530m08/8+TJDYBkvg9PcOK/0xBy/Kq+/vgnJn8+F1FpP+JF+8E2v
        D+b/EFQ0VzpPwkQiwstmOw==
X-Google-Smtp-Source: ABdhPJwEPb10fj9w9+iuDh14GzpFtGbcUbBT9YQT7EfkJduKMoyN4IcMJ50ib2BBgXy5CWOTTsFcig==
X-Received: by 2002:a9d:6e91:: with SMTP id a17mr166967otr.284.1601316768301;
        Mon, 28 Sep 2020 11:12:48 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e22sm397977oib.18.2020.09.28.11.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:12:47 -0700 (PDT)
Received: (nullmailer pid 3011832 invoked by uid 1000);
        Mon, 28 Sep 2020 18:12:47 -0000
Date:   Mon, 28 Sep 2020 13:12:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: usb: add properties for hard wired devices
Message-ID: <20200928181247.GA3008733@bogus>
References: <20200928063950.64722-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928063950.64722-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 02:39:50PM +0800, Chunfeng Yun wrote:
> Add some optional properties which are needed for hard wired devices
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-hcd.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-hcd.yaml b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> index 7263b7f2b510..1194a82887e7 100644
> --- a/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> +++ b/Documentation/devicetree/bindings/usb/usb-hcd.yaml
> @@ -22,6 +22,17 @@ properties:
>      description:
>        Name specifier for the USB PHY
>  
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^hub|device@[0-9a-f]+$":

Could be any class of device, so '@[0-9a-f]+$'

> +    type: object
> +    description: The hard wired USB devices. See usb/usb-device.txt

Ideally, we'd convert usb-device.txt to schema and reference it here.

> +
>  examples:
>    - |
>      usb {
> -- 
> 2.18.0
