Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2ADF2C85E0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgK3NvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:51:06 -0500
Received: from gloria.sntech.de ([185.11.138.130]:44442 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgK3NvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:51:06 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kjjZQ-0002YW-4x; Mon, 30 Nov 2020 14:50:24 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alexis Ballier <aballier@gentoo.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: rk3399-orangepi: Properly define the type C connector.
Date:   Mon, 30 Nov 2020 14:50:20 +0100
Message-Id: <160674371010.1066509.9885458366425661043.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201022113532.18470-1-aballier@gentoo.org>
References: <20201022113532.18470-1-aballier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 13:35:32 +0200, Alexis Ballier wrote:
> Tested:
> - USB3 Gigabit adapter
> - USB2 mass storage
> 
> The wiring is the same as the pinebook pro according to the schematics,
> thus this patch is heavily based on its dts.

Applied, thanks!

[1/1] arm64: dts: rockchip: rk3399-orangepi: Properly define the type C connector.
      commit: e56ed188c83053a505041e1a8ad4fba0f3b39089

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
