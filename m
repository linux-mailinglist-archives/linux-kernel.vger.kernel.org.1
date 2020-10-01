Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F4627FD25
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbgJAKTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 06:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731819AbgJAKTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 06:19:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AC2C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 03:19:11 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kNvg5-0005E9-KP; Thu, 01 Oct 2020 12:19:09 +0200
Subject: Re: [PATCH v2 08/12] ARM: dts: imx6dl-pico: fix board compatibles
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200930190143.27032-1-krzk@kernel.org>
 <20200930190143.27032-9-krzk@kernel.org>
 <0a0afea6-8cbb-3e89-5a4f-89660c942ca3@pengutronix.de>
 <20201001073208.GA5208@kozik-lap>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <027fd826-6822-9e92-0c6c-2ebed63f4a07@pengutronix.de>
Date:   Thu, 1 Oct 2020 12:19:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001073208.GA5208@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/1/20 9:32 AM, Krzysztof Kozlowski wrote:
> On Thu, Oct 01, 2020 at 09:22:03AM +0200, Ahmad Fatoum wrote:
>>> diff --git a/arch/arm/boot/dts/imx6dl-pico-hobbit.dts b/arch/arm/boot/dts/imx6dl-pico-hobbit.dts
>>> index d7403c5c4337..08fedcbcc91b 100644
>>> --- a/arch/arm/boot/dts/imx6dl-pico-hobbit.dts
>>> +++ b/arch/arm/boot/dts/imx6dl-pico-hobbit.dts
>>> @@ -13,5 +13,5 @@
>>>  
>>>  / {
>>>  	model = "TechNexion PICO-IMX6 DualLite/Solo Board and Hobbit baseboard";
>>> -	compatible = "technexion,imx6dl-pico", "fsl,imx6dl";
>>> +	compatible = "technexion,imx6dl-pico-hobbit", "fsl,imx6dl";
>>>  };
> 
> The bindings, added in commit 53b61224ca40 ("dt-bindings: arm: fsl: Add
> TechNexion boards"), describe that these are the only valid compatibles.
> "technexion,imx6dl-pico" is not valid and would require changing the
> bindings, thus breaking compatibility which you want to avoid.> 
> The bindings, not what is present in DTS, is considered ABI.

The existing binding doesn't cover these boards then and needs to be
extended, no? How about following patch?

[I guess we need to keep the two-compatible list they were originally
 in for compatibility even if it's unused among upstream device trees?]

Cheers,
Ahmad

-------------------------8<---------------------------

From d2e44951f900a1774ef289db22812969e72925d6 Mon Sep 17 00:00:00 2001
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
Date: Thu, 1 Oct 2020 12:03:36 +0200
Subject: [RFC PATCH] dt-bindings: arm: fsl: add technexion,imx6dl-pico compatible

The technexion,imx6dl-pico -dwarf, -hobbit, -nymph and -pi all use the
same SoM. Reflect this compatibility with the SoM in the binding.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 6da9d734cdb7..b7110305ce81 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -211,6 +211,16 @@ properties:
           - const: gw,ventana
           - const: fsl,imx6dl
 
+      - description: i.MX6DL TechNexion Pico Boards
+        items:
+          - enum:
+              - technexion,imx6dl-pico-dwarf   # TechNexion i.MX6DL Pico-Dwarf
+              - technexion,imx6dl-pico-hobbit  # TechNexion i.MX6DL Pico-Hobbit
+              - technexion,imx6dl-pico-nymph   # TechNexion i.MX6DL Pico-Nymph
+              - technexion,imx6dl-pico-pi      # TechNexion i.MX6DL Pico-Pi
+          - const: technexion,imx6dl-pico
+          - const: fsl,imx6dl
+
       - description: i.MX6SL based Boards
         items:
           - enum:


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
