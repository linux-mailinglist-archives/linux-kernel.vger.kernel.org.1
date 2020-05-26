Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6821A7701
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 11:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437423AbgDNJJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 05:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437383AbgDNJJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:09:30 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BD2C0A3BD0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 02:09:29 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n17so11629057lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 02:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/jjcpDWJJCm/4UD6RSTptZqrE2MCrtUN9gDsEJ2RDk=;
        b=mbqoFFVi/5Zv4uaWbNQuLuwUPh5Ix5igCOrh0j7iAHy/uLKhlxhSQPI+5JqGqgsyt8
         z5RY4fB+g06qLRwyfLuanEa0deqAbfCpO0+YUOHH4a1bmtjivm4GXpXye+rCsl7pcjT3
         Kyj5jZIKoA6JK42//jI1NxxtyisZe5GR4hirE8TPDp1XyPw3UhpQKXXqz8ipnpDrwm6b
         tjNAHT6X4t1YjkHsH7ltu8nB25Vyvqj7AqV34pJjeOM61ARCNMhx7GoqNmz/wxW6CiKd
         psmA42mmRiCX5+cEazZzf68zjL93WhKKPfk1FWu41gvFoMFsKidGNVJ0FT0FtITqKGD8
         Q3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/jjcpDWJJCm/4UD6RSTptZqrE2MCrtUN9gDsEJ2RDk=;
        b=oxEMD8euZvyRAY3cD3Qz86h5u7IyB8izEwiZD7P9dSpL0BKI8MnoLmciZ43ueyKK6r
         QSLG/O4PMh66yctQsIg0Thh60UnPHHDnCFOKzD5PFG+hZ+DZzY3bVuq5xqU+sHC4ghcw
         5Y079dGbROJg1cV1UaLrKugCV+0bxiWZYDVizpLAIQ+plMgpSZRRlj7tbnNZUAynkjDt
         B7QI04KpT7JaSAWD+N0DbhRU13tcAnd1sXwDq+Bw3i2KjOt2b4TwMDPO33du33Tsz3h0
         07Wqj+rVn4em3cVyJi14dJalVEGYZ5pL2CkXjjzxCYhGBOFn9tS8rkVv0VWP81YnE6MB
         bHVw==
X-Gm-Message-State: AGi0PuY8ACNGf/Bre3PBonCGHVOUuYSuFnqSi6WkSYvxZZeWfBl8YTdj
        97RaDhCAdSEei5ya8plPsUBZPnxJvoU/XpBaM0pDtQ==
X-Google-Smtp-Source: APiQypK6pT2Izf1yio7JAUcBy8yfd3egCkIvdRCIFWIsppoWZu+KBD9EBUX6zlGOnGH8kyF+DeD81LKz0ivkG3QgTjY=
X-Received: by 2002:a2e:9256:: with SMTP id v22mr12722064ljg.286.1586855368004;
 Tue, 14 Apr 2020 02:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org>
 <1585064650-16235-2-git-send-email-jprakash@codeaurora.org>
 <CAHLCerML7vR9X_YxAg=S71n2NiY88toZyGDhxZaUZAvnNX2P+g@mail.gmail.com> <69b882b0-56ad-1b93-0a9d-2c7f96dd9d32@codeaurora.org>
In-Reply-To: <69b882b0-56ad-1b93-0a9d-2c7f96dd9d32@codeaurora.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 14 Apr 2020 14:39:13 +0530
Message-ID: <CAP245DXqDFGkd0Q3WactiwZjx5HpV3UrLmb7hd_9uvoy2_=d5Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: adc: Convert the QCOM SPMI ADC bindings to .yaml format
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Jonathan.Cameron@huawei.com,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        kgunda@codeaurora.org, aghayal@codeaurora.org,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 5:15 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
> Hi Amit,
>
> On 4/3/2020 5:34 PM, Amit Kucheria wrote:
> >
> >> +required:
> >> +  - compatible
> >> +  - reg
> >> +  - '#address-cells'
> >> +  - '#size-cells'
> >> +  - '#io-channel-cells'
> >> +
> >> +patternProperties:
> >> +  "^[a-z0-9-_@]$":
> >> +    type: object
> >> +    description: |
> >> +      Represents the external channels which are connected to the ADC.
> >> +      For compatible property "qcom,spmi-vadc" following channels, also known as
> >> +      reference point channels, are used for result calibration and their channel
> >> +      configuration nodes should be defined:
> >> +      VADC_REF_625MV and/or VADC_SPARE1(based on PMIC version) VADC_REF_1250MV,
> >> +      VADC_GND_REF and VADC_VDD_VADC.
> > Instead of this note for "qcom,spmi-vadc", you can enforce this
> > through checks in YAML grammar.
> >
> > A simple example can be found in
> > Documentation/devicetree/bindings/thermal/qcom-tsens.yaml. Look for
> > the if, then, else clause which determines how many interrupts need to
> > be defined.
>
> I have gone through tsens and other examples, but I'm not able to get a
> way to apply this kind of constraint, on what child nodes should be present.
>
> In this case, the constraint would have to be that for compatible
> property "qcom,spmi-vadc", there should be at least four child nodes and
> those four should have their "reg" property fixed to the channel values
> mentioned above. I can see how to apply constraints on a single property
> like interrupts in tsens, but I'm not sure if there is a way to specify
> a lower limit to the number of child nodes or something like "there
> should be at least one child node with value 0x9 for its "reg"
> property". I could not find any examples with constraints placed on
> number of occurrences of a child node.
>
> Can you please share an example of such a constraint if you are aware of
> any or suggest some way by which this kind of constraint can be specified?

Hi Jishnu,

I misread that particular property. I don't think it is possible to
specify child nodes w/o splitting this binding into two, I think.
Please go ahead with the rest of changes. I'll keep digging to see if
this is possible.

Regards,
Amit
