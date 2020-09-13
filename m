Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B360267ED1
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 10:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgIMIkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 04:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgIMIkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 04:40:23 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95194207C3;
        Sun, 13 Sep 2020 08:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599986423;
        bh=nkOkHmUG9ZCpI51sdLBC63sJIZFR7gM0zcVLDsrsFjs=;
        h=Date:From:To:Cc:Subject:From;
        b=ERGW9DQ6D1XKu5HK78vNiKWhRAj+EgVjnaebVeUFr8hB9EVc0JoBM60dn6Zc9NORo
         XWmIB9Gw4f3UGTo1n/YYcYyxeMW43+pI5AWeDMid8z3UdPbxGETkciW/fpFJUutHmd
         0ut7hiOk3In6oT1XaqgvtttxaX1wWxFZS+c51Gfw=
Date:   Sun, 13 Sep 2020 10:40:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt fixes for 5.9-rc5
Message-ID: <20200913084024.GA907010@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc5

for you to fetch changes up to a29c0adbb688ddee61b731804fb360898412fe7e:

  Merge tag 'usb-serial-5.9-rc5' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2020-09-08 17:50:58 +0200)

----------------------------------------------------------------
USB/Thunderbolt fixes for 5.9-rc5

Here are some small USB and Thunderbolt driver fixes for 5.9-rc5.

Nothing huge, just a number of bugfixes and new device ids for problems
reported:
	- new USB serial driver ids
	- bug fixes for syzbot reported problems
	- typec driver fixes
	- thunderbolt driver fixes
	- revert of reported broken commit

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aleksander Morgado (1):
      USB: serial: option: add support for SIM7070/SIM7080/SIM7090 modules

Amjad Ouled-Ameur (1):
      Revert "usb: dwc3: meson-g12a: fix shared reset control use"

Bjørn Mork (1):
      USB: serial: option: support dynamic Quectel USB compositions

Greg Kroah-Hartman (2):
      Merge tag 'thunderbolt-for-v5.9-rc4' of git://git.kernel.org/.../westeri/thunderbolt into usb-linus
      Merge tag 'usb-serial-5.9-rc5' of https://git.kernel.org/.../johan/usb-serial into usb-linus

Heikki Krogerus (1):
      usb: typec: ucsi: acpi: Check the _DEP dependencies

Madhusudanarao Amara (1):
      usb: typec: intel_pmc_mux: Un-register the USB role switch

Mathias Nyman (1):
      usb: Fix out of sync data toggle if a configured device is reconfigured

Mika Westerberg (1):
      thunderbolt: Use maximum USB3 link rate when reclaiming if link is not up

Nikunj A. Dadhania (1):
      thunderbolt: Disable ports that are not implemented

Patrick Riphagen (1):
      USB: serial: ftdi_sio: add IDs for Xsens Mti USB converter

Utkarsh Patel (2):
      usb: typec: intel_pmc_mux: Do not configure Altmode HPD High
      usb: typec: intel_pmc_mux: Do not configure SBU and HSL Orientation in Alternate modes

Zeng Tao (1):
      usb: core: fix slab-out-of-bounds Read in read_descriptors

 drivers/thunderbolt/switch.c          |  1 +
 drivers/thunderbolt/tb.h              |  2 +-
 drivers/thunderbolt/tunnel.c          | 12 ++++-
 drivers/usb/core/message.c            | 91 ++++++++++++++++-------------------
 drivers/usb/core/sysfs.c              |  5 ++
 drivers/usb/dwc3/dwc3-meson-g12a.c    | 15 +++---
 drivers/usb/serial/ftdi_sio.c         |  1 +
 drivers/usb/serial/ftdi_sio_ids.h     |  1 +
 drivers/usb/serial/option.c           | 22 ++++++---
 drivers/usb/typec/mux/intel_pmc_mux.c | 14 +-----
 drivers/usb/typec/ucsi/ucsi_acpi.c    |  4 ++
 11 files changed, 87 insertions(+), 81 deletions(-)
