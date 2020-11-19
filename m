Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BB42B977E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgKSQLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:11:07 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57172 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgKSQLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:11:06 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AJGB0Gh006667;
        Thu, 19 Nov 2020 10:11:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605802260;
        bh=yxsGpYL205LqA0daxvYUX0HBguANmgaeAUkE/ZYmpRI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=U0Ti9VoAd27wVoOtxahq9xI2gKTQETn1gM5wT7W2kJiJLFNssjL57jhkVXYl/7ktF
         2H2z5Gdq8SkKiajFUrLh3B2iPCWV0oZN6hlHwE4nrKwcb7tqnho/SSNw52hZSlUd0O
         UzO9vsepWXzIyZAKo+dNdqwkgM2OvVwdk+T8ZeQ4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AJGB0fY131015
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 10:11:00 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 19
 Nov 2020 10:11:00 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 19 Nov 2020 10:11:00 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AJGAvdk090430;
        Thu, 19 Nov 2020 10:10:58 -0600
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j7200-common-proc-board: Correct
 the name of io expander on main_i2c1
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <nm@ti.com>,
        <t-kristo@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nsekhar@ti.com>
References: <20201119132627.8041-1-peter.ujfalusi@ti.com>
 <20201119132627.8041-3-peter.ujfalusi@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <dc2f740a-e53e-d612-0ec7-e69bf8228e71@ti.com>
Date:   Thu, 19 Nov 2020 21:40:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201119132627.8041-3-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/20 6:56 PM, Peter Ujfalusi wrote:
> J7200 main_i2c1 is connected to the i2c bus on the CPB marked as main_i2c3
> 
> The i2c1 devices on the CPB are _not_ connected to the SoC, they are not
> usable with the J7200 SOM.
> 
> Correct the expander name from exp4 to exp3 and at the same time add the
> line names as well.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---

Yes, the schematics call this expander as exp3. Thanks for the fix

Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

>  arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> index 2721137d8943..83e043c65f81 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -159,11 +159,14 @@ &main_i2c1 {
>  	pinctrl-0 = <&main_i2c1_pins_default>;
>  	clock-frequency = <400000>;
>  
> -	exp4: gpio@20 {
> +	exp3: gpio@20 {
>  		compatible = "ti,tca6408";
>  		reg = <0x20>;
>  		gpio-controller;
>  		#gpio-cells = <2>;
> +		gpio-line-names = "CODEC_RSTz", "CODEC_SPARE1", "UB926_RESETn",
> +				  "UB926_LOCK", "UB926_PWR_SW_CNTRL",
> +				  "UB926_TUNER_RESET", "UB926_GPIO_SPARE", "";

I assume these lines have same meaning in J721e and J7200? If so, then
no issues.

>  	};
>  };
>  
> 
