Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAB02D0586
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 15:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgLFOft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 09:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:44244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgLFOfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 09:35:48 -0500
Date:   Sun, 6 Dec 2020 15:36:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607265308;
        bh=zY0JFJJabkvGhIOouKGYLLVKrt5KF3Cd8M07vID0bhg=;
        h=From:To:Cc:Subject:From;
        b=GqI2Hxd4CObZ4SByFZlTskMfo+SZ4B6QkLwgXRq3hwBD/GwU22WcokeNUp6Mh+VCT
         qtsVSsdDIc+PquhFF26LfJ8qi3sFnCO8qYQDmR3z4x1owSb4J4XXrHWoRcbaHYmfLk
         tDTMrErB8p1EzxDS+1WAHS+Va0no3ut/Q7Zms/Kg=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.10-rc7
Message-ID: <X8zsZCwxs6Oas7rJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.10-rc7

for you to fetch changes up to 264f53b41946dcabb2b3304190839ab5670c7825:

  Revert "mei: virtio: virtualization frontend driver" (2020-12-06 10:36:17 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 5.10-rc7

Here are some small driver fixes, and one "large" revert, for 5.10-rc7.

They include:
	- revert mei patch from 5.10-rc1 that was using a reserved
	  userspace value.  It will be resubmitted once the proper id
	  has been assigned by the virtio people.
	- habanalabs fixes found by the fall-through audit from Gustavo
	- speakup driver fixes for reported issues
	- fpga config build fix for reported issue.

All of these except the revert have been in linux-next with no reported
issues.  The revert is "clean" and just removes a previously-added
driver, so no real issue there.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
David Gow (1):
      fpga: Specify HAS_IOMEM dependency for FPGA_DFL

Greg Kroah-Hartman (1):
      Merge tag 'misc-habanalabs-fixes-2020-11-30' of ssh://gitolite.kernel.org/.../ogabbay/linux into char-misc-linus

Michael S. Tsirkin (1):
      Revert "mei: virtio: virtualization frontend driver"

Ofir Bitton (2):
      habanalabs: free host huge va_range if not used
      habanalabs: put devices before driver removal

Samuel Thibault (1):
      speakup: Reject setting the speakup line discipline outside of speakup

 drivers/accessibility/speakup/spk_ttyio.c |  37 +-
 drivers/fpga/Kconfig                      |   1 +
 drivers/misc/habanalabs/common/device.c   |  16 +-
 drivers/misc/habanalabs/common/memory.c   |   1 +
 drivers/misc/mei/Kconfig                  |  10 -
 drivers/misc/mei/Makefile                 |   3 -
 drivers/misc/mei/hw-virtio.c              | 874 ------------------------------
 7 files changed, 33 insertions(+), 909 deletions(-)
 delete mode 100644 drivers/misc/mei/hw-virtio.c
