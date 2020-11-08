Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383032AA898
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 01:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgKHAbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 19:31:36 -0500
Received: from gloria.sntech.de ([185.11.138.130]:40086 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgKHAbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 19:31:35 -0500
Received: from p508fc3ee.dip0.t-ipconnect.de ([80.143.195.238] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kbYc8-0008Lx-70; Sun, 08 Nov 2020 01:31:24 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        robin.murphy@arm.com, dianders@chromium.org,
        linux-arm-kernel@lists.infradead.org, wens@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Assign a fixed index to mmc devices on rk3399 boards.
Date:   Sun,  8 Nov 2020 01:31:20 +0100
Message-Id: <160479547333.328385.2096192615846398067.b4-ty@sntech.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104162356.1251-1-m.reichl@fivetechno.de>
References: <20201104162356.1251-1-m.reichl@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 17:23:55 +0100, Markus Reichl wrote:
> Recently introduced async probe on mmc devices can shuffle block IDs.
> Pin them to fixed values to ease booting in environments where UUIDs
> are not practical. Use newly introduced aliases for mmcblk devices from [1].
> 
> [1]
> https://patchwork.kernel.org/patch/11747669/

Applied, thanks!

[1/1] arm64: dts: rockchip: Assign a fixed index to mmc devices on rk3399 boards.
      commit: 0011c6d182774fc781fb9e115ebe8baa356029ae

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
