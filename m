Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC0C2FA0C7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392009AbhARNE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:04:56 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47574 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390695AbhARM63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:58:29 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l1U6E-000424-L9; Mon, 18 Jan 2021 13:57:38 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 0/3] arm64: rockchip: rk3328: Add Radxa ROCK Pi E
Date:   Mon, 18 Jan 2021 13:57:35 +0100
Message-Id: <161097370156.287816.17060866195446483502.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117100710.4857-1-wens@kernel.org>
References: <20210117100710.4857-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021 18:07:07 +0800, Chen-Yu Tsai wrote:
> This is v2 of my ROCK Pi E support series.
> 
> Changes since v1:
> 
> - Picked up Rob's Ack for the binding
> - Dropped comment about LED color
> - Dropped max-frequency from emmc node
> - Changed pingroup name from "ethernet-phy" to "ephy" to avoid DT binding
>   check failure
> - Dropped cap-mmc-highspeed from sdmmc node
> - Fixed regulator properties to have consistent ordering
> - Added adc-key for recovery button
> - Sorted header files
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: rk3328: Add clock_in_out property to gmac2phy node
      commit: c6433083f5930fdf52ad47c8c0459719c810dc89
[2/3] dt-bindings: arm: rockchip: Add Radxa ROCK Pi E
      commit: 31b8e8592f6663c0937d1408f1fd6ed566fbde5c
[3/3] arm64: dts: rockchip: rk3328: Add Radxa ROCK Pi E
      commit: b918e81f2145967f0cadfe9ede38c69c1796fe09

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
