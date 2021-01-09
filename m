Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37732F00E5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 16:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbhAIPkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 10:40:39 -0500
Received: from gloria.sntech.de ([185.11.138.130]:36616 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbhAIPki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 10:40:38 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kyGLM-0000jX-Ed; Sat, 09 Jan 2021 16:39:56 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: assign a fixed index to mmc devices on rk3328 boards
Date:   Sat,  9 Jan 2021 16:39:48 +0100
Message-Id: <161020678303.3482489.12512122590216902227.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201219210500.3855-1-jbx6244@gmail.com>
References: <20201219210500.3855-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Dec 2020 22:05:00 +0100, Johan Jonker wrote:
> Recently introduced async probe on mmc devices can shuffle block IDs.
> Pin them to fixed values to ease booting in environments where UUIDs
> are not practical. Use newly introduced aliases for mmcblk devices from [1].
> 
> [1] https://patchwork.kernel.org/patch/11747669/

Applied, thanks!

[1/1] arm64: dts: rockchip: assign a fixed index to mmc devices on rk3328 boards
      commit: 221c6c042fa004b73b10780fa2aaf177085e2f3f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
