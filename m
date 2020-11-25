Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842A32C36CE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 03:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgKYC2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:28:54 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8031 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgKYC2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:28:53 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CglDv5gDtzhgmF;
        Wed, 25 Nov 2020 10:28:31 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 25 Nov 2020 10:28:50 +0800
Subject: Re: [PATCH 4/8] arm64: dts: hisilicon: Use generic "ngpios" rather
 than "snps,nr-gpios"
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20201109170258.4a70c768@xhacker.debian>
 <20201109170529.2ee1f04e@xhacker.debian>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        "Linus Walleij" <linus.walleij@linaro.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5FBDC161.8020700@hisilicon.com>
Date:   Wed, 25 Nov 2020 10:28:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20201109170529.2ee1f04e@xhacker.debian>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On 2020/11/9 17:05, Jisheng Zhang wrote:
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
>  arch/arm64/boot/dts/hisilicon/hip05.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> index bc49955360db..fbe83eb9f77b 100644
> --- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
> @@ -335,7 +335,7 @@ porta: gpio-controller@0 {
>  				compatible = "snps,dw-apb-gpio-port";
>  				gpio-controller;
>  				#gpio-cells = <2>;
> -				snps,nr-gpios = <32>;
> +				ngpios = <32>;
>  				reg = <0>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
> @@ -354,7 +354,7 @@ portb: gpio-controller@0 {
>  				compatible = "snps,dw-apb-gpio-port";
>  				gpio-controller;
>  				#gpio-cells = <2>;
> -				snps,nr-gpios = <32>;
> +				ngpios = <32>;
>  				reg = <0>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
> 

Thanks!
Applied to the hisilicon arm64 dt tree.

Best Regards,
Wei
