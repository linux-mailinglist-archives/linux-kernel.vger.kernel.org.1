Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C272F6120
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbhANMld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:41:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:58966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbhANMld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:41:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C8F623A53;
        Thu, 14 Jan 2021 12:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610628052;
        bh=OxL9TuHjbQbPuPcAueI8mkcZ4/hHYeRATV5+Snzg2sg=;
        h=From:To:Cc:Subject:Date:From;
        b=orgFjgQL/Kn0lbejYzUJ0LUwxm1/SMaYz2krykGO0uxLsaSmgJPJgwWiezS7Mpz+V
         gTD97L8ou/pJL+BcGSYjUiWNUpcp51hfx3/icX5GaP3MHEobVyM1/duQeYPIJ1aj0f
         NzBZvUwh13mqZrz/CzyVdUYJH2McU8lzNNed9LEnk7v4bdw9VlsAy0hggA73/FV4UC
         kmyHd3/UQ5d7DSUU2fYvobCg9rUU+qeF1knJMVEE5/v67q7s44wOtZsOSRxsCG9HSb
         6Ll1DKQYiGKr0hl7vRpd090BPAAkviVUKz7sw4KRSrsQhdn+q4/gQ/borKL6/FL5WN
         3yIHNDxiC5jzw==
Received: by pali.im (Postfix)
        id 9D0CF621; Thu, 14 Jan 2021 13:40:49 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Tomasz Maciej Nowak" <tmn505@gmail.com>,
        "Luka Perkov" <luka.perkov@sartura.hr>,
        "Andre Heider" <a.heider@gmail.com>,
        "Vladimir Vid" <vladimir.vid@sartura.hr>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?G=C3=A9rald=20Kerma?= <gerald@gk2.net>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH mvebu v2 00/10] Armada 37xx: Fix cpufreq changing base CPU speed to 800 MHz from 1000 MHz
Date:   Thu, 14 Jan 2021 13:40:22 +0100
Message-Id: <20210114124032.12765-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The armada-37xx-cpufreq driver changes base CPU speed from 1000 MHz to
800 MHz on EspressoBIN and Turris MOX. The commit message in patch 2/10
explains why and how can this be discovered.

That patch 2/10 led us to discover another bug, in the SOC itself,
that causes the CPU to behave weirdly when frequency changes to 1 GHz.
A similar erratum is documented by Marvell but only for systems where
base frequency is 1.2 GHz.

We've discovered that to make cpufreq scaling stable on Armada 3720
systems with base frequency 1 GHz, we also have to set voltage levels
for L0 and L1 loads to at least 1108 mV. We were led to this by patch we
found in Marvell kernel fork. Fix is in the patch 4/10.

https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/dc33b62c90696afb6adc7dbcc4ebbd48bedec269

During fixing this voltage issue for 1 GHz we discovered another bug in
armada-37xx-cpufreq driver that causes CPU instability. Erratum for VDD
stabilization was improperly implemented, details are in patch 6/10.

This patch series is also available in my git tree in branch a3720-cpufreq-issues:

https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=a3720-cpufreq-issues

We have tested this patch series on Espressobin v5 and Turris MOX
boards. If you have other Armada 3720 boards (Espressobin v5/v7, uDPU,
Devel Board, ...) then it will be nice to do an additional tests and
check if instability issues are finally fixed.

There is a discussion on armbian forum that Espressobin v7 is unstable
when running at 1 GHz and in this thread was also mentioned above
voltage patch from Marvell kernel fork:

https://forum.armbian.com/topic/10429-how-to-make-espressobin-v7-stable/

Marek & Pali


Marek Behún (3):
  arm64: dts: marvell: armada-37xx: add syscon compatible to NB clk node
  cpufreq: armada-37xx: Fix setting TBG parent for load levels
  clk: mvebu: armada-37xx-periph: remove .set_parent method for CPU PM
    clock

Pali Rohár (7):
  cpufreq: armada-37xx: Fix the AVS value for loads L0 and L1
  clk: mvebu: armada-37xx-periph: Fix switching CPU freq from 250 Mhz to
    1 GHz
  clk: mvebu: armada-37xx-periph: Fix workaround for switching from L1
    to L0
  cpufreq: armada-37xx: Fix driver cleanup when registration failed
  cpufreq: armada-37xx: Fix determining base CPU frequency
  cpufreq: armada-37xx: Remove cur_frequency variable
  cpufreq: armada-37xx: Fix module unloading

 arch/arm64/boot/dts/marvell/armada-37xx.dtsi |   3 +-
 drivers/clk/mvebu/armada-37xx-periph.c       |  83 ++++++++-------
 drivers/cpufreq/armada-37xx-cpufreq.c        | 100 ++++++++++++++-----
 3 files changed, 124 insertions(+), 62 deletions(-)

-- 
2.20.1

