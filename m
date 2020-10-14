Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A3428E7A0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgJNUAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:00:45 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:58694 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNUAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:00:45 -0400
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 7B79CA54A3E; Wed, 14 Oct 2020 22:00:43 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Heiko Stuebner <heiko@sntech.de>, Aditya Prayoga <aditya@kobol.io>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 0/2] arm64: Add basic support for Kobol's Helios64
Date:   Wed, 14 Oct 2020 22:00:28 +0200
Message-Id: <20201014200030.845759-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in v3 Johan still found some inconsistencies in how I sorted (or didn't
sort) the device tree properties. The rules I applied now are:

	at the beginning of a node: compatible, reg and interrupt stuff
	status and #* at the end
	i2c-scl-rising-time-ns before i2c-scl-falling-time-ns
	regulator-name first among regulator-*
	regulator-min-microvolt before regulator-max-microvolt
	pinctrl-names before pinctrl-0
	tx_delay grouped with (and after) rx_delay
	vcc12* after vcc5*
	otherwise alphabetically

other things changed are:

	- drop disable-wp and supports-emmc for emmc
	- use led-0 and led-1 as node names for the leds
	- rename pinctrl for the leds according to the line name in the schematic
	- drop linux,default-trigger = "none";
	- add an enable gpio for the sd regulator
	- some whitespace nits

While testing I rebased to 5.9 and for an unknown reason this kernel
fails to boot (just no output), but the resulting dtb works just fine
with a Debian 5.8 kernel.

Uwe Kleine-König (2):
  dt-bindings: vendor-prefixes: Add kobol prefix
  arm64: dts: rockchip: Add basic support for Kobol's Helios64

 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3399-kobol-helios64.dts    | 371 ++++++++++++++++++
 3 files changed, 374 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-kobol-helios64.dts

-- 
2.28.0

