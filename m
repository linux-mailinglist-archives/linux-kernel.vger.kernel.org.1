Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A137C1A3612
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 16:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgDIOjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 10:39:43 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:42316 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbgDIOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:39:43 -0400
Received: by mail-vk1-f195.google.com with SMTP id q7so9497vkb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 07:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEkP9tsPmG6xIpP1vzjRU5PHmw91Ij8x4EQYq0ffIRY=;
        b=gRRRZ1sMj922xak2A74EFoOiHADrJzQm7/rJaeK5pfAuVSHS3gB2+2r+tsPF5OS3eU
         d6WCreqRsPuEuBmb7GUYzdYOWcj35hAhSyknSdX72vRTG8MWdz56Xa0CxZ3wF6m+lNY+
         LTFdC2ag6KmzAX+wWZkumO7x9+kjKJCrPw4XheX1XI6vClZR6jJ3v9g8n+UDk6Y5h+94
         DCmS5TZheYWqU1IJ9febMYwkGVw3Spycnc9wl32T284wdq1MJvmrwQuP6SJyi2M0qycW
         JoLTjabvZkTA6YKrrBRs8HZv8gpzqbcKC+Km/0ddJSh+SHoNn/WtjQiXGv+2ykhEopSO
         4W4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEkP9tsPmG6xIpP1vzjRU5PHmw91Ij8x4EQYq0ffIRY=;
        b=A2vGTzIfSaXWzY8e+b9uAgvHE4MLqD7d2CohP2xdPO1TN49OXliwE+V91ieM10n7l5
         JTkmfmMDJBAcV1VgrU1zfzzd2od+lqA9QeTRS7JPdwJBu9eeZYPhJkN0wVRwdGlag66r
         PZHK6nbDqWDRLmocTToOvazSlt2vS5iUNQ7CxunRlcsIEWrBLqavteFvha/ry9KOc5AZ
         VZYngC6uF8ASzG6zmQss9oGkF51xdqqNChyzs93vJ7XHf8te0AHOkUL8KB0WLdKsZqcR
         xL9E9Ab/FZDB1eBsRpcK3N2Y1/wPtfrbn7iP/+1HnhXVGU3A0jrkPhbh96HPwnFkDejl
         AcXA==
X-Gm-Message-State: AGi0PuZvcyVtvO2DavABJXC30v3ubqpB3g5GubViLiBtmQ0f4Dx+qu4P
        /gaUREpQfLlnZ6JPiONgvj/5ZKjwuxyR5RiY8Env0w==
X-Google-Smtp-Source: APiQypLrVG6KjexVOrXdXNiyGWmOu+0dTmnud+29Y24Oy2Dagz3JnegvbbcroVkVqLcf1po17uWnVbKTKKTfeO305Zg=
X-Received: by 2002:a05:6122:446:: with SMTP id f6mr1083497vkk.79.1586443182560;
 Thu, 09 Apr 2020 07:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <1586402293-30579-1-git-send-email-Anson.Huang@nxp.com>
 <CAHLCerNonZ7qJi8Qihmj87QteEnxTF0PRS6vw5GPemMurOfS9Q@mail.gmail.com> <DB3PR0402MB39160A94CD5E97AA79E2DB5AF5C10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39160A94CD5E97AA79E2DB5AF5C10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 9 Apr 2020 20:09:31 +0530
Message-ID: <CAHLCerM+UpmdvvxV2KpEZuJSKQNjz2ONpXdFPdyUxCOj0PjnGA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: thermal: Convert i.MX8MM to json-schema
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 7:52 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Amit
>
> > Subject: Re: [PATCH] dt-bindings: thermal: Convert i.MX8MM to json-schema
> >
> > Hi Anson,
> >
> > On Thu, Apr 9, 2020 at 8:56 AM Anson Huang <Anson.Huang@nxp.com>
> > wrote:
> > >
> > > Convert the i.MX8MM thermal binding to DT schema format using
> > > json-schema
> >
> > Would it be possible to have a single yaml file for all i.MX thermal sensors by
> > playing with required and optional properties ?
>
> i.MX SoCs have many different thermal sensor IP and hence different thermal driver
> is used, and different i.MX thermal drivers have different DT bindings, so is it good to
> put all of them into single yaml file? For example, imx_thermal.c is for i.MX6/7 SoCs which
> do NOT use of_thermal framework, imx8mm_thermal.c is for i.MX8MM/i.MX8MP which
> use of_thermal framework.
>
> If putting all of them into 1 yaml file, it will be almost like just putting 2 files together, I
> Personally don't think it is a good idea.

