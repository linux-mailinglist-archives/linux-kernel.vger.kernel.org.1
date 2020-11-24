Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E030D2C30AB
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391026AbgKXTSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391018AbgKXTSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:18:39 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1486CC061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:18:39 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id g1so7562745ilk.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=azXiFz0WNAfRl4Pgrck3jqWrs5+Sata50ywpvGazjv8=;
        b=RiO6PKuYZ2zEMVLu+GSEjJeiJFcQ7eA4HUxGeCtv/idGeKCfYNrnxk/tFXh99PtJXH
         5AnjS+fvfnNYbmIA7VrELfcdmFgoTl0ksowYLMlKJru4EDwGxpiH0tGHpTlXTxfJxoKH
         7RrbNh4ZZRjBH2s3MBrbZZIVqo6ZVXtrygOq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=azXiFz0WNAfRl4Pgrck3jqWrs5+Sata50ywpvGazjv8=;
        b=eIgwXmUSdqRO/5/ow6NjJyddU9HD95JtVMBx9z+RU4Y6jEcvLisqy6IlGP1Kee0C8j
         TzBca0PaNPFfqkAQOAKiZHR5GfvVlTOAuTdIY8XV19O4pH5A6u6wE0FumHJ5MjVV4DAy
         WQjBWSwqKNwetWStDPGqXTicKdbGkGHR8BV87567fkeJQFEH2N/6cGoKIvdLoM6zJOUI
         53slRyLjKem8nZ0Etf9TpZ5NdXzIHJ76fz3XqghdBXSYn0XWFfMCxpMtUeRegkrfJpVK
         26D6jnC+h+NpIKFit0fLX/8ahxaIuP5ix43V0Auilv343Orj0qhLubZtUubqdySoFTtq
         cZvQ==
X-Gm-Message-State: AOAM5329rPhv9yaHcbmiJMNLlHeR16vaSW8U6ZoAsWjcxCMDfayfaYEj
        U5HZJXItL/V5Dr6gpxD7PATv2qZgIXHutA==
X-Google-Smtp-Source: ABdhPJxMPJDcuJ85ZnPxzCAmLrFsd6xdMZGPJv8Nql8ZGNpcI8KiQUKGZGuiyfMq7a3NMBeNLW7W8Q==
X-Received: by 2002:a92:c708:: with SMTP id a8mr5992821ilp.199.1606245518201;
        Tue, 24 Nov 2020 11:18:38 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id d23sm11039528ill.56.2020.11.24.11.18.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 11:18:37 -0800 (PST)
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: Limit ipa iommu streams
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alex Elder <elder@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201123052305.157686-1-bjorn.andersson@linaro.org>
From:   Alex Elder <elder@ieee.org>
Message-ID: <ecf7f5b6-a5ba-e370-d716-89272ad3c67b@ieee.org>
Date:   Tue, 24 Nov 2020 13:18:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201123052305.157686-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/20 11:23 PM, Bjorn Andersson wrote:
> The Android and Windows firmware does not accept the use of 3 as a mask
> to cover the IPA streams. But with 0x721 being related to WiFi and 0x723
> being unsed the mapping can be reduced to just cover 0x720 and 0x722,
> which is accepted.

Do you want to update sc7180.dtsi too?

I tried your change on my SDM845 machine and observed no
problem.   I tried the comparable change in "sc7180.dtsi"
(using 440 and 442) and that seemed to work as before also.

If you think that's sufficient, you can add:

Tested-by: Alex Elder <elder@linaro.org>

Otherwise:

Acked-by: Alex Elder <elder@linaro.org>


> Fixes: e9e89c45bfeb ("arm64: dts: sdm845: add IPA iommus property")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 0da27b065761..a6147bd54cdf 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -2136,7 +2136,8 @@ ufs_mem_phy_lanes: lanes@1d87400 {
>   		ipa: ipa@1e40000 {
>   			compatible = "qcom,sdm845-ipa";
>   
> -			iommus = <&apps_smmu 0x720 0x3>;
> +			iommus = <&apps_smmu 0x720 0x0>,
> +				 <&apps_smmu 0x722 0x0>;
>   			reg = <0 0x1e40000 0 0x7000>,
>   			      <0 0x1e47000 0 0x2000>,
>   			      <0 0x1e04000 0 0x2c000>;
> 

