Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB852B097E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgKLQGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:06:34 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35731 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgKLQGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:06:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id n11so6080615ota.2;
        Thu, 12 Nov 2020 08:06:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3ufV/nE7yMD/9nE/SuqLhfnK8fps7nR0yXh6Zbp0Nms=;
        b=mC0VQndCAmd6Ubs3v6R1ubCAcjIFYRofYgvGaWaKZ38MOpbHLv9pDrRDCcmnw7ZqwW
         U1h8elmYJgUOiBQ/7JB/dQDabgm9EZF419asPfW9XlnxdtzkYb9HnBm9IZV3ebJX7/I1
         N6N/Nw91mlMOqrJdk1LY3jIKHVVBAcGwmq5DDmvr5fSVu4iE4aDziF6Wfquz2F9DU2qF
         t5PlPynWZ6hjdG8dQJrurjQtglM8D/4XD2AR1mtv3WMUpdOq8K3uwwqIBfEm0B7zLXXy
         KuSFwAbUiw+yVEwIIDWyZxjYTXSNUmBTRkcfI1voOH6gbkbvf9vWHnuxJM/9u/8kCqzJ
         JM1g==
X-Gm-Message-State: AOAM533vt+S2VXTLIft6/T5ZsU2Xu0sYSJ1QaTia4fhaiyejYcqId05m
        +ItujnWb430HEOIJ11t26cDF4ScqmQ==
X-Google-Smtp-Source: ABdhPJyS6c0yPbEFXN9wyW73xxOhuVjIDcn90D3c+lrlsn8DYEzLaQDA01QgYclNrf9Xxptu3wJfZA==
X-Received: by 2002:a9d:6311:: with SMTP id q17mr21446605otk.284.1605197192475;
        Thu, 12 Nov 2020 08:06:32 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s185sm1251840oia.18.2020.11.12.08.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 08:06:31 -0800 (PST)
Received: (nullmailer pid 3681332 invoked by uid 1000);
        Thu, 12 Nov 2020 16:06:31 -0000
Date:   Thu, 12 Nov 2020 10:06:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     broonie@kernel.org, kuninori.morimoto.gx@renesas.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: audio-graph-card: Refactor schema
Message-ID: <20201112160631.GA3671282@bogus>
References: <1605097613-25301-1-git-send-email-spujar@nvidia.com>
 <1605097613-25301-2-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605097613-25301-2-git-send-email-spujar@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 05:56:52PM +0530, Sameer Pujar wrote:
> There can be customized sound cards which are based on generic audio
> graph. In such cases most of the stuff is reused from generic audio
> graph. To facilitate this, refactor audio graph schema into multiple
> files and the base schema can be reused for specific sound cards.

I did ack it, but it's not great that this was just applied and now it's 
being changed. If the submitter doesn't have time to work on it more 
then the maintainers shouldn't really have time to apply it.

> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../bindings/sound/audio-graph-card.yaml           | 102 +-------------------
>  .../devicetree/bindings/sound/audio-graph.yaml     | 107 +++++++++++++++++++++
>  2 files changed, 110 insertions(+), 99 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/audio-graph.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.yaml b/Documentation/devicetree/bindings/sound/audio-graph-card.yaml
> index 2329aeb..e047d7d 100644
> --- a/Documentation/devicetree/bindings/sound/audio-graph-card.yaml
> +++ b/Documentation/devicetree/bindings/sound/audio-graph-card.yaml
> @@ -9,113 +9,17 @@ title: Audio Graph Card Driver Device Tree Bindings
>  maintainers:
>    - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>  
> +allOf:
> +  - $ref: /schemas/sound/audio-graph.yaml#
> +
>  properties:
>    compatible:
>      enum:
>        - audio-graph-card
>        - audio-graph-scu-card
>  
> -  dais:
> -    $ref: /schemas/types.yaml#/definitions/phandle-array
> -  label:
> -    maxItems: 1
> -  prefix:
> -    description: "device name prefix"
> -    $ref: /schemas/types.yaml#/definitions/string
> -  routing:
> -    description: |
> -      A list of the connections between audio components.
> -      Each entry is a pair of strings, the first being the
> -      connection's sink, the second being the connection's source.
> -    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> -  widgets:
> -    description: User specified audio sound widgets.
> -    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> -  convert-rate:
> -    description: CPU to Codec rate convert.
> -    $ref: /schemas/types.yaml#/definitions/uint32
> -  convert-channels:
> -    description: CPU to Codec rate channels.
> -    $ref: /schemas/types.yaml#/definitions/uint32
> -  pa-gpios:
> -    maxItems: 1
> -  hp-det-gpio:
> -    maxItems: 1
> -  mic-det-gpio:
> -    maxItems: 1
> -
> -  port:
> -    description: single OF-Graph subnode
> -    type: object
> -    properties:
> -      reg:
> -        maxItems: 1
> -      prefix:
> -        description: "device name prefix"
> -        $ref: /schemas/types.yaml#/definitions/string
> -      convert-rate:
> -        description: CPU to Codec rate convert.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -      convert-channels:
> -        description: CPU to Codec rate channels.
> -        $ref: /schemas/types.yaml#/definitions/uint32
> -    patternProperties:
> -      "^endpoint(@[0-9a-f]+)?":
> -        type: object
> -        properties:
> -          remote-endpoint:
> -            maxItems: 1
> -          mclk-fs:
> -            description: |
> -              Multiplication factor between stream rate and codec mclk.
> -              When defined, mclk-fs property defined in dai-link sub nodes are ignored.
> -            $ref: /schemas/types.yaml#/definitions/uint32
> -          frame-inversion:
> -            description: dai-link uses frame clock inversion
> -            $ref: /schemas/types.yaml#/definitions/flag
> -          bitclock-inversion:
> -            description: dai-link uses bit clock inversion
> -            $ref: /schemas/types.yaml#/definitions/flag
> -          frame-master:
> -            description: Indicates dai-link frame master.
> -            $ref: /schemas/types.yaml#/definitions/phandle-array
> -            maxItems: 1
> -          bitclock-master:
> -            description: Indicates dai-link bit clock master
> -            $ref: /schemas/types.yaml#/definitions/phandle-array
> -            maxItems: 1
> -          dai-format:
> -            description: audio format.
> -            items:
> -              enum:
> -                - i2s
> -                - right_j
> -                - left_j
> -                - dsp_a
> -                - dsp_b
> -                - ac97
> -                - pdm
> -                - msb
> -                - lsb
> -          convert-rate:
> -            description: CPU to Codec rate convert.
> -            $ref: /schemas/types.yaml#/definitions/uint32
> -          convert-channels:
> -            description: CPU to Codec rate channels.
> -            $ref: /schemas/types.yaml#/definitions/uint32
> -        required:
> -          - remote-endpoint
> -
> -  ports:
> -    description: multi OF-Graph subnode
> -    type: object
> -    patternProperties:
> -      "^port(@[0-9a-f]+)?":
> -        $ref: "#/properties/port"
> -
>  required:
>    - compatible
> -  - dais
>  
>  additionalProperties: false

