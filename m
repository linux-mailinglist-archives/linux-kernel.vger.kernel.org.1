Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96062D8B46
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 05:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392316AbgLMEZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 23:25:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbgLMEZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 23:25:50 -0500
Date:   Sun, 13 Dec 2020 05:24:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607833507;
        bh=yDRErw2lKHvrlUMCc79cmETAZesrsSn+JtJBXLOBwjQ=;
        h=From:To:Cc:Subject:From;
        b=WW25848rKrnDytd8aonIWdngPuyESalpX11IzmvBeQyWZXdPKhKzY7djqbOT8Qh0y
         k5OT52ncpth5NyJo8HVF6HIbjUsoFQCIrdYxUCFnaMBJt+mBlkFVo8mD2ThIWn7fEt
         MSxp+dbWmpqR7bZzCYxR9fBYWrXekfFp2iFJn8mPxEybRFA5vw/yqTWaJlZOg2jpkP
         H4IVFoogeiITV2C6CoDFC6PNXIuIhjHf6/qmQHUx+ZbX6IVgrsI7AZl4O0hPyL+O6X
         iqGqECBmP9eAPmW3MTRRYW+AS6Xgd+sSUcOi3GJaFgNIVWzHOvGHWFeo9/AFW9IavB
         U6IGjwthv9tlA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lars Poeschel <poeschel@lemonage.de>, Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for v5.11
Message-ID: <20201213042450.GA26048@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This time there have been quite a few changes in auxdisplay thanks to
a refactor by Lars Poeschel to share code in order to introduce a new driver.

I am sending these earlier than usual. Please also note I am using
a different email address than usual, too.

Cheers,
Miguel

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.11

for you to fetch changes up to 351dcacc6d774258be9fec6f51c14f8ff38243f6:

  auxdisplay: panel: Remove redundant charlcd_ops structures (2020-11-16 17:13:37 +0100)

----------------------------------------------------------------
A bigger set of changes than usual for auxdisplay:

  - Significant refactor work to make charlcd independent
    of device, i.e. hd44780 (Lars Poeschel)

  - New driver: lcd2s (Lars Poeschel)

  - Fixes on top of the rework while being tested in -next
    (Lars Poeschel, Dan Carpenter and kernel test robot)

----------------------------------------------------------------
Dan Carpenter (1):
      auxdisplay: fix use after free in lcd2s_i2c_remove()

Lars Poeschel (28):
      auxdisplay: Use an enum for charlcd backlight on/off ops
      auxdisplay: Introduce hd44780_common.[ch]
      auxdisplay: Move hwidth and bwidth to struct hd44780_common
      auxdisplay: Move ifwidth to struct hd44780_common
      auxdisplay: Move write_data pointer to hd44780_common
      auxdisplay: Move write_cmd pointers to hd44780 drivers
      auxdisplay: Move addr out of charlcd_priv
      auxdisplay: hd44780_common_print
      auxdisplay: provide hd44780_common_gotoxy
      auxdisplay: add home to charlcd_ops
      auxdisplay: Move clear_display to hd44780_common
      auxdisplay: make charlcd_backlight visible to hd44780_common
      auxdisplay: Make use of enum for backlight on / off
      auxdisplay: Move init_display to hd44780_common
      auxdisplay: implement various hd44780_common_ functions
      auxdisplay: cleanup unnecessary hd44780 code in charlcd
      auxdisplay: Move char redefine code to hd44780_common
      auxdisplay: Call charlcd_backlight in place
      auxdisplay: hd44780_common: Reduce clear_display timeout
      auxdisplay: hd44780: Remove clear_fast
      auxdisplay: charlcd: replace last device specific stuff
      auxdisplay: Change gotoxy calling interface
      auxdisplay: charlcd: Do not print chars at end of line
      auxdisplay: lcd2s DT binding doc
      auxdisplay: add a driver for lcd2s character display
      auxdisplay: hd44780_common: Fix build error
      auxdisplay: panel: Fix missing print function pointer
      auxdisplay: panel: Remove redundant charlcd_ops structures

kernel test robot (1):
      auxdisplay: fix platform_no_drv_owner.cocci warnings

 .../bindings/auxdisplay/modtronix,lcd2s.yaml       |  58 +++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/auxdisplay/Kconfig                         |  33 +-
 drivers/auxdisplay/Makefile                        |   2 +
 drivers/auxdisplay/charlcd.c                       | 412 ++++++---------------
 drivers/auxdisplay/charlcd.h                       |  86 ++++-
 drivers/auxdisplay/hd44780.c                       | 120 ++++--
 drivers/auxdisplay/hd44780_common.c                | 361 ++++++++++++++++++
 drivers/auxdisplay/hd44780_common.h                |  33 ++
 drivers/auxdisplay/lcd2s.c                         | 402 ++++++++++++++++++++
 drivers/auxdisplay/panel.c                         | 173 ++++-----
 11 files changed, 1218 insertions(+), 464 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/auxdisplay/modtronix,lcd2s.yaml
 create mode 100644 drivers/auxdisplay/hd44780_common.c
 create mode 100644 drivers/auxdisplay/hd44780_common.h
 create mode 100644 drivers/auxdisplay/lcd2s.c
