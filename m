Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA25C273ADF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgIVG1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbgIVG1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:27:48 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8908C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:27:48 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d9so11518078pfd.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=woHFhNdFvWZhxnzjj5p36qds2qzyLIuLI/tFt/hEi8Y=;
        b=UrlCgqemp+/Bor9qmpDKI/tKMYlxfjLjB5G7IpOHTCg8dK05bL1+AgPSL/OzBCBCtt
         hHYEwaAtIXFUxnFvjdP2/H7j028gPXRq5ygqGraplX6ouXF66btXX4G7TUSdxNWHQjw3
         KWKDmtjVuUdz8BlIlJOUujeTq4tYJjyIS9KupKlQsxubs7UAVxBr57NG7XMOUOErkGde
         YP8/bLewl3HWvPviCBYOlq2BW5UMLTd2+pGk8vudVORWwhfsllS38RkuRWuX1bwFikW3
         A1TCl0DpOx4B3RI5ZKE+APvi59MdDXryMtbELcEqrtA1yLlcjpp9Udz4EuvIrxzwKxP4
         1kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=woHFhNdFvWZhxnzjj5p36qds2qzyLIuLI/tFt/hEi8Y=;
        b=Z894wuIhn2sDcsMbgXeA9qbKLBCOiViqXdLzN1SUNzn4D4atjQgW2aqu8n5Z04ch1y
         hpVWQfm2MrstVJ/dwJoxpioPUjzCO2gZFt6Z0cT8Qp9PoI4Av37dxkAcRglZ6oppJ1ne
         rNo8JbWPKfAwRsozoCRfZ55h/zJboGQCPXtGvMWEVn4hhXzWwqYQaloTvZlQ8nyML+C5
         wVEIBYDbgwlL6dWySQIl0iuudmdIhv6H65+aB3Fk2pioOOKrsp6sg2V+wzacL9rsyS1B
         zxhuieUxYtx4ay2JdkzV+3JY3IpdabFF0J7r+yh8kl+PZOFoE58zTotm6ANXpYOBJ0yL
         vrhQ==
X-Gm-Message-State: AOAM531xni1YgElcHlJHA2b7XxOpgYKtbAzdNjqWZBgXRB7CBHPLF5ot
        DrGp+Oix/QV4rcK5UL3cMDOn
X-Google-Smtp-Source: ABdhPJwBZlI2BuI4jTySxavQ+CeYSPq9SQ5+WuL5fnrirKYHpWeAlh82GocOydmJbKRN3O427LPLYQ==
X-Received: by 2002:a17:902:7c0c:b029:d1:f38b:713b with SMTP id x12-20020a1709027c0cb02900d1f38b713bmr3330711pll.44.1600756068175;
        Mon, 21 Sep 2020 23:27:48 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e1c:c062:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id a5sm13045509pgk.13.2020.09.21.23.27.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Sep 2020 23:27:47 -0700 (PDT)
Date:   Tue, 22 Sep 2020 11:57:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     afaerber@suse.de, mark.rutland@arm.com, robh+dt@kernel.org,
        edgar.righi@lsitec.org.br, igor.lima@lsitec.org.br,
        helen.koike@collabora.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v7 3/4] ARM: dts: Add Caninos Loucos Labrador v2
Message-ID: <20200922062740.GD29035@Mani-XPS-13-9360>
References: <20200922024302.205062-1-matheus@castello.eng.br>
 <20200922024302.205062-4-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922024302.205062-4-matheus@castello.eng.br>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:43:01PM -0300, Matheus Castello wrote:
> Add Device Trees for Caninos Loucos Labrador CoM Core v2 and base board
> M v1. Based on the work of Andreas Färber on Lemaker Guitar device tree.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Andreas Färber <afaerber@suse.de>

Applied for v5.10!

Thanks,
Mani

> ---
>  arch/arm/boot/dts/Makefile                    |  1 +
>  .../arm/boot/dts/owl-s500-labrador-base-m.dts | 35 +++++++++++++++++++
>  arch/arm/boot/dts/owl-s500-labrador-v2.dtsi   | 22 ++++++++++++
>  3 files changed, 58 insertions(+)
>  create mode 100644 arch/arm/boot/dts/owl-s500-labrador-base-m.dts
>  create mode 100644 arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4572db3fa5ae..5d5e370af290 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -868,6 +868,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
>  dtb-$(CONFIG_ARCH_ACTIONS) += \
>  	owl-s500-cubieboard6.dtb \
>  	owl-s500-guitar-bb-rev-b.dtb \
> +	owl-s500-labrador-base-m.dtb \
>  	owl-s500-sparky.dtb
>  dtb-$(CONFIG_ARCH_PRIMA2) += \
>  	prima2-evb.dtb
> diff --git a/arch/arm/boot/dts/owl-s500-labrador-base-m.dts b/arch/arm/boot/dts/owl-s500-labrador-base-m.dts
> new file mode 100644
> index 000000000000..c92f8bdcb331
> --- /dev/null
> +++ b/arch/arm/boot/dts/owl-s500-labrador-base-m.dts
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Caninos Labrador Base Board
> + *
> + * Copyright (c) 2019-2020 Matheus Castello
> + */
> +
> +/dts-v1/;
> +
> +#include "owl-s500-labrador-v2.dtsi"
> +
> +/ {
> +	model = "Caninos Labrador Core v2 on Labrador Base-M v1";
> +	compatible = "caninos,labrador-base-m",
> +		     "caninos,labrador-v2", "actions,s500";
> +
> +	aliases {
> +		serial3 = &uart3;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial3:115200n8";
> +	};
> +
> +	uart3_clk: uart3-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <921600>;
> +		#clock-cells = <0>;
> +	};
> +};
> +
> +&uart3 {
> +	status = "okay";
> +	clocks = <&uart3_clk>;
> +};
> diff --git a/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi b/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
> new file mode 100644
> index 000000000000..883ff2f9886d
> --- /dev/null
> +++ b/arch/arm/boot/dts/owl-s500-labrador-v2.dtsi
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Caninos Labrador SoM V2
> + *
> + * Copyright (c) 2019-2020 Matheus Castello
> + */
> +
> +#include "owl-s500.dtsi"
> +
> +/ {
> +	model = "Caninos Labrador Core V2.1";
> +	compatible = "caninos,labrador-v2", "actions,s500";
> +
> +	memory@0 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000>;
> +	};
> +};
> +
> +&timer {
> +	clocks = <&hosc>;
> +};
> --
> 2.28.0
> 
