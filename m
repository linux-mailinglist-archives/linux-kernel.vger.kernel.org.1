Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677262F4E75
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbhAMPXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:23:09 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:44014 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbhAMPXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:23:08 -0500
Received: by mail-ot1-f53.google.com with SMTP id q25so2188337otn.10;
        Wed, 13 Jan 2021 07:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SE9am3kq8RjarWOXnd9kdCTvbTnepwR4fe9xga07N+k=;
        b=r/VicUnQ5yw2wjSj7r9xoU+qkGFHn34sd4UBjOF6JIlEHEt9rF+xwjTZxnAV5ZeRaK
         6Q4OztWVwzRruQM4ve8JUvkZ2N1NYSGp/ONWauok0WVYDy0lPkiteEqotL5H0BFYGOJr
         xRlRGOsUKFL6Au3yeM6g3dxBO2juwKkZRBTCMBbBcDjJzDApes0CiBQRUvLAzrWe6pCT
         fT7ZT+2DX9VEDL8Bl2kdns2f9FLOIrpDkkZqRvhbFLZgG8gXI56TiBfQMNGSziWHDNp5
         RMWLaOrtH6tjQt9GRZGyRBe64oRDngMAQZ2G8hZLHeZrH04NmXTzPIhPDYH0bHCPK3E5
         v+Hw==
X-Gm-Message-State: AOAM531KIU3ZH65iPsLT3RJbc6+n274qu4M9r+vDriG8KVvw+8c9l8OF
        0M6JSe1c0B9b6F834U0iTA==
X-Google-Smtp-Source: ABdhPJyXSD7O2u+KLy4dCmhAaS4RrzejnZJ8LhZpdTnooicBMv0HLXKioHgADiNofONZ/RIUjKsn5g==
X-Received: by 2002:a9d:470f:: with SMTP id a15mr1617646otf.62.1610551347611;
        Wed, 13 Jan 2021 07:22:27 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e10sm437795otl.38.2021.01.13.07.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:22:26 -0800 (PST)
Received: (nullmailer pid 2470201 invoked by uid 1000);
        Wed, 13 Jan 2021 15:22:25 -0000
Date:   Wed, 13 Jan 2021 09:22:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     broonie@kernel.org, kuninori.morimoto.gx@renesas.com,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/6] dt-bindings: audio-graph-card: Add plls and
 sysclks properties
Message-ID: <20210113152225.GA2334778@robh.at.kernel.org>
References: <20210108160501.7638-1-rf@opensource.cirrus.com>
 <20210108160501.7638-3-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108160501.7638-3-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 04:04:57PM +0000, Richard Fitzgerald wrote:
> The audio-graph-card driver has properties for configuring the clocking
> for DAIs within a component, but is missing properties for setting
> up the PLLs and sysclks of the component.
> 
> This patch adds the two new properties 'plls' and 'sysclks' so that the
> audio-graph-driver can fully configure the component clocking.

I'm not sure this makes sense to be generic, but if so, we already have 
the clock binding and should use (and possibly extend) that.

This appears to all be configuration of clocks within the codec, so 
these properties belong in the codec or cpu nodes.

> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  .../bindings/sound/audio-graph.yaml           | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/audio-graph.yaml b/Documentation/devicetree/bindings/sound/audio-graph.yaml
> index 4b46794e5153..9e0819205a17 100644
> --- a/Documentation/devicetree/bindings/sound/audio-graph.yaml
> +++ b/Documentation/devicetree/bindings/sound/audio-graph.yaml
> @@ -39,6 +39,52 @@ properties:
>    mic-det-gpio:
>      maxItems: 1
>  
> +  plls:
> +    description: |
> +      A list of component pll settings. There are 4 cells per PLL setting:
> +        - phandle to the node of the codec or cpu component,
> +        - component PLL id,
> +        - component clock source id,
> +        - frequency (in Hz) of the PLL output clock.

assigned-clocks binding can set frequencies and parent clocks.

'pll' is too specific to the implementation. You may want to configure 
the freq and parent of something that's not a pll.

> +      The PLL id and clock source id are specific to the particular component
> +      so see the relevant component driver for the ids. Typically the
> +      clock source id indicates the pin the source clock is connected to.
> +      The same phandle can appear in multiple entries so that several plls
> +      can be set in the same component.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  plls-clocks:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description: |
> +      A list of clock names giving the source clock for each setting
> +      in the plls property.
> +
> +  sysclks:
> +    description: |
> +      A list of component sysclk settings. There are 4 cells per sysclk
> +      setting:
> +        - phandle to the node of the codec or cpu component,
> +        - component sysclk id,
> +        - component clock source id,
> +        - direction of the clock: 0 if the clock is an input to the component,
> +          1 if it is an output.

A clock provider and consumer would provide the direction.

> +      The sysclk id and clock source id are specific to the particular
> +      component so see the relevant component driver for the ids. Typically
> +      the clock source id indicates the pin the source clock is connected to.
> +      The same phandle can appear in multiple entries so that several sysclks
> +      can be set in the same component.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +
> +  sysclks-clocks:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description: |
> +      A list of clock names giving the source clock for each setting
> +      in the sysclks property.
> +
> +dependencies:
> +  plls: [ plls-clocks ]
> +  sysclks: [ sysclks-clocks ]
> +
>  required:
>    - dais
>  
> -- 
> 2.20.1
> 
