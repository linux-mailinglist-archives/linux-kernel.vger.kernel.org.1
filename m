Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F00298DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 14:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770297AbgJZN1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 09:27:14 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40744 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437450AbgJZN1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 09:27:08 -0400
Received: by mail-oi1-f193.google.com with SMTP id m128so10453674oig.7;
        Mon, 26 Oct 2020 06:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I00XBAnJ7WylgkzAn5TxWF3njmn5zBWWNtxL/K5mgoc=;
        b=TVXiAs5ykgWsOsfHe1HrFs4nzi2/UmGHV1oZ5M+wvIORfMaG0ulMiJBgWEzDEWLm3A
         LuU5aOToRncoiAbxGTiD24H/4SFdwOU72T2lORFsAzLDdD9TQ3DNJTrij8P62R3VEs93
         1PT4BwhBkdqomH2wgjlxM7fv/bqgXAZMEYMCxBPN79J9CUgCsmqxNFFiJ57Vi4X+EbNZ
         GZ4i9t0JWdAM1rt8yYA2fcu1nKSBoSHLzeH2wWoIJ9ty+KHRoVtlmQPJcVA7IwTrlh36
         fj+M33oflleliW9gqgkBqRxgi/skXy0MxH+ts7xr3GR69WE3oQ+IRw5PqdSeU6tByaH0
         zfyA==
X-Gm-Message-State: AOAM532p4cuN6YwcK06kIaB8c8UCUT4davKBE0KzZU+vqbZDXkX91H7j
        NqYrD/8YT1CBvOI237/lrA==
X-Google-Smtp-Source: ABdhPJw/URyM2Olc0l0cnR5M+IOaA7dfiOz7xYxgvGes09V25+mkFzvABkINEQh/Wu5rg0R4pOiViw==
X-Received: by 2002:aca:6206:: with SMTP id w6mr14216985oib.121.1603718826869;
        Mon, 26 Oct 2020 06:27:06 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d22sm3855955oij.53.2020.10.26.06.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 06:27:05 -0700 (PDT)
Received: (nullmailer pid 28455 invoked by uid 1000);
        Mon, 26 Oct 2020 13:27:04 -0000
Date:   Mon, 26 Oct 2020 08:27:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     broonie@kernel.org, nsaenzjulienne@suse.de,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/7] ASoC: audio-graph-card: Add plls and sysclks DT
 bindings
Message-ID: <20201026132704.GA19204@bogus>
References: <20201016173541.21180-1-rf@opensource.cirrus.com>
 <20201016173541.21180-3-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016173541.21180-3-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 06:35:36PM +0100, Richard Fitzgerald wrote:
> This adds the two new properties 'plls' and 'sysclks' to the dt bindings.
> These add the ability to set values that will be
> passed to snd_soc_component_set_sysclk() and snd_soc_component_set_pll().

I worry this looks like Linux implementation details leaking into the 
binding.

> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  .../bindings/sound/audio-graph-card.txt       | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
> index d5f6919a2d69..59bbd5b55b59 100644
> --- a/Documentation/devicetree/bindings/sound/audio-graph-card.txt
> +++ b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
> @@ -32,6 +32,19 @@ Required properties:
>  Optional properties:
>  - pa-gpios: GPIO used to control external amplifier.
>  
> +- plls: A list of component pll settings that will be applied with
> +      snd_soc_component_set_pll. Each entry is a phandle to the node of the
> +      codec or cpu component, followed by the four arguments id, source,
> +      frequency_in, frequency_out. Multiple entries can have the same phandle
> +      so that several plls can be set in the same component.

Where do the values of id and source come from?

> +
> +- sysclks: A list of component sysclk settings that will be applied with
> +      snd_soc_component_set_sysclk. Each entry is a phandle to the node of
> +      the codec or cpu component, followed by the four arguments id, source,
> +      frequency, direction. Direction is 0 if the clock is an input, 1 if it
> +      is an output. Multiple entries can have the same phandle so that several
> +      clocks can be set in the same component.

Are these really common properties? They seem kind of Cirrus specific 
and perhaps should be located in the codec node(s).

> +
>  -----------------------
>  Example: Single DAI case
>  -----------------------
> @@ -335,3 +348,34 @@ Example: Multi DAI with DPCM
>  			};
>  		};
>  	};
> +
> +-----------------------
> +Example: Set component sysclks and PLLs
> +-----------------------
> +
> +	sound {
> +		compatible = "audio-graph-card";
> +
> +		sysclks = <
> +			&cs47l15 1 4 98304000 0
> +			&cs47l15 8 4 147456000 0
> +		>;
> +		plls = <
> +			&cs47l15 1 0 24576000 98304000
> +		>;
> +
> +		dais = <&cpu_i2s_port>;
> +	};
> +
> +	cs47l15: codec@0 {
> +		...
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			cs47l15_aif1_port: port@0 {
> +				reg = <0>;
> +				cs47l15_aif1: endpoint {
> +					remote-endpoint = <&cpu_i2s_endpoint>;
> +				};
> +			};
> +	};
> -- 
> 2.20.1
> 
