Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F08C2E9F72
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 22:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbhADVUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 16:20:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbhADVUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 16:20:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69B0E216C4;
        Mon,  4 Jan 2021 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609795171;
        bh=zO6+WXbnZQQa5gtNXGGXGB/Dm+JTT/SJtmVKDTQFkGY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fMZ/t2MbLrzIC/TC/K6F1g7NiCrgOvl1OQIDb7loC9qdDFGMfma8FOuhexVVnjB6t
         XuJvKKHjPb8wQeQHuWep9d+y8vez7FLBjuZb6Kd8Zm3Y6pQx/CpvUlyiHVSxSyNGQE
         aU2EwToaZIdHdsr6H6GqYWo/z0QUwbFWD8z5bOC3C81OnCWuppj/Ha+O+HpLBXYVOe
         MIDNvauuybhCV+e/dP8FK06b4MZZf766TxL6GQdKhjSrCjj3mQEf8yRLSunboa9dKY
         BzCkK63I58m2Q0B6mZalpr88NnU9t6L+syOqb06CVCWy3aJZxGtcRGPjkArWkruZ5F
         yVl7Z1RdP88cQ==
Subject: Re: [PATCH 8/8] ARM: dts: socfgpa: Use generic "ngpios" rather than
 "snps,nr-gpios"
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Linus Walleij <linus.walleij@linaro.org>
References: <20201109170258.4a70c768@xhacker.debian>
 <20201109170712.6e8c1a90@xhacker.debian>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <f2cba2f2-338a-793f-a5bf-a95acc28e6f4@kernel.org>
Date:   Mon, 4 Jan 2021 15:19:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201109170712.6e8c1a90@xhacker.debian>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/20 3:07 AM, Jisheng Zhang wrote:
> This is to remove similar errors as below:
> 
> OF: /.../gpio-port@0: could not find phandle
> 
> Commit 7569486d79ae ("gpio: dwapb: Add ngpios DT-property support")
> explained the reason of above errors well and added the generic
> "ngpios" property, let's use it.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>   arch/arm/boot/dts/socfpga.dtsi         | 6 +++---
>   arch/arm/boot/dts/socfpga_arria10.dtsi | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index 0b021eef0b53..32b7ad814ec6 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -612,7 +612,7 @@ porta: gpio-controller@0 {
>   				compatible = "snps,dw-apb-gpio-port";
>   				gpio-controller;
>   				#gpio-cells = <2>;
> -				snps,nr-gpios = <29>;
> +				ngpios = <29>;
>   				reg = <0>;
>   				interrupt-controller;
>   				#interrupt-cells = <2>;
> @@ -633,7 +633,7 @@ portb: gpio-controller@0 {
>   				compatible = "snps,dw-apb-gpio-port";
>   				gpio-controller;
>   				#gpio-cells = <2>;
> -				snps,nr-gpios = <29>;
> +				ngpios = <29>;
>   				reg = <0>;
>   				interrupt-controller;
>   				#interrupt-cells = <2>;
> @@ -654,7 +654,7 @@ portc: gpio-controller@0 {
>   				compatible = "snps,dw-apb-gpio-port";
>   				gpio-controller;
>   				#gpio-cells = <2>;
> -				snps,nr-gpios = <27>;
> +				ngpios = <27>;
>   				reg = <0>;
>   				interrupt-controller;
>   				#interrupt-cells = <2>;
> diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
> index 0013ec3463c4..34e23e0582fb 100644
> --- a/arch/arm/boot/dts/socfpga_arria10.dtsi
> +++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
> @@ -491,7 +491,7 @@ porta: gpio-controller@0 {
>   				compatible = "snps,dw-apb-gpio-port";
>   				gpio-controller;
>   				#gpio-cells = <2>;
> -				snps,nr-gpios = <29>;
> +				ngpios = <29>;
>   				reg = <0>;
>   				interrupt-controller;
>   				#interrupt-cells = <2>;
> @@ -511,7 +511,7 @@ portb: gpio-controller@0 {
>   				compatible = "snps,dw-apb-gpio-port";
>   				gpio-controller;
>   				#gpio-cells = <2>;
> -				snps,nr-gpios = <29>;
> +				ngpios = <29>;
>   				reg = <0>;
>   				interrupt-controller;
>   				#interrupt-cells = <2>;
> @@ -531,7 +531,7 @@ portc: gpio-controller@0 {
>   				compatible = "snps,dw-apb-gpio-port";
>   				gpio-controller;
>   				#gpio-cells = <2>;
> -				snps,nr-gpios = <27>;
> +				ngpios = <27>;
>   				reg = <0>;
>   				interrupt-controller;
>   				#interrupt-cells = <2>;
> 

Applied to socfpga dts tree.

Thanks,
Dinh
