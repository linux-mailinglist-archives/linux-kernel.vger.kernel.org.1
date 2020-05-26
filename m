Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AC91D2EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 13:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgENLuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 07:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgENLuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:50:20 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEF1C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:50:18 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id p127so4779830oia.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2rW2p6WUMtKGhozEHKEEts3+I7kg5DxNuGw6wF1CLEM=;
        b=PgX9XmdRqisszbkjsPpa0Gwr80htE0F274IforjKb38R1tfcW11dwHs2ltBT8O+9fs
         I8N0ECtStEWmdyk46K3lfbNha7034uGa8mbVnsf+RwbOV0RuiLuAy8e31/Gq2a9erGa2
         SQOdksP93nrOk3G50CG0Mrdgs6pSta7q97WldtKfqCcvEvZFWcW4mQIbrkPM1S3KXzbe
         sqmXCiSe5ZBff4+yGsR3k+Y6mlRRjG50mUAN5ndp5ka4bWE4TtaSptw3oawBOqpPUwSX
         u1RCfDoPEUOVBYzAcjOG0GEJzxnJfxeaEiHxKjU7vMic9oKzxs8rSxrXDSQp0Uo+CU8G
         Q8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2rW2p6WUMtKGhozEHKEEts3+I7kg5DxNuGw6wF1CLEM=;
        b=G/+brfoPrP+LFr2sMcBn1WPXPBE4pON+jVj+5SYBhpU8hEEq9zDjMftvSuZzzFbVlw
         1SP7t7EHfUhp1XSEIraZbMYzb4crJZlj4M3jhb8fRoQhmiHHhI9iuH0eRiSKpU1Hc9Ya
         cXyHJwgpybF4CFC5xtrRP7/Ri2s55G5W8aLw13Yv/bzhmg3wtazRTFcyw5bf+UC5HbJG
         rl7N1ShFJX3GqJ2Lf3KsVSwKF1MkyxVcnM14NMJ3ldce8k0W/hHcR/FhpKC+QTKb0J30
         DM0LvKNTlUDtIxguuF35hzm3Dm9a14UCx27jsA4p5RQ5AUGLxqk7wmL+n9RGLbo0UAxL
         qItQ==
X-Gm-Message-State: AOAM533GFqJ6fTDdyM898d1KJWw1YK4IPdg43zEkOJlYldJng72zS96e
        qeOctOp3l8hJL56Lndcvt5dB+Gn7pLvXrS5URFMLBQ==
X-Google-Smtp-Source: ABdhPJx3vey05pA94gTXh3JPwjGoemVRMMAPudVNha65pjDn+PiNcd2tKPQIp9BSWL8i5Zc0gFHuLtVVKToDeJGM0iQ=
X-Received: by 2002:a05:6808:9ab:: with SMTP id e11mr4680289oig.119.1589457017820;
 Thu, 14 May 2020 04:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200508204200.13481-1-sumit.semwal@linaro.org>
 <20200508204200.13481-2-sumit.semwal@linaro.org> <20200512014339.GE57962@builder.lan>
In-Reply-To: <20200512014339.GE57962@builder.lan>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Thu, 14 May 2020 17:20:06 +0530
Message-ID: <CAO_48GHHhP+gRnEfeXeGob5Q4150oQOtWEyx8Fz5rFiUqXYa4A@mail.gmail.com>
Subject: Re: [v2 1/4] dt-bindings: regulator: Add labibb regulator
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>, robh+dt@kernel.org,
        Nisha Kumari <nishakumari@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, kgunda@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bjorn,

Thanks for the comments!

On Tue, 12 May 2020 at 07:15, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 08 May 13:41 PDT 2020, Sumit Semwal wrote:
>
> > From: Nisha Kumari <nishakumari@codeaurora.org>
> >
> > Adding the devicetree binding for labibb regulator.
> >
> > Signed-off-by: Nisha Kumari <nishakumari@codeaurora.org>
> > Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
>
> Sorry, I missed this when we talked about it. But please rewrite this in
> yaml.
Sure, I will.

>
> >
> > --
> > v2: updated for better compatible string and names.
> > ---
> >  .../regulator/qcom-labibb-regulator.txt       | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt
> >
> > diff --git a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt
> > new file mode 100644
> > index 000000000000..6e639d69f780
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.txt
> > @@ -0,0 +1,47 @@
> > +Qualcomm's LAB(LCD AMOLED Boost)/IBB(Inverting Buck Boost) Regulator
> > +
> > +LAB can be used as a positive boost power supply and IBB can be used as a negative
> > +boost power supply for display panels. Currently implemented for pmi8998.
> > +
> > +Main node required properties:
> > +
> > +- compatible:                        Must be:
> > +                             "qcom,pmi8998-lab-ibb"
> > +- #address-cells:            Must be 1
> > +- #size-cells:                       Must be 0
>
> But the children doesn't have reg properties...
Oh, right. Let me correct that.
>
> > +
> > +LAB subnode required properties:
> > +
> > +- interrupts:                        Specify the interrupts as per the interrupt
> > +                             encoding.
> > +- interrupt-names:           Interrupt names to match up 1-to-1 with
> > +                             the interrupts specified in 'interrupts'
> > +                             property.
>
> Do specify the expected string (and given that you already have the
> lab & ibb subnodes, you don't need to include this in the string).
Yes, agreed. Keeping it as 'sc-err' makes the code easier too.
>
> Regards,
> Bjorn
Best,
Sumit.
>
> > +
> > +IBB subnode required properties:
> > +
> > +- interrupts:                        Specify the interrupts as per the interrupt
> > +                             encoding.
> > +- interrupt-names:           Interrupt names to match up 1-to-1 with
> > +                             the interrupts specified in 'interrupts'
> > +                             property.
> > +
> > +Example:
> > +     pmi8998_lsid1: pmic@3 {
> > +             labibb {
> > +                     compatible = "qcom,pmi8998-lab-ibb";
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +
> > +                     lab: lab {
> > +                             interrupts = <0x3 0xde 0x0 IRQ_TYPE_EDGE_RISING>;
> > +                             interrupt-names = "lab-sc-err";
> > +                     };
> > +
> > +                     ibb: ibb {
> > +                             interrupts = <0x3 0xdc 0x2 IRQ_TYPE_EDGE_RISING>;
> > +                             interrupt-names = "ibb-sc-err";
> > +                     };
> > +
> > +             };
> > +     };
> > --
> > 2.26.2
> >
