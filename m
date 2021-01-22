Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA182FFD92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbhAVHrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbhAVHrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:47:43 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10F1C06174A;
        Thu, 21 Jan 2021 23:47:02 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1A3BF4FB;
        Fri, 22 Jan 2021 08:47:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1611301620;
        bh=wt62T3G4ia9eC/+Hx1MTLqggmcGJG89Uw0CwF+nOj0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+5jIAgtdhCwh6iyyJE+oAfkUmA3kWISa8YRKNA/9z3gQGgxr6Y18UIECrV4FsxYt
         HNsZWmw90R7jwXKqrsV9ibSaUOhZPiOdKI7SlYtaQvMVdpkLAiNtQNDj3rmdFRCyxE
         ULjBvpL3whCTRtMSg4RQ74lVzXXPbN6J+IldOHME=
Date:   Fri, 22 Jan 2021 09:46:41 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] arm64: dts: zynqmp: Wire up the DisplayPort subsystem
Message-ID: <YAqC4WigXbw6ihqE@pendragon.ideasonboard.com>
References: <cover.1611232558.git.michal.simek@xilinx.com>
 <9769d4d103b6eb75e3324825117f6832a746004e.1611232558.git.michal.simek@xilinx.com>
 <YAoCMqq/hpY0Jz6A@pendragon.ideasonboard.com>
 <80b7a167-86ad-3012-b080-b380e7013f18@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <80b7a167-86ad-3012-b080-b380e7013f18@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Fri, Jan 22, 2021 at 08:19:15AM +0100, Michal Simek wrote:
> On 1/21/21 11:37 PM, Laurent Pinchart wrote:
> > On Thu, Jan 21, 2021 at 01:36:07PM +0100, Michal Simek wrote:
> >> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>
> >> Enable the dpsub device and wire it up to the PS-GTR PHY lanes routed to
> >> the DisplayPort connector.
> >>
> >> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> ---
> >>
> >> Wire all the boards
> >>
> >> ---
> >>  .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 31 +++++++++++++++++++
> >>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 10 ++++++
> >>  .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 11 +++++++
> >>  .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 11 +++++++
> >>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 11 +++++++
> >>  .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 11 +++++++
> >>  6 files changed, 85 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> >> index 71ebcaadb7c8..a53598c3624b 100644
> >> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> >> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> >> @@ -15,6 +15,7 @@
> >>  #include <dt-bindings/input/input.h>
> >>  #include <dt-bindings/interrupt-controller/irq.h>
> >>  #include <dt-bindings/gpio/gpio.h>
> >> +#include <dt-bindings/phy/phy.h>
> >>  
> >>  / {
> >>  	model = "ZynqMP ZCU100 RevC";
> >> @@ -108,6 +109,18 @@ ina226 {
> >>  		compatible = "iio-hwmon";
> >>  		io-channels = <&u35 0>, <&u35 1>, <&u35 2>, <&u35 3>;
> >>  	};
> >> +
> >> +	si5335a_0: clk26 {
> >> +		compatible = "fixed-clock";
> >> +		#clock-cells = <0>;
> >> +		clock-frequency = <26000000>;
> >> +	};
> >> +
> >> +	si5335a_1: clk27 {
> >> +		compatible = "fixed-clock";
> >> +		#clock-cells = <0>;
> >> +		clock-frequency = <27000000>;
> >> +	};
> > 
> > This is fine as a workaround for now, but I'm still wondering how we'll
> > solve this properly. We can declare the SI5335A in DT without wiring the
> > output that provides the clock to the PS, otherwise it will be disabled
> > as part of the boot process.
> 
> All these clock chips are preprogrammed to certain rate and enabled by
> default. It means there doesn't need to be any SW handling to enable it.
> When driver for these clock chips comes we can change this that's why I
> used labels which are saying which output it is.

Unless I'm mistaken, on the ZCU106 board, the chip is an SI5341B, which
has a driver already. I tried to declare it in DT, but the PS_REF_CLK
then got disabled at the end of boot, and the system wasn't happy about
it :-)

-- 
Regards,

Laurent Pinchart
