Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D184E2E0296
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 23:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgLUWe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 17:34:59 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:37053 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLUWe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 17:34:58 -0500
Received: by mail-oo1-f51.google.com with SMTP id p72so2563157oop.4;
        Mon, 21 Dec 2020 14:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nwkmxUnyc+70jBLqAzr5iSoKUZYnqKhXG4oOa7bmAVY=;
        b=T4eJDsuoyvBrbpz4OfpfsF0tAjdQWCzZQusPR6JGszvcdsXf4+0v7e4Fy8rjjRYkn3
         kmTpsZY+ljHcnkEedsL7iVIO3S+8Heh2oPyUtlhIATCWETzEsFNZhef+VRP6xyz2akcZ
         Pnn+NNu2LAmrw3l1PTKN1eKKy8fQFlnfseXqppw33ARp7S+6IjzWBi51/1JplJW9I8fw
         lgmVhTrAwRT6l1Nc/ye/JPfR5UDt5IA5svBxinWmWUEkTg1vrWK4eD4/8jIuO39sl5N0
         bRl9TAnSms92FzcUa+Pyx3qZxWBOY/cxlRNKsPPyIAla8eXW4NfacgPn8gmcNLNaboZx
         tYfA==
X-Gm-Message-State: AOAM531Q2vmrgGRehS/yCoxLZgTbeunFJndUDcyGe/1pVZHsNY+xNF+u
        xzmhtYYoKYb2Uf4CyjWMJw==
X-Google-Smtp-Source: ABdhPJzZe4HjIcXZYX6IiGv6NVNfbHgWdbvac2UXEoc2OdCwz2tKMLWGBTFtRKX8zgTcFXnio+DJ+Q==
X-Received: by 2002:a05:6820:503:: with SMTP id m3mr13135986ooj.83.1608590057671;
        Mon, 21 Dec 2020 14:34:17 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id p18sm3916482ood.48.2020.12.21.14.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 14:34:16 -0800 (PST)
Received: (nullmailer pid 693960 invoked by uid 1000);
        Mon, 21 Dec 2020 22:34:13 -0000
Date:   Mon, 21 Dec 2020 15:34:13 -0700
From:   Rob Herring <robh@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     broonie@kernel.org, kuninori.morimoto.gx@renesas.com,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/6] ASoC: audio-graph-card: Add plls and sysclks DT
 bindings
Message-ID: <20201221223413.GA693000@robh.at.kernel.org>
References: <20201217154142.24301-1-rf@opensource.cirrus.com>
 <20201217154142.24301-3-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217154142.24301-3-rf@opensource.cirrus.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 03:41:38PM +0000, Richard Fitzgerald wrote:
> The audio-graph-card driver has bindings for configuring the clocking
> for DAIs within a component, but is missing bindings for setting
> up the PLLs and sysclks of the component.
> 
> This patch adds the two new bindings 'plls' and 'sysclks' so that the
> audio-graph-driver can fully configure the component clocking.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  .../bindings/sound/audio-graph-card.txt       | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)

This is a schema now in master.

> 
> diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card.txt b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
> index d5f6919a2d69..30405e64cfbb 100644
> --- a/Documentation/devicetree/bindings/sound/audio-graph-card.txt
> +++ b/Documentation/devicetree/bindings/sound/audio-graph-card.txt
> @@ -32,6 +32,40 @@ Required properties:
>  Optional properties:
>  - pa-gpios: GPIO used to control external amplifier.
>  
> +- plls: A list of component pll settings. There are 4 cells per PLL setting:
> +	- phandle to the node of the codec or cpu component,
> +	- component PLL id,
> +	- component clock source id,
> +	- frequency (in Hz) of the PLL output clock.
> +
> +	The PLL id and clock source id are specific to the particular component
> +	so see the relevant component driver for the ids. Typically the
> +	clock source id indicates the pin the source clock is connected to.
> +
> +	The same phandle can appear in multiple entries so that several plls
> +	can be set in the same component.
> +
> +- plls-clocks: A list of clock names giving the source clock for each setting
> +	in the plls property.
> +
> +- sysclks: A list of component sysclk settings.  There are 4 cells per sysclk
> +	setting:
> +	- phandle to the node of the codec or cpu component,
> +	- component sysclk id,
> +	- component clock source id,
> +	- direction of the clock: 0 if the clock is an input to the component,
> +	  1 if it is an output.
> +
> +	The sysclk id and clock source id are specific to the particular
> +	component so see the relevant component driver for the ids. Typically
> +	the clock source id indicates the pin the source clock is connected to.
> +
> +	The same phandle can appear in multiple entries so that several sysclks
> +	can be set in the same component.
> +
> +- sysclks-clocks: A list of clock names giving the source clock for each setting
> +	in the sysclks property.
> +
>  -----------------------
>  Example: Single DAI case
>  -----------------------
> @@ -335,3 +369,41 @@ Example: Multi DAI with DPCM
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
> +		clocks = <&audioclk>, <&pll1>;
> +		clock-names = "audioclk", "pll1";
> +
> +		plls = <&cs47l15 MADERA_FLL1_REFCLK MADERA_FLL_SRC_MCLK1 98304000>;
> +		plls-clocks = "audioclk";
> +
> +		sysclks = <&cs47l15 MADERA_CLK_SYSCLK_1 MADERA_CLK_SRC_FLL1 0>;
> +		sysclks-clocks = "pll1";
> +
> +		dais = <&cpu_i2s_port>;
> +
> +		pll1: pll1 {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <98304000>;
> +		};
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
