Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980622B8A38
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 04:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgKSDAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 22:00:32 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3462 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgKSDAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 22:00:32 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fb5dfc60000>; Wed, 18 Nov 2020 19:00:22 -0800
Received: from [10.19.109.31] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 19 Nov
 2020 02:59:30 +0000
Subject: Re: [PATCH v1] arm64: tegra: jetson-tx1: Fix USB_VBUS_EN0 regulator
To:     Jon Hunter <jonathanh@nvidia.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20201118034631.74127-1-jckuo@nvidia.com>
 <6e21646a-a687-65b7-cd69-2c15e29e8241@nvidia.com>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <0d66af1a-c136-7065-503d-ca13a7468943@nvidia.com>
Date:   Thu, 19 Nov 2020 10:59:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6e21646a-a687-65b7-cd69-2c15e29e8241@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1605754822; bh=jzwATxT+Ubz8G3PVDqapbCWbdWIJYZPlbzxuOVZVq/c=;
        h=Subject:To:CC:References:X-Nvconfidentiality:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=mY5X9ZiTO1N7TteprsJQid7L3BlGzYjQJTIENPh5SGNgjkoUZXZY6zK0/fhqX/vAJ
         RDHjCGzRHf1sJeK52mZoJgQ5T+AXvZBhCJneKN5Y8TOnQ6/98mZ0l/ImLI1HNyqcTk
         lClc9ur4GzHVi/dcOaf89oG1uNqu/eMRPPkz/BEV4PMwnCLYu+pk5Ho3QGPRjOEpFv
         K+FmB4rkzTfee8kOyGdAFny5vj7XagjXCUtcKGEqibiG+ZuDmRUOage62LGN1Tee4F
         njVLuJxH8mwy5KZwx6QW4xNaYepfn/Wqu4yKGyUSopkdIsPb7WHkRSu3zE9Z+FCbTE
         kjrzZLN9XIXFQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/20 7:24 PM, Jon Hunter wrote:
> 
> On 18/11/2020 03:46, JC Kuo wrote:
>> USB_VBUS_EN0 regulator (regulator@11) is being overwritten by vdd-cam-1v2
>> regulator. This commit rearrange USB_VBUS_EN0 to be regulator@14.
>>
>> Signed-off-by: JC Kuo <jckuo@nvidia.com>
>> ---
>>  .../arm64/boot/dts/nvidia/tegra210-p2597.dtsi | 20 +++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
>> index e18e1a9a3011..a9caaf7c0d67 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi
>> @@ -1663,16 +1663,6 @@ vdd_usb_vbus: regulator@9 {
>>  		vin-supply = <&vdd_5v0_sys>;
>>  	};
>>  
>> -	vdd_usb_vbus_otg: regulator@11 {
>> -		compatible = "regulator-fixed";
>> -		regulator-name = "USB_VBUS_EN0";
>> -		regulator-min-microvolt = <5000000>;
>> -		regulator-max-microvolt = <5000000>;
>> -		gpio = <&gpio TEGRA_GPIO(CC, 4) GPIO_ACTIVE_HIGH>;
>> -		enable-active-high;
>> -		vin-supply = <&vdd_5v0_sys>;
>> -	};
>> -
>>  	vdd_hdmi: regulator@10 {
>>  		compatible = "regulator-fixed";
>>  		regulator-name = "VDD_HDMI_5V0";
>> @@ -1712,4 +1702,14 @@ vdd_cam_1v8: regulator@13 {
>>  		enable-active-high;
>>  		vin-supply = <&vdd_3v3_sys>;
>>  	};
>> +
>> +	vdd_usb_vbus_otg: regulator@14 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "USB_VBUS_EN0";
>> +		regulator-min-microvolt = <5000000>;
>> +		regulator-max-microvolt = <5000000>;
>> +		gpio = <&gpio TEGRA_GPIO(CC, 4) GPIO_ACTIVE_HIGH>;
>> +		enable-active-high;
>> +		vin-supply = <&vdd_5v0_sys>;
>> +	};
>>  };
>>
> 
> Thanks for catching this! We should add the 'Fixes:' tag.
Thanks for review. I will submit v2 and add 'Fixes:' tag.
> 
> By the way, I assume that VBUS is currently broken for the OTG port.
> Without this change is that USB port completely broken? I am wondering
> if we need to CC stable@vger.kernel.org on this.
You are correct. Host mode at the OTG port is currently broken because VBUS is
not supplied to the OTG port. I will CC stable@vger.kernel.org when send v2.
> 
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Cheers
> Jon
> 
