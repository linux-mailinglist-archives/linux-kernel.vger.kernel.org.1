Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D3A2AACE0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgKHSot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728191AbgKHSot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:44:49 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B35A920731;
        Sun,  8 Nov 2020 18:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604861088;
        bh=LXOiMNYM7kGcZAGWndQIk3yHIk7KW8ixrefg31JUDMc=;
        h=Date:From:To:Cc:Subject:From;
        b=xM5ggfq1jcHdOl0gqK0UzDpDZeTUZiFlwBn0oksrLndV5B8WDEbNHjuUVXvqSq53J
         mQfpYt7oe131AyIccj66t1Rw3B/u7H3K0iKzEKyBUY4BECzRHWVYVDCs3CrJDpeWT6
         /BQMo2BhA3bkBIWd2uPmUpCkw8lkz/fetzwuygII=
Date:   Sun, 8 Nov 2020 19:45:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.10-rc3
Message-ID: <20201108184549.GA66721@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3cea11cd5e3b00d91caf0b4730194039b45c5891:

  Linux 5.10-rc2 (2020-11-01 14:43:51 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc3

for you to fetch changes up to db388a6cb7ed986077d3a275712bfc2e28082760:

  Merge tag 'usb-serial-5.10-rc3' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2020-11-07 15:56:37 +0100)

----------------------------------------------------------------
USB fixes for 5.10-rc3

Here are some small USB fixes and new device ids for 5.10-rc3

They include:
	- USB gadget fixes for some reported issues
	- Fixes for the every-troublesome apple fastcharge driver,
	  hopefully we finally have it right.
	- More USB core quirks for odd devices
	- USB serial driver fixes for some long-standing issues that
	  were recently found
	- some new USB serial driver device ids

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: Add NO_LPM quirk for Kingston flash drive

Daniele Palmas (2):
      USB: serial: option: add LE910Cx compositions 0x1203, 0x1230, 0x1231
      USB: serial: option: add Telit FN980 composition 0x1055

Evgeny Novikov (1):
      usb: gadget: goku_udc: fix potential crashes in probe

Greg Kroah-Hartman (2):
      Merge tag 'fixes-for-v5.10-rc2' of git://git.kernel.org/.../balbi/usb into usb-linus
      Merge tag 'usb-serial-5.10-rc3' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Alder Lake-S

Johan Hovold (1):
      USB: serial: cyberjack: fix write-URB completion race

Macpaul Lin (1):
      usb: mtu3: fix panic in mtu3_gadget_stop()

Martin Blumenstingl (1):
      usb: dwc2: Avoid leaving the error_debugfs label unused

Ran Wang (1):
      usb: gadget: fsl: fix null pointer checking

Thinh Nguyen (1):
      usb: dwc3: ep0: Fix delay status handling

Zhang Qilong (1):
      USB: apple-mfi-fastcharge: fix reference leak in apple_mfi_fc_set_property

Ziyi Cao (1):
      USB: serial: option: add Quectel EC200T module support

Zqiang (1):
      usb: raw-gadget: fix memory leak in gadget_setup

 drivers/usb/core/quirks.c               |  3 +++
 drivers/usb/dwc2/platform.c             |  3 +++
 drivers/usb/dwc3/dwc3-pci.c             |  4 ++++
 drivers/usb/dwc3/ep0.c                  |  3 ++-
 drivers/usb/gadget/legacy/raw_gadget.c  |  5 ++++-
 drivers/usb/gadget/udc/fsl_udc_core.c   |  2 +-
 drivers/usb/gadget/udc/goku_udc.c       |  2 +-
 drivers/usb/misc/apple-mfi-fastcharge.c |  4 +++-
 drivers/usb/mtu3/mtu3_gadget.c          |  1 +
 drivers/usb/serial/cyberjack.c          |  7 ++++++-
 drivers/usb/serial/option.c             | 10 ++++++++++
 11 files changed, 38 insertions(+), 6 deletions(-)
