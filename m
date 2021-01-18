Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45852FA6B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393243AbhARQuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393423AbhARQtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:49:19 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BF3C061573;
        Mon, 18 Jan 2021 08:48:37 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s11so11030192edd.5;
        Mon, 18 Jan 2021 08:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MdavDPScT8OMhzBsegf4N4uuSFdYSkhFpD+67Vj7XX4=;
        b=rjR+0plW0jpyDPgI6e9OUdyRjou3VeQ4qpxqBG4i+DV6JbdbOvKLk63j4OWwBKmW8R
         M9Cx5VPfOMI1eTNEhutT7gh4rcGKXVvX+bvhAm4f/LBHg0T59erwISKG2qvBSfPqnji4
         gyqbBXlutXpdB8Hw2x2L+XimtM5305BezpSXAcq5Gqxr2W/PoSpTbhwjDx49u24F2cUi
         Enh3cXAf2WxwL5a3RW0BtK1Ho3cdTruGR6IXrNpgkEkvaszjs3COnsX0NhZPhNePFut9
         +TJK4lsKmLMFdR/T5Sb/QgiwwIGrpL8K8XH5PLoATmTEM7tgOljPnWLFlKvTnzNE9Ltj
         DFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MdavDPScT8OMhzBsegf4N4uuSFdYSkhFpD+67Vj7XX4=;
        b=LPaZpPwE5S5sLdCn0tfTEOqFM7hq7TnzAKqJTEn8XO4kPr+9kQ7qUK80TuO1O/Xff8
         bkSBvHPazbn97AHJFA+Z7azJcl0+3OXghwKFU6+ox3Zg87o6W9tBjEoJ3jRneM53r4eJ
         VJAUjViYZnYgYvarAYmthrvJ1qohh029EXF/WRrAjUYtnuv6XP23wDM2y84IeF5LvjN7
         nUokZFYAZzKjx0xNN/lLTg0KyJLlIipD+/+esuVTrPzpWVd5UcFErTVcBGOWIARAFay6
         mdaGQLTbIxWhPOK4xJRyqEZ4ZrCPH1kanf/PFcuuKE8MbJDcF2ydlYFf2Co50dNom7kH
         TuXA==
X-Gm-Message-State: AOAM531V05WSr6W0MjmH2mB12ikFsKADmxK7P5bwbMbLjpSAZnrnAcKX
        8PzeG3HHiozA3Y5S8rBQarXjZPZhaio=
X-Google-Smtp-Source: ABdhPJzpYtzVUi2XrlE1b/f2Q7A5d5j6NrtBFUvOylh6ry9hP/bQDkPOSi1NNGAvQoaDbG4A2SJGFw==
X-Received: by 2002:aa7:ce87:: with SMTP id y7mr262073edv.211.1610988516027;
        Mon, 18 Jan 2021 08:48:36 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id m24sm9618925ejo.52.2021.01.18.08.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 08:48:35 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: rockchip: cleanup cpu_thermal node of
 rk3399-rock960.dts
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210118163306.8693-1-jbx6244@gmail.com>
Message-ID: <c6dfa1a7-4a61-2e80-fe43-add1af611395@gmail.com>
Date:   Mon, 18 Jan 2021 17:48:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210118163306.8693-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry.
This can go in the bin...
It needs more cleanup...
See question below.

On 1/18/21 5:33 PM, Johan Jonker wrote:
> The cpu_thermal node in the rk3399-rock960.dts file does not
> reference &cpu_thermal directly to add the board-specific parts,
> but also repeats all the SoC default properties.
> Clean the whole thing up and fix alignment.
> Place node in the correct alphabetical order.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399-rock960.dts | 75 ++++++++++++-------------
>  1 file changed, 36 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> index b20774081..bff8a73d9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> @@ -63,6 +63,42 @@
>  
>  };
>  
> +&cpu_thermal {
> +	polling-delay-passive = <100>;
> +	polling-delay = <1000>;
> +	thermal-sensors = <&tsadc 0>;
> +	sustainable-power = <1550>;
> +
> +	trips {
> +		cpu_alert0: cpu_alert0 {
> +			temperature = <65000>;
> +			hysteresis = <2000>;
> +			type = "passive";
> +		};
> +
> +		cpu_alert1: cpu_alert1 {
> +			temperature = <75000>;
> +			hysteresis = <2000>;
> +			type = "passive";
> +		};
> +
> +		cpu_crit: cpu_crit {
> +			temperature = <95000>;
> +			hysteresis = <2000>;
> +			type = "critical";
> +		};
> +	};
> +
> +	cooling-maps {
> +		map0 {
> +			trip = <&cpu_alert1>;
> +			cooling-device =
> +				<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +				<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +		};
> +	};
> +};
> +
>  &pcie0 {
>  	ep-gpios = <&gpio2 RK_PA2 GPIO_ACTIVE_HIGH>;
>  };
> @@ -125,45 +161,6 @@
>  	status = "okay";
>  };
>  
> -&thermal_zones {
> -	cpu_thermal: cpu-thermal {
> -		polling-delay-passive = <100>;
> -		polling-delay = <1000>;
> -		thermal-sensors = <&tsadc 0>;
> -		sustainable-power = <1550>;
> -
> -		trips {
> -			cpu_alert0: cpu_alert0 {
> -				    temperature = <65000>;
> -				    hysteresis = <2000>;
> -				    type = "passive";
> -			};
> -
> -			cpu_alert1: cpu_alert1 {
> -				    temperature = <75000>;
> -				    hysteresis = <2000>;
> -				    type = "passive";
> -			};
> -
> -			cpu_crit: cpu_crit {
> -				  temperature = <95000>;
> -				  hysteresis = <2000>;
> -				  type = "critical";
> -			};
> -		};
> -
> -		cooling-maps {

> -			     map0 {
> -
> -			     trip = <&cpu_alert1>;

The trip property points to "cpu_alert1", while in rk3399.dtsi that is
"&cpu_alert0"
What is correct here?


> -			     cooling-device =
> -					<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -					<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -			};
> -		};
> -	};
> -};
> -
>  &usbdrd_dwc3_0 {
>  	dr_mode = "otg";
>  };
> 


				map0 {
					trip = <&cpu_alert0>;
					cooling-device =
						<&cpu_b0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
						<&cpu_b1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
				};
