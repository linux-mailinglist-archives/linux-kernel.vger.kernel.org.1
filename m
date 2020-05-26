Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025D11DF743
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 14:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbgEWMdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 08:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729150AbgEWMdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 08:33:45 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27054C05BD43
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 05:33:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c3so8641705wru.12
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 05:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+ha2P0gI7/dhCR+x1uWrZGR8vEfMxTFQAnCpem5drIw=;
        b=m5pSwqzqb6HpOMNW5gFCyuwJNBY7jMuVL1za74VwCneV9k6X7R6QpHOUgqEQWRtNn4
         SvgCa954xVeXMD3Km6dpuNgUjmocnT70TzaK9JeGyXbRNIY1Sr3DsXl957oOAGywgQsi
         2XswZKMKCgiGNlyFjiExEZuBIglEdLs1Ps7G1cuh+GODhvIvW2hSCVJJbuKwtIEswduK
         Ca8K/X0yHehp9OEEpgRyIWdiOPMG3ADKIc0H9OYpSdEbduubihaEYZDKvrDe4Uq1g4Bu
         rygpkOerSD5lSVX2Re+Mx0lILNsyegxBIBaxW5W2xzgeXUfsn9fYw9sX273OQBRAf++1
         Wvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+ha2P0gI7/dhCR+x1uWrZGR8vEfMxTFQAnCpem5drIw=;
        b=nhHTcgtkdd2nFSpxcacO8Z+IHvrMO4iSQHlQISkV7ZBS4KCcYrApHzNauS+Ka8ycdq
         8ZjcOgNWTYLu9B/R57g8/AcfeoWWlE8yacI0v/yt3Pe00DRraNAPvV8Yx8VxY5+Wg546
         YhZqDRVmfo6h6R7M5ksSrszweeS3MkJcRl9E9uIWUU3z5j0ogxFyMHeSuhwbDvxir8zt
         DIi+shSfpOKhqXG0hEff5i5bbT4XTJfksdH0WnuoBRa59akkhsnpSpI3/TrFnaGnxqdI
         o24S3gd6sbrOqq//jlqHtHGd5scbEvAr7Ux4/7XdJ1uTiX5/SEATzbEjM26rYSGmvTqJ
         jOdA==
X-Gm-Message-State: AOAM530mj0jWPkGYzr1T8QyjoYBsDAs8+8xVI9MQR/ftghvsxl1grIW0
        2ePIFMw3Fcn5JlMQzSiYtAIi+g==
X-Google-Smtp-Source: ABdhPJyL1mgbO/QqqFeAEHWsW/FnRQwYf9IXv1JuxdTJ0DWSLveRKUz+j5yAZUkxEzwjdUnPqh5o8Q==
X-Received: by 2002:adf:fec3:: with SMTP id q3mr1267150wrs.123.1590237222514;
        Sat, 23 May 2020 05:33:42 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:c871:e070:f68d:a4f7? ([2a01:e34:ed2f:f020:c871:e070:f68d:a4f7])
        by smtp.googlemail.com with ESMTPSA id h1sm12875416wme.42.2020.05.23.05.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 05:33:41 -0700 (PDT)
Subject: Re: [PATCH] thermal: imx8mm: Add get_trend ops
To:     Anson Huang <anson.huang@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "amit.kucheria@verdurent.com" <amit.kucheria@verdurent.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1589338689-15700-1-git-send-email-Anson.Huang@nxp.com>
 <fccf4197-d0ca-f313-8f70-000ef4731033@linaro.org>
 <DB3PR0402MB3916B6D11328A036BD479D39F5B50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6a4d31e4-8a24-2e9f-aa49-bec8258ead4c@linaro.org>
Date:   Sat, 23 May 2020 14:33:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <DB3PR0402MB3916B6D11328A036BD479D39F5B50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2020 02:35, Anson Huang wrote:
> Hi, Daniel
> 
> 
>> Subject: Re: [PATCH] thermal: imx8mm: Add get_trend ops
>>
>> On 13/05/2020 04:58, Anson Huang wrote:
>>> Add get_trend ops for i.MX8MM thermal to apply fast cooling mechanism,
>>> when temperature exceeds passive trip point, the highest cooling
>>> action will be applied, and when temperature drops to lower than the
>>> margin below passive trip point, the lowest cooling action will be
>>> applied.
>>
>> You are not describing what is the goal of this change.
> 
> The goal of this change is to make sure whenever temperature exceeds passive trip point,
> the highest cooling action will be applied immediately, e.g., if there are many cpufreq OPP,
> the default cooling will be step by step, it will take some more rounds to make cpufreq drop
> to lowest OPP, while on i.MX, we expect the cpufreq drop to lowest OPP immediately.

Whatever the slope of the temperature increase?

>> IIUC, the resulting change will be an on/off action. The thermal zone is
>> mitigated with the highest cooling effect, so the lowest OPP, then the
>> temperature trend is stable until it goes below the trip - margin where the
>> mitigation is stopped.
> 
> Yes, your understanding is correctly, once the temperature exceeds passive trip point,
> the highest cooling action will be applied immediately and then it will be stable there
> until temperature drop to trip - margin, then the cooling action will be cancelled, the
> margin is to avoid the back and forth near the passive trip point.
> 
>>
>> Except, I'm missing something, setting a trip point with a 10000 hysteresis and
>> a cooling map min/max set to the highest opp will result on the same.
> 
> Yes setting cooling map min/max cooling state to highest OPP will make the highest
> cooling action applied immediately, and to have the function of cooling action being
> cancelled when temperature drops to trip - margin, I have to define another trip point,
> say passive trip point is 85000, and cooling map min/max set to highest OPP in passive
> trip point then add another trip point named "active" with 75000, and without any
> cooling map in it, right?

May be I misunderstood but only the change as below is needed. No need
to add a trip point, especially an 'active' trip which is a for an
active cooling device like a fan.

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index cc7152ecedd9..bea263bd06b4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -231,10 +231,10 @@ cooling-maps {
 				map0 {
 					trip = <&cpu_alert0>;
 					cooling-device =
-						<&A53_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&A53_1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&A53_2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-						<&A53_3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+						<&A53_0 2 2>,
+						<&A53_1 2 2>,
+						<&A53_2 2 2>,
+						<&A53_3 2 2>
 				};
 			};
 		};


> If yes, then I think I can try to make the changes in DT instead of thermal driver. 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
