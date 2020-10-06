Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65F628532B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgJFUeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:34:37 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39557 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgJFUeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:34:37 -0400
Received: by mail-ot1-f65.google.com with SMTP id f10so62056otb.6;
        Tue, 06 Oct 2020 13:34:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9Bl8Ef7MsrCUl5Y6fQNE2hvCJzehQ4qg3g3ESvM80Lc=;
        b=qJWiwuSfJsuTEo5/0ZdGXdjgyhCqQyXoP595ntYK/0Agz93Cjasu4+J4h9ZKdLbCvq
         huQZq/OC8v6qKyxrgqxXfdNxsWyDVrc/uaSjb4Nms772Ue/mbLQxfl8QBHxzhDyxtJf5
         MbVbnKXNOIugmz08VJU6LszEmDIP2ufONk1QLVgG7osNAdlUN9GovgUJJv0vpyJ/Wq1L
         ZlwewHzYB51PkO4UuFx7Q+SR2fq937siea7n8z9AZSFN9IG1JB7ZQMf7ZXOss90ynCu2
         z9tj8rZHQq84/7x9hLC4hp+vdCiq7iI58LkDdCunVq9YXJi0fC1zRCHeuuPtML2Xxbum
         1S1A==
X-Gm-Message-State: AOAM533d98fVbPVcvwG32UhXnLQGGwsrolKeR1uRRMC9bwVdX48Te4DZ
        3NUQbWeqMsNugiCKylRldtWyMa8paBfP
X-Google-Smtp-Source: ABdhPJysTVo6aPJYaCescnoWvcltcz2t7AvkaOwyZJCnYE7pLEiVUUXMPN/uFUEiRDTj2GvBxcP5TQ==
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr3473086otl.27.1602016475621;
        Tue, 06 Oct 2020 13:34:35 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v21sm1605218ots.29.2020.10.06.13.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:34:34 -0700 (PDT)
Received: (nullmailer pid 2790213 invoked by uid 1000);
        Tue, 06 Oct 2020 20:34:33 -0000
Date:   Tue, 6 Oct 2020 15:34:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        kuninori.morimoto.gx@renesas.com,
        pierre-louis.bossart@linux.intel.com, perex@perex.cz,
        tiwai@suse.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, mkumard@nvidia.com, viswanathl@nvidia.com,
        rlokhande@nvidia.com, dramesh@nvidia.com, atalambedu@nvidia.com,
        nwartikar@nvidia.com, swarren@nvidia.com, nicoleotsuka@gmail.com
Subject: Re: [PATCH v3 09/13] ASoC: dt-bindings: tegra: Add schema for audio
 graph card
Message-ID: <20201006203433.GA2786434@bogus>
References: <1601573587-15288-1-git-send-email-spujar@nvidia.com>
 <1601573587-15288-10-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601573587-15288-10-git-send-email-spujar@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 11:03:03PM +0530, Sameer Pujar wrote:
> Add YAML schema for Tegra audio graph sound card DT bindings. It uses the
> same DT bindings provided by generic audio graph driver. Along with this
> few standard clock DT bindings are added which are specifically required
> for Tegra audio.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  .../sound/nvidia,tegra-audio-graph-card.yaml       | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml
> new file mode 100644
> index 0000000..b73fbe5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-graph-card.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-graph-card.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Audio Graph based Tegra sound card driver
> +
> +description: |
> +  This is based on generic audio graph card driver along with additional
> +  customizations for Tegra platforms. It uses the same bindings with
> +  additional standard clock DT bindings required for Tegra.
> +
> +  See{LINUX}/Documentation/devicetree/bindings/sound/audio-graph-card.txt
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Sameer Pujar <spujar@nvidia.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: nvidia,tegra210-audio-graph-card
> +      - const: nvidia,tegra186-audio-graph-card
> +
> +  clocks:
> +   minItems: 2
> +
> +  clock-names:
> +   minItems: 2
> +   items:
> +     - const: pll_a
> +     - const: plla_out0
> +
> +  assigned-clocks:
> +    minItems: 1
> +    maxItems: 3
> +
> +  assigned-clock-parents:
> +    minItems: 1
> +    maxItems: 3
> +
> +  assigned-clock-rates:
> +    minItems: 1
> +    maxItems: 3
> +
> +required:
> +  - compatible
> +  - clocks
> +  - clock-names
> +  - assigned-clocks
> +  - assigned-clock-parents

Where's the graph? You need to define the ports and reference the common 
schema.

> +
> +examples:
> +  - |
> +    #include<dt-bindings/clock/tegra210-car.h>
> +
> +    tegra_sound {
> +        compatible = "nvidia,tegra210-audio-graph-card";
> +        clocks = <&tegra_car TEGRA210_CLK_PLL_A>,
> +                 <&tegra_car TEGRA210_CLK_PLL_A_OUT0>;
> +        clock-names = "pll_a", "plla_out0";
> +        assigned-clocks = <&tegra_car TEGRA210_CLK_PLL_A>,
> +                          <&tegra_car TEGRA210_CLK_PLL_A_OUT0>,
> +                          <&tegra_car TEGRA210_CLK_EXTERN1>;
> +        assigned-clock-parents = <0>, <0>, <&tegra_car TEGRA210_CLK_PLL_A_OUT0>;
> +        assigned-clock-rates = <368640000>, <49152000>, <12288000>;
> +    };
> +
> +...
> -- 
> 2.7.4
> 
