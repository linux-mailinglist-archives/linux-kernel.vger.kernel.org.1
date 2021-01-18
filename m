Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C8A2FA0B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404086AbhARNGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:06:21 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47584 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391679AbhARM6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:58:40 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l1U6F-000424-1T; Mon, 18 Jan 2021 13:57:39 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     richard@nod.at, robh+dt@kernel.org, vigneshr@ti.com,
        miquel.raynal@bootlin.com, Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: (subset) [PATCH v16 0/8] Add Rockchip NFC drivers for RK3308 and others
Date:   Mon, 18 Jan 2021 13:57:36 +0100
Message-Id: <161097370156.287816.7898637730580960045.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210002134.5686-1-yifeng.zhao@rock-chips.com>
References: <20201210002134.5686-1-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 08:21:30 +0800, Yifeng Zhao wrote:
> Rockchp's NFC(Nand Flash Controller) has four versions: V600, V622, V800 and
> V900.This series patch can support all four versions.
> 
> 
> Changes in v16:
> - Fix some comments about 'ret' variable.
> 
> [...]

Applied, thanks!

[6/8] arm: dts: rockchip: Add NFC node for RV1108 SoC
      commit: 2525f194f9dc07c48b0a12697128357068c2e04b
[7/8] arm: dts: rockchip: Add NFC node for RK2928 and other SoCs
      commit: 9c2bfe53b2fc4a8a63311f162e80b27978db6c06
[8/8] arm: dts: rockchip: Add NFC node for RK3036 SoC
      commit: 4cd9a03435bcd20ce6f524e3826fd263951c22fe

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
