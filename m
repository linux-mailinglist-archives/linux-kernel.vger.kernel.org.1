Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7D12D1E1C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgLGXJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:09:05 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41992 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgLGXJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:09:05 -0500
Received: by mail-ot1-f68.google.com with SMTP id 11so14176774oty.9;
        Mon, 07 Dec 2020 15:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zsVLjp+2xVraSwpotdRQfpDFqATYYtM1FS0Mr8BrZ+c=;
        b=ZFps8B8N2eu9j4Sbl91kBD5HDxYQ/rlCreJV1ak3WBs/T8yNICMYZHLE+QMS3sr8/M
         2PFmWJ0nFcvxtD9aEwGZYXtQWfCz8I9ZjW3IwZF8QrHTQea0/IKrZU/e/Q5DJd6zIiws
         NNCnloQGi0jIyHOS7BomCuQgSj25+bm24+p7Q8tliDv1SlFvVxriDRD0tJBZ17+/cXgf
         ITCqBhSHDbban9l0r1G+VHoVA0kng3jPyGRxmjV4bPQe73PBLum/OFtHlFo5pwHuyQ+W
         Q7TjAqa7101JDtqrOI1GkRV0cX7DeQIxfYLA54+8oMzWI3A2D0BIt3D1tV2cepoxLIsc
         DKHA==
X-Gm-Message-State: AOAM533ufCDJV4FIPp+f+mYE0NxfRUGsYBvrJEVp3KvmwuAi5arb6PcQ
        O+W8ArOfxKTi3sltVq07BQ==
X-Google-Smtp-Source: ABdhPJz4Ez45qvDjUXcFbK2D9LsN06TUB99Be4VmINejvsIBhqWEOY1+GGCCp/E8ICedi7w4b/lemw==
X-Received: by 2002:a05:6830:3151:: with SMTP id c17mr14831740ots.336.1607382504412;
        Mon, 07 Dec 2020 15:08:24 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x72sm3289675oia.16.2020.12.07.15.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 15:08:22 -0800 (PST)
Received: (nullmailer pid 1021070 invoked by uid 1000);
        Mon, 07 Dec 2020 23:08:21 -0000
Date:   Mon, 7 Dec 2020 17:08:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 1/3] reset: hisilicon: correct vendor prefix
Message-ID: <20201207230821.GA1015860@robh.at.kernel.org>
References: <20201204014236.1158-1-thunder.leizhen@huawei.com>
 <20201204014236.1158-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204014236.1158-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 09:42:34AM +0800, Zhen Lei wrote:
> The vendor prefix of "Hisilicon Limited" is "hisilicon", it is clearly
> stated in "vendor-prefixes.yaml".

Yes, but you can't fix this as changing it breaks compability between 
DTBs and kernels.

hisi has to be documented and marked 'deprecated'.

> 
> Fixes: 1527058736fa ("reset: hisilicon: add reset-hi3660")
> Fixes: 35ca8168133c ("arm64: dts: Add dts files for Hisilicon Hi3660 SoC")
> Fixes: dd8c7b78c11b ("arm64: dts: Add devicetree for Hisilicon Hi3670 SoC")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Cc: Chen Feng <puck.chen@hisilicon.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 4 ++--
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi | 2 +-
>  drivers/reset/hisilicon/reset-hi3660.c    | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index 49c19c6879f95ce..bfb1375426d2b58 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -345,7 +345,7 @@
>  		crg_rst: crg_rst_controller {
>  			compatible = "hisilicon,hi3660-reset";
>  			#reset-cells = <2>;
> -			hisi,rst-syscon = <&crg_ctrl>;
> +			hisilicon,rst-syscon = <&crg_ctrl>;
>  		};
>  
>  
> @@ -376,7 +376,7 @@
>  
>  		iomcu_rst: reset {
>  			compatible = "hisilicon,hi3660-reset";
> -			hisi,rst-syscon = <&iomcu>;
> +			hisilicon,rst-syscon = <&iomcu>;
>  			#reset-cells = <2>;
>  		};
>  
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> index 85b0dfb35d6d396..5c5a5dc964ea848 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> @@ -155,7 +155,7 @@
>  			compatible = "hisilicon,hi3670-reset",
>  				     "hisilicon,hi3660-reset";
>  			#reset-cells = <2>;
> -			hisi,rst-syscon = <&crg_ctrl>;
> +			hisilicon,rst-syscon = <&crg_ctrl>;
>  		};
>  
>  		pctrl: pctrl@e8a09000 {
> diff --git a/drivers/reset/hisilicon/reset-hi3660.c b/drivers/reset/hisilicon/reset-hi3660.c
> index a7d4445924e558c..8f1953159a65b31 100644
> --- a/drivers/reset/hisilicon/reset-hi3660.c
> +++ b/drivers/reset/hisilicon/reset-hi3660.c
> @@ -83,7 +83,7 @@ static int hi3660_reset_probe(struct platform_device *pdev)
>  	if (!rc)
>  		return -ENOMEM;
>  
> -	rc->map = syscon_regmap_lookup_by_phandle(np, "hisi,rst-syscon");
> +	rc->map = syscon_regmap_lookup_by_phandle(np, "hisilicon,rst-syscon");
>  	if (IS_ERR(rc->map)) {
>  		dev_err(dev, "failed to get hi3660,rst-syscon\n");
>  		return PTR_ERR(rc->map);
> -- 
> 1.8.3
> 
> 
