Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F1E2F2285
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 23:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389616AbhAKWPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 17:15:19 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:38407 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbhAKWPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:15:18 -0500
Received: by mail-ot1-f53.google.com with SMTP id j20so404240otq.5;
        Mon, 11 Jan 2021 14:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EUpURo/tqlO11d0ZWh9pJqmfT9/Dqh7vfkqpzFQuRyw=;
        b=H5XUPXC5cgK/vneHOa5+gitNs6T6K35m6+yK3WecqF8T/F25nzkZTJtuXbFcizOkpI
         S/RYd/vaFSPXrYm6lI9UR4HAW3dsQTqkRBui0CT79F8ADgiwkSz1IzVAgCleIfB7JDwi
         Feozc8B9rZ7y480XpM+JPijJgTFRx7A3bqkKN8kQYy6bkJ4c1szKTEkS1oigI3Cuo6gP
         wF8WF0o/DtP0KAsuWnj8NgakC37PPX0SyGXLiHfHC7opkD6MWglvxaQ+FsZkWEtrmYtW
         U45rTHi4DJ6QuC3u28+hjvAmZlH8eQh5JDUd6UAAvv+LV9GNw03P92P83dkUbYlJp6Rp
         AbpQ==
X-Gm-Message-State: AOAM533YtZeesJytnJwNvGL4GahNcVtPYzzmcxyID+jVbUJcIToieQ5n
        9j5TXajeZRUk/1MsRWtt2Q==
X-Google-Smtp-Source: ABdhPJynZmBNaJWokVqNq/yz3Znmx7KTAFKORtHEJxCrTr9eUh0wfnSWBI4rB+vdbBzij68rJVWmtw==
X-Received: by 2002:a9d:2248:: with SMTP id o66mr847503ota.236.1610403277462;
        Mon, 11 Jan 2021 14:14:37 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w9sm236310otq.44.2021.01.11.14.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 14:14:36 -0800 (PST)
Received: (nullmailer pid 3152734 invoked by uid 1000);
        Mon, 11 Jan 2021 22:14:35 -0000
Date:   Mon, 11 Jan 2021 16:14:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Xin Ji <xji@analogixsemi.com>
Cc:     David Airlie <airlied@linux.ie>,
        Nicolas Boichat <drinkcat@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Ricardo =?iso-8859-1?Q?Ca=F1uelo?= 
        <ricardo.canuelo@collabora.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, Sheng Pan <span@analogixsemi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: drm/bridge: anx7625: add DPI flag
 and swing setting
Message-ID: <20210111221435.GA3138373@robh.at.kernel.org>
References: <cover.1609380663.git.xji@analogixsemi.com>
 <d13442f84fefccc992d6c5e48ac1e6129882af31.1609380663.git.xji@analogixsemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d13442f84fefccc992d6c5e48ac1e6129882af31.1609380663.git.xji@analogixsemi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 31, 2020 at 10:21:12AM +0800, Xin Ji wrote:
> Add DPI flag for distinguish MIPI input signal type, DSI or DPI. Add
> swing setting for adjusting DP tx PHY swing
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../bindings/display/bridge/analogix,anx7625.yaml  | 25 ++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> index 60585a4..4eb0ea3 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> @@ -34,6 +34,16 @@ properties:
>      description: used for reset chip control, RESET_N pin B7.
>      maxItems: 1
>  
> +  analogix,swing-setting:
> +    type: uint8-array

Humm, this should have be rejected by the meta-schema.

> +    $ref: /schemas/types.yaml#/definitions/uint32-array

This is how types are defined other than boolean or nodes (object).

> +    description: an array of swing register setting for DP tx PHY
> +
> +  analogix,mipi-dpi-in:
> +    type: int
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: indicate the MIPI rx signal type is DPI or DSI

Why does this need to be in DT, you should be able to determine this 
based on what you are connected to.

> +
>    ports:
>      type: object
>  
> @@ -49,8 +59,8 @@ properties:
>            Video port for panel or connector.
>  
>      required:
> -        - port@0
> -        - port@1
> +      - port@0
> +      - port@1
>  
>  required:
>    - compatible
> @@ -72,6 +82,17 @@ examples:
>              reg = <0x58>;
>              enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
>              reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
> +            analogix,swing-setting = <0x00 0x14>, <0x01 0x54>,
> +                <0x02 0x64>, <0x03 0x74>, <0x04 0x29>,
> +                <0x05 0x7b>, <0x06 0x77>, <0x07 0x5b>,
> +                <0x08 0x7f>, <0x0c 0x20>, <0x0d 0x60>,
> +                <0x10 0x60>, <0x12 0x40>, <0x13 0x60>,
> +                <0x14 0x14>, <0x15 0x54>, <0x16 0x64>,
> +                <0x17 0x74>, <0x18 0x29>, <0x19 0x7b>,
> +                <0x1a 0x77>, <0x1b 0x5b>, <0x1c 0x7f>,
> +                <0x20 0x20>, <0x21 0x60>, <0x24 0x60>,
> +                <0x26 0x40>, <0x27 0x60>;

This is a matrix, which is different from an array type.

> +            analogix,mipi-dpi-in = <0>;
>  
>              ports {
>                  #address-cells = <1>;
> -- 
> 2.7.4
> 
