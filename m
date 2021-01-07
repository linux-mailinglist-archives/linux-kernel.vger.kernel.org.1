Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6699D2ED477
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbhAGQko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbhAGQko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:40:44 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8344C0612F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 08:40:03 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id p5so8004170oif.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 08:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rLbDxkZihrXYUcaRx2rKleFNc1os6D5R11mPf5jrUhQ=;
        b=zEQOzqR3gVGoFJzHHBAmhpEcAZMmzdzcqkwEtisPlRZspQhlik7Pa9Rqbn6ns9rwwz
         Ce9DGgMVWIAy1AhAs5HFhR9kRBLL1Jz63vJ1A/Xc23hxtjO7aB5KElCB83MeSSML/FbX
         vZ1nTlYEHyyf/gmNKmdzEe8BMZjigy+kpxyKt4AEPSCDwJQLXTaQogAG2mB9KamlXfbt
         geOE2fECNGQ64AcyMEG/pQzDt3DgY/mlcPz5Felz3vtG+uxIN9SBoQWMpswlFib0s806
         Ex0gxpS4aMu47svJ6o127/slP2FZxgfJ0mKgjbrlLSseWQUgfaUO8c6ZNWMjUoW6FbGo
         AzJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rLbDxkZihrXYUcaRx2rKleFNc1os6D5R11mPf5jrUhQ=;
        b=h1SxJoO34FkXVG2H0joLN1Gz141YGTsK262TpNuRdwxc2WbsA3sDgvI1g14PU1r8H+
         ok6ad7d1xbXVCmhlcif1JF/E1Ga4mpUoVWvZ2h1BElFQIN9fjDGfhHlgnTV0wO4A9oB9
         rcNz4bQ2ilJ0dhFSfFmb+aZK5qeUzX4Sw3rnit5DfpyHm4F2JoyWM9uLlISTguNWQ2OM
         cFZBF/yGS4tNLO2az7J3A/iBoZih9KUN3TeLnAbLU/8M1B+WholDWh1F/qA92Af4OpdH
         /MGvhJlDLHeXH1At9VorqU8QIvnaEdKmmxh1JcnBAiQXUajgc5z8wICA1MPvhcC8KAqB
         zT6A==
X-Gm-Message-State: AOAM530HytKt5pVsIlU7h38W033kUocBdLrqMgKRcmNn6ipu8gKn6LLR
        vHrYrrn44ugim5VBWTEfWM4z/bE9DEJjenY62XTSRw==
X-Google-Smtp-Source: ABdhPJxVobV2F3VeEA8e2tLKd579WXQpBTToHYqjORg8YZ+RswgelRFykfU7Nveq/PTaOvCpUZlHJWFLpOYKZhcwHrw=
X-Received: by 2002:aca:5e42:: with SMTP id s63mr6916565oib.96.1610037603029;
 Thu, 07 Jan 2021 08:40:03 -0800 (PST)
MIME-Version: 1.0
References: <20201222222637.3204929-1-robert.marko@sartura.hr>
 <20201222222637.3204929-3-robert.marko@sartura.hr> <20201223005633.GR3107610@lunn.ch>
In-Reply-To: <20201223005633.GR3107610@lunn.ch>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Thu, 7 Jan 2021 17:39:52 +0100
Message-ID: <CA+HBbNF0OqD7g-SnicEaUcX-YMu99pjQr1vFQ1Nhkj+izyTDkw@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: net: Add bindings for Qualcomm QCA807x
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, David Miller <davem@davemloft.net>,
        kuba@kernel.org, netdev@vger.kernel.org,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 1:56 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +  gpio-controller: true
> > +  "#gpio-cells":
> > +    const: 2
> > +
> > +  qcom,single-led-1000:
> > +    description: |
> > +      If present, then dedicated 1000 Mbit will light up for 1000Base-T.
> > +      This is a workround for boards with a single LED instead of two.
> > +    type: boolean
> > +
> > +  qcom,single-led-100:
> > +    description: |
> > +      If present, then dedicated 1000 Mbit will light up for 100Base-TX.
> > +      This is a workround for boards with a single LED instead of two.
> > +    type: boolean
> > +
> > +  qcom,single-led-10:
> > +    description: |
> > +      If present, then dedicated 1000 Mbit will light up for 10Base-Te.
> > +      This is a workround for boards with a single LED instead of two.
> > +    type: boolean
>
> Sorry, but no. Please look at the work being done for allow PHY LEDs
> to be controlled via the LED subsystem.

Ok, I will drop the LED configuration from the driver until there is a generic
way to do it.
I was following the work on it, but it seems to have halted after September.
>
> > +  qcom,tx-driver-strength:
> > +    description: PSGMII/QSGMII TX driver strength control.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
>
> Please use the actual values here, and have the driver convert to the
> value poked into the register. So the property would be
> qcom,tx-driver-strength-mv and it would have the value 220 for
> example.
Ok, it actually makes more sense than using dt-binding includes for this.
>
> > +
> > +  qcom,control-dac:
> > +    description: Analog MDI driver amplitude and bias current.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
>
> Make here.
I am using defines in dt-binding includes for this one as it makes the
values humanly readable in DT as these configure the amplitude and
bias current for power saving.
>
>      Andrew
