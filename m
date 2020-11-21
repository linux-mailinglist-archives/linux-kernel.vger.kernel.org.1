Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F7D2BBF10
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 13:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgKUMus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 07:50:48 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38256 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgKUMur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 07:50:47 -0500
Received: by mail-qt1-f193.google.com with SMTP id g17so9303414qts.5;
        Sat, 21 Nov 2020 04:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0eLODkRpKbmFULO0YO5o421ANqpWCtV3ViGaBwX9fGk=;
        b=gnBwQqKSygvu8DVAQQ7I0rxeSbXpYigeh6Pd931g6Kdvj2bFsb1TJzgQMGfx7tXM07
         WP/PiiVqzsaXWuAlYgu8Vx/WCu2mUXZnIJIuy+qLJPLkcGQUc7rx3yrsNoA7YXuKzbk5
         GrKWFMC9Qf7lfHGG5kfLC2CNcck0014JCj03mcQ4RtCdmtk+2bRN0n0eVmbO+RjIv1eU
         e7/wrBH4RSoDuGRZydFNOiXvjZzQ6wbl53YGxvhkDdcbpfWxPMjh8H2Uo1JeguEK9VpO
         AeFys0iLs/MPAVXYMfJ36QqJMu4zPMTD1wZC0c35q27NDqtVy9xPd7RijU7K2bW2HmKr
         83Zw==
X-Gm-Message-State: AOAM531FwscfrZzoRucBrXyewYeZymhuEUJFrs2B2YdXrL8zzxDlQMmy
        3p6pW2CorEok7y+4oxVnXPts8gBTrA==
X-Google-Smtp-Source: ABdhPJyUJ7IlSagRKbzuDzYgX/hB+zYDKd2lKwox5U7luJqaS/fiFLVH8Q0NOUOK/Z3bx90u8wuJ0g==
X-Received: by 2002:a05:622a:1cd:: with SMTP id t13mr20450545qtw.39.1605963046240;
        Sat, 21 Nov 2020 04:50:46 -0800 (PST)
Received: from xps15 ([2607:fb90:5feb:6270:cdf7:680e:59f2:6ccd])
        by smtp.gmail.com with ESMTPSA id e6sm2224127qtb.57.2020.11.21.04.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 04:50:45 -0800 (PST)
Received: (nullmailer pid 2076002 invoked by uid 1000);
        Sat, 21 Nov 2020 12:50:40 -0000
Date:   Sat, 21 Nov 2020 06:50:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Xin Ji <xji@analogixsemi.com>, Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 1/2] dt-bindings: drm/bridge: anx7625: Add power supplies
Message-ID: <20201121125040.GA2074808@robh.at.kernel.org>
References: <20201112083704.1173908-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112083704.1173908-1-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 04:37:03PM +0800, Hsin-Yi Wang wrote:
> anx7625 requires 3 power supply regulators.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  .../display/bridge/analogix,anx7625.yaml       | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> index 60585a4fc22b..1aa08f10d894 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> @@ -34,6 +34,18 @@ properties:
>      description: used for reset chip control, RESET_N pin B7.
>      maxItems: 1
>  
> +  vdd10-supply:
> +    description: Regulator that provides the supply 1.0V power.
> +    maxItems: 1
> +
> +  vdd18-supply:
> +    description: Regulator that provides the supply 1.8V power.
> +    maxItems: 1
> +
> +  vdd33-supply:
> +    description: Regulator that provides the supply 3.3V power.
> +    maxItems: 1

Supplies are always a single item, so you can drop maxItems.

> +
>    ports:
>      type: object
>  
> @@ -55,6 +67,9 @@ properties:
>  required:
>    - compatible
>    - reg
> +  - vdd10-supply
> +  - vdd18-supply
> +  - vdd33-supply
>    - ports
>  
>  additionalProperties: false
> @@ -72,6 +87,9 @@ examples:
>              reg = <0x58>;
>              enable-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
>              reset-gpios = <&pio 73 GPIO_ACTIVE_HIGH>;
> +            vdd10-supply = <&pp1000_mipibrdg>;
> +            vdd18-supply = <&pp1800_mipibrdg>;
> +            vdd33-supply = <&pp3300_mipibrdg>;
>  
>              ports {
>                  #address-cells = <1>;
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 
