Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64AD62AAE30
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 00:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgKHXPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 18:15:30 -0500
Received: from gloria.sntech.de ([185.11.138.130]:45296 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbgKHXP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 18:15:29 -0500
Received: from p508fc9d6.dip0.t-ipconnect.de ([80.143.201.214] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kbtu8-0005QO-Bn; Mon, 09 Nov 2020 00:15:24 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v4 0/7] arm64: dts: rockchip: Add Engicam PX30.Core
Date:   Mon, 09 Nov 2020 00:15:23 +0100
Message-ID: <2320954.tcIoyGMtcG@phil>
In-Reply-To: <20200929083217.25406-1-jagan@amarulasolutions.com>
References: <20200929083217.25406-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Dienstag, 29. September 2020, 10:32:10 CET schrieb Jagan Teki:
> PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.
> 
> PX30.Core needs to mount on top of Engicam baseboards for creating
> complete platform boards.
> 
> Possible baseboards are,
> - EDIMM2.2 Starter Kit
> - C.TOUCH 2.0 Carrier Board
> 
> Changes for v4:
> - collect Rob A-b
> Changes for v3:
> - resolved Johan comments about sorting node properties
> - add copyright to Amarula Solutions
> - update px30 dtsi author
> Changes for v2:
> - include C.TOUCH 2.0 carrier board
> - skip 10" OF LCD as it requires separate dts with panel support.
> 
> Note: These baseboards can be used for i.MX8 SOM's as well. So having
> baseboard on respective SoC seems to be easy rather than making it
> common across all.
> 
> Any inputs?
> Jagan.
> 
> Jagan Teki (6):
>   dt-bindings: arm: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
>   arm64: dts: rockchip: px30: Add Engicam EDIMM2.2 Starter Kit
>   arm64: dts: rockchip: Add Engicam PX30.Core EDIMM2.2 Starter Kit
>   dt-bindings: arm: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
>   arm64: dts: rockchip: px30: Add Engicam C.TOUCH 2.0
>   arm64: dts: rockchip: Add Engicam PX30.Core C.TOUCH 2.0
> 
> Michael Trimarchi (1):
>   arm64: dts: rockchip: Add Engicam PX30.Core SOM

I've applied the patches for 5.11 with some changes:
(1) engicam,px30-px30-core became engicam,px30-core
(2) px30-px30-core.dtsi became px30-engicam-px30-core.dtsi

That double px30 is unnecessary and confusing in compatibles
and the px30-core thingy needed something less generic, as that is
not px30-specific but specific to the engicam boards.


Heiko


