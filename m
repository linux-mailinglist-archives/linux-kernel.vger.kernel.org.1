Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA57281E2D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 00:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgJBWUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 18:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBWUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 18:20:53 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44004C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 15:20:52 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id w25so1322822vsk.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YO3BKY1t3RoujCw4IEgcApM9xQo/s9/vmUvLTebAFNM=;
        b=m5FbwErQrFIkbcAHJy1GVJKbl6vRV+J+dt+nYMjgxQRPRNTF+zT52nUaMxENOqrjhP
         wfGGITQx1Bwxme2YbRfw2q+zmy+r4MYafc0n8+L6LrKWj277oua4N5WISIphdRHMinkc
         mWNUIQnXPSk5zYx76rd8L+TV2t4MuZSqWGziw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YO3BKY1t3RoujCw4IEgcApM9xQo/s9/vmUvLTebAFNM=;
        b=J0+WdZeg4l+cZzGouvv7f4Mppi9RQse8lMPn+GJQdkiRiDYj/SLbgepeDq0Ncauqjk
         2Vw0QsaizoorsPfkNimw3DW4Dni1YjqvEAi6iZbywj66J2a9JqfPrCm9eUoNRKgTLTrb
         9vr74+KuJWV4B/SPaaFqTFO0DvQoIXVM8Of3JqDZDFIQ6TwMXRNUvsveuJSttWoc6puR
         7x25LmphB+C2Nhe8YeIIvXNhdFO+IpaaI4pay1RtBgXMGDfZjX0xCr84FykA2bzdj7PI
         IxfwIfZ/ngzm59SMEfBqrncKcTGXUrR0lyXBlbFpiDn/WwSmDEvy1l0gwzo8IXnJcFaJ
         erRw==
X-Gm-Message-State: AOAM532v/4v0FdtAWS6YVa/xvCVwzgwcd9UsAEB6RFQEU2IxWdFlRabG
        RE0oMpV/o7hNnr/SHM5dDENmlsyiFRiMNg==
X-Google-Smtp-Source: ABdhPJzkornVPICR5d77Mh/qYrVgy8agvQG2jf7qx6drtpTpkOHkf57K41cau0UBufYfQSDL9lF4vA==
X-Received: by 2002:a67:e457:: with SMTP id n23mr318332vsm.57.1601677250982;
        Fri, 02 Oct 2020 15:20:50 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id w201sm456415vke.47.2020.10.02.15.20.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 15:20:50 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id n7so584545vkq.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 15:20:50 -0700 (PDT)
X-Received: by 2002:a1f:d986:: with SMTP id q128mr2544346vkg.7.1601677249682;
 Fri, 02 Oct 2020 15:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200929205807.2360405-1-evgreen@chromium.org> <20200929135741.1.I8b447ca96abfbef5f298d77350e6c9d1d18d00f6@changeid>
In-Reply-To: <20200929135741.1.I8b447ca96abfbef5f298d77350e6c9d1d18d00f6@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 2 Oct 2020 15:20:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V3+V0uBiC_whvWEnv1TSkXt-MfnK+34Kir_kfTymejSA@mail.gmail.com>
Message-ID: <CAD=FV=V3+V0uBiC_whvWEnv1TSkXt-MfnK+34Kir_kfTymejSA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: Add qcom,sc7180-qfprom compatible string
To:     Evan Green <evgreen@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 29, 2020 at 1:58 PM Evan Green <evgreen@chromium.org> wrote:
>
> Add an SoC-specific compatible string so that data can be attached
> to it in the driver.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
>
>  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> index 59aca6d22ff9b..b16c8e6a8c23d 100644
> --- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> @@ -14,7 +14,9 @@ allOf:
>
>  properties:
>    compatible:
> -    const: qcom,qfprom
> +    enum:
> +      - qcom,qfprom
> +      - qcom,sc7180-qfprom

You don't want either/or.  You want both.  At the time Srinivas didn't
see the point of having the SoC-specific compatible string here, but
now that we have a reason for it maybe he'll be convinced?  IMO you
essentially want:

    items:
      - enum:
          - qcom,apq8064-qfprom
          - qcom,apq8084-qfprom
          - qcom,msm8974-qfprom
          - qcom,msm8916-qfprom
          - qcom,msm8996-qfprom
          - qcom,msm8998-qfprom
          - qcom,qcs404-qfprom
          - qcom,sc7180-qfprom
          - qcom,sdm845-qfprom
      - const: qcom,qfprom

For some context:
<https://lore.kernel.org/r/CAD=FV=WjvAWVmq3fTh=_f2p1Dv+sXg1RV-CqZr8KRgHe8_wT0w@mail.gmail.com/>

-Doug


>
>    reg:
>      # If the QFPROM is read-only OS image then only the corrected region
> --
> 2.26.2
>
