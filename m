Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3E02C7C90
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 02:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgK3Bws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 20:52:48 -0500
Received: from gloria.sntech.de ([185.11.138.130]:40834 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgK3Bws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 20:52:48 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kjYME-0007OY-EN; Mon, 30 Nov 2020 02:52:02 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: rename sdhci nodename to mmc in rk3399.dtsi
Date:   Mon, 30 Nov 2020 02:51:57 +0100
Message-Id: <160670107988.1055391.14402297807608969522.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116132311.8318-1-jbx6244@gmail.com>
References: <20201116132311.8318-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020 14:23:11 +0100, Johan Jonker wrote:
> A test with the command below gives for example this error:
> 
> /arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml:
> sdhci@fe330000: $nodename:0: 'sdhci@fe330000'
> does not match '^mmc(@.*)?$'
> 
> Fix it by renaming sdhci to mmc.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: rename sdhci nodename to mmc in rk3399.dtsi
      commit: 9a9f642784074d09efe9337e64b959f76c9f6913

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
