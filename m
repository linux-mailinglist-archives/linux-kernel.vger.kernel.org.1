Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9132722A016
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 21:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732872AbgGVTVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 15:21:33 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47732 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732488AbgGVTVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:21:25 -0400
Received: from x2f7fa19.dyn.telefonica.de ([2.247.250.25] helo=phil.sntech)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jyKIs-0005Ud-Cy; Wed, 22 Jul 2020 21:21:22 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Alex Bee <knaerzche@gmail.com>, linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2] clk: rockchip: add sclk_mac_lbtest to rk3188_critical_clocks
Date:   Wed, 22 Jul 2020 21:21:07 +0200
Message-Id: <159544564767.763387.12839655099512768766.b4-ty@sntech.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722161820.5316-1-knaerzche@gmail.com>
References: <20200722161820.5316-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 18:18:20 +0200, Alex Bee wrote:
> Since the loopbacktest clock is not exported and is not touched in the
> driver, it has to be added to rk3188_critical_clocks to be protected from
> being disabled and in order to get the emac working.

Applied, thanks!

[1/1] clk: rockchip: add sclk_mac_lbtest to rk3188_critical_clocks
      commit: ef990bcad58cf1d13c5a49191a2c2342eb8d6709

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
