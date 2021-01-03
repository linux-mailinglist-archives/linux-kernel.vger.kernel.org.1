Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C3B2E8A22
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 04:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbhACDmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 22:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbhACDmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 22:42:16 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE3DC061573
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jan 2021 19:41:36 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id q25so23009738otn.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jan 2021 19:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Je7ZrxEnj+ATsetwnIVjeJYWwlX+I7xy7rp43NLumnY=;
        b=quOajXQY6VJPaJAkWTocL8j8AqsHafiK54ydwCzYQaWsUdz5K3Vf/+yf1xuI5XJVrU
         ji3FeCXlNzGFsDALfotdDNtygWXmj6mxc9iAmnp4PcrdcLflroYRLt1TEDEMcQwbScWg
         AH7e2oXYhCNwJ1oxCrEetxCOwXtU7ouRww5/Z0eCBXU+RcD/+GhQP78buIbokgR7WtLi
         bt7Uov4IBmAedhXuvqQCw8VGqwmdz7L9nqkp/S6b62fJGNb1gV2HMrN8/dX/W5YoQ2ZJ
         Enkihm3jIWGfwSC+8yAfUMzjrbl43dprOqzSiRmILeImFzcUUAWWi3rKbxSmVWrmrk/8
         5ZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Je7ZrxEnj+ATsetwnIVjeJYWwlX+I7xy7rp43NLumnY=;
        b=bia+mXJ+/6OOh+lLxtz5Ewvad6o39j9G0agiOTx5LGRoK6wKs/vKCIwM3LHKDjasvj
         jO7s+5eK2t4OwJ6SOQdWeyOMnsAELmOByxRNryOI9VM6pinuwzKLKIEWtEsnNKIkcZBk
         pzyIKLmlEH3wEQKLf2ZZYMSJFbNMPS9MUR3HHGdF5wwyDtytB7ka7AamAyyUdqx9kjp3
         eZss+0wzSA3YRBh6OZIGQW5EG3QSeDDA0ClMj4fGXbZm8TKET7TTmjZEuLl7eA0H9fc1
         HW2IRoiiWHvxpSe7gEu0eIOOidi/sM2+vJWFE823XrpwDDjw1RK2jx3wy2vOepAAAkcr
         TW+Q==
X-Gm-Message-State: AOAM531eEe9bJ14gWdF2RDcYlitBzgWT5LuSWfa+Wom+9sNm0na/f9RX
        wGBl9sBjleb3JumEpkWeIWoiXA9vsM7+KqxKMaNUZg==
X-Google-Smtp-Source: ABdhPJwyEw/sVqCr/JlCcfICKxi49vVyMYEVCq8AmNf3r1z+Fr4GK4Um4/kES72uqtfRsLN1X9jsCwdUFsmmCe5uPyE=
X-Received: by 2002:a9d:4e84:: with SMTP id v4mr49880828otk.45.1609645295473;
 Sat, 02 Jan 2021 19:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20201220165845.3712599-1-dmitry.baryshkov@linaro.org>
 <20201220165845.3712599-2-dmitry.baryshkov@linaro.org> <20201231225007.GA2509172@robh.at.kernel.org>
