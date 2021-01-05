Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCB62EB20A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbhAESGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbhAESGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:06:33 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76721C06179A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:05:52 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id q25so502175otn.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a7FQj9WS23NBhN1GnkQfwD+Xu2FEJgNqtA1ZOAmMQY4=;
        b=a5oX8hdv6rwQ7Wqo9PZcfRXmoebmWEHJv5/aaQBe6XEoByrlC8/F2Onf9n1kiu7bjW
         YNt/b19/uphxkMEqz8gAQdJNWP30cRIfBY/tb94qlq8AG8PJUDxp+O3Q7iRRgYQ83G2v
         X01sLioOD4YMhwgOos0t71B7Na9v3vA7hTN2CPxblLMeNe+HN43tzfIjE9IQvnewig7Y
         LE1YhfEV2b2ABojD0b0qMmK21jtozaTKIrJo9tPhbJYjJRjHXgxhZ6Ojd5F709Al2FKI
         z0MjEjUeICLuxggSatwFKieroi7TOmIQDejpVtfvMvkcT5VYS35LeVB2EG24r1iOeHgl
         SHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a7FQj9WS23NBhN1GnkQfwD+Xu2FEJgNqtA1ZOAmMQY4=;
        b=ia7HTCLseyTnCzgJpdPIMOPw1M4+hXefWk2DnT87IVhwVgUKzRSlo3i0aTnJIE3q0F
         ujchPCpHjjurFox0UEKjVn2nJqxYXGzrvD5uW7XBBbl1rhbQEp2Q99wX6dYHIFZX2IBk
         9LX21Ge2jTzV/frpWzVEXhsYCOB9AmCZFJpnWm+Kz7BgB4pVEN+Xtf8tRdDau0oAgHGs
         AsanYgAZWo/OW5TslYeTZJNI20vlGFgNf1FhiHuS86equwEIDpA3Pt1klpo0wTD5wvZc
         GgB0luUnncfiO73dbiQEpbVod6S2OEABsOxxxWc5kq10SEIoabwfsyNgnhAC4J7VeSZC
         EIlw==
X-Gm-Message-State: AOAM531Y+JDoczRt+dLtNSDWB7weDMYwYYs/6gPBvBjOEZBWrWHVVIWD
        mYWNIlbbUHY3mY/5hU46kMfuOg==
X-Google-Smtp-Source: ABdhPJwK/F2DvUCmB9E522VTyRot7CVADz7B3tEHis6xdZUsS9N9RoSHvkyfcCqs5sJyAaGoCg+BtA==
X-Received: by 2002:a9d:27e9:: with SMTP id c96mr484863otb.15.1609869951840;
        Tue, 05 Jan 2021 10:05:51 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id s17sm62187otg.16.2021.01.05.10.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 10:05:51 -0800 (PST)
Date:   Tue, 5 Jan 2021 12:05:49 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 02/18] ARM: dts: qcom: sdx55: Add reserved memory nodes
Message-ID: <X/Sqfeonlthrys/O@builder.lan>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
 <20210105122649.13581-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105122649.13581-3-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Jan 06:26 CST 2021, Manivannan Sadhasivam wrote:

> From: Vinod Koul <vkoul@kernel.org>
> 
> This adds reserved memory nodes to the SDX55 dtsi as defined by v8 of
> the memory map
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-sdx55.dtsi | 67 +++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
> index 08b4a40338fa..eeb6bf392f93 100644
> --- a/arch/arm/boot/dts/qcom-sdx55.dtsi
> +++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
> @@ -60,6 +60,73 @@ psci {
>  		method = "smc";
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		mpss_debug_mem: memory@8ef00000 {
> +			no-map;
> +			reg = <0x8ef00000 0x800000>;
> +		};
> +
> +		hyp_mem: memory@8fc00000 {
> +			no-map;
> +			reg = <0x8fc00000 0x80000>;
> +		};
> +
> +		ac_db_mem: memory@8fc80000 {
> +			no-map;
> +			reg = <0x8fc80000 0x40000>;
> +		};
> +
> +		secdata_mem: memory@8fcfd000 {
> +			no-map;
> +			reg = <0x8fcfd000 0x1000>;
> +		};
> +
> +		ipa_fw_mem: memory@8fced000 {
> +			no-map;
> +			reg = <0x8fced000 0x10000>;
> +		};
> +
> +		sbl_mem: memory@8fd00000 {
> +			no-map;
> +			reg = <0x8fd00000 0x100000>;
> +		};
> +
> +		aop_image: memory@8fe00000 {
> +			no-map;
> +			reg = <0x8fe00000 0x20000>;
> +		};
> +
> +		aop_cmd_db: memory@8fe20000 {
> +			compatible = "qcom,cmd-db";
> +			reg = <0x8fe20000 0x20000>;
> +			no-map;
> +		};
> +
> +		smem_mem: memory@8fe40000 {
> +			no-map;
> +			reg = <0x8fe40000 0xc0000>;
> +		};
> +
> +		tz_mem: memory@8ff00000 {
> +			no-map;
> +			reg = <0x8ff00000 0x100000>;
> +		};
> +
> +		tz_apps_mem: memory@0x90000000 {
> +			no-map;
> +			reg = <0x90000000 0x500000>;
> +		};
> +
> +		mpss_adsp_mem: memory@90800000 {
> +			no-map;
> +			reg = <0x90800000 0xf800000>;

Didn't you say this moved to 0x9c000000?

Regards,
Bjorn

> +		};
> +	};
> +
>  	soc: soc {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -- 
> 2.25.1
> 
