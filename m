Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258552AACE3
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgKHSpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:45:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbgKHSpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:45:14 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5409F20731;
        Sun,  8 Nov 2020 18:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604861113;
        bh=ZRxSWClJTJREmRbTo11n9BuC0l8BvYgKW/8Z6kghBVE=;
        h=Date:From:To:Cc:Subject:From;
        b=fa2UesNGAmxCLoprZIJumDUAOWd1AQb4f8bhOly+i70PZGJdnkvogeL+VbiiOjB9A
         RK2Qe08uOAoXI5flFP2PcG7BUX3ACyRArL9oVbv1+CHZHAV+81TTzx+8ifo48zz1Y1
         8WmtxxfkVReuY2y0GQ8/+ycmdw94LbW3KLKP4LYA=
Date:   Sun, 8 Nov 2020 19:46:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 5.10-rc3
Message-ID: <20201108184614.GA66799@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-5.10-rc3

for you to fetch changes up to 3c4e0dff2095c579b142d5a0693257f1c58b4804:

  vt: Disable KD_FONT_OP_COPY (2020-11-08 19:35:06 +0100)

----------------------------------------------------------------
TTY/Serial fixes for 5.10-rc3

Here are a small number of small tty and serial fixes for some reported
problems for the tty core, vt code, and some serial drivers.

They include fixes for:
	- a buggy and obsolete vt font ioctl removal
	- 8250_mtk serial baudrate runtime warnings
	- imx serial earlycon build configuration fix
	- txx9 serial driver error path cleanup issues
	- tty core fix in release_tty that can be triggered by trying to
	  bind an invalid serial port name to a speakup console device

Almost all of these have been in linux-next without any problems, the
only one that hasn't, just deletes code :)

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Claire Chang (1):
      serial: 8250_mtk: Fix uart_get_baud_rate warning

Daniel Vetter (1):
      vt: Disable KD_FONT_OP_COPY

Lucas Stach (1):
      tty: serial: imx: enable earlycon by default if IMX_SERIAL_CONSOLE is enabled

Matthias Reichl (1):
      tty: fix crash in release_tty if tty->port is not set

Qinglang Miao (1):
      serial: txx9: add missing platform_driver_unregister() on error in serial_txx9_init

 drivers/tty/serial/8250/8250_mtk.c |  2 +-
 drivers/tty/serial/Kconfig         |  1 +
 drivers/tty/serial/serial_txx9.c   |  3 +++
 drivers/tty/tty_io.c               |  6 ++++--
 drivers/tty/vt/vt.c                | 24 ++----------------------
 5 files changed, 11 insertions(+), 25 deletions(-)