OK.

> >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  .../devicetree/bindings/thermal/imx8mm-thermal.txt | 15 ------
> > >  .../bindings/thermal/imx8mm-thermal.yaml           | 53
> > ++++++++++++++++++++++
> > >  2 files changed, 53 insertions(+), 15 deletions(-)  delete mode
> > > 100644 Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> > >  create mode 100644
> > > Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> > > b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> > > deleted file mode 100644
> > > index 3629d3c..0000000
> > > --- a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.txt
> > > +++ /dev/null
> > > @@ -1,15 +0,0 @@
> > > -* Thermal Monitoring Unit (TMU) on Freescale i.MX8MM SoC
> > > -
> > > -Required properties:
> > > -- compatible : Must be "fsl,imx8mm-tmu" or "fsl,imx8mp-tmu".
> > > -- reg : Address range of TMU registers.
> > > -- clocks : TMU's clock source.
> > > -- #thermal-sensor-cells : Should be 0 or 1. See ./thermal.txt for a description.
> > > -
> > > -Example:
> > > -tmu: tmu@30260000 {
> > > -       compatible = "fsl,imx8mm-tmu";
> > > -       reg = <0x30260000 0x10000>;
> > > -       clocks = <&clk IMX8MM_CLK_TMU_ROOT>;
> > > -       #thermal-sensor-cells = <0>;
> > > -};
> > > diff --git
> > > a/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> > > b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> > > new file mode 100644
> > > index 0000000..53a42b3
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/thermal/imx8mm-thermal.yaml
> > > @@ -0,0 +1,53 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +%YAML 1.2
> > > +---
> > > +$id:
> > > +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
> > >
> > +cetree.org%2Fschemas%2Fthermal%2Fimx8mm-thermal.yaml%23&amp;data
> > =02%7
> > >
> > +C01%7CAnson.Huang%40nxp.com%7Cb190e049130e49e0750d08d7dc8e48
> > a3%7C686e
> > >
> > +a1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637220375963888457&am
> > p;sdata=s
> > >
> > +S8%2FR2j%2BT1UmDqXFIPPzPgWs26lMiwW3saTq4qlZAUs%3D&amp;reserve
> > d=0
> > > +$schema:
> > > +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
> > >
> > +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=02%7C01%7CAns
> > on.Hua
> > >
> > +ng%40nxp.com%7Cb190e049130e49e0750d08d7dc8e48a3%7C686ea1d3bc
> > 2b4c6fa92
> > >
> > +cd99c5c301635%7C0%7C0%7C637220375963898454&amp;sdata=tXIh9d%
> > 2BszcExH0
> > > +7ic7s%2BqJyUdbE0aHM3tH%2BwkWgnbhQ%3D&amp;reserved=0
> > > +
> > > +title: NXP i.MX8M Mini Thermal Binding
> > > +
> > > +maintainers:
> > > +  - Anson Huang <Anson.Huang@nxp.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    oneOf:
> > > +      - items:
> > > +          - enum:
> > > +              - fsl,imx8mm-tmu
> > > +              - fsl,imx8mp-tmu
> > > +  reg:
> > > +    description: |
> > > +      Address range of TMU registers.
> > > +    maxItems: 1
> > > +  clocks:
> > > +    description: |
> > > +      TMU's clock source.
> > > +    maxItems: 1
> > > +
> > > +  # See ./thermal.txt for details
> >
> > Don't point to thermal.txt anymore. thermal.txt will be replaced by
> > thermal-*.yaml files at some point soon.
>
> OK, will remove it.
>
> >
> > > +  "#thermal-sensor-cells":
> > > +    enum:
> > > +      - 0
> >
> > Don't you have multiple sensors connected to this controller? In that case, 0
> > won't be a valid value.
>
> imx8mm_thermal driver is for i.MX8MM and i.MX8MP, i.MX8MM ONLY has 1 sensor,
> while i.MX8MP has 2 sensors, that is why I put both 0 and 1 here.

Please put this in description after maintainers above.
