Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363F02BA2D3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgKTHGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:06:47 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34642 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgKTHGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:06:47 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AK76g0p073306;
        Fri, 20 Nov 2020 01:06:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605856002;
        bh=4ZnHtj3JkqJd6wTi9h6QLIgdwNG0j6oy+5LGrYhIv14=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jSrsHXuWEl6MCckHdxtlTjaltwI0sQtkD8dXoAE/xX3vWfJNduviFQ76LUEzDe2Wl
         YhtNCsFibTa5WSN8Di82KGVFUR01FDPILcY/gl1tOu7QV3ld3Q/8cY/wF/RN73XZ0b
         ErnBmeI6LUYd0E5CADfzq9sNi0l+EJIFwYnR51C4=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AK76g2s039565
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Nov 2020 01:06:42 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 20
 Nov 2020 01:06:41 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 20 Nov 2020 01:06:41 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AK76dfi041154;
        Fri, 20 Nov 2020 01:06:40 -0600
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j7200-common-proc-board: Correct
 the name of io expander on main_i2c1
To:     Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        <t-kristo@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nsekhar@ti.com>
References: <20201119132627.8041-1-peter.ujfalusi@ti.com>
 <20201119132627.8041-3-peter.ujfalusi@ti.com>
 <dc2f740a-e53e-d612-0ec7-e69bf8228e71@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <30c98749-5893-ffa4-6351-ee805b93bcb6@ti.com>
Date:   Fri, 20 Nov 2020 09:07:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <dc2f740a-e53e-d612-0ec7-e69bf8228e71@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/11/2020 18.10, Vignesh Raghavendra wrote:
> 
> 
> On 11/19/20 6:56 PM, Peter Ujfalusi wrote:
>> J7200 main_i2c1 is connected to the i2c bus on the CPB marked as main_i2c3
>>
>> The i2c1 devices on the CPB are _not_ connected to the SoC, they are not
>> usable with the J7200 SOM.
>>
>> Correct the expander name from exp4 to exp3 and at the same time add the
>> line names as well.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
> 
> Yes, the schematics call this expander as exp3. Thanks for the fix

The CPB is the same for both j721e and j7200 SOMs.
I'll send v2 with a small comment block to explain this.

> Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>
> 
>>  arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> index 2721137d8943..83e043c65f81 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> @@ -159,11 +159,14 @@ &main_i2c1 {
>>  	pinctrl-0 = <&main_i2c1_pins_default>;
>>  	clock-frequency = <400000>;
>>  
>> -	exp4: gpio@20 {
>> +	exp3: gpio@20 {
>>  		compatible = "ti,tca6408";
>>  		reg = <0x20>;
>>  		gpio-controller;
>>  		#gpio-cells = <2>;
>> +		gpio-line-names = "CODEC_RSTz", "CODEC_SPARE1", "UB926_RESETn",
>> +				  "UB926_LOCK", "UB926_PWR_SW_CNTRL",
>> +				  "UB926_TUNER_RESET", "UB926_GPIO_SPARE", "";
> 
> I assume these lines have same meaning in J721e and J7200? If so, then
> no issues.
> 
>>  	};
>>  };
>>  
>>

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
