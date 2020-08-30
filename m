Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D75F257038
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 21:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgH3Tms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 15:42:48 -0400
Received: from gloria.sntech.de ([185.11.138.130]:48010 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgH3Tmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:42:37 -0400
Received: from p508fca7b.dip0.t-ipconnect.de ([80.143.202.123] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kCTDl-0002KX-UO; Sun, 30 Aug 2020 21:42:33 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] rk3318 A95X Z2 board
Date:   Sun, 30 Aug 2020 21:42:30 +0200
Message-Id: <159881654154.22245.1067280987036121454.b4-ty@sntech.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200808160618.15445-1-jbx6244@gmail.com>
References: <20200808160618.15445-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Aug 2020 18:06:15 +0200, Johan Jonker wrote:
> Add rk3318 A95X Z2 board.
> 
> What works:
>  adc key
>  emmc
>  ethernet
>  hdmi
>  gpu
>  ir
>  mmc
>  sd card
>  vop
>  usb2
>  uart2
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: Add vendor prefix for Shenzhen Zkmagic Technology Co., Ltd.
      commit: cb1cc137a2c148cbe60e5065afa1a09e176e0269
[2/3] dt-bindings: arm: rockchip: add Zkmagic A95X Z2 description
      commit: 0dc8c62c92d4df35a001b613ebe10f95e4ebf776
[3/3] arm64: dts: rockchip: add rk3318 A95X Z2 board
      commit: 964ed0807b5f7b42b8a6ad48531ae9312e19599d

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
