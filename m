Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3982824BF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgJCO0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgJCO0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:26:07 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F29EE206B8;
        Sat,  3 Oct 2020 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601735166;
        bh=2nOPF4EOCcanEina9U8+kv9YWJwUQ3G0BitfdrDMnbc=;
        h=Date:From:To:Cc:Subject:From;
        b=cqd13kJotJ2DyUeSNiVxFHXReSdKSq5zGm1YBydC1b7WjWhJSyj+M3lw/SlbMFCEE
         zGYBcAHGbuCDDQmUKzrOt+5G6U7meinrzHbbCt00G9MjjL8Mcrw2mctacOjDklQLeL
         yxB3xs5ak7OyqffO7TAolAifE7EuIDR4WWPKsUB8=
Date:   Sat, 3 Oct 2020 16:26:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/PHY driver fixes for 5.9-rc8
Message-ID: <20201003142651.GA794077@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a31128384dfd9ca11f15ef4ea73df25e394846d1:

  Merge tag 'libnvdimm-fixes-5.9-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm (2020-09-21 08:46:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc8

for you to fetch changes up to 25b9e4b31ed5724b1f37a8a46fd50c6bafa6745c:

  Merge tag 'phy-fixes-2-5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy into usb-linus (2020-09-29 17:21:54 +0200)

----------------------------------------------------------------
USB/PHY fixes for 5.9-rc8

Here are some small USB and PHY driver fixes for 5.9-rc8

The PHY driver fix resolves an issue found by Dan Carpenter for a memory
leak.

The USB fixes fall into two groups:
	- usb gadget fix from Bryan that is a fix for a previous
	  security fix that showed up in in-the-wild testing
	- usb core driver matching bugfixes.  This fixes a bug that has
	  plagued the both the usbip driver and syzbot testing tools
	  this -rc release cycle.  All is now working properly so usbip
	  connections will work, and syzbot can get back to fuzzing USB
	  drivers properly.

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Bryan O'Donoghue (1):
      USB: gadget: f_ncm: Fix NDP16 datagram validation

Dan Carpenter (1):
      phy: ti: am654: Fix a leak in serdes_am654_probe()

Greg Kroah-Hartman (1):
      Merge tag 'phy-fixes-2-5.9' of git://git.kernel.org/.../phy/linux-phy into usb-linus

M. Vefa Bicakci (4):
      Revert "usbip: Implement a match function to fix usbip"
      usbcore/driver: Fix specific driver selection
      usbcore/driver: Fix incorrect downcast
      usbcore/driver: Accommodate usbip

 drivers/phy/ti/phy-am654-serdes.c   |  6 +++--
 drivers/usb/core/driver.c           | 50 +++++++++++++++++++++++++------------
 drivers/usb/gadget/function/f_ncm.c | 30 ++--------------------
 drivers/usb/usbip/stub_dev.c        |  6 -----
 4 files changed, 40 insertions(+), 52 deletions(-)
