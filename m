Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A702AA89B
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 01:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgKHAf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 19:35:59 -0500
Received: from gloria.sntech.de ([185.11.138.130]:40192 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgKHAf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 19:35:58 -0500
Received: from p508fc3ee.dip0.t-ipconnect.de ([80.143.195.238] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kbYgT-0008Ps-Mr; Sun, 08 Nov 2020 01:35:53 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        linux-kernel@vger.kernel.org, wens@kernel.org,
        devicetree@vger.kernel.org, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Reorder LED triggers from mmc devices on rk3399-roc-pc.
Date:   Sun,  8 Nov 2020 01:35:52 +0100
Message-Id: <160479574913.328911.1441170250420756577.b4-ty@sntech.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104192933.1001-1-m.reichl@fivetechno.de>
References: <20201104192933.1001-1-m.reichl@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 20:29:31 +0100, Markus Reichl wrote:
> After patch [1] SD-card becomes mmc1 and eMMC becomes mmc2.
> Correct trigger of LEDs accordingly.
> 
> [1]
> https://patchwork.kernel.org/patch/11881427

Applied, thanks!

[1/1] arm64: dts: rockchip: Reorder LED triggers from mmc devices on rk3399-roc-pc.
      commit: 7327c8b98e2e14c47021eea14d1ab268086a6408

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
