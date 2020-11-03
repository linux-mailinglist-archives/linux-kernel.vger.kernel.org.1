Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50B12A4D36
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 18:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgKCRiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 12:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgKCRiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 12:38:50 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2CBC061A04
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 09:38:50 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id s21so19227896oij.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 09:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6yq0B3gvpA5I9jO0QaxOACvCmaKCwDtvfH76pkYCkZg=;
        b=FqmmT6V8Gq5zNDIRdAcsPxa3SHsggSSNGDGshs9JNs2boyl4bwPhwJvkChemdgu8sQ
         8g2z9V5syZcqucGxPh97feZDakb+BmVINkLo8avFUzEv38aC/OVzMdmrhq2Db3D7IDbA
         DAE5DBqAk9bVC59sFuSRAFsy57q+Ckyl4WCT9fakS/H5JmJX/zuLpBtNOSudLhwi79Lg
         h155UN0cN2fM/3gR5qV+FC604ThUqXqqSpxTK4Up6THGOgyx3ecwMZ4g8/CJSTPwnxsB
         j17Jji8+K47Z/mVwX3f1Ro2UH6C0HqHfIHvR1uUfYb4f/6OoCh8XMNNALRoACXkNzB9w
         /j6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6yq0B3gvpA5I9jO0QaxOACvCmaKCwDtvfH76pkYCkZg=;
        b=ip1dQ6VeKJM8CpfVweRVrySOGryoOt5v/g5aoJZKWljisj98RqNRVpv+Xt4sDLk/5B
         tD4aLJWeEHrWlEB7H11H7sbPoF5Jc8dVe1dwfr2hD3QsIHGEGp39QjqrmBB78hQBFhL9
         TCrrCOhFX417gPx6ggLL3ok8A8KObsvQNNU8LdT1ZE5c83NqyF+OHZxN2fPw+bXGWyWL
         2F4iLnc+vX0KQ3NHYXjRHubYE8zdgXYoqvU5/UshFW9G20xdvqKDE5csMB7o83MdHXz0
         4JIPQbWwpQRj3OFkY3Npi5W+eID+akhFLNmS67zLsJsh38qJ/seSlWKffF3iFTIrh0W6
         YqGA==
X-Gm-Message-State: AOAM533nJTiaQ8F04E2kwctdQBkVui0wDlMMwLz1fXCBZX/3L3H/R0hQ
        MfNy+V5ChKFF6m8qDqsSgeZ+hg==
X-Google-Smtp-Source: ABdhPJypPLRjFtGH2biL/X5Yn96B4TBH3Vu+himb7NU0CUAstfPyiQfNjdgy9o775vs0mUl4QvjBxw==
X-Received: by 2002:aca:fcd5:: with SMTP id a204mr146080oii.161.1604425129714;
        Tue, 03 Nov 2020 09:38:49 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h3sm4288352oom.18.2020.11.03.09.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 09:38:48 -0800 (PST)
Date:   Tue, 3 Nov 2020 11:38:47 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: clock: Introduce RPMHCC bindings for
 SDX55
Message-ID: <20201103173847.GQ3151@builder.lan>
References: <20201028074232.22922-1-manivannan.sadhasivam@linaro.org>
 <20201028074232.22922-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028074232.22922-4-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28 Oct 02:42 CDT 2020, Manivannan Sadhasivam wrote:

> From: Vinod Koul <vkoul@kernel.org>
> 
> Add compatible for SDX55 RPMHCC and DT include.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Given that you handled the patch on its way here you should add your
Signed-off-by.

When doing so feel free to add my:
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
>  include/dt-bindings/clock/qcom,rpmh.h                    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
> index a46a3a799a70..a54930f111ba 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
> @@ -19,6 +19,7 @@ properties:
>      enum:
>        - qcom,sc7180-rpmh-clk
>        - qcom,sdm845-rpmh-clk
> +      - qcom,sdx55-rpmh-clk
>        - qcom,sm8150-rpmh-clk
>        - qcom,sm8250-rpmh-clk
>  
> diff --git a/include/dt-bindings/clock/qcom,rpmh.h b/include/dt-bindings/clock/qcom,rpmh.h
> index 2e6c54e65455..cd806eccb7dd 100644
> --- a/include/dt-bindings/clock/qcom,rpmh.h
> +++ b/include/dt-bindings/clock/qcom,rpmh.h
> @@ -21,5 +21,6 @@
>  #define RPMH_IPA_CLK				12
>  #define RPMH_LN_BB_CLK1				13
>  #define RPMH_LN_BB_CLK1_A			14
> +#define RPMH_QPIC_CLK				15
>  
>  #endif
> -- 
> 2.17.1
> 
