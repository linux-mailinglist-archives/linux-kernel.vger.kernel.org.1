Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD452CECAB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgLDLCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:02:48 -0500
Received: from gloria.sntech.de ([185.11.138.130]:46192 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbgLDLCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:02:48 -0500
Received: from [95.90.166.74] (helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kl8qf-0005Lx-GJ; Fri, 04 Dec 2020 12:02:01 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] arm64: dts: rockchip: rk3328: Fix UART pull-ups
Date:   Fri,  4 Dec 2020 12:01:55 +0100
Message-Id: <160707971061.1322141.15049981560864741595.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204064805.6480-1-wens@kernel.org>
References: <20201204064805.6480-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 14:48:05 +0800, Chen-Yu Tsai wrote:
> For UARTs, the local pull-ups should be on the RX pin, not the TX pin.
> UARTs transmit active-low, so a disconnected RX pin should be pulled
> high instead of left floating to prevent noise being interpreted as
> transmissions.
> 
> This gets rid of bogus sysrq events when the UART console is not
> connected.

Applied, thanks!

[1/1] arm64: dts: rockchip: rk3328: Fix UART pull-ups
      commit: 94dad6bed3c86c00050bf7c2b2ad6b630facae31

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
