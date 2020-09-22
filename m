Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B771273BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgIVHVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:21:54 -0400
Received: from gloria.sntech.de ([185.11.138.130]:36638 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729755AbgIVHVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:21:54 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kKccZ-0006mh-IB; Tue, 22 Sep 2020 09:21:51 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Helen Koike <helen.koike@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>
Subject: Re: [PATCH] phy: rockchip-dphy-rx0: Include linux/delay.h
Date:   Tue, 22 Sep 2020 09:21:50 +0200
Message-ID: <28085307.etP1RCWPPi@diego>
In-Reply-To: <20200921225618.52529-1-tfiga@chromium.org>
References: <20200921225618.52529-1-tfiga@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 22. September 2020, 00:56:18 CEST schrieb Tomasz Figa:
> Fix an implicit declaration of usleep_range():
> 
> drivers/phy/rockchip/phy-rockchip-dphy-rx0.c: In function 'rk_dphy_enable':
> drivers/phy/rockchip/phy-rockchip-dphy-rx0.c:203:2: error: implicit declaration of function 'usleep_range' [-Werror=implicit-function-declaration]
> 
> Fixes: 32abcc4491c62 ("media: staging: phy-rockchip-dphy-rx0: add Rockchip MIPI Synopsys DPHY RX0 driver")
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


