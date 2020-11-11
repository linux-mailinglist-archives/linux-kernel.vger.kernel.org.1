Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0F52AE796
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 05:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgKKErQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 23:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgKKErP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 23:47:15 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8578DC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 20:47:15 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id n15so992803otl.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 20:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/GM1cBjAx8YRMcwX0sp3r5R4zE7TcRZNQ+BuoADbC18=;
        b=N8B1ptautluDDXyzqpgtNEqTabMXgiCpxMgtImiU7qAFK/ZMn9TSVQYP+oBKxqEDOD
         gAI2A5VuGvYM0R3ZI3GTK+SbdcqUk8EMZ/rgfVfZGvHskDVeSsKTAcAImsRzqSlNwgB2
         vzt7Bfhw4rUlozyG3gGg+Qv7fh65mvuGikFa9PvQB/BAuf3XvwJ1VTJx8Vf8ko/eu73T
         ziSnlxm9GzDFWvH1TcgOZXWGc6owy5QJ7plty/sWLfE/r4CTHcc8UR/LgNQpMXaLDJiz
         CPCg1GGkZm8+IvW0J6B2rmwvU2y7M6VQYjeBE1Yv7+BPywnYYiXwS4Yz5/UuQsbO1R8w
         kn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/GM1cBjAx8YRMcwX0sp3r5R4zE7TcRZNQ+BuoADbC18=;
        b=uNB9RvtkURyGzT0nXk9JVs2IS+FlMbkg078gT2ugW8dKdCU3JeJSW4AmhBu1PeuRSn
         Bq5XKcjwwKuYHNMxikWVkxbp1vIxK60f+XpqBOHH3PfXUtlymMTfiav1WqKySM1ClMOg
         YqLs5tOe39Vc3KDkbU9cGAoToW0k5d+b6dgeOdnMVYFgMqL/x4naHio0kiltBWC+QL+c
         3a0heseqYELioe/RGodX4tc1JBCq16SC8O6xTP7l7pDnHfzM1cN0o+iecr1XtOLU2fTc
         dhWsMR3XNoN/ErMRRrhayFbaRl27AoEurgoCzed5zAleDSxjYDy2qS4aWPaie1ruSW81
         I60A==
X-Gm-Message-State: AOAM5309e23DdlbX9MjFsnRwddSa4LDnahGo91MHA2U+PEkixgeNj5WN
        fb7zHxN2xttU+4MW6OWE7Z7v/g==
X-Google-Smtp-Source: ABdhPJzCLhTdR2RZSM4QLuXt5fQ+REOnp8ZmpeLA1wi7kB9NZrx12A6FWzAxU032uQM8aqvJCbROiw==
X-Received: by 2002:a9d:654c:: with SMTP id q12mr15634713otl.84.1605070034856;
        Tue, 10 Nov 2020 20:47:14 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g3sm207983oif.26.2020.11.10.20.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 20:47:14 -0800 (PST)
Date:   Tue, 10 Nov 2020 22:47:12 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: sc7180: Add camera clock controller node
Message-ID: <20201111044712.GF332990@builder.lan>
References: <1604687907-25712-1-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604687907-25712-1-git-send-email-tdas@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06 Nov 12:38 CST 2020, Taniya Das wrote:

> Add the camera clock controller node supported on SC7180.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index f5ef2cb..e795dba 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2019, The Linux Foundation. All rights reserved.
>   */
> 
> +#include <dt-bindings/clock/qcom,camcc-sc7180.h>

Applied the patch without this include, as it was not available in the
tag I branched off my 5.11 branch off.

Regards,
Bjorn

>  #include <dt-bindings/clock/qcom,dispcc-sc7180.h>
>  #include <dt-bindings/clock/qcom,gcc-sc7180.h>
>  #include <dt-bindings/clock/qcom,gpucc-sc7180.h>
> @@ -2896,6 +2897,18 @@
>  			qcom,bcm-voters = <&apps_bcm_voter>;
>  		};
> 
> +		camcc: clock-controller@ad00000 {
> +			compatible = "qcom,sc7180-camcc";
> +			reg = <0 0x0ad00000 0 0x10000>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
> +			       <&gcc GCC_CAMERA_AHB_CLK>,
> +			       <&gcc GCC_CAMERA_XO_CLK>;
> +			clock-names = "bi_tcxo", "iface", "xo";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
>  		mdss: mdss@ae00000 {
>  			compatible = "qcom,sc7180-mdss";
>  			reg = <0 0x0ae00000 0 0x1000>;
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 
