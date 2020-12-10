Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8532D5098
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 03:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgLJCG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 21:06:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43658 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbgLJCG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 21:06:28 -0500
Received: by mail-oi1-f196.google.com with SMTP id q25so4036521oij.10;
        Wed, 09 Dec 2020 18:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8GuGks7pjJoLfrOI5hpguNKWl0aw9SWAL6rU3/z+zUI=;
        b=sc/Q9Z3DS+E4aiwJw9bgieomocnoqshZUrfpMf/Xk2BwU4zz3MoKsVJdO5BwVuSzhM
         nNbRH3EcG4lfQGOi8KPml0JemV47gxA76qi6+2cHvXgS7zDO5dZ7ExDle0SEpnskH4C3
         /Afu/IHUnaDFi8tCJ90yepOWZpgduCUFSoRe6uhsYzkMU0h33bkVwAcvcevORXXGTBcA
         M8leD+3Ptclv6sRUZXd/10HgyITJ9ZzG11+8jyOPM8SL7djoTjpFUs3Qcf8UcYmPvX4/
         Bs5WmOkAjs+uoMmDT56Z902Y1J+nbgGPc04NuIKbF8h7NXIES5cOR9MDGxgMCg72J88P
         izDw==
X-Gm-Message-State: AOAM530Ae5ORpLgGgqBcy94sCJXxZzXfqpW4aFhoBmD6XYvx0YCgfLsI
        WukkAr8T1yJlBffQ0zBSEKIFkprs4w==
X-Google-Smtp-Source: ABdhPJwoARnT512h9iJ5Js1SDMsBW69jc17uvbUNL4uUBpC574j9b0Ymjg3ke21CekdWBTrNzGIxEw==
X-Received: by 2002:aca:4006:: with SMTP id n6mr3949480oia.22.1607565947425;
        Wed, 09 Dec 2020 18:05:47 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o82sm693247oih.5.2020.12.09.18.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 18:05:46 -0800 (PST)
Received: (nullmailer pid 1484610 invoked by uid 1000);
        Thu, 10 Dec 2020 02:05:45 -0000
Date:   Wed, 9 Dec 2020 20:05:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: add simple-audio-mux binding
Message-ID: <20201210020545.GA1480364@robh.at.kernel.org>
References: <20201205001508.346439-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205001508.346439-1-alexandre.belloni@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 01:15:07AM +0100, Alexandre Belloni wrote:
> Add devicetree documentation for simple audio multiplexers
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> 
>  .../bindings/sound/simple-audio-mux.yaml      | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml b/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
> new file mode 100644
> index 000000000000..5986d1fcbb54
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/simple-audio-mux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple Audio Multiplexer
> +
> +maintainers:
> +  - Alexandre Belloni <aleandre.belloni@bootlin.com>

typo

> +
> +description: |
> +  Simple audio multiplexers are driven using gpios, allowing to select which of
> +  their input line is connected to the output line.

What's wrong with the generic mux binding and driver(s)?

> +
> +properties:
> +  compatible:
> +    const: simple-audio-mux
> +
> +  mux-gpios:
> +    description: |
> +      GPIOs used to select the input line.
> +
> +  sound-name-prefix:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Used as prefix for sink/source names of the component. Must be a
> +      unique string among multiple instances of the same component.
> +
> +required:
> +  - compatible
> +  - mux-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mux {
> +        compatible = "simple-audio-mux";
> +        mux-gpios = <&gpio 3 0>;
> +    };
> -- 
> 2.28.0
> 
