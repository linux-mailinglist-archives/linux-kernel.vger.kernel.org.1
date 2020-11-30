Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48B32C7C92
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgK3Bwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:52:51 -0500
Received: from gloria.sntech.de ([185.11.138.130]:40856 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgK3Bwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:52:51 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kjYME-0007OY-4p; Mon, 30 Nov 2020 02:52:02 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Will Deacon <will@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-rockchip@lists.infradead.org,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/9] arm64: dts: rockchip: Engicam PX30.Core changes
Date:   Mon, 30 Nov 2020 02:51:56 +0100
Message-Id: <160670107989.1055391.7542778986080357647.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109181017.206834-1-jagan@amarulasolutions.com>
References: <20201109181017.206834-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Nov 2020 23:40:08 +0530, Jagan Teki wrote:
> Series support Engicam PX30.Core SOM changes along with C.TOUCH
> Open Frame 10.1" board.
> 
> All respetive LCD panels are in Mainline already.
> 
> thanks,
> Jagan.
> 
> [...]

Applied, thanks!

[1/9] arm64: dts: rockchip: px30-enagicam: Enable USB Host, OTG
      commit: 4548ea027c900f1e0f07a292b8e10dc3d2725f44
[2/9] arm64: dts: rockchip: px30-engicam-edimm2.2: Enable LVDS panel
      commit: 87761edeb2cd90b8251f269eb52c4b48152aace8
[3/9] dt-bindings: arm: rockchip: Add Engicam PX30.Core C.TOUCH 2.0 10.1" OF
      commit: 23708d46101b5d5538c88b84b764d0ed9d8957ca
[4/9] arm64: dts: rockchip: Add Engicam PX30.Core C.TOUCH 2.0 10.1" OF
      commit: 0e418423be1c824b2cda37fd00528f62231cd219
[5/9] arm64: dts: rockchip: px30-engicam: Add WiFi support
      commit: 93a4e7d12468b0ab46796f3ed8dc5838dc7f63bc
[6/9] arm64: dts: rockchip: px30-engicam: Add BT support
      commit: 1cc1e851d15b4ebd4c6c5f741cfdb58b988a4445
[7/9] arm64: defconfig: Enable ROCKCHIP_LVDS
      commit: dbb378a59cb2bdb01454098513d9b61355fbe377
[8/9] arm64: defconfig: Enable PHY_ROCKCHIP_INNO_DSIDPHY
      commit: ec68a66395d9ccedc9b2b2f6452edfd7cb0fdfd5
[9/9] arm64: defconfig: Enable USB_SERIAL_CP210X
      commit: cf35bff64f79b4ca8785766d67b608b76404d43f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
