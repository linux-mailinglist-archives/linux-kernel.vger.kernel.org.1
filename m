Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0384A2F6681
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbhANQzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbhANQzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:55:53 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA202C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:55:12 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id d8so5781257otq.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5m+OY37W0GKLWbfky43ZmcAdCMqxDwjhx52GcGW1hDQ=;
        b=T5s98gvdXLbHxUEItuGeY4Rzy0y6xaGT9/7huL2B59jiNMpsrDIX6qzpGLUJFv37vz
         ZhTPOjKaO2dkxZiQhRGhA/AEVJ5sSroHOwA9pYvLPQONjYBgyFV1Qlzm8KKSsB8V113w
         OJ/ieg5L1AuNTYg9lfKHqKtF+PFOPfpQ+x0vHPqLFpYxN3ozgDuQ7au2iM8tSyQhM02j
         R1qFEcoXOvugP0pzy3j+iI/Qx6lAajeXrT5eNxi41ytWrmF6XkgOpmlYoQPoeuJmlYKA
         OhR60jPdDt8kZoFBwb2peCw+Exom29mNPRCrzMEEv6dd/xFkawj96io2BPeMi7z65LU0
         rfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5m+OY37W0GKLWbfky43ZmcAdCMqxDwjhx52GcGW1hDQ=;
        b=ra19Ex79kNLdLignRrLzdgcqBbviy+ppTtz9Jo10tMeFK1isnApm7ILUjCY+fPoo0D
         52951Nvg7fPx3Gylli1yIEfOFkuucjWTaSocQ0pjuiKKqae0w4dPuPZt+eXiSduY4OM3
         wXKmXDlU8MCijFY3ZIqpLqmveV1rhbTWkbc865vyGG5ttpmgC18qJuLdZofwU76O75d5
         YpWc/HDpZxXpAU4p+Uc4bECdB3vOG+nvrO50OVb6z0uYVA7GeP9HOr6H/mASwtGDR79G
         oTzFpaEaOtbOF+mraFakYJi5oo+vVc3FRX5TI+PutXFVjuVNSoeEiwytIda3Q3N0Ue21
         gsQA==
X-Gm-Message-State: AOAM5306ReU1AlIyzFvfFxWIl584smK4uoAKTTwkT4t3FQ9cN2RWsUFX
        xR1BbZ6HJ0kqxGgJ6iu1O9B4KVfXOt30I+mJwcHSyRfmOgZgzO3L
X-Google-Smtp-Source: ABdhPJxgDeLZoaanGamxKRHggVdrfTzkLl3FSiAzq7Cd5Si5C37i7V5LGYE+PqdRJzVReh7gIbausg+9b2UZrNc/kco=
X-Received: by 2002:a9d:4e84:: with SMTP id v4mr5310699otk.45.1610643312061;
 Thu, 14 Jan 2021 08:55:12 -0800 (PST)
MIME-Version: 1.0
References: <20201220165845.3712599-1-dmitry.baryshkov@linaro.org>
 <20201220165845.3712599-2-dmitry.baryshkov@linaro.org> <20201231225007.GA2509172@robh.at.kernel.org>
 <CAA8EJpp7cJO9Dej3uicPA0+BccqVjs=VphDmGSj05t7SeypAfQ@mail.gmail.com> <CAL_Jsq+1rMKgiumshe2BMSMS-hn03pjmfF3P90j=o8kNQTGCLQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+1rMKgiumshe2BMSMS-hn03pjmfF3P90j=o8kNQTGCLQ@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 14 Jan 2021 19:55:00 +0300
Message-ID: <CAA8EJpqPONJfQLFQhB3_AEdFYcZ8rKWJw7=wd7KzJRhOEr+w_A@mail.gmail.com>
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

Hi Rob,

