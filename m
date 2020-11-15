Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B76B2B3543
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 15:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgKOO3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 09:29:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbgKOO3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 09:29:16 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF96F22447;
        Sun, 15 Nov 2020 14:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605450556;
        bh=3zkRk6Pcg7FbVXDGzl4l75DoJWf3R1mPFRMGczK5wqQ=;
        h=Date:From:To:Cc:Subject:From;
        b=dn81P+K/1AWve0uk8Y16f8jGFnvtqYhrQzAj5VJTiY5d4qG6DiGQFD3+j4C+sbBSm
         rp0n/+kf11n/kSrUzICknaxDoqzn8BwAt1S4kzSZR5/UtG+KNMXdQ6KAmQK3BteBeS
         ifKHf/BnUTb7wpolb5bpKf+WxjBF+FMEK6q6DCi4=
Date:   Sun, 15 Nov 2020 15:30:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.10-rc4
Message-ID: <X7E7cMDVfEMb2oSt@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.10-rc4

for you to fetch changes up to 092561f06702dd4fdd7fb74dd3a838f1818529b7:

  uio: Fix use-after-free in uio_unregister_device() (2020-11-09 18:54:30 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 5.10-rc4

Here are some small char/misc/whatever driver fixes for 5.10-rc4.

Nothing huge, lots of small fixes for reported issues:
	- habanalabs driver fixes
	- speakup driver fixes
	- uio driver fixes
	- virtio driver fix
	- other tiny driver fixes
Full details are in the shortlog.

All of these have been in linux-next for a full week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Lobakin (1):
      virtio: virtio_console: fix DMA memory allocation for rproc serial

Alexander Usyskin (1):
      mei: protect mei_cl_mtu from null dereference

Andra Paraschiv (1):
      nitro_enclaves: Fixup type and simplify logic of the poll mask setup

Arnd Bergmann (2):
      habanalabs: fix kernel pointer type
      firmware: xilinx: fix out-of-bounds access

Greg Kroah-Hartman (1):
      Merge tag 'misc-habanalabs-fixes-2020-11-04' of ssh://gitolite.kernel.org/.../ogabbay/linux into char-misc-next

Oded Gabbay (1):
      habanalabs/gaudi: mask WDT error in QMAN

Ofir Bitton (1):
      habanalabs/gaudi: move coresight mmu config

Samuel Thibault (3):
      speakup: Fix var_id_t values and thus keymap
      speakup: Fix clearing selection in safe context
      speakup ttyio: Do not schedule() in ttyio_in_nowait

Shin'ichiro Kawasaki (1):
      uio: Fix use-after-free in uio_unregister_device()

 drivers/accessibility/speakup/main.c               |  1 -
 drivers/accessibility/speakup/selection.c          | 11 +++----
 drivers/accessibility/speakup/speakup.h            |  1 -
 drivers/accessibility/speakup/spk_ttyio.c          | 10 +++---
 drivers/accessibility/speakup/spk_types.h          |  8 +++--
 drivers/char/virtio_console.c                      |  8 ++---
 drivers/firmware/xilinx/zynqmp.c                   |  3 ++
 drivers/misc/habanalabs/common/command_buffer.c    |  9 +++--
 drivers/misc/habanalabs/common/habanalabs.h        | 14 ++++----
 drivers/misc/habanalabs/common/hw_queue.c          | 19 +++++------
 drivers/misc/habanalabs/common/irq.c               | 17 +++++-----
 drivers/misc/habanalabs/gaudi/gaudi.c              | 38 +++++++++-------------
 drivers/misc/habanalabs/gaudi/gaudiP.h             |  1 +
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |  5 +++
 drivers/misc/habanalabs/goya/goya.c                | 26 +++++++--------
 drivers/misc/habanalabs/goya/goyaP.h               |  2 +-
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |  1 -
 drivers/misc/mei/client.h                          |  4 +--
 drivers/uio/uio.c                                  | 10 +++---
 drivers/virt/nitro_enclaves/ne_misc_dev.c          |  6 ++--
 20 files changed, 95 insertions(+), 99 deletions(-)
