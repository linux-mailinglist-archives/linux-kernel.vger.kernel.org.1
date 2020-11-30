Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585392C7C91
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgK3Bwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:52:50 -0500
Received: from gloria.sntech.de ([185.11.138.130]:40846 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgK3Bwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:52:49 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kjYMF-0007OY-Kl; Mon, 30 Nov 2020 02:52:03 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: dts: rockchip: rk3328-roc-cc: Misc improvements
Date:   Mon, 30 Nov 2020 02:52:00 +0100
Message-Id: <160670107988.1055391.17437580601124113737.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126073336.30794-1-wens@kernel.org>
References: <20201126073336.30794-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 15:33:33 +0800, Chen-Yu Tsai wrote:
> Here are some improvements for the ROC-RK3328-CC.
> 
> Patch 1 sets dr_mode to "host" for OTG. Since the board has a type A
> host port wired to the OTG controller, setting this is appropriate.
> 
> Patch 2 enables HDMI audio.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: rockchip: rk3328-roc-cc: Set dr_mode to "host" for OTG
      commit: 4076a007bd0f6171434bdb119a0b8797749b0502
[2/3] arm64: dts: rockchip: rk3328-roc-cc: Enable HDMI audio
      commit: 65f0b420dea7e70d70cd6ef0f12f9ff81ab90d23
[3/3] arm64: dts: rockchip: rk3328-roc-cc: Enable analog audio
      commit: 5df4d4d16ce4c6e6a5cb9d4b684b187f28258219

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
