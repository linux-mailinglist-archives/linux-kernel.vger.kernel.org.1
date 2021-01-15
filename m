Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FF12F7245
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732999AbhAOFib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731901AbhAOFi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:38:28 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A88EC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 21:37:48 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id b24so7561142otj.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 21:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HoK0L94tAvaQsC8IbUSCSznvz7aY6ZUAuuiO3QdSeTo=;
        b=qL1N45lPrp9WXaKR7CLMyFVlaUtrQs71X2pYQnQ6zL5m07fj2CHGPdAXOBy4Oc3+fF
         b59G5XHPLIjDH0oKAJozjVrnCmqq0iz/f1WKWQL7koPZ0UIroSuYGU3tyRL58o63o5es
         3VoQaB4eUSukDECwOHkSkSSeOynLQiWSzCZyEn6vpwdv3DpvbV+FUOqszb/nCjePLOsp
         +wE3QnjvZ46aHej8J/j/fvP8xWuxti/S/NDJ4jCol1ITySOVPCIRGQIxOrq4M60TDM8l
         NJo/6fMzZNV52ewBpjlcZyhWV1wamWksumAi+M31igqQWfZCYskvNnfbNWWsFDUDzgXx
         qIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HoK0L94tAvaQsC8IbUSCSznvz7aY6ZUAuuiO3QdSeTo=;
        b=AbL8uCwyd0EruwlTECnaZ2wschyU4NAwEY9oQjvFWRYp7W2AR0GhbxWrLCL4T5Xjkl
         kEczGQOHdycZvjejc2kg6FwPd93awtOtJw7vt8HTnSzSVfM3Ei3+i6C8izPBTvSabhlN
         M/1z5xyLAJfUUXFaN0PwVx+CEAXuBJk1Fx0dKQGmiaMl5z5hZIr8ly81PN/kKRnnSBgB
         oZAsDAF1t7noDvBMouo7GiRz9VKw+PfcqHvj1NvZi6/qvF439aU/JUw8mEj2dXnGxyPX
         1olKDNq7BoxkTWyBWPQGzGE9y2+hm1BH/Ox0kAu0i2fOf/fUJubR7eKY9J1JgEwByxoy
         ywiA==
X-Gm-Message-State: AOAM533Kr0HrYU3tEswgMnvRZ9Fi9nw9/L6CUQ2uh0GHox8DRUaHgCKV
        L1na+xU25XpnjCzOwzxXQl5+Bg==
X-Google-Smtp-Source: ABdhPJzMl0myBJ7Bn9w2oT979MZhSkUQEZbpeYNzD4GeDLRYtKbq7kLuPVeDXaFMYZFwW7IImwf8IA==
X-Received: by 2002:a05:6830:1587:: with SMTP id i7mr6975631otr.301.1610689067662;
        Thu, 14 Jan 2021 21:37:47 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id t13sm1503195oih.26.2021.01.14.21.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 21:37:46 -0800 (PST)
Date:   Thu, 14 Jan 2021 23:37:45 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        sumit.semwal@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org
Subject: Re: [PATCH v2 7/7] arm64: dts: pmi8998: Add the right interrupts for
 LAB/IBB SCP and OCP
Message-ID: <YAEqKZknkKT8/KSJ@builder.lan>
References: <20210113194214.522238-1-angelogioacchino.delregno@somainline.org>
 <20210113194214.522238-8-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113194214.522238-8-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13 Jan 13:42 CST 2021, AngeloGioacchino Del Regno wrote:

> In commit 208921bae696 ("arm64: dts: qcom: pmi8998: Add nodes for
> LAB and IBB regulators") bindings for the lab/ibb regulators were
> added to the pmi8998 dt, but the original committer has never
> specified what the interrupts were for.
> LAB and IBB regulators provide two interrupts, SC-ERR (short
> circuit error) and VREG-OK but, in that commit, the regulators
> were provided with two different types of interrupts;
> specifically, IBB had the SC-ERR interrupt, while LAB had the
> VREG-OK one, none of which were (luckily) used, since the driver
> didn't actually use these at all.
> Assuming that the original intention was to have the SC IRQ in
> both LAB and IBB, as per the names appearing in documentation,
> fix the SCP interrupt.
> 
> While at it, also add the OCP interrupt in order to be able to
> enable the Over-Current Protection feature, if requested.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  arch/arm64/boot/dts/qcom/pmi8998.dtsi | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> index d016b12967eb..d230c510d4b7 100644
> --- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
> @@ -30,11 +30,15 @@ labibb {
>  			compatible = "qcom,pmi8998-lab-ibb";
>  
>  			ibb: ibb {
> -				interrupts = <0x3 0xdc 0x2 IRQ_TYPE_EDGE_RISING>;
> +				interrupts = <0x3 0xdc 0x2 IRQ_TYPE_EDGE_RISING>,
> +					     <0x3 0xdc 0x0 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names = "sc-err", "ocp";
>  			};
>  
>  			lab: lab {
> -				interrupts = <0x3 0xde 0x0 IRQ_TYPE_EDGE_RISING>;
> +				interrupts = <0x3 0xde 0x1 IRQ_TYPE_EDGE_RISING>,
> +					     <0x3 0xde 0x0 IRQ_TYPE_LEVEL_LOW>;
> +				interrupt-names = "sc-err", "ocp";
>  			};
>  		};
>  	};
> -- 
> 2.29.2
> 