In-Reply-To: <20201231225007.GA2509172@robh.at.kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 3 Jan 2021 06:41:24 +0300
Message-ID: <CAA8EJpp7cJO9Dej3uicPA0+BccqVjs=VphDmGSj05t7SeypAfQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: mfd: qcom,qca639x: add binding for
 QCA639x defvice
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 1 Jan 2021 at 01:50, Rob Herring <robh@kernel.org> wrote:
>
> On Sun, Dec 20, 2020 at 07:58:42PM +0300, Dmitry Baryshkov wrote:
> > Qualcomm QCA639x is a family of WiFi + Bluetooth SoCs, with BT part
> > being controlled through the UART and WiFi being present on PCIe bus.
> > Both blocks share common power sources. Add binding to describe power
> > sequencing required to power up this device.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../devicetree/bindings/mfd/qcom,qca639x.yaml | 84 +++++++++++++++++++
> >  1 file changed, 84 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,qca639x.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/qcom,qca639x.yaml b/Documentation/devicetree/bindings/mfd/qcom,qca639x.yaml
> > new file mode 100644
> > index 000000000000..d43c75da136f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/qcom,qca639x.yaml
> > @@ -0,0 +1,84 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/mfd/qcom,qca639x.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Qualcomm QCA639x WiFi + Bluetoot SoC bindings
> > +
> > +maintainers:
> > +  - Andy Gross <agross@kernel.org>
> > +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> > +
> > +description: |
> > +  This binding describes thes Qualcomm QCA6390 or QCA6391 power supplies and
> > +  enablement pins.
>
> Humm, this should really be for the whole device. For BT/WiFi chips
> we've gotten away with 2 nodes for each interface. If that doesn't work
> here, then I think this needs to be 1 node for all, not 3 as it seems
> you are doing.

2 nodes: one for common power sequencer and one for bluetooth part.
WiFi part doesn't need a separate node, but see below.

>
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,qca639x
>
> List each device, we don't do wildcards in compatible strings.

Ack. I will change this to qca6390, as 6391 should be fully compatible
from the power sequence point of view.

>
> > +
> > +  '#power-domain-cells':
> > +    const: 0
> > +
> > +  pinctrl-0: true
> > +  pinctrl-1: true
> > +
> > +  pinctrl-names:
> > +    items:
> > +      - const: default
> > +      - const: active
> > +
> > +  vddaon-supply:
> > +    description:
> > +      0.95V always-on LDO power input
> > +
> > +  vddpmu-supply:
> > +    description:
> > +      0.95V LDO power input to PMU
> > +
> > +  vddrfa1-supply:
> > +    description:
> > +      0.95V LDO power input to RFA
> > +
> > +  vddrfa2-supply:
> > +    description:
> > +      1.25V LDO power input to RFA
> > +
> > +  vddrfa3-supply:
> > +    description:
> > +      2V LDO power input to RFA
> > +
> > +  vddpcie1-supply:
> > +    description:
> > +      1.25V LDO power input to PCIe part
> > +
> > +  vddpcie2-supply:
> > +    description:
> > +      2V LDO power input to PCIe part
>
> Do the PCIe supplies have to be on if only the BT part is used?

Good question. The documentation just tells us to power up all rails.
There are further internal voltage regulators taking care of current
qca639x mode

>
> Supplies are refcounted, so I'd suggest just duplicating the supplies in
> both the BT and PCIe nodes.

While for BT it would be easy, for PCIe it is not that easy. We have
to make sure that the chip is powered up before the respective PCIe
bus is probed (basically before the PCIe controller driver is probed).
I ended up putting a reference to the PCIe PHY device node, making
sure that qca6391 is powered up before the PCIe PHY driver is probed.
PCIe device node itself has its own power-domains entry (PCIE_0_GDSC).

>
> > +
> > +  vddio-supply:
> > +    description:
> > +      1.8V VIO input
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    qca639x: qca639x {
> > +      compatible = "qcom,qca639x";
> > +      #power-domain-cells = <0>;
> > +
> > +      vddaon-supply = <&vreg_s6a_0p95>;
> > +      vddpmu-supply = <&vreg_s2f_0p95>;
> > +      vddrfa1-supply = <&vreg_s2f_0p95>;
> > +      vddrfa2-supply = <&vreg_s8c_1p3>;
> > +      vddrfa3-supply = <&vreg_s5a_1p9>;
> > +      vddpcie1-supply = <&vreg_s8c_1p3>;
> > +      vddpcie2-supply = <&vreg_s5a_1p9>;
> > +      vddio-supply = <&vreg_s4a_1p8>;
> > +      pinctrl-names = "default", "active";
> > +      pinctrl-0 = <&wlan_default_state &bt_default_state>;
> > +      pinctrl-1 = <&wlan_active_state &bt_active_state>;
> > +    };
> > +...
> > --
> > 2.29.2
> >



-- 
With best wishes
Dmitry
