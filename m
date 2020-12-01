Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209492CABA6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbgLATUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgLATUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:20:11 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0CEC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:19:25 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id t18so2780901otk.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LckDgaqy2Wn4VuU1MAexf+GwPBgKOOjs/09Enf2QqEI=;
        b=jvGu+3Q2FsjzlBtj5IKsZi6iALz3dK5Xe3RDwwDEe1RT2cUcBSZmgBrAEOUEy0o6h7
         Znugijy0meUrqw/tVTge/FAqw7rmxM+jFVbXFXnewASdmgRQGEazt0bvEfji8750r+Tf
         zpINcxzekeIzYml0kcdkNaQ48tq+QTDU7oQoplnoj/QcQ5VXENH2vFCv7U3OdurXFpcx
         39Tt4JyzaZL28+wB8w3eVpIrtF3s0dU+yYwl4mCZ1uTruwlPZHgywD6y1cMn3mZkLokV
         8lvGdixK+43GbWXPwT2HBi77PqcpznA2HnucSvw6FetZzxUPlyvNT27HgMXME4SxGtRv
         6BYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LckDgaqy2Wn4VuU1MAexf+GwPBgKOOjs/09Enf2QqEI=;
        b=dlEiDOJDuDiKjk94Af8NucjBw2ZK05TKd0Jl2bt/A2Ralhcrz6cApbOZk9eva+hhQK
         OnWLeqplv4g10f9KrYONL4XVkGxOajqG7k3NLMjk2FIFG9ECSXQHXrpVhRU+TDIv4FtH
         vwnHh1W7jUyHoXZJXbPdr/nXUdpDFnuyrWhEcMzLbSWVGxoAxFGoRZ6DPK0d8ef6a6o2
         /PIpIbpNu+oRV9Z+BmOb/ivIIRekNHk4PUikBa/3ITBX1sdn5vk3lLpbj4j2inAqMFSX
         Mbu5CJObTspNiloClGjhA7lNDNVSWn78xf4Bs5KSKKHzvJLRFWaei13LposaD/DIGFTC
         y96g==
X-Gm-Message-State: AOAM532xFhAQpSCre+3jcIm2IRHvPqimBzLoxCAp0Ml5wV2XUfE0zcZV
        nDoJPzfF/u1+pKlME22oDI68Sg==
X-Google-Smtp-Source: ABdhPJziF8nfchXr/paN/pGLeZ7h7zcwalH41lLBL6jw9cAaRkTEMDNlDx8yasaAW1upVFR/s15mIw==
X-Received: by 2002:a05:6830:1e08:: with SMTP id s8mr2926116otr.144.1606850365226;
        Tue, 01 Dec 2020 11:19:25 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u20sm99053oie.56.2020.12.01.11.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:19:24 -0800 (PST)
Date:   Tue, 1 Dec 2020 13:19:22 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8250: add mi2s pinconfs
Message-ID: <X8aXOp/E226yyufx@builder.lan>
References: <20201201153706.13450-1-srinivas.kandagatla@linaro.org>
 <20201201153706.13450-6-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201153706.13450-6-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01 Dec 09:37 CST 2020, Srinivas Kandagatla wrote:

> Add primary and tertinary mi2s pinconfs required to get I2S audio.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 98 ++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 19dd7460e586..a87940e157be 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -1561,6 +1561,9 @@
>  			};
>  		};
>  
> +		sound: sound {
> +		};
> +
>  		usb_1_hsphy: phy@88e3000 {
>  			compatible = "qcom,sm8250-usb-hs-phy",
>  				     "qcom,usb-snps-hs-7nm-phy";
> @@ -1884,6 +1887,60 @@
>  			gpio-ranges = <&tlmm 0 0 180>;
>  			wakeup-parent = <&pdc>;
>  
> +			pri_mi2s_sck_active: pri-mi2s-sck-active {
> +				mux {

As in patch 3, please make these state-centric and flatten the inner
subnode.

> +					pins = "gpio138";
> +					function = "mi2s0_sck";
> +				};
> +
> +				config {
> +					pins = "gpio138";
> +					drive-strength = <8>;
> +					bias-disable;
> +					output-high;

If function is mi2s0_sck is the output value relevant? Or should this
be dropped?

Regards,
Bjorn

> +				};
> +			};
> +
> +			pri_mi2s_ws_active: pri-mi2s-ws-active {
> +				mux {
> +					pins = "gpio141";
> +					function = "mi2s0_ws";
> +				};
> +
> +				config {
> +					pins = "gpio141";
> +					drive-strength = <8>;
> +					output-high;
> +				};
> +			};
> +
> +			pri_mi2s_sd0_active: pri-mi2s-sd0-active {
> +				mux {
> +					pins = "gpio139";
> +					function = "mi2s0_data0";
> +				};
> +
> +				config {
> +					pins = "gpio139";
> +					drive-strength = <8>;
> +					bias-disable;
> +					output-high;
> +				};
> +			};
> +
> +			pri_mi2s_sd1_active: pri-mi2s-sd1-active {
> +				mux {
> +					pins = "gpio140";
> +					function = "mi2s0_data1";
> +				};
> +
> +				config {
> +					pins = "gpio140";
> +					drive-strength = <8>;
> +					output-high;
> +				};
> +			};
> +
>  			qup_i2c0_default: qup-i2c0-default {
>  				mux {
>  					pins = "gpio28", "gpio29";
> @@ -2480,6 +2537,47 @@
>  					function = "qup18";
>  				};
>  			};
> +
> +			tert_mi2s_sck_active: tert-mi2s-sck-active {
> +				mux {
> +					pins = "gpio133";
> +					function = "mi2s2_sck";
> +				};
> +
> +				config {
> +					pins = "gpio133";
> +					drive-strength = <8>;
> +					bias-disable;
> +					output-high;
> +				};
> +			};
> +
> +			tert_mi2s_sd0_active: tert-mi2s-sd0-active {
> +				mux {
> +					pins = "gpio134";
> +					function = "mi2s2_data0";
> +				};
> +
> +				config {
> +					pins = "gpio134";
> +					drive-strength = <8>;
> +					bias-disable;
> +					output-high;
> +				};
> +			};
> +
> +			tert_mi2s_ws_active: tert-mi2s-ws-active {
> +				mux {
> +					pins = "gpio135";
> +					function = "mi2s2_ws";
> +				};
> +
> +				config {
> +					pins = "gpio135";
> +					drive-strength = <8>;
> +					output-high;
> +				};
> +			};
>  		};
>  
>  		apps_smmu: iommu@15000000 {
> -- 
> 2.21.0
> 