On Thu, 14 Jan 2021 at 17:33, Rob Herring <robh@kernel.org> wrote:
>
> On Sat, Jan 2, 2021 at 9:41 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > Hello,
> >
> > On Fri, 1 Jan 2021 at 01:50, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Sun, Dec 20, 2020 at 07:58:42PM +0300, Dmitry Baryshkov wrote:
> > > > Qualcomm QCA639x is a family of WiFi + Bluetooth SoCs, with BT part
> > > > being controlled through the UART and WiFi being present on PCIe bus.
> > > > Both blocks share common power sources. Add binding to describe power
> > > > sequencing required to power up this device.
> > > >
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > >  .../devicetree/bindings/mfd/qcom,qca639x.yaml | 84 +++++++++++++++++++
> > > >  1 file changed, 84 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,qca639x.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/mfd/qcom,qca639x.yaml b/Documentation/devicetree/bindings/mfd/qcom,qca639x.yaml
> > > > new file mode 100644
> > > > index 000000000000..d43c75da136f
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/mfd/qcom,qca639x.yaml
> > > > @@ -0,0 +1,84 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: "http://devicetree.org/schemas/mfd/qcom,qca639x.yaml#"
> > > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > > +
> > > > +title: Qualcomm QCA639x WiFi + Bluetoot SoC bindings
> > > > +
> > > > +maintainers:
> > > > +  - Andy Gross <agross@kernel.org>
> > > > +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> > > > +
> > > > +description: |
> > > > +  This binding describes thes Qualcomm QCA6390 or QCA6391 power supplies and
> > > > +  enablement pins.
> > >
> > > Humm, this should really be for the whole device. For BT/WiFi chips
> > > we've gotten away with 2 nodes for each interface. If that doesn't work
> > > here, then I think this needs to be 1 node for all, not 3 as it seems
> > > you are doing.
> >
> > 2 nodes: one for common power sequencer and one for bluetooth part.
> > WiFi part doesn't need a separate node, but see below.
> >
> > >
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: qcom,qca639x
> > >
> > > List each device, we don't do wildcards in compatible strings.
> >
> > Ack. I will change this to qca6390, as 6391 should be fully compatible
> > from the power sequence point of view.
> >
> > >
> > > > +
> > > > +  '#power-domain-cells':
> > > > +    const: 0
> > > > +
> > > > +  pinctrl-0: true
> > > > +  pinctrl-1: true
> > > > +
> > > > +  pinctrl-names:
> > > > +    items:
> > > > +      - const: default
> > > > +      - const: active
> > > > +
> > > > +  vddaon-supply:
> > > > +    description:
> > > > +      0.95V always-on LDO power input
> > > > +
> > > > +  vddpmu-supply:
> > > > +    description:
> > > > +      0.95V LDO power input to PMU
> > > > +
> > > > +  vddrfa1-supply:
> > > > +    description:
> > > > +      0.95V LDO power input to RFA
> > > > +
> > > > +  vddrfa2-supply:
> > > > +    description:
> > > > +      1.25V LDO power input to RFA
> > > > +
> > > > +  vddrfa3-supply:
> > > > +    description:
> > > > +      2V LDO power input to RFA
> > > > +
> > > > +  vddpcie1-supply:
> > > > +    description:
> > > > +      1.25V LDO power input to PCIe part
> > > > +
> > > > +  vddpcie2-supply:
> > > > +    description:
> > > > +      2V LDO power input to PCIe part
> > >
> > > Do the PCIe supplies have to be on if only the BT part is used?
> >
> > Good question. The documentation just tells us to power up all rails.
> > There are further internal voltage regulators taking care of current
> > qca639x mode
> >
> > >
> > > Supplies are refcounted, so I'd suggest just duplicating the supplies in
> > > both the BT and PCIe nodes.
> >
> > While for BT it would be easy, for PCIe it is not that easy. We have
> > to make sure that the chip is powered up before the respective PCIe
> > bus is probed (basically before the PCIe controller driver is probed).
> > I ended up putting a reference to the PCIe PHY device node, making
> > sure that qca6391 is powered up before the PCIe PHY driver is probed.
> > PCIe device node itself has its own power-domains entry (PCIE_0_GDSC).
>
> This is an abuse of the power-domains binding and a complete hack, so
> no. The wifi part should be a child node on the PCI bus. That's the
> only acceptable solution for DT.

I see your point here.

>
> Obviously there's a probe chicken and egg problem for Linux, but for
> DT it doesn't matter. You have 2 options. You can fix PCIe to force
> probe devices with a DT node (and lots of folks would appreciate it
> because you aren't the only one needing it). If there's a DT node,
> then you know there is a device there. This is what MDIO bus does. Or
> you can keep your misc driver, but it needs to go find the PCIe child
> node itself. IOW, you have to create the platform device yourself in
> the initcall rather than rely on the DT code to create one.
>
> Personally, I wouldn't accept the 2nd solution as I think it is still
> a hack, but I won't object.

To make things worse, if the device is not powered during the initial
PCIe host probe, the powerup sequence turns into PCIe hotplug story.
Even PCIehp driver is probed after initial link training. Would you
agree to one of the following variants:

1) Add extra power-domain to pcie host:

 pcie0: pci@1c00000 {
     compatible = "qcom,pcie-sm8250", "snps,dw-pcie";
     [....]
     power-domains = <&gcc PCIE_0_GDSC>, <&qca639x>;
     power-domain-names = "core", "child";
};

2) Add power domain to PCIe bridge device  (and handle that from the host code):

 pcie0: pci@1c00000 {
     compatible = "qcom,pcie-sm8250", "snps,dw-pcie";
     [....]
     power-domains = <&gcc PCIE_0_GDSC>;

     bridge@0,0 {
         compatible = "pci17cb,010b";
         [.....]
         power-domains = <qca639x>;
    };
};

Does any of those variants seem suitable for you?

Or you'd really insist on the following binding:

3)

pcie0: pci@1c00000 {
     compatible = "qcom,pcie-sm8250", "snps,dw-pcie";
     [....]
     power-domains = <&gcc PCIE_0_GDSC>;

     bridge@0,0 {
         compatible = "pci17cb,010b";
         [.....]
         wifi@1,0 {
             compatible = "pci17cb,1101";
             power-domains = <qca639x>;
          };
    };
};


-- 
With best wishes
Dmitry
