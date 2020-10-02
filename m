Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C23281EF5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 01:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgJBXPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 19:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgJBXPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 19:15:05 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E10C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 16:15:03 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b12so3797295lfp.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X7v0IguEkfr1cOBmK+SE8+7CIjedoZmEtVTfp5z8yVo=;
        b=FKIIGNm4cuXzs5quW9CEsjwrBj/6hqBDlLAbYlhfvbbn90YZfqbXxeZnjcqGYHc2+P
         DmWhmHUaOnPKYLk5zeuEaxW74SuTqmoumQLo54K2124c58ju5tkmCzv5A856Ncmtf2pu
         89vVhrcPGWaAoE7eOd9ckQ+014uVKwEoEbb54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X7v0IguEkfr1cOBmK+SE8+7CIjedoZmEtVTfp5z8yVo=;
        b=eTQ9/u93zsMBTNDXM8wYH80hGvLHeKpCe2QHrgya8++5f7sc48r+OX9OO/qYk+QnWt
         BSeZ+oKkRgdjFRaYt3lA2dbv7m1/TV0ltuFOdL5HsGMoezc6XfXUSr45S0JLEVTow5AS
         793hERVGWlQoVTkBZPilO7m+NVtx6ndxBHWgItfpMCFsS5PKsONqeGcjKF4yRPJzQLZ9
         apJpJz4EE36w3AELLmYS8pVrSSJ8Wt7hpWJp+QKlV9A3t38hsaPWHE943Kr5cBl6esGf
         /cN50ADN3M31v/K7lLE5rtqAnEyJwbssqagxJMasNWDERsf8e87CPnOcfu4ygKqzUr3h
         Ltdw==
X-Gm-Message-State: AOAM5319Xya0vjzIwZPTmurVt3F8AJ/sivNCF/Y7aYCSYRm0Fy1jnkBP
        oxivHNmP5Zpu5xEyB37GwXPnBCipatvaag==
X-Google-Smtp-Source: ABdhPJxftm4rdqPWqkfyZDKyIsi8YFxLkb0uwcEFV+s7wDA8I2kSKEQ63ytEAoFcu0OEBl1HYwfvgA==
X-Received: by 2002:ac2:4db7:: with SMTP id h23mr1528061lfe.459.1601680501666;
        Fri, 02 Oct 2020 16:15:01 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id a7sm759563lfl.56.2020.10.02.16.15.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 16:15:00 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id k25so2478094ljg.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 16:15:00 -0700 (PDT)
X-Received: by 2002:a2e:b4fc:: with SMTP id s28mr1247909ljm.305.1601680500013;
 Fri, 02 Oct 2020 16:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200929205807.2360405-1-evgreen@chromium.org>
 <20200929135741.1.I8b447ca96abfbef5f298d77350e6c9d1d18d00f6@changeid> <CAD=FV=V3+V0uBiC_whvWEnv1TSkXt-MfnK+34Kir_kfTymejSA@mail.gmail.com>
In-Reply-To: <CAD=FV=V3+V0uBiC_whvWEnv1TSkXt-MfnK+34Kir_kfTymejSA@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 2 Oct 2020 16:14:23 -0700
X-Gmail-Original-Message-ID: <CAE=gft6GAYePE6eCPi4PxNoJvc1K=KYCN5U_PvTRNnLdpKmLyg@mail.gmail.com>
Message-ID: <CAE=gft6GAYePE6eCPi4PxNoJvc1K=KYCN5U_PvTRNnLdpKmLyg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: nvmem: Add qcom,sc7180-qfprom compatible string
To:     Doug Anderson <dianders@chromium.org>
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

On Fri, Oct 2, 2020 at 3:20 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Tue, Sep 29, 2020 at 1:58 PM Evan Green <evgreen@chromium.org> wrote:
> >
> > Add an SoC-specific compatible string so that data can be attached
> > to it in the driver.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
> >
> >  Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> > index 59aca6d22ff9b..b16c8e6a8c23d 100644
> > --- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> > +++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
> > @@ -14,7 +14,9 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    const: qcom,qfprom
> > +    enum:
> > +      - qcom,qfprom
> > +      - qcom,sc7180-qfprom
>
> You don't want either/or.  You want both.  At the time Srinivas didn't
> see the point of having the SoC-specific compatible string here, but
> now that we have a reason for it maybe he'll be convinced?  IMO you
> essentially want:
>
>     items:
>       - enum:
>           - qcom,apq8064-qfprom
>           - qcom,apq8084-qfprom
>           - qcom,msm8974-qfprom
>           - qcom,msm8916-qfprom
>           - qcom,msm8996-qfprom
>           - qcom,msm8998-qfprom
>           - qcom,qcs404-qfprom
>           - qcom,sc7180-qfprom
>           - qcom,sdm845-qfprom
>       - const: qcom,qfprom
>
> For some context:
> <https://lore.kernel.org/r/CAD=FV=WjvAWVmq3fTh=_f2p1Dv+sXg1RV-CqZr8KRgHe8_wT0w@mail.gmail.com/>

That makes sense, thanks Doug.

Srini, do you want me to go fix up all the various device trees to add
the soc-compatible string, or just sc7180? (Also, don't forget about
my other question about whether you still want the keepout stuff in
the core at the cost of added complexity).

-Evan

>
> -Doug
>
>
> >
> >    reg:
> >      # If the QFPROM is read-only OS image then only the corrected region
> > --
> > 2.26.2
> >
