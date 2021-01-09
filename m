Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2642F00E6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 16:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbhAIPkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 10:40:39 -0500
Received: from gloria.sntech.de ([185.11.138.130]:36644 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbhAIPki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 10:40:38 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kyGLL-0000jX-PQ; Sat, 09 Jan 2021 16:39:55 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Demetris Ierokipides <ierokipides.dem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>
Subject: Re: (subset) [PATCH 0/2] ARM: dts: rockchip: minor tweaks for rk3288-miqi.This series adds a missing mali GPU node and two additional CPU opp points
Date:   Sat,  9 Jan 2021 16:39:46 +0100
Message-Id: <161020678303.3482489.15547780514120849790.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108151036.36434-1-ierokipides.dem@gmail.com>
References: <20210108151036.36434-1-ierokipides.dem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jan 2021 17:10:34 +0200, Demetris Ierokipides wrote:
> Demetris Ierokipides (2):
>   ARM: dts: rockchip: add gpu node to rk3288-miqi
>   ARM: dts: rockchip: add extra cpu opp points to rk3288-miqi
> 
>  arch/arm/boot/dts/rk3288-miqi.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Applied, thanks!

[1/2] ARM: dts: rockchip: add gpu node to rk3288-miqi
      commit: 36948ec3d4d0d1b9260d87b550a56fab8d86d17d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
