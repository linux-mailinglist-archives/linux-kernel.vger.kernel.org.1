Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA012F00E8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 16:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbhAIPkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 10:40:41 -0500
Received: from gloria.sntech.de ([185.11.138.130]:36728 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbhAIPkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 10:40:40 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kyGLO-0000jX-2W; Sat, 09 Jan 2021 16:39:58 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     sigmaris@gmail.com, jbx6244@gmail.com, t.schramm@manjaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, smoch@web.de,
        linux-rockchip@lists.infradead.org,
        Simon South <simon@simonsouth.net>, katsuhiro@katsuster.net,
        robh+dt@kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] arm64: dts: rockchip: Pinebook Pro: Use supported PCIe link speed
Date:   Sat,  9 Jan 2021 16:39:53 +0100
Message-Id: <161020678303.3482489.12367815944017835659.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20200930185627.5918-1-simon@simonsouth.net>
References: <20200930185627.5918-1-simon@simonsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 14:56:27 -0400, Simon South wrote:
> On Pinebook Pro laptops with an NVMe SSD installed, prevent random
> crashes in the NVMe driver by not attempting to use a PCIe link speed
> higher than that supported by the RK3399 SoC.
> 
> See commit 712fa1777207 ("arm64: dts: rockchip: add max-link-speed for
> rk3399").

Applied, thanks!

[1/1] arm64: dts: rockchip: Pinebook Pro: Use supported PCIe link speed
      commit: 642fb2795290c4abe629ca34fb8ff6d78baa9fd3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
