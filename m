Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679752F6115
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbhANMem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:34:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727986AbhANMel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:34:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B611B23A53;
        Thu, 14 Jan 2021 12:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610627640;
        bh=EdSlPG4RuQzaA2DtueRN4oem+FBAVXvWJBKrOj/ojf8=;
        h=Date:From:To:cc:Subject:From;
        b=DJZuBknLl++nr0wVTc7WLDWuPQigX5aZnNzk1JQD3peUxYArD3PQ492Oz4vZDgJMF
         5BPn7WGCu+LOEsktRC9hqwCzSLlB04apSiGm0dDPUyTIxvGtBds2opS4fEXSmPuQu4
         GX3Hx8+cz+dZ8O8BGinWtTdexAiivWvbd4/kK/xd1F43bLJf/JCFomgmwNapbq8Imd
         /sSmVBHA42V0itODlgi1AVwtSpoZE5fkbNpRuGyG01ugcblKFXCw2qjC4WrVPXkFRk
         azcgXZYfe151i4qpLRlQzGbuw+Q6zwfMtP77M1V/9OaXRbHc4R77k1+dBjdIfNcewJ
         R3+rotT1PsLhw==
Date:   Thu, 14 Jan 2021 13:33:57 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2101141332140.13752@cbobk.fhfr.pm>
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

to receive fixes for HID subsystem;

=====
- memory leak fix for Wacom driver (Ping Cheng)
- various trivial small fixes, cleanups and device ID additions
=====

Thanks.

----------------------------------------------------------------
Arnd Bergmann (2):
      HID: sfh: fix address space confusion
      HID: sony: select CONFIG_CRC32

Filipe Laíns (1):
      HID: logitech-dj: add the G602 receiver

Kai-Heng Feng (1):
      HID: multitouch: Enable multi-input for Synaptics pointstick/touchpad device

Nicholas Miell (1):
      HID: logitech-hidpp: Add product ID for MX Ergo in Bluetooth mode

Ping Cheng (1):
      HID: wacom: Fix memory leakage caused by kfifo_alloc

Seth Miller (1):
      HID: Ignore battery for Elan touchscreen on ASUS UX550

Tom Rix (2):
      HID: uclogic: remove h from printk format specifier
      HID: wiimote: remove h from printk format specifier

 drivers/hid/Kconfig                      |  1 +
 drivers/hid/amd-sfh-hid/amd_sfh_client.c |  8 ++++----
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h    |  2 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c   |  2 +-
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h   |  2 +-
 drivers/hid/hid-ids.h                    |  1 +
 drivers/hid/hid-input.c                  |  2 ++
 drivers/hid/hid-logitech-dj.c            |  4 ++++
 drivers/hid/hid-logitech-hidpp.c         |  2 ++
 drivers/hid/hid-multitouch.c             |  4 ++++
 drivers/hid/hid-uclogic-params.c         |  2 +-
 drivers/hid/hid-wiimote-core.c           |  2 +-
 drivers/hid/wacom_sys.c                  | 35 +++++++++++++++++++++++++++++---
 13 files changed, 55 insertions(+), 12 deletions(-)

-- 
Jiri Kosina
SUSE Labs

