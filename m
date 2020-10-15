Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C51628F8E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 20:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391093AbgJOSwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 14:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391088AbgJOSwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 14:52:41 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D0C221527;
        Thu, 15 Oct 2020 18:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602787960;
        bh=CE15LjRnhykVbExyoSlNN0OVh0Yp9xo9xl2GMjmJSl0=;
        h=Date:From:To:cc:Subject:From;
        b=URkPMyrBgJL2GkrNaITxiKgsb4WMCWDOWxV8+7FQy4yxxmDcugSI2yWLP+gCrOu4N
         nICUjeWGCkEyywPmqXP2aQoLgFFmEq//mQU7NF8LqkTmedZYfhG6nUN6Y9iEwT1s6O
         F9EXRaceCT5PM2KwxxMOKw+sn2DpIagG+Z/RLqGU=
Date:   Thu, 15 Oct 2020 20:52:36 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 5.10
Message-ID: <nycvar.YFH.7.76.2010152048140.18859@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID subsystem queue for 5.10. Highlights:

=====
- Lenovo X1 Tablet support improvements from Mikael Wikström
- "heartbeat" report fix for several Wacom devices from Jason Gerecke
- bounds checking fix in hid-roccat from Dan Carpenter
- stylus battery reporting fix from Dmitry Torokhov
- i2c-hid support for wakeup from suspend-to-idle from Kai-Heng Feng
- new driver for Vivaldi devices from Sean O'Brien
- other assorted small fixes and device ID additions
=====

Thanks.

----------------------------------------------------------------
BALATON Zoltan (1):
      HID: apple: Add support for Matias wireless keyboard

Colin Ian King (1):
      HID: alps: clean up indentation issue

Dan Carpenter (1):
      HID: roccat: add bounds checking in kone_sysfs_write_settings()

Dmitry Torokhov (1):
      HID: hid-input: fix stylus battery reporting

Douglas Anderson (1):
      HID: i2c-hid: Prefer asynchronous probe

Hans de Goede (1):
      HID: ite: Add USB id match for Acer One S1003 keyboard dock

Ian Abbott (2):
      HID: wiimote: make handlers[] const
      HID: wiimote: narrow spinlock range in wiimote_hid_event()

Jason Gerecke (1):
      HID: wacom: Avoid entering wacom_wac_pen_report for pad / battery

Kai-Heng Feng (1):
      HID: i2c-hid: Enable wakeup capability from Suspend-to-Idle

Laurent Gauthier (1):
      HID: hid-debug: fix nonblocking read semantics wrt EIO/ERESTARTSYS

Linus Walleij (1):
      HID: cp2112: Use irqchip template

Mikael Wikström (2):
      HID: multitouch: Lenovo X1 Tablet Gen3 trackpoint and buttons
      HID: multitouch: Lenovo X1 Tablet Gen2 trackpoint and buttons

Qinglang Miao (1):
      HID: intel-ish-hid: simplify the return expression of ishtp_bus_remove_device()

Sean O'Brien (1):
      HID: add vivaldi HID driver

Xiaofei Tan (2):
      HID: core: fix kerneldoc warnings in hid-core.c
      HID: i2c-hid: fix kerneldoc warnings in i2c-hid-core.c

 drivers/hid/Kconfig                   |   9 +++
 drivers/hid/Makefile                  |   1 +
 drivers/hid/hid-alps.c                |   2 +-
 drivers/hid/hid-apple.c               |   2 +
 drivers/hid/hid-core.c                |  15 +++-
 drivers/hid/hid-cp2112.c              |  19 ++---
 drivers/hid/hid-debug.c               |  10 +--
 drivers/hid/hid-ids.h                 |   3 +
 drivers/hid/hid-input.c               |   4 +-
 drivers/hid/hid-ite.c                 |   4 +
 drivers/hid/hid-multitouch.c          |  12 +++
 drivers/hid/hid-roccat-kone.c         |  23 ++++--
 drivers/hid/hid-vivaldi.c             | 144 ++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote-core.c        |  10 +--
 drivers/hid/i2c-hid/i2c-hid-core.c    |  15 +++-
 drivers/hid/intel-ish-hid/ishtp/bus.c |   8 +-
 drivers/hid/wacom_wac.c               |   4 +-
 include/linux/hid.h                   |   2 +
 18 files changed, 244 insertions(+), 43 deletions(-)
 create mode 100644 drivers/hid/hid-vivaldi.c

-- 
Jiri Kosina
SUSE Labs

