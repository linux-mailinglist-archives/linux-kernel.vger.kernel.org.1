Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201962AF9B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 21:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgKKUZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 15:25:07 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34363 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKUZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 15:25:07 -0500
Received: by mail-oi1-f196.google.com with SMTP id w188so3667778oib.1;
        Wed, 11 Nov 2020 12:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d2UhCfR+FPSqXBFp8I37OaKb4IVpY8wcdSKJRwOBPY4=;
        b=A6O7xAYwvPUe7vQRDhMdo3IsKHZy70OpAYVCU8+sZv+Pqe9LctZDto9qngOcWrlPAb
         O6a2uS/LtrDw6k/wh7Qi7WqJciTIGKC2Vae9ceoj32X1jwp0aZS0tO2a3o412qI0EnYQ
         d6mliCxLmxyxFljV3A1IvjGUmMm/PoDshGdJK41Ji03OWxE2gUmYPJAC1FuieKqoFU47
         ztATsUOr63M0YM4+bKmM2TrymrZqockKCtr35gWU1SgmHSIKU0QeFJUl1XimyFsAEtuN
         E5fZFn2+wdcuCkaMg1QKaiqd+lJzO7LZjkLzc/FiJcr+Ti42TI1RNoIDRz9cyzS/4CTw
         i6bg==
X-Gm-Message-State: AOAM531+Zx/46SU5+qCHg+g1kD35Aoma1+D8Avww/nghHrjDHbsh994I
        T/Q0VWo6YPjwVDmFQwRCZg==
X-Google-Smtp-Source: ABdhPJwIarYJoYP3z9DEt3WpnwufR8NzTSpJNI9E1JK3YX6Ww4fDqfbKq2zguFglhqIi+It5Da5dLg==
X-Received: by 2002:a05:6808:56a:: with SMTP id j10mr3367292oig.121.1605126306388;
        Wed, 11 Nov 2020 12:25:06 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 132sm660445oid.54.2020.11.11.12.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 12:25:05 -0800 (PST)
Received: (nullmailer pid 1968388 invoked by uid 1000);
        Wed, 11 Nov 2020 20:25:04 -0000
Date:   Wed, 11 Nov 2020 14:25:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jun Li <lijun.kernel@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: connector: add typec-power-opmode
 property to usb-connector
Message-ID: <20201111202504.GA1964362@bogus>
References: <20201106165805.31534-1-amelie.delaunay@st.com>
 <20201106165805.31534-2-amelie.delaunay@st.com>
 <CAL_Jsq+A=nixpdrT3Omq7Osat=_Egb5g6VGao=gY4CEssOe+xQ@mail.gmail.com>
 <a0e0bde1-5657-c0f9-9123-6b1dd5a1bd73@st.com>
 <CAL_JsqLcTNNWm7ChBjhFaTvfDm-kSYXrppcGU8uFTGEEuaT5Tg@mail.gmail.com>
 <5df74edf-b6f9-3397-4c85-683987dd5743@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5df74edf-b6f9-3397-4c85-683987dd5743@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 05:10:23PM +0100, Amelie DELAUNAY wrote:
> 
> 
> On 11/9/20 5:02 PM, Rob Herring wrote:
> > On Mon, Nov 9, 2020 at 9:54 AM Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
> > > 
> > > On 11/9/20 4:03 PM, Rob Herring wrote:
> > > > On Fri, Nov 6, 2020 at 10:58 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:
> > > > > 
> > > > > Power operation mode may depends on hardware design, so, add the optional
> > > > > property typec-power-opmode for usb-c connector to select the power
> > > > > operation mode capability.
> > > > > 
> > > > > Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> > > > > ---
> > > > > Hi Bahdri, Rob,
> > > > > 
> > > > > I've added the exlusion with FRS property, but new FRS property name
> > > > > should be use here so, be careful.
> > > > > 
> > > > > ---
> > > > >    .../bindings/connector/usb-connector.yaml     | 24 +++++++++++++++++++
> > > > >    1 file changed, 24 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > > > index 62781518aefc..a84464b3e1f2 100644
> > > > > --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > > > +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> > > > > @@ -93,6 +93,24 @@ properties:
> > > > >          - device
> > > > >          - dual
> > > > > 
> > > > > +  typec-power-opmode:
> > > > > +    description: Determines the power operation mode that the Type C connector
> > > > > +      will support and will advertise through CC pins when it has no power
> > > > > +      delivery support.
> > > > > +      - "default" corresponds to default USB voltage and current defined by the
> > > > > +        USB 2.0 and USB 3.2 specifications, 5V 500mA for USB 2.0 ports and
> > > > > +        5V 900mA or 1500mA for USB 3.2 ports in single-lane or dual-lane
> > > > > +        operation respectively.
> > > > > +      - "1.5A" and "3.0A", 5V 1.5A and 5V 3.0A respectively, as defined in USB
> > > > > +        Type-C Cable and Connector specification, when Power Delivery is not
> > > > > +        supported.
> > > > > +    allOf:
> > > > > +      - $ref: /schemas/types.yaml#definitions/string
> > > > > +    enum:
> > > > > +      - default
> > > > > +      - 1.5A
> > > > > +      - 3.0A
> > > > 
> > > > Use the enums here. Unless you want to define it as actual current as
> > > > a numerical value.
> > > 
> > > If I understand your point correctly, I think I should remove allOf here
> > > and stick with what is done to describe power-role and data-role
> > > property. Right ?
> > 
> > No, use the numerical values like FRS:
> > 
> > +      "1" refers to default USB power level as described by "Table
> > 6-14 Fixed Supply PDO - Sink".
> > +      "2" refers to 1.5A@5V.
> > +      "3" refers to 3.0A@5V.
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [1, 2, 3]
> 
> But it changes the type-c class philosophy. There is already an API to
> convert string into enum, the same kind is used for data-role and power-role
> properties.
> Moveover, FRS values doesn't fit with typec_pwr_opmode enum:
> enum typec_pwr_opmode {
> 	TYPEC_PWR_MODE_USB,
> 	TYPEC_PWR_MODE_1_5A,
> 	TYPEC_PWR_MODE_3_0A,
> 	TYPEC_PWR_MODE_PD,
> };

Okay, then strings it is I guess.

Reviewed-by: Rob Herring <robh@kernel.org>
