Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6657C2B7546
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 05:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgKREIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 23:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbgKREIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 23:08:48 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FEFC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 20:08:47 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id z16so486282otq.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 20:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OFlGs4mKDX02PSiyPJiMC0bb+xNxk/N/G1k1e5peRxM=;
        b=QQxY3p7I4RHFjrJTNkalSyBx+aIXUj8ijk/Babr2vzHpUep7XKzj77fta6TtzebgCu
         54w0M3ZVHkJ7tSZJaQFR13s4eDVIVnuggLxxAX/z9ETdmoCw7xAt0Za8Y6X241m2BeFH
         3Er2KD5uQ9DeDGOB62xwTWlctLYgh74cMeJ5dJribRHezlK2WOR/0WPuzzI0l6M4WEjk
         zIqI92EjKqkBWA+foxnWcitA3s9/AQwyndns11yV9uHU7TQnSCWdcfqA4ytclWb0VxOP
         w3kBDZUlO6Ay3K/vVQQILFpKML26QLRUiIpvcrwjgXFFzKDAlSmB24By6DeNLtaItTfU
         j4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OFlGs4mKDX02PSiyPJiMC0bb+xNxk/N/G1k1e5peRxM=;
        b=aP9LB+TtkbY11YxinVzOxNx1TO8dxAzzUfWd6/zzgMAzs4XFAMIAl6Q435eJOYTuXc
         2SsmQVmg1J7yCIdnTgEN3DAQfYVxyfgQHREi4dpwyaYiE7lYZ0GMa+X1NW3+w1/RhHMg
         9jTSEL1qrTL/klLo6fB85m7dK5gg6wgH/iKo0aDPLkeCF9fBd1XyU9IZEQhLAByCT5NE
         mxDbpTD+LHNOSVbbN3dQLw8QOj+TKQYF8T0qa2CPbP8VheIlrWzsQgimIAdvH5xqZ1pW
         pJ2XhAS2eHjIuNSvrUI0Nsm5VyRnmgOy9AcTYbwuiQZDvyyHko9rFuy6KkfEM8bOOS8e
         3iGA==
X-Gm-Message-State: AOAM532p0BoBpDIA8QD8NKyNGb/GYqWclSHC364/fO3tRbkA31k82CLs
        aE++/mqruX5h/bGT7zeN8ETk0g==
X-Google-Smtp-Source: ABdhPJxXjhnt+l7S4mf68h2a9v6ouX5XJ/FbYDzULaWBwyywmHfA/8h64fZ+7LNab2guhsIUdYyfpw==
X-Received: by 2002:a9d:268:: with SMTP id 95mr5025458otb.27.1605672527061;
        Tue, 17 Nov 2020 20:08:47 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a4sm6447099otj.29.2020.11.17.20.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 20:08:46 -0800 (PST)
Date:   Tue, 17 Nov 2020 22:08:44 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, robh+dt@kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 6/6] devicetree:bindings:crypto: Extend qcom-qce binding
 to add support for crypto engine version 5.4
Message-ID: <20201118040844.GE8532@builder.lan>
References: <20201117134714.3456446-1-thara.gopinath@linaro.org>
 <20201117134714.3456446-7-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117134714.3456446-7-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17 Nov 07:47 CST 2020, Thara Gopinath wrote:

> Add compatible string to support v5.4 crypto engine.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>

$subject should be "dt-bindings: crypto: ..." and you should try to stay
within 50 chars for the subject. So how about something like:

"dt-bindings: crypto: qcom-qce: Add v5.4 to binding"

With something like that:
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/crypto/qcom-qce.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.txt b/Documentation/devicetree/bindings/crypto/qcom-qce.txt
> index fdd53b184ba8..ed1ede9c0acc 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom-qce.txt
> +++ b/Documentation/devicetree/bindings/crypto/qcom-qce.txt
> @@ -2,7 +2,9 @@ Qualcomm crypto engine driver
>  
>  Required properties:
>  
> -- compatible  : should be "qcom,crypto-v5.1"
> +- compatible  : should be
> +		"qcom,crypto-v5.1" for ipq6018
> +		"qcom,crypto-v5.4" for sdm845
>  - reg         : specifies base physical address and size of the registers map
>  - clocks      : phandle to clock-controller plus clock-specifier pair
>  - clock-names : "iface" clocks register interface
> -- 
> 2.25.1
> 
