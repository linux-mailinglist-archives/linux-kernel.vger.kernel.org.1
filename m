Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDED29E596
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 09:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387881AbgJ2H7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:59:03 -0400
Received: from z5.mailgun.us ([104.130.96.5]:14197 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388021AbgJ2H6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:58:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603958326; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=TlU0fDOuXAQSqUNYC4Vl1Hk+7AlQn1pnRJi/r7LKsoc=; b=CV6WhkU3iAstERX9Ewlzdr7I2YNZEo8IHI3WQwzqgtrr92DOhNKNVQiQv7n5pu3fPZOdU45l
 PYOL8r4h9DDCYslAPGF0aTOsAx/f8fV0GLoV6tbTT3YfevL2I0BfecImknNeI+xxfQSP+Aa6
 4M77v8zr3kK7YTUk64Dl4sr2YoY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f9a763038c6e400455d6955 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Oct 2020 07:58:40
 GMT
Sender: akhilpo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C3451C433C9; Thu, 29 Oct 2020 07:58:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.9] (unknown [61.3.76.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 63B9BC433FE;
        Thu, 29 Oct 2020 07:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 63B9BC433FE
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akhilpo@codeaurora.org
Subject: Re: [v3,2/3] arm64: dts: qcom: sc7180: Add gpu cooling support
To:     mka@chromium.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        dri-devel@freedesktop.org, freedreno@lists.freedesktop.org
References: <1603892395-3570-2-git-send-email-akhilpo@codeaurora.org>
 <20201029003931.GA1855806@google.com>
From:   Akhil P Oommen <akhilpo@codeaurora.org>
Message-ID: <2919f377-4824-dc85-aa2c-c3ce252d437c@codeaurora.org>
Date:   Thu, 29 Oct 2020 13:28:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201029003931.GA1855806@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/2020 6:09 AM, mka@chromium.org wrote:
> Hi Akhil,
> 
> On Wed, Oct 28, 2020 at 07:09:53PM +0530, Akhil P Oommen wrote:
>> Add cooling-cells property and the cooling maps for the gpu tzones
>> to support GPU cooling.
>>
>> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7180.dtsi | 30 +++++++++++++++++++++++-------
>>   1 file changed, 23 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> index d46b383..a7ea029 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
>> @@ -2,7 +2,7 @@
>>   /*
>>    * SC7180 SoC device tree source
>>    *
>> - * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2019-20, The Linux Foundation. All rights reserved.
>>    */
>>   
>>   #include <dt-bindings/clock/qcom,dispcc-sc7180.h>
>> @@ -1886,6 +1886,8 @@
>>   			operating-points-v2 = <&gpu_opp_table>;
>>   			qcom,gmu = <&gmu>;
>>   
>> +			#cooling-cells = <2>;
>> +
>>   			interconnects = <&gem_noc MASTER_GFX3D &mc_virt SLAVE_EBI1>;
>>   			interconnect-names = "gfx-mem";
>>   
>> @@ -3825,16 +3827,16 @@
>>   		};
>>   
>>   		gpuss0-thermal {
>> -			polling-delay-passive = <0>;
>> +			polling-delay-passive = <100>;
>>   			polling-delay = <0>;
>>   
>>   			thermal-sensors = <&tsens0 13>;
>>   
>>   			trips {
>>   				gpuss0_alert0: trip-point0 {
>> -					temperature = <90000>;
>> +					temperature = <95000>;
>>   					hysteresis = <2000>;
>> -					type = "hot";
>> +					type = "passive";
>>   				};
>>   
>>   				gpuss0_crit: gpuss0_crit {
>> @@ -3843,19 +3845,26 @@
>>   					type = "critical";
>>   				};
>>   			};
>> +
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&gpuss0_alert0>;
>> +					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>>   		};
>>   
>>   		gpuss1-thermal {
>> -			polling-delay-passive = <0>;
>> +			polling-delay-passive = <100>;
>>   			polling-delay = <0>;
>>   
>>   			thermal-sensors = <&tsens0 14>;
>>   
>>   			trips {
>>   				gpuss1_alert0: trip-point0 {
>> -					temperature = <90000>;
>> +					temperature = <95000>;
>>   					hysteresis = <2000>;
>> -					type = "hot";
>> +					type = "passive";
>>   				};
>>   
>>   				gpuss1_crit: gpuss1_crit {
>> @@ -3864,6 +3873,13 @@
>>   					type = "critical";
>>   				};
>>   			};
>> +
>> +			cooling-maps {
>> +				map0 {
>> +					trip = <&gpuss0_alert0>;
> 
> Copy & paste error, this should be 'gpuss1_alert0'.
aah! you are correct.

--Akhil
> 
>> +					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +				};
>> +			};
>>   		};
>>   
>>   		aoss1-thermal {
> 
> 
> Other than the C&P error:
> 
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