This is not going to work with all the properties moved. 
'additionalProperties' can't 'see' into the reference. This needs to be 
unevaluatedProperties instead which solves that problem.

>  
> diff --git a/Documentation/devicetree/bindings/sound/audio-graph.yaml b/Documentation/devicetree/bindings/sound/audio-graph.yaml
> new file mode 100644
> index 0000000..1e338d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/audio-graph.yaml
> @@ -0,0 +1,107 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/audio-graph.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Audio Graph Card Driver Device Tree Bindings
> +
> +maintainers:
> +  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> +
> +allOf:
> +  - $ref: /schemas/graph.yaml#
> +
> +select: false
> +
> +properties:
> +  dais:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +  label:
> +    maxItems: 1
> +  prefix:
> +    description: "device name prefix"
> +    $ref: /schemas/types.yaml#/definitions/string
> +  routing:
> +    description: |
> +      A list of the connections between audio components.
> +      Each entry is a pair of strings, the first being the
> +      connection's sink, the second being the connection's source.
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +  widgets:
> +    description: User specified audio sound widgets.
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +  convert-rate:
> +    description: CPU to Codec rate convert.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +  convert-channels:
> +    description: CPU to Codec rate channels.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +  pa-gpios:
> +    maxItems: 1
> +  hp-det-gpio:
> +    maxItems: 1
> +  mic-det-gpio:
> +    maxItems: 1
> +
> +  port:
> +    description: single OF-Graph subnode
> +    type: object
> +    properties:
> +      prefix:
> +        description: "device name prefix"
> +        $ref: /schemas/types.yaml#/definitions/string
> +      convert-rate:
> +        description: CPU to Codec rate convert.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +      convert-channels:
> +        description: CPU to Codec rate channels.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +    patternProperties:
> +      "^endpoint(@[0-9a-f]+)?":
> +        type: object
> +        properties:
> +          mclk-fs:
> +            description: |
> +              Multiplication factor between stream rate and codec mclk.
> +              When defined, mclk-fs property defined in dai-link sub nodes are
> +              ignored.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +          frame-inversion:
> +            description: dai-link uses frame clock inversion
> +            $ref: /schemas/types.yaml#/definitions/flag
> +          bitclock-inversion:
> +            description: dai-link uses bit clock inversion
> +            $ref: /schemas/types.yaml#/definitions/flag
> +          frame-master:
> +            description: Indicates dai-link frame master.
> +            $ref: /schemas/types.yaml#/definitions/phandle-array
> +            maxItems: 1
> +          bitclock-master:
> +            description: Indicates dai-link bit clock master
> +            $ref: /schemas/types.yaml#/definitions/phandle-array
> +            maxItems: 1
> +          dai-format:
> +            description: audio format.
> +            items:
> +              enum:
> +                - i2s
> +                - right_j
> +                - left_j
> +                - dsp_a
> +                - dsp_b
> +                - ac97
> +                - pdm
> +                - msb
> +                - lsb
> +          convert-rate:
> +            description: CPU to Codec rate convert.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +          convert-channels:
> +            description: CPU to Codec rate channels.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +
> +required:
> +  - dais
> +
> +additionalProperties: true
> -- 
> 2.7.4
> 
