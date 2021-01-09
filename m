Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04FF2F00EE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 16:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbhAIPlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 10:41:05 -0500
Received: from gloria.sntech.de ([185.11.138.130]:36712 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbhAIPkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 10:40:39 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kyGLN-0000jX-7n; Sat, 09 Jan 2021 16:39:57 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: enable HDMI sound nodes for rk3328-rock64
Date:   Sat,  9 Jan 2021 16:39:51 +0100
Message-Id: <161020678304.3482489.3049942177726573857.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20200802154231.2639186-1-katsuhiro@katsuster.net>
References: <20200802154231.2639186-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 00:42:31 +0900, Katsuhiro Suzuki wrote:
> This patch enables HDMI sound (I2S0) and Analog sound (I2S1) which
> are defined in rk3328.dtsi, and replace SPDIF nodes.
> 
> We can use SPDIF pass-through with suitable ALSA settings and on
> mpv or other media players.
>   - Settings: https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Rockchip/filesystem/usr/share/alsa/cards/SPDIF.conf
>   - Ex.: mpv foo.ac3 --audio-spdif=ac3 --audio-device='alsa/SPDIF.pcm.iec958.0:SPDIF'
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: enable HDMI sound nodes for rk3328-rock64
      commit: 25572fb5aa986bdbb35d06c0fb52a9b9d9b3b2c9

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
