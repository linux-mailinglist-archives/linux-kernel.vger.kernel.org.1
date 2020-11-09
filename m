Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81F32AC067
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgKIQDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:03:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729658AbgKIQDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:03:05 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72E74216C4;
        Mon,  9 Nov 2020 16:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604937784;
        bh=YkEwFfSdMDdq9/clov9ZEns0F1+3sR4zx7EG5cfZhYc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mRNOOAn5sC8Z//uTsvBQuvVMEaa0ZT/YLDcQyTdt+DxbBFmTDwhhhv49XpsK3Uked
         9bpsVbMVj2tcHibCkh1OHn5NfrB/S5Bpfv3V/v4OcjwiTeqrVvqvTTEBrz6qrB6oy1
         kBhV9RQvAaf3eWxJmgRMo60qLvA4zIR6i4xXItNo=
Received: by mail-oi1-f174.google.com with SMTP id t16so10693797oie.11;
        Mon, 09 Nov 2020 08:03:04 -0800 (PST)
X-Gm-Message-State: AOAM53005avSpymzRA4pAoDaUjogIVXrvnI+2e7mmoQDvic936Iz1XyI
        n9YLhhkPNd7iJESRYEnOFyV/xiUirT3lQH1T9g==
X-Google-Smtp-Source: ABdhPJwUDjegKtKBMpqT91zhRknyIWujIwiGxHoxmVjfzOiuKkE6iJqRiSsYwAylWRatkHNGVt6QBND93MEfLu5Qk+c=
X-Received: by 2002:aca:5dc2:: with SMTP id r185mr9674317oib.106.1604937783677;
 Mon, 09 Nov 2020 08:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20201106165805.31534-1-amelie.delaunay@st.com>
 <20201106165805.31534-2-amelie.delaunay@st.com> <CAL_Jsq+A=nixpdrT3Omq7Osat=_Egb5g6VGao=gY4CEssOe+xQ@mail.gmail.com>
 <a0e0bde1-5657-c0f9-9123-6b1dd5a1bd73@st.com>
In-Reply-To: <a0e0bde1-5657-c0f9-9123-6b1dd5a1bd73@st.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 9 Nov 2020 10:02:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLcTNNWm7ChBjhFaTvfDm-kSYXrppcGU8uFTGEEuaT5Tg@mail.gmail.com>
Message-ID: <CAL_JsqLcTNNWm7ChBjhFaTvfDm-kSYXrppcGU8uFTGEEuaT5Tg@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: connector: add typec-power-opmode
 property to usb-connector
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 9:54 AM Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
>
> On 11/9/20 4:03 PM, Rob Herring wrote:
> > On Fri, Nov 6, 2020 at 10:58 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:
> >>
> >> Power operation mode may depends on hardware design, so, add the optional
> >> property typec-power-opmode for usb-c connector to select the power
> >> operation mode capability.
> >>
> >> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> >> ---
> >> Hi Bahdri, Rob,
> >>
> >> I've added the exlusion with FRS property, but new FRS property name
> >> should be use here so, be careful.
> >>
> >> ---
> >>   .../bindings/connector/usb-connector.yaml     | 24 +++++++++++++++++++
> >>   1 file changed, 24 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >> index 62781518aefc..a84464b3e1f2 100644
> >> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> >> @@ -93,6 +93,24 @@ properties:
> >>         - device
> >>         - dual
> >>
> >> +  typec-power-opmode:
> >> +    description: Determines the power operation mode that the Type C connector
> >> +      will support and will advertise through CC pins when it has no power
> >> +      delivery support.
> >> +      - "default" corresponds to default USB voltage and current defined by the
> >> +        USB 2.0 and USB 3.2 specifications, 5V 500mA for USB 2.0 ports and
> >> +        5V 900mA or 1500mA for USB 3.2 ports in single-lane or dual-lane
> >> +        operation respectively.
> >> +      - "1.5A" and "3.0A", 5V 1.5A and 5V 3.0A respectively, as defined in USB
> >> +        Type-C Cable and Connector specification, when Power Delivery is not
> >> +        supported.
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#definitions/string
> >> +    enum:
> >> +      - default
> >> +      - 1.5A
> >> +      - 3.0A
> >
> > Use the enums here. Unless you want to define it as actual current as
> > a numerical value.
>
> If I understand your point correctly, I think I should remove allOf here
> and stick with what is done to describe power-role and data-role
> property. Right ?

No, use the numerical values like FRS:

+      "1" refers to default USB power level as described by "Table
6-14 Fixed Supply PDO - Sink".
+      "2" refers to 1.5A@5V.
+      "3" refers to 3.0A@5V.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 3]

Rob
