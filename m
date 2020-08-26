Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7342F25374D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 20:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHZSiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 14:38:16 -0400
Received: from foss.arm.com ([217.140.110.172]:50084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgHZSiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:38:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACF8E101E;
        Wed, 26 Aug 2020 11:38:13 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0A593F71F;
        Wed, 26 Aug 2020 11:38:11 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Min <chanho.min@lge.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Wei Xu <xuwei5@hisilicon.com>
Subject: [PATCH 0/6] dt-bindings: Convert SP804 to Json-schema (and fix users)
Date:   Wed, 26 Aug 2020 19:37:58 +0100
Message-Id: <20200826183805.19369-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first attempt to convert the SP804 timer binding to yaml.
This is done in the first patch, the remaining five fix some DT users.

I couldn't test any of those DT files on actual machines, but tried
to make the changes in a way that would be transparent to at least the
Linux driver. The only other SP804 DT user I could find is FreeBSD,
but they seem to use a different binding (no clocks, but a
clock-frequency property).
For some platforms I wonder how this worked before (missing arm,primecell
compatible), maybe they magically spring to life now?

Cheers,
Andre

Andre Przywara (6):
  dt-bindings: timers: sp-804: Convert to json-schema
  ARM: dts: arm: Fix SP804 users
  ARM: dts: broadcom: Fix SP804 node
  ARM: dts: hisilicon: Fix SP804 users
  ARM: dts: nspire: Fix SP804 users
  arm64: dts: lg: Fix SP804 users

 .../devicetree/bindings/timer/arm,sp804.txt   | 29 -------
 .../devicetree/bindings/timer/arm,sp804.yaml  | 82 +++++++++++++++++++
 arch/arm/boot/dts/arm-realview-pb11mp.dts     | 16 ++--
 arch/arm/boot/dts/bcm-nsp.dtsi                |  2 +-
 arch/arm/boot/dts/hi3620.dtsi                 | 30 ++++---
 arch/arm/boot/dts/hip04.dtsi                  |  4 +-
 arch/arm/boot/dts/mps2.dtsi                   |  6 +-
 arch/arm/boot/dts/nspire.dtsi                 | 12 ++-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts        |  4 +-
 arch/arm64/boot/dts/lg/lg1312.dtsi            |  6 +-
 arch/arm64/boot/dts/lg/lg1313.dtsi            |  6 +-
 11 files changed, 133 insertions(+), 64 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.yaml

-- 
2.17.1

