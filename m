Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB412FA0B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392041AbhARNGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:06:09 -0500
Received: from gloria.sntech.de ([185.11.138.130]:47526 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390678AbhARM6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:58:30 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l1U6E-000424-AR; Mon, 18 Jan 2021 13:57:38 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: remove interrupt-names property from rk3399 vdec node
Date:   Mon, 18 Jan 2021 13:57:34 +0100
Message-Id: <161097370155.287816.107161049165561703.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117181653.24886-1-jbx6244@gmail.com>
References: <20210117181653.24886-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021 19:16:53 +0100, Johan Jonker wrote:
> A test with the command below gives this error:
> /arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml: video-codec@ff660000:
> 'interrupt-names' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> The rkvdec driver gets it irq with help of the platform_get_irq()
> function, so remove the interrupt-names property from the rk3399
> vdec node.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: remove interrupt-names property from rk3399 vdec node
      commit: a6b519f5ccecb0a68af788b07fd85b8e91969a53

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
