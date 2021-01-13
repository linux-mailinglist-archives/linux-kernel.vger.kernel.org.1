Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D91642F4A21
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbhAML1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbhAML1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:27:32 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C7EC0617BC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:26:01 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id e15so922423vsa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+8zY4mAyzjmgjsrYvoqLVjDJOKDqaN1fkUOrBGLi4M=;
        b=OiN+OkGx7489GZZh0hmDDLNJvwzokz7n7baE1dAg2JdPLXWQH+eyBoKVNNUmD/UHzl
         LUtsej7UJpMuN3zRHOf/Pc6z0Dr/m/06kprtF/2UKtdvKV7hZS/NH57YOf7N89v5amU0
         yEdmZGuuygp01KoL/S4EO0Z4+9wvZHUjv2LyUlNdXtPgGXw+mQMZYBWJu+YmKTzLfI24
         +7esSdpJsGqkzAmrfqFg5NQyjUYW9q3jJ02mhTPW0dE6o9P9bJPzdSgqpzxS3IH/raUQ
         H3dQ98j7/SmsuINw5DviiUGLSvG/MughwrzB49oNI/9i6zuxRJNplu3BbLtHwM2y+WgW
         /DkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+8zY4mAyzjmgjsrYvoqLVjDJOKDqaN1fkUOrBGLi4M=;
        b=c5wqCTWvxl3SISnz9JndHFzBgwx8aeQnPW0gEw4ujEoa502/u6Eqi8WXDVqSH6Hiz+
         hIhVFiTr8temTM3OkMdT19bhbRum0GqexzWERsdO2nLf2hGH2OslWh3D8XcbZpPGyP3R
         59RNI8foiITywTF7zpUKI+olybrSfPb9HM6eitAv/AbOAcXdNzI+zbDYlqPgrQeWl0BB
         6ZqeekV/2NZKW4+Zpktmxvl+OMKwIBtxQbu5aVteCsvmfUqz17qwr5X6WYFxyoGe3YQc
         9cWTfjuz0qCmAZFmX4/YzfilCUehTPaUF52TLOYTPQSdhCoydFA8RTYTFbGh6fynyojr
         U7rg==
X-Gm-Message-State: AOAM530IXbdYPxr9K04jgazfnQy8w4CfqCDYPiqDdYm7nCky/jLqdOqJ
        nb3R2inAmaKQFChdKcIQAKhslwD/pOhabBzBTn/aZA==
X-Google-Smtp-Source: ABdhPJyEXS/qxGhlAHcgztCWad9kvXwLG1Ay9RD3A+8qxnVUMWamsOhdl/W7h+uvCfYzaoMIXQ1TJLpGt8dfvFUfVoE=
X-Received: by 2002:a67:7f41:: with SMTP id a62mr1386085vsd.55.1610537160317;
 Wed, 13 Jan 2021 03:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
In-Reply-To: <20210107143118.2386-1-manivannan.sadhasivam@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:23 +0100
Message-ID: <CAPDyKFqFNq=GkcLS1dwx2rh5i2uMYP5Sum4Uu9udRkF8_-NbLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Document the SDX55 compatible
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jan 2021 at 15:31, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> The SDHCI controller on SDX55 is based on MSM SDHCI v5 IP. Hence,
> document the compatible with "qcom,sdhci-msm-v5" as the fallback.
> While at it, let's also sort the compatibles in ascending order.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 3b602fd6180b..9fa8a24fbc97 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -17,10 +17,11 @@ Required properties:
>                 "qcom,msm8916-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8992-sdhci", "qcom,sdhci-msm-v4"
>                 "qcom,msm8996-sdhci", "qcom,sdhci-msm-v4"
> -               "qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
> -               "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
>                 "qcom,qcs404-sdhci", "qcom,sdhci-msm-v5"
>                 "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
> +               "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"
> +               "qcom,sdx55-sdhci", "qcom,sdhci-msm-v5";
> +               "qcom,sm8250-sdhci", "qcom,sdhci-msm-v5"
>         NOTE that some old device tree files may be floating around that only
>         have the string "qcom,sdhci-msm-v4" without the SoC compatible string
>         but doing that should be considered a deprecated practice.
> --
> 2.25.1
>
