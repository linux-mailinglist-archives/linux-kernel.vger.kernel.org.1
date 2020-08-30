Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C88625703D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 21:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgH3Tm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 15:42:57 -0400
Received: from gloria.sntech.de ([185.11.138.130]:48028 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgH3Tml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:42:41 -0400
Received: from p508fca7b.dip0.t-ipconnect.de ([80.143.202.123] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kCTDl-0002KX-Lu; Sun, 30 Aug 2020 21:42:33 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, sugar.zhang@rock-chips.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: rockchip-spdif: add description for rk3308
Date:   Sun, 30 Aug 2020 21:42:29 +0200
Message-Id: <159881654154.22245.11587351037887788062.b4-ty@sntech.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818143727.5882-1-jbx6244@gmail.com>
References: <20200818143727.5882-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 16:37:26 +0200, Johan Jonker wrote:
> A test with the command below shows that the compatible string
> 
> "rockchip,rk3308-spdif", "rockchip,rk3328-spdif"
> 
> is already in use, but is not added to a document.
> The current fallback string "rockchip,rk3328-spdif" points to a data
> set enum RK_SPDIF_RK3366 in rockchip_spdif.c that is not used both
> in the mainline as in the manufacturer kernel.
> (Of the enum only RK_SPDIF_RK3288 is used.)
> So if the properties don't change we might as well use the first SoC
> in line as fallback string and add the description for rk3308 as:
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: change spdif fallback compatible on rk3308
      commit: bc1f9bff0629a15e3de1ef106ac03cba930227dd

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
