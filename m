Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C7621401B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 21:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgGCTsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 15:48:47 -0400
Received: from vps.xff.cz ([195.181.215.36]:47710 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgGCTsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1593805724; bh=9gsrsQinKxRqqrBrwbzd4pwGqYgzIUxXBKt11M3IrKs=;
        h=From:To:Cc:Subject:Date:From;
        b=jfjr5y1sTKsVJEhs4JzvttIdtxAPQA+gJV905wEGOFVIUXflhP1OHA2NPaDeFrmCA
         USYOYmxp9liwCcMU/Pp7+3EpdeIxoqEecXV9v189woNmfvnXAtXPZyKTN/y7oLOWHg
         aarDj4pexO23fuaglI7h/VD86h6fk2cvPVeOKdQ8=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add support for Pine64 PinePhone HW Revision 1.2
Date:   Fri,  3 Jul 2020 21:48:39 +0200
Message-Id: <20200703194842.111845-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds an initial support for Pine64 PinePhone 1.2.

The differences against 1.1 and 1.0 are larger. So far this
series describes the magnetometer interrupt that is wired
correctly on 1.2 and backlight differences.

There are also a lot of changes in how modem gpios are exposed,
and in HDMI/USB bridge and USB power in this revision. Those
will be expressed later, when the base dtsi gains support for
these things.

Please take a look.

thank you and regards,
  Ondrej Jirman

Ondrej Jirman (3):
  dt-bindings: arm: sunxi: Add PinePhone 1.2 bindings
  arm64: dts: allwinner: Add support for PinePhone revision 1.2
  arm64: dts: sun50i-pinephone: dldo4 must not be >= 1.8V

 .../devicetree/bindings/arm/sunxi.yaml        |  5 +++
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../allwinner/sun50i-a64-pinephone-1.2.dts    | 40 +++++++++++++++++++
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   |  4 +-
 4 files changed, 48 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts

-- 
2.27.0

