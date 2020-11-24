Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD752C2A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389367AbgKXO52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728352AbgKXO52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:57:28 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6B4C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:57:26 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id w15so852079oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sXzXgvLp4s+46JRUtzzV0/6Df/FZIX/XlFhg2++CJ7g=;
        b=rvgO0ShYj3OMSlEin7VGkUn0IM+58ObeVh/TdWxzWTdOvl/seTdhKJCeGJb2aVxEOP
         4mveIzPpcPBk+2ATDUftjhUVhK0DZlvF6jiSLo5Q9pbO10swOdOH8pxUsooaQpuIjfm6
         w9PYIVZ70hsp6bcw23zxkMx2FRuv1cynkbn9co/6PvObOa4WVwO/ih8uP8svElI8NpWZ
         IwVQ83vdU8w8SdOR/nbTfYQWOMPQf1BghyrUxELA1ObvUtzZalIkV+9d0D5tazrekRxY
         u4eGRu3KesPfVPY+82kT9W/Jti1rsm4Xanmen3fBhkZdbvgSSFyD9E825RQroHApWEKy
         vxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sXzXgvLp4s+46JRUtzzV0/6Df/FZIX/XlFhg2++CJ7g=;
        b=DZzVbM3fmKJTO1VOq97Y0gvOTJk5HcwnAC4VloMX/Gp5+3ACiVaGthR4WNtAklHJcD
         TPR/tsWK94BliLY1X4uzbQ873ad/oVxukra56CxqhbTdNBJLe1b09bVqf0uA8pRpwDpT
         Qk20NKXeZnP+ZFVNez+lwY21AVyiKq48IVdyEtTYqVARQXKolATtZWHHxEv9/B8uQ3YQ
         /7KWiCCB4NZqAGf5GE8fmoSwiGJLAPi27FS4YY3HQk1ebWd74KgB6iP/mUkBIwt5nz5p
         XtqH8184OYkT0aqUCzdS4SoAI8zhwtinfYLVVuNXCVf/9PgtXiatc8pd+SYClMyJEbL0
         l1cg==
X-Gm-Message-State: AOAM533UUqgBQL0yd8mYw2tflO9xvBHNEll4F8bYHWG5kXap456+mEwX
        WmaE/J2EYHpKimz4w78udKGxJg==
X-Google-Smtp-Source: ABdhPJxa3NAVx1Cn2t+G3dKNxlpEbRiazZDjFN23ymWT/MGwtBTKGNQYqdxTJmVghDox3My4/lknJQ==
X-Received: by 2002:aca:c3c4:: with SMTP id t187mr2783806oif.148.1606229846311;
        Tue, 24 Nov 2020 06:57:26 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k13sm2227901otl.72.2020.11.24.06.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 06:57:25 -0800 (PST)
Date:   Tue, 24 Nov 2020 08:57:23 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, robh+dt@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document SDX55 Modem and
 boards
Message-ID: <20201124145723.GJ95182@builder.lan>
References: <20201124140011.134751-1-manivannan.sadhasivam@linaro.org>
 <20201124140011.134751-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124140011.134751-2-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24 Nov 08:00 CST 2020, Manivannan Sadhasivam wrote:

> From: Vinod Koul <vkoul@kernel.org>
> 
> Document the SDX55 Modem binding and also the boards using it.

It's not really the "SDX55 Modem", it's the "SDX55 platform". That way
things become less confusing when we actually add the modem on SDX55
later.

> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index ad25deba4d86..4362e8f0d495 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -39,6 +39,7 @@ description: |
>          sc7180
>          sdm630
>          sdm660
> +        sdx55

'x' > 'm', so this should go one line down.

Regards,
Bjorn

>          sdm845
>          sm8250
>  
> @@ -178,4 +179,9 @@ properties:
>                - qcom,sm8250-mtp
>            - const: qcom,sm8250
>  
> +      - items:
> +          - enum:
> +              - qcom,sdx55-mtp
> +          - const: qcom,sdx55
> +
>  ...
> -- 
> 2.25.1
> 
