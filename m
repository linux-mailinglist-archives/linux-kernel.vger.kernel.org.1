Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D8B3030B8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 01:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbhAZAA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 19:00:57 -0500
Received: from gloria.sntech.de ([185.11.138.130]:33998 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732075AbhAYX5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 18:57:13 -0500
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=phil.fritz.box)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1l4Big-00066j-EY; Tue, 26 Jan 2021 00:56:30 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: rename pinctrl nodename to gmac2io for nanopi-r2s board
Date:   Tue, 26 Jan 2021 00:56:20 +0100
Message-Id: <161161878917.2050283.17759962582911912279.b4-ty@sntech.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210110194851.10207-1-jbx6244@gmail.com>
References: <20210110194851.10207-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jan 2021 20:48:51 +0100, Johan Jonker wrote:
> A test with the command below gives this error:
> /arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dt.yaml:
> ethernet-phy: 'reg' is a required property
> 
> The pinctrl nodename "ethernet-phy" conflicts with the rules
> in the "ethernet-phy.yaml" document, so rename it to "gmac2io".
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: rename pinctrl nodename to gmac2io for nanopi-r2s board
      commit: 16459ecac6d6bf6a817d9c0cf78d696461fdcd26

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
