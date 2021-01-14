Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0605B2F61F2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 14:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbhANN1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 08:27:16 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:46881 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbhANN1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 08:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610630835; x=1642166835;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lxcchmlm8obu3rlFf5uFKJiK+GEdYu44ZP1HH6VEu0A=;
  b=Nrhx9MW1tvHUF3jfkYeegLYzahZdfCAyrlI6oHUmPYsbRpXqa5DCJpJL
   0ij5VIDwp0IPVCEMT+WKF7WiKrOJe3/pCsOAO5fOWpiJ3LXItpJHpgRJ4
   zvFFMWN0oMw0Brv7tR0o6PZ9zY0S0viM8zRO5OE+p8RLOS0xdHtqfFm9z
   CqKZMw0OySSEJYF13d6CO33e7Z6sn+MPtm6NpoNIJNEbDZhMVzuN8TmQ9
   0XEogWYfa8BLE5DPnmKSXrNDSB+zm7t0UuNm5REXwBzDgR5WGYxSASEiP
   +h82tUqfSCgRQsqbHkZPYrw/yjopKGGAvUZIxZdGpCx1lW/MUWvx7EQQr
   Q==;
IronPort-SDR: HS83lwaP6ijJaUvp1aN1KbgF8STYQ5+aTFT8pX7xB14EikaZUu4n6lI4Vwkw5hfiLw2vD4Iiym
 /716B0oD02hyloapviCb9KSbKhn/UDdpYekkrcardj4jwgKjRMDIiqfX1zBivl+qksOq26SXEc
 CgRDudCe7rsMFyfWSPVsC6xxbjwHabPqktzASzzQIy7w2YDCt3CRtUtGh1/OVR8nVVsJWjwFnr
 /KWzW8ATlfZZMCKEIn3BWzr37cEXQw+o3eXpNATgPbGZM/178WJCvd35+gJBL+97XqmlM6QXtF
 OEY=
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="111032907"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jan 2021 06:25:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 14 Jan 2021 06:25:57 -0700
Received: from tyr.hegelund-hansen.dk (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 14 Jan 2021 06:25:55 -0700
Message-ID: <f819a37076d8bbb49b7c3288c03b75e23d4eb6f9.camel@microchip.com>
Subject: Re: [PATCH 1/3] dt-bindings: reset: microchip sparx5 reset driver
 bindings
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Date:   Thu, 14 Jan 2021 14:25:54 +0100
In-Reply-To: <80d4d9b16628847c59a7f94a7c002d8ce859b0ca.camel@pengutronix.de>
References: <20210113201915.2734205-1-steen.hegelund@microchip.com>
         <20210113201915.2734205-2-steen.hegelund@microchip.com>
         <80d4d9b16628847c59a7f94a7c002d8ce859b0ca.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,


On Thu, 2021-01-14 at 10:39 +0100, Philipp Zabel wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you
> know the content is safe
> 
> Hi Steen,
> 
> On Wed, 2021-01-13 at 21:19 +0100, Steen Hegelund wrote:
> > Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
> > ---
> >  .../bindings/reset/microchip,rst.yaml         | 52
> > +++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > new file mode 100644
> > index 000000000000..b5526753e85d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reset/microchip,rst.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/reset/microchip,rst.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Microchip Sparx5 Switch Reset Controller
> > +
> > +maintainers:
> > +  - Steen Hegelund <steen.hegelund@microchip.com>
> > +  - Lars Povlsen <lars.povlsen@microchip.com>
> > +
> > +description: |
> > +  The Microchip Sparx5 Switch provides reset control and
> > implements the following
> > +  functions
> > +    - One Time Switch Core Reset (Soft Reset)
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^reset-controller@[0-9a-f]+$"
> > +
> > +  compatible:
> > +    const: microchip,sparx5-switch-reset
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#reset-cells":
> > +    const: 1
> > +
> > +  syscons:
> > +    $ref: "/schemas/types.yaml#/definitions/phandle-array"
> > +    description: Array of syscons used to access reset registers
> > +    minItems: 2
> 
> The order seems to be important in the driver, so this should specify
> which is the CPU syscon and which is the GCB syscon. I'm not sure if
> it
> would be better to have two separately named syscon properties with a
> single phandle each.

Yes you got a point.  I will change that.

> 
> regards
> Philipp

BR
Steen

