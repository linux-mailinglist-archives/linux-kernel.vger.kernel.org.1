Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994B82BA7D1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgKTKxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:53:34 -0500
Received: from mail-ej1-f68.google.com ([209.85.218.68]:46375 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbgKTKxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:53:33 -0500
Received: by mail-ej1-f68.google.com with SMTP id bo9so6503591ejb.13;
        Fri, 20 Nov 2020 02:53:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V3kEOLd2utFjzbmv50gNlqd+2n+lrD5UargnZ9h+es4=;
        b=a7AaFD1THjCNc2NYemXAE+pRymBU0ALnRtqy/G3oEJJI/x3/0DDKHVMfLUN0xiGc+n
         4H0nbecesUPelFbUQcJn8DEmkEOcUaqKOIQXKaOr8FYIxhgV6y6798bZyyoS3p3jU+XN
         ZqpiJCA/aOQmI6PqqbUkuNENW8/Kgy2HMV9fRsWU6yZl9vsAkY48sBPBafFc5ZyjW7/n
         2M4xIbB3Q3PVSRwQUIPBjt3IcCK0Oo0tdOEpa1TLaifL0lEt6aoGQLVpt/KHZ7RyRJ4e
         XVjIvxtI0q7EQOaEc9QcodlH7jANSkfjjmRNwlavwPtCu5LoKK0apM9ek5zguUBQyAYz
         WozQ==
X-Gm-Message-State: AOAM533nRcCmr8hwzIVS/ri9ofLZPD3Nn+YZ2VV0IL3iiDNOjmpVgEXf
        rlD/2janHIYwTz4IbZcMZnA=
X-Google-Smtp-Source: ABdhPJxtp/tR2wp7KDqe9HbHJKFxzlmWgj9mNs3miaUyBfYqNNhqPGNkOcDgkfRd68k23+zAjz6Apw==
X-Received: by 2002:a17:906:d8a8:: with SMTP id qc8mr32002836ejb.149.1605869611481;
        Fri, 20 Nov 2020 02:53:31 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id u17sm987053eje.11.2020.11.20.02.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 02:53:30 -0800 (PST)
Date:   Fri, 20 Nov 2020 11:53:29 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/4] arm64: dts: imx8m: add NVMEM provider and
 consumer to read soc unique ID
Message-ID: <20201120105329.GB18581@kozik-lap>
References: <20201120101112.31819-1-alice.guo@nxp.com>
 <20201120101112.31819-3-alice.guo@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201120101112.31819-3-alice.guo@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 06:11:11PM +0800, Alice Guo wrote:
> In order to be able to use NVMEM APIs to read soc unique ID, add the
> nvmem data cell and name for nvmem-cells to the "soc" node, and add a
> nvmem node which provides soc unique ID to efuse@30350000.
> 
> v2: remove the subject prefix "LF-2571-3"
> v3: convert register addresses and sizes to hex
> v4: delete "stuff" in subject and commit message, add detailed
>     description
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 6 ++++++
>  arch/arm64/boot/dts/freescale/imx8mn.dtsi | 6 ++++++
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++++
>  4 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> index d457ce815e68..0e0edd5db07b 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -261,6 +261,8 @@
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  		ranges = <0x0 0x0 0x0 0x3e000000>;
> +		nvmem-cells = <&imx8mm_uid>;
> +		nvmem-cell-names = "soc_unique_id";
> 
>  		aips1: bus@30000000 {
>  			compatible = "fsl,aips-bus", "simple-bus";
> @@ -518,6 +520,10 @@
>  				#address-cells = <1>;
>  				#size-cells = <1>;
> 
> +				imx8mm_uid: unique_id@410 {

Any reason why device node uses underscore, not a hyphen/dash? Other
fields are proper (it's also naming convention of DT spec and dtc W=2
will point it).

Best regards,
Krzysztof

> +					reg = <0x4 0x8>;
> +				};
> +
>  				cpu_speed_grade: speed-grade@10 {
>  					reg = <0x10 4>;
>  				};
