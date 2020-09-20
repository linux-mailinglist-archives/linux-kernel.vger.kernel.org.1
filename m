Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EFA27148C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 15:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgITN2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 09:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgITN2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 09:28:05 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E8DD2220C;
        Sun, 20 Sep 2020 13:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600608484;
        bh=u8RCC0R3r+tetpcJh+PF/KNlzTKwwzGUVErVKwaocy0=;
        h=Date:From:To:Cc:Subject:From;
        b=01mr5jXNV1egtLQSqAlD/CYaNZ13Gmrdyk2RQ7dXYGSvx78G65jQjCWlKpX+cI6yS
         qCt2JGBeW4HHchKg68HwNWKaI1r8YMYzpeqYhGSbIxsqEz45yhJ9eoHx78KB0alPl4
         jUMwcis8nHTPmuZCRsrX7/bzSD/Uicg5E7moh1/A=
Date:   Sun, 20 Sep 2020 15:28:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt fixes for 5.9-rc6
Message-ID: <20200920132830.GA2845084@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc6

for you to fetch changes up to 9cdabcb3ef8c24ca3a456e4db7b012befb688e73:

  usblp: fix race between disconnect() and read() (2020-09-17 18:45:30 +0200)

----------------------------------------------------------------
USB/Thunderbolt fixes for 5.9-rc6

Here are some small USB and one Thunderbolt driver fixes for 5.9-rc6.

Nothing major at all, just some fixes for reported issues, and a quirk
addition:
	- typec fixes
	- UAS disconnect fix
	- usblp race fix
	- ehci-hcd modversions build fix
	- ignore wakeup quirk table addition
	- thunderbolt DROM read fix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Merge tag 'thunderbolt-for-v5.9-rc6' of git://git.kernel.org/.../westeri/thunderbolt into usb-linus

Heikki Krogerus (2):
      usb: typec: ucsi: acpi: Increase command completion timeout value
      usb: typec: ucsi: Prevent mode overrun

Madhusudanarao Amara (1):
      usb: typec: intel_pmc_mux: Handle SCU IPC error conditions

Mika Westerberg (1):
      thunderbolt: Retry DROM read once if parsing fails

Oliver Neukum (2):
      USB: UAS: fix disconnect by unplugging a hub
      usblp: fix race between disconnect() and read()

Penghao (1):
      USB: quirks: Add USB_QUIRK_IGNORE_REMOTE_WAKEUP quirk for BYD zhaoxin notebook

Quentin Perret (1):
      ehci-hcd: Move include to keep CRC stable

 drivers/thunderbolt/eeprom.c          | 20 ++++++++++++++++----
 drivers/usb/class/usblp.c             |  5 +++++
 drivers/usb/core/quirks.c             |  4 ++++
 drivers/usb/host/ehci-hcd.c           |  1 +
 drivers/usb/host/ehci-hub.c           |  1 -
 drivers/usb/storage/uas.c             | 14 ++++++++++++--
 drivers/usb/typec/mux/intel_pmc_mux.c | 12 +++++++++---
 drivers/usb/typec/ucsi/ucsi.c         | 22 ++++++++++++++++------
 drivers/usb/typec/ucsi/ucsi_acpi.c    |  2 +-
 9 files changed, 64 insertions(+), 17 deletions(-)
