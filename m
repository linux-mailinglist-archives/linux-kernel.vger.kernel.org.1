Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744DF2F0787
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 15:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbhAJOI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 09:08:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbhAJOI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 09:08:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D249D22EBF;
        Sun, 10 Jan 2021 14:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610287697;
        bh=NcVIwl9rkpdu5CPbbETn7w1Jwe510qUTFxdppGL3szk=;
        h=Date:From:To:Cc:Subject:From;
        b=Rx7tYHWl2qfSnVepJkLA1P+yKUYHupWjjRFEO4U2DjiFfVU8S40Ni8e5Lvy12TBw0
         w8MBKvvqRqSHdD3yIKQs5zid7IJB3EAB3sQEb/gM24CJ3e51WECN6j4Bzh9Cm7BzEa
         piC36ernx9xDCsHg1yfBOB9+dd+6ghh8d5bQCpt4=
Date:   Sun, 10 Jan 2021 15:09:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.11-rc3
Message-ID: <X/sKmuNK82RLz8jR@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.11-rc3

for you to fetch changes up to 384b77fd48fd683a82760bc88bef8611cba997fc:

  Fonts: font_ter16x32: Update font with new upstream Terminus release (2021-01-07 21:06:25 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 5.11-rc3

Here are some small char and misc driver fixes for 5.11-rc3.

the majority here are fixes for the habanalabs drivers, but also in here
are:
	- crypto driver fix
	- pvpanic driver fix
	- updated font file
	- interconnect driver fixes

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alon Mizrahi (5):
      habanalabs: add comment for pll frequency ioctl opcode
      habanalabs: fetch PSOC PLL frequency from F/W in goya
      habanalabs: remove generic gaudi get_pll_freq function
      habanalabs/gaudi: do not set EB in collective slave queues
      habanalabs: add validation cs counter, fix misplaced counters

Amanoel Dawod (1):
      Fonts: font_ter16x32: Update font with new upstream Terminus release

Andy Shevchenko (1):
      misc: pvpanic: Check devm_ioport_map() for NULL

Arnd Bergmann (1):
      interconnect: qcom: fix rpmh link failures

Christophe JAILLET (2):
      interconnect: imx: Add a missing of_node_put after of_device_is_available
      interconnect: imx: Remove a useless test

Dinghao Liu (1):
      habanalabs: Fix memleak in hl_device_reset

Georgi Djakov (1):
      MAINTAINERS: Update Georgi's email address

Greg Kroah-Hartman (3):
      Merge tag 'misc-habanalabs-fixes-2020-12-30' of https://git.kernel.org/.../ogabbay/linux into char-misc-linus
      crypto: asym_tpm: correct zero out potential secrets
      Merge tag 'icc-5.11-rc3' of git://git.kernel.org/.../djakov/icc into char-misc-linus

Martin Kepplinger (1):
      interconnect: imx8mq: Use icc_sync_state

Oded Gabbay (7):
      habanalabs/gaudi: disable CGM at HW initialization
      habanalabs/gaudi: enhance reset message
      habanalabs: update comment in hl_boot_if.h
      habanalabs: adjust pci controller init to new firmware
      habanalabs/gaudi: retry loading TPC f/w on -EINTR
      habanalabs: register to pci shutdown callback
      habanalabs: fix order of status check

Ofir Bitton (2):
      habanalabs: preboot hard reset support
      habanalabs: full FW hard reset support

Samuel Thibault (1):
      speakup: Add github repository URL and bug tracker

Tomer Tayar (2):
      habanalabs: Fix a missing-braces warning
      habanalabs: Revise comment to align with mirror list name

 MAINTAINERS                                        |   4 +-
 crypto/asymmetric_keys/asym_tpm.c                  |   2 +-
 drivers/interconnect/imx/imx.c                     |   3 +-
 drivers/interconnect/imx/imx8mq.c                  |   2 +
 drivers/interconnect/qcom/Kconfig                  |  23 ++-
 .../misc/habanalabs/common/command_submission.c    |  77 +++++++--
 drivers/misc/habanalabs/common/device.c            |   8 +-
 drivers/misc/habanalabs/common/firmware_if.c       |  60 +++++--
 drivers/misc/habanalabs/common/habanalabs.h        |   4 +-
 drivers/misc/habanalabs/common/habanalabs_drv.c    |   1 +
 drivers/misc/habanalabs/common/habanalabs_ioctl.c  |   7 +-
 drivers/misc/habanalabs/common/hw_queue.c          |   5 +-
 drivers/misc/habanalabs/common/pci.c               |  28 +--
 drivers/misc/habanalabs/gaudi/gaudi.c              | 191 +++++++++------------
 drivers/misc/habanalabs/gaudi/gaudiP.h             |   7 -
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |   3 +-
 drivers/misc/habanalabs/goya/goya.c                |  75 ++++----
 .../misc/habanalabs/include/common/hl_boot_if.h    |   9 +-
 drivers/misc/pvpanic.c                             |  19 +-
 include/uapi/misc/habanalabs.h                     |   5 +
 lib/fonts/font_ter16x32.c                          |   6 +-
 21 files changed, 322 insertions(+), 217 deletions(-)
