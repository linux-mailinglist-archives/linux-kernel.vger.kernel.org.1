Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422C32F4B59
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbhAMMc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbhAMMc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:32:28 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECCFC061575;
        Wed, 13 Jan 2021 04:31:47 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id z5so3603951iob.11;
        Wed, 13 Jan 2021 04:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dNewR/GBxYcqHW8j6LuwWO6j2XEeY/N+ilHta5QzCk=;
        b=lcWTjOWdQuNqFHO9XwhlRGKL/P9lSHTuR6eETxZ2dEeh76XT++qEVAaXM1wS9xzjDe
         hqBQbFaTjiy3H9zXt+2ws+2+fbdAvhgkpsB8jcPL/UIiTiPO/tiT1+mNBGreOMHWjYqe
         gGJZgrBj1w2YA4pso727j9FplByThhA6cO0SNAbbQ3CWJYtcMimyJuHDHrPEKebOj+Mh
         e8ZXaRAypHPUN1WF2z9+TmEeLC4bfBoiJrvJAOK1gqTzsLK6O7yZt+72xXVCaFAHWfcB
         zZxODTYsHJuFKwmWWoDMOSS7qaUMakKlmAI2SBaUD0ndXAXvLWH3EUbtFnyhqHypIZ/t
         CprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dNewR/GBxYcqHW8j6LuwWO6j2XEeY/N+ilHta5QzCk=;
        b=tISayi3wE+8gbMqW1i8oYRysb2eZROFg5ZaJGM1UVXW/W0F17TYcnZP0uGsjCIriQX
         0dK3wNt4/bB8RTan/whu2wbiXrhoQ4kZ/1HUOliKQBowr8BfJo0d1iL/EzJ2mH+6jcUn
         64j/txKHoxuHH++x1hbn6KI6NkojlpeApx+KKm4cOaYQBAhjgEknXaz2B63Op4QIz5Zu
         HiolEbwF5jePIRJzLuUrJ6EU5ILIyK3M2MQeTAqxHVmQwPL+GvFXQ4xhLbQiV968dbLB
         hPtIh1Yd0BuxHcPIOnmiHLAAkbBYUlLVCw06EEsxfq6gRAQOqLpBkhveDiA48sI0gaeG
         Rqwg==
X-Gm-Message-State: AOAM532/zPt/oQHeDEIjrjQIeF/VHtjgRFZO86aiZnQraVfw14qvgjjH
        PS1K0x8uQa7yRr6bg3T3032C4B7OtlyCfajBgX7Qta/ukYKQ7Q==
X-Google-Smtp-Source: ABdhPJxwcpHJVURwhWzDFDHmcEiM8hi12WksernV6sFsug/0SRqUo7Gkf96usQ+DR19K8jeC4AYpIgzgyBLayGVYZqk=
X-Received: by 2002:a92:d64e:: with SMTP id x14mr2079672ilp.89.1610541107166;
 Wed, 13 Jan 2021 04:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20210106173900.388758-1-aford173@gmail.com> <20210113031602.GA1443816@robh.at.kernel.org>
In-Reply-To: <20210113031602.GA1443816@robh.at.kernel.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 13 Jan 2021 06:31:35 -0600
Message-ID: <CAHCN7xKLRj=bbMQAXNDZ+8cHh+jon5Bb7GdQYpVUos91uiV5Tw@mail.gmail.com>
Subject: Re: [RFC 1/2] dt-bindings: clk: versaclock5: Add load capacitance properties
To:     Rob Herring <robh@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 9:16 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jan 06, 2021 at 11:38:59AM -0600, Adam Ford wrote:
> > There are two registers which can set the load capacitance for
> > XTAL1 and XTAL2. These are optional registers when using an
> > external crystal.  Update the bindings to support them.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >  .../devicetree/bindings/clock/idt,versaclock5.yaml   | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > index 2ac1131fd922..e5e55ffb266e 100644
> > --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > @@ -59,6 +59,18 @@ properties:
> >      minItems: 1
> >      maxItems: 2
> >
> > +  idt,xtal1-load-femtofarads:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
>
> Already has a type, so you can drop the $ref.
>
> > +    minimum: 9000
> > +    maximum: 25000

Luca,

Do you want the range to the 9000 - 25000 per the datasheet, or should
I use the max value based on the programmer guide?  Currently, my
intent was to cap the value to 11111b, so anyone who writes 23000,
24000, or 25000 will all be the same value based on the feedback I got
from Renesas.

adam
> > +    description: Optional loading capacitor for XTAL1
> > +
> > +  idt,xtal2-load-femtofarads:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 9000
> > +    maximum: 25000
> > +    description: Optional loading capacitor for XTAL2
> > +
> >  patternProperties:
> >    "^OUT[1-4]$":
> >      type: object
> > --
> > 2.25.1
> >
