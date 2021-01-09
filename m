Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4468C2F00ED
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 16:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbhAIPkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 10:40:49 -0500
Received: from gloria.sntech.de ([185.11.138.130]:36754 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbhAIPkn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 10:40:43 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kyGLM-0000jX-WC; Sat, 09 Jan 2021 16:39:57 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add SPDIF node for rk3399-rockpro64
Date:   Sat,  9 Jan 2021 16:39:50 +0100
Message-Id: <161020678304.3482489.5731474695073425593.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20200810091619.3170534-1-katsuhiro@katsuster.net>
References: <20200810091619.3170534-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 18:16:19 +0900, Katsuhiro Suzuki wrote:
> This patch adds 'disabled' SPDIF sound node and related settings
> for rk3399-rockpro64.
> 
> There are 2 reasons:
>   - All RK3399 dma-bus channels have been already used by I2S0/1/2
>   - RockPro64 does not have SPDIF optical nor coaxial connector,
>     just have 3pins

Applied, thanks!

[1/1] arm64: dts: rockchip: add SPDIF node for rk3399-rockpro64
      commit: 7f02feb56d9dc8ee2fffe00993f7b9aadd8902ba

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
