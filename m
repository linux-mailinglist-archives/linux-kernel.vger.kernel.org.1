Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F28E2D9A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390921AbgLNOtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:49:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408247AbgLNOtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:49:05 -0500
From:   Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap updates for v5.11
Date:   Mon, 14 Dec 2020 14:47:31 +0000
Message-Id: <20201214144753.1DA3B22B4B@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v5.11

for you to fetch changes up to 4616c509d187d2afda4a8f1121c2a3ef16bbcefe:

  Merge remote-tracking branch 'regmap/for-5.11' into regmap-next (2020-11-30 18:16:06 +0000)

----------------------------------------------------------------
regmap: Updates for v5.11

This is quite a busy release for regmap with two substantial features
being added:

 - Support for register maps Soundwire 1.2 multi-byte operations,
   allowing atomic support for registers larger than a single byte.
 - Support for relaxed I/O without barriers in MMIO regmaps, allowing
   them to be used efficiently on systems where default MMIO operations
   include barriers.

There was also an addition and revert of use of the new Soundwire
support for RT715 due to build issues with the driver built in, my tests
only covered building it as a module, the patch wasn't just dropped as
it had already been merged elsewhere.

----------------------------------------------------------------
Adrian Ratiu (1):
      regmap: mmio: add config option to allow relaxed MMIO accesses

Jack Yu (1):
      ASoC/SoundWire: rt715-sdca: First version of rt715 sdw sdca codec driver

Lucas Tanure (1):
      regmap: Fix order of regmap write log

Mark Brown (4):
      Merge series "regmap/SoundWire/ASoC: Add SoundWire SDCA support" from Bard Liao <yung-chuan.liao@linux.intel.com>:
      ASoC: rt715: Fix build
      Merge branch '20201104_yung_chuan_liao_regmap_soundwire_asoc_add_soundwire_sdca_support' into regmap-5.11
      Merge remote-tracking branch 'regmap/for-5.11' into regmap-next

Philippe Duplessis-Guindon (1):
      regmap: Remove duplicate `type` field from regmap `regcache_sync` trace event

Pierre-Louis Bossart (3):
      regmap: sdw: add required header files
      soundwire: SDCA: add helper macro to access controls
      regmap/SoundWire: sdw: add support for SoundWire 1.2 MBQ

 drivers/base/regmap/Kconfig             |   6 +-
 drivers/base/regmap/Makefile            |   1 +
 drivers/base/regmap/regmap-mmio.c       |  90 +++++++++++++++++++++++++---
 drivers/base/regmap/regmap-sdw-mbq.c    | 101 ++++++++++++++++++++++++++++++++
 drivers/base/regmap/regmap-sdw.c        |   2 +
 drivers/base/regmap/regmap.c            |  11 ++--
 drivers/base/regmap/trace.h             |   1 -
 include/linux/regmap.h                  |  40 +++++++++++++
 include/linux/soundwire/sdw_registers.h |  32 ++++++++++
 9 files changed, 270 insertions(+), 14 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-sdw-mbq.c
