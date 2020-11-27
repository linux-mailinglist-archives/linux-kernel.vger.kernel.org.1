Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D53C2C6103
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgK0Ii0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbgK0IiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:38:24 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A57C0613D1;
        Fri, 27 Nov 2020 00:38:24 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 10so4391599wml.2;
        Fri, 27 Nov 2020 00:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u79lL/HP+WpOwKFUXdt5Th5mjfi+tKiFgA+cKzsBuR0=;
        b=JnsUHSQe//Aq13uWmoBPI4hMTMYUmNQU39HV5DV+aNtOqi+XFYQG6VzSxBi1eLThJI
         TsJFNU20n11+5uSkIwpqJ5+l50BOeVKf6n/l0Rkg7X1JI3umoWpuAfAoA4+B5qfdtCDH
         xUqPfEIJdUsxHot2QSfkRPRrilgU8fo+rpMW9ThzZxl1TAytM8iW+xnxLA+AW7nyO45o
         0CLDmNxEvvYWEzwP9o2A7LawwrMuxy5JeKKud8P2ip0mcB0xaQZUBIMX740fncs/KL2w
         so6QXgMfKN0qjztEWyeCOi+MbuDYKXl1WEFKvV80VJE2uRqG6YS9PSM8UFM0u4B28xG7
         xRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u79lL/HP+WpOwKFUXdt5Th5mjfi+tKiFgA+cKzsBuR0=;
        b=Kahf0MxkHSyFl0Y/XwRWpvgQhILBjouhRQDVAfU5VMWvVuRr3YKns9IixLJ1ku3SxQ
         JJpeAJSybw8UlksViLHkmL0cdhGkuJGgQT1Si80Fy2slAYEJRnf/sM+MAzhWRwTJpFbJ
         /xOtfVxEsjqTZcNdrXnHVDsz3uzFHFA8iNWZnk3M8lqfWtCFb6FyFCc8g75ldAyhEAM+
         XJ6Fs7/0dZDPfsv54Js9UVtjZJ17ocFu9d0a3xBg0cZUm5WDyTeH839T3k4xFjsemy7l
         n5TpLa6srs4Ni46fY/vCUP4uHEvPfc3wQfdHhu/oeQttN8Dy4rTqVKeEXJK9Sw5TvJ6i
         x7vA==
X-Gm-Message-State: AOAM530o7K1RciuvDe5bo6mtWNbt7ogxd3PbQqBnKP1UNhaPpThJwzO3
        DVLOViJ8FGc3EccVcqBHbk4+RCmSYUYe9w==
X-Google-Smtp-Source: ABdhPJzts4WMM6w1TBYYczsTANwCb75EY/urEjpkkBZDT1zOBukum2mbdM3B38OuN7KLEhmFrRlWyg==
X-Received: by 2002:a1c:7510:: with SMTP id o16mr7729449wmc.66.1606466303239;
        Fri, 27 Nov 2020 00:38:23 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id l10sm6107889wme.42.2020.11.27.00.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 00:38:22 -0800 (PST)
Subject: Re: [PATCH 1/3] dt-bindings: arm64: dts: mediatek: Add mt8167-pumpkin
 board
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201027194816.1227654-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <75a1835b-14a1-f86d-bae6-6377e50e1864@gmail.com>
Date:   Fri, 27 Nov 2020 09:38:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201027194816.1227654-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 27/10/2020 20:48, Fabien Parent wrote:
> Add binding documentation for the MT8167 Pumpkin board.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>   Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
> 

All three patches applied to v5.10-next/dts64

Thanks!

> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 30908963ae26..5c772b937efc 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -84,6 +84,10 @@ properties:
>             - enum:
>                 - mediatek,mt8135-evbp1
>             - const: mediatek,mt8135
> +      - items:
> +          - enum:
> +              - mediatek,mt8167-pumpkin
> +          - const: mediatek,mt8167
>         - description: Google Elm (Acer Chromebook R13)
>           items:
>             - const: google,elm-rev8
> 
