Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264A52CE33B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbgLCX4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731372AbgLCX4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:56:55 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6435C061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 15:56:14 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id y74so4180716oia.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 15:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tj/eqYhhAQcKhYafB9RPIyuN5cfJ1B/TPw46tE9Fbis=;
        b=Cv0f1XYlFWVeIv0CnpbmITuX9a/QfNIUokjvwnG1Y0tpB/b4WTNLEgsx2GqHYbwmbX
         bvhqEZ/ouLGsCDneKK0NjCs+MOlgw4gyuxVtxu5QAnpiqTh+ijsMRzYylX4ynJBTDsrU
         OzSOWrY03hNVSMfLHOQO9/r2RtcCwUrGj+SsK0GoABwDOaddcMNCUBqvhCuQIv+YlQxp
         hGlZhtQX2ph3prAyNeYbNocnwO1T2aIHyqwwAyZBYsn1RYBDDfQJ4TcRZgL9yLuPo8mF
         jO9f19aonKqQ35gSQu21U8SdFeMqcnNavI6kmjc1DwFFbg0PIJDPW5SZZMfbVA+2mOJq
         KnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tj/eqYhhAQcKhYafB9RPIyuN5cfJ1B/TPw46tE9Fbis=;
        b=Pl2+6ZJz9L5+NKrudcnPM36/PXQM4Y1XWUJ/TeXOiz9qS5N1CGAkqfuMBoNasr3YGB
         iTsotTUVvUCRdLbBUKK0wfOB851sUPVC1kBYzZVGQ/U9EKbpIntW7I/AjKTJXKfMcEjj
         78Jp6toXyA5+y2Kpth9lJHWqoJjQoR121gbe30lsjnFA/k0fFtA6uJbCjsjBFklJX2/Z
         7jDelrdkldoP6xGAYWGG/20v/eqFIBXSQaFuJZ2cVXMzwZMCYfneYA7xltMwQ+TTny9y
         NUFFRhDu28V2QeJueY4sHq79KingNcFmXFcXdJ/omWKS3pm5XORg6Oi8SOJHRXxM6zdD
         68mg==
X-Gm-Message-State: AOAM5337vysT1geftjZ5vYJLgiEbm7eMymOxhBaV0MvTh9yddf739BUe
        mRdBA1XEn4K4I90JoSfF+liHKA==
X-Google-Smtp-Source: ABdhPJzQPweT/buGuh+MWJkK+6cjezKR9RTV5x/u3ct6Fn8EYBV5akr7cubnndZ8rc/R3woJjd/r1w==
X-Received: by 2002:aca:728b:: with SMTP id p133mr1227521oic.125.1607039774149;
        Thu, 03 Dec 2020 15:56:14 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j16sm268488oot.24.2020.12.03.15.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 15:56:13 -0800 (PST)
Date:   Thu, 3 Dec 2020 17:56:11 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: clock: Add RPMHCC bindings for SM8350
Message-ID: <X8l7Gwekn2UHO/2z@builder.lan>
References: <20201203070241.2648874-1-vkoul@kernel.org>
 <20201203070241.2648874-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203070241.2648874-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Dec 01:02 CST 2020, Vinod Koul wrote:

> Add bindings and update documentation for clock rpmh driver on SM8350.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
> index a46a3a799a70..3037eb98c810 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml
> @@ -21,6 +21,7 @@ properties:
>        - qcom,sdm845-rpmh-clk
>        - qcom,sm8150-rpmh-clk
>        - qcom,sm8250-rpmh-clk
> +      - qcom,sm8350-rpmh-clk
>  
>    clocks:
>      maxItems: 1
> -- 
> 2.26.2
> 
