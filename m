Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A970D27433B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 15:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgIVNfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 09:35:41 -0400
Received: from gloria.sntech.de ([185.11.138.130]:39916 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgIVNfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 09:35:40 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kKiSC-0000Mu-4V; Tue, 22 Sep 2020 15:35:32 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Elaine Zhang <zhangqing@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, xxx@rock-chips.com,
        huangtao@rock-chips.com, sboyd@kernel.org, mturquette@baylibre.com,
        kever.yang@rock-chips.com, xf@rock-chips.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] clk: rockchip: Support module build
Date:   Tue, 22 Sep 2020 15:35:30 +0200
Message-Id: <160078161850.2368325.2980207509081000555.b4-ty@sntech.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914022225.23613-1-zhangqing@rock-chips.com>
References: <20200914022225.23613-1-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 10:22:19 +0800, Elaine Zhang wrote:
> Export some APIs for module drivers.
> Fix the clock config to support module build.
> Fix the clk driver init, add module author, description
> and license to support building RK3399 SoC clock driver as module.
> 
> Change in V2:
> [PATCH v2 1/6]: remove "clk",and check "hw" isn't an error value.
> [PATCH v2 6/6]: store a function pointer in the match data.
> 
> [...]

Applied, thanks!

[1/6] clk: rockchip: Use clk_hw_register_composite instead of clk_register_composite calls
      commit: 63207c37eac4f15fdebac14685a315c259c0a780
[2/6] clk: rockchip: Export rockchip_clk_register_ddrclk()
      commit: f73907de3493b94d80af5122bcacc98f0e7b295b
[3/6] clk: rockchip: Export rockchip_register_softrst()
      commit: 37353491d1a8c207685c138c3640bd43864b70d9
[4/6] clk: rockchip: Export some clock common APIs for module drivers
      commit: ea650c26611dd61adfcc8647d6144f2c9f453d90
[5/6] clk: rockchip: fix the clk config to support module build
      commit: 4d98ed1e126495016f2a3ef4db6379855c4aacf2
[6/6] clk: rockchip: rk3399: Support module build
      commit: 70d839e2761d22eba6facdb3b65faea4d57f355d


I did some minor tweaks:
- in the Kconfig texts "Rk" -> "RK"
- made the rk3399 entry bool in patch 5
  so that it stays correct when a bisection lands between
  patches 5 and 6
- made in tristate in patch6 which adds the rest of module
  elements


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
