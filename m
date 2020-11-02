Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A7E2A26F3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 10:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgKBJ1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 04:27:09 -0500
Received: from foss.arm.com ([217.140.110.172]:56516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbgKBJ1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 04:27:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 79869101E;
        Mon,  2 Nov 2020 01:27:08 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7AD23F718;
        Mon,  2 Nov 2020 01:27:06 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:27:04 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, sudeep.holla@arm.com,
        lukasz.luba@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, broonie@kernel.org,
        satyakim@qti.qualcomm.com, etienne.carriere@linaro.org,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v3 4/4] dt-bindings: arm: add support for SCMI Regulators
Message-ID: <20201102092704.GJ20482@e120937-lin>
References: <20201026203148.47416-1-cristian.marussi@arm.com>
 <20201026203148.47416-5-cristian.marussi@arm.com>
 <20201030185514.GA4129214@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030185514.GA4129214@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

thanks for the review.

On Fri, Oct 30, 2020 at 01:55:14PM -0500, Rob Herring wrote:
> On Mon, Oct 26, 2020 at 08:31:48PM +0000, Cristian Marussi wrote:
> > Add devicetree bindings to support regulators based on SCMI Voltage
> > Domain Protocol.
> > 
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > ---
> > v2 --> v3
> > - avoid awkard examples based on _cpu/_gpu regulators
> > v1 --> v2
> > - removed any reference to negative voltages
> > ---
> >  .../devicetree/bindings/arm/arm,scmi.txt      | 42 +++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > index 55deb68230eb..0cef83a60f03 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > @@ -62,6 +62,28 @@ Required properties:
> >   - #power-domain-cells : Should be 1. Contains the device or the power
> >  			 domain ID value used by SCMI commands.
> >  
> > +Regulator bindings for the SCMI Regulator based on SCMI Message Protocol
> > +------------------------------------------------------------
> > +
> > +An SCMI Regulator is permanently bound to a well defined SCMI Voltage Domain,
> > +and should be always positioned as a root regulator.
> > +It does not support any current operation.
> > +
> > +This binding uses the common regulator binding[6].
> > +
> > +SCMI Regulators are grouped under a 'regulators' node which in turn is a child
> > +of the SCMI Voltage protocol node inside the desired SCMI instance node.
> > +
> > +Required properties:
> > + - reg : shall identify an existent SCMI Voltage Domain.
> > +
> > +Optional properties:
> > + - all of the other standard regulator bindings as in [6]: note that, since
> > +   the SCMI Protocol itself aims in fact to hide away many of the operational
> > +   capabilities usually exposed by the properties of a standard regulator,
> > +   most of the usual regulator bindings could have just no effect in the
> > +   context of this SCMI regulator.
> 
> You can't have it both ways... You should list out which ones apply.
> 

I'm double checking now every regulator binding that can apply, and I'll
append here the full list of supported standard regulator bindings.

> I'm a bit worried that now we're changing CPUs (at least?) from clocks 
> to 'performance domains' while at the same time here we're adding 
> low level, virtual regulators. Are we going to end up wanting something 
> more abstract here too?
> 

As said already in a different thread by Mark and Sudeep, this was needed
to accomodate some driver like MMC which expects to be able to fine tune
some regulator voltages at some point.

The SCMI abstraction exposed by the SCMI Power protocol indeed already
provided a coarse grain tuning in term of abstract power levels and
on/off ops but it was not able to provide fine grained voltage tuning
in a clean way (without horribly abusing IMP DEFINED values), so
Voltage Domain protocol with a regulator on top of it was added.
(and I think anyway partners were already starting thinking about
developing their own custom protocols and regulators to bypass these
limitations...so providing a unified solution seemed sensible)

Anyway consider that everything remains still in control of the SCMI fw
which has the last word and can anyway drop your 'fine' tuned request
if deemed unreasonable/invalid.

> > +
> >  Sensor bindings for the sensors based on SCMI Message Protocol
> >  --------------------------------------------------------------
> >  SCMI provides an API to access the various sensors on the SoC.
> > @@ -105,6 +127,7 @@ Required sub-node properties:
> >  [3] Documentation/devicetree/bindings/thermal/thermal*.yaml
> >  [4] Documentation/devicetree/bindings/sram/sram.yaml
> >  [5] Documentation/devicetree/bindings/reset/reset.txt
> > +[6] Documentation/devicetree/bindings/regulator/regulator.yaml
> >  
> >  Example:
> >  
> > @@ -169,6 +192,25 @@ firmware {
> >  			reg = <0x16>;
> >  			#reset-cells = <1>;
> >  		};
> > +
> > +		scmi_voltage: protocol@17 {
> > +			reg = <0x17>;
> > +
> > +			regulators {
> > +				regulator_devX: regulator_scmi_devX@0 {
> 
> Node names should be generic:
> 
> regulator@0
> 

Yes, I was not sure if it this kind of naming for reg-based property was
preferable of mandatory and so, since supporting using a <common-nam>@<unit>
format in this driver needs a small patch in the regulator core framework
(at least it seems so to me...), I wanted to be sure this was needed.

I'll repost soon with naming fixed and with any additional patch added.

Thanks

Cristian

> > +					reg = <0x0>;
> > +					regulator-max-microvolt = <3300000>;
> > +				};
> > +
> > +				regulator_devY: regulator_scmi_devY@9 {
> > +					reg = <0x9>;
> > +					regulator-min-microvolt = <500000>;
> > +					regulator-max-microvolt = <4200000>;
> > +				};
> > +
> > +				...
> > +			};
> > +		};
> >  	};
> >  };
> >  
> > -- 
> > 2.17.1
> > 
