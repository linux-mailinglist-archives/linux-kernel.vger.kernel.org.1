Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E402F98F6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbhARFGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731061AbhARFG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:06:26 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7E3C061786
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:05:35 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id b24so15165853otj.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 21:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=157JaOxm7wR/eDPzKyW4vaqbpfn4OsQxM2synGZIrts=;
        b=eT68+s7Vogy3UND7W2eORXt+ItAHKQBtHKTrjoceaVV7UpKQyqwWM1puvbZWAcfL2j
         zM++4qIjGrWuj8EtBgTijwbyOZhYscGkrUeUyS1iDce4Z1tC99M7WE2OA6VoHe7wUT4r
         ctum0IL+KlCMBlA02PtHHADT0DWywRV+dU+q46UTGPghFgOC6BqmEe0JHnyOkjiTJo/V
         snPQY4MnAFoYjI/xkY5dWdHvTVV8cjyA3oVnowBTb6Q70F3PwL57+nTb+nPve6M9hi38
         fgocx4UJ3a53R+q5zy6UOCw39iXOkQaUWn+aUuE3LBcB7SwbSyo4a6N383kF4cBhGrfO
         dw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=157JaOxm7wR/eDPzKyW4vaqbpfn4OsQxM2synGZIrts=;
        b=HS7Z3YPmdSG6IEECG8+GmaPuhbGXukFGdUKk+qYs72n/CtKohYfZjJjHHCePBQmL8c
         YFgUPOd6V4JVrD6kgP8rr7VV6huj+uTgCmzeCTG3b+g25w9XiqG4rSEC2qk4uspqJngp
         0A+Z8psgCgYuiYgOKfDJquRFqrJoAplJBZ5bd6nXLiWLrZsfdqdR4lmFDbgRhh25RMAu
         Gf/MyTKPWGGIjaremjGRxWk0IvazFBnzJdChMhO/seCoyC2ZoJ1Szzexm+mYMYZryZDw
         B1UMsgGs0y9TR53QhdBwPcartY+ykhFb53X+GziZ9VV5DGrY/QZbrRzb7H1dh9iay1gE
         uqvw==
X-Gm-Message-State: AOAM531rqeRdIVz6xkaaGEBl5Q5hf8n07onMtUPP1YuH5LpkLKkqAkdu
        eJnkaiBBlTSv8sv0q7mo+JqsQg==
X-Google-Smtp-Source: ABdhPJx8d5yDkFxjUJkAUFkASqjhbA9f9ZXcUdCxbSLnizQZ5CvASqTmkXfl9V+67Kc6WIrh1cEoYg==
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr16535839otn.41.1610946335398;
        Sun, 17 Jan 2021 21:05:35 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p22sm166535oth.38.2021.01.17.21.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 21:05:34 -0800 (PST)
Date:   Sun, 17 Jan 2021 23:05:33 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jack Pham <jackp@codeaurora.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dt-bindings: usb: qcom,dwc3: Add bindings for
 SM8150, SM8250, SM8350
Message-ID: <YAUXHbX36bHBbVPW@builder.lan>
References: <20210115174723.7424-1-jackp@codeaurora.org>
 <20210115174723.7424-5-jackp@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115174723.7424-5-jackp@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15 Jan 11:47 CST 2021, Jack Pham wrote:

> Add compatible strings for the USB DWC3 controller on QCOM SM8150,
> SM8250 and SM8350 SoCs.
> 
> Note the SM8150 & SM8250 compatibles are already being used in the
> dts but was missing from the documentation.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Jack Pham <jackp@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index 2cf525d21e05..da47f43d6b04 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -17,6 +17,9 @@ properties:
>            - qcom,msm8998-dwc3
>            - qcom,sc7180-dwc3
>            - qcom,sdm845-dwc3
> +          - qcom,sm8150-dwc3
> +          - qcom,sm8250-dwc3
> +          - qcom,sm8350-dwc3
>        - const: qcom,dwc3
>  
>    reg:
> -- 
> 2.24.0
> 
