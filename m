Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E1A2BC986
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 22:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgKVVSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 16:18:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgKVVSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:18:23 -0500
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAED220782;
        Sun, 22 Nov 2020 21:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606079902;
        bh=bMqEt5m/bNHW93aVOLs03laH0dJyIoDEIpyy+jtqs3U=;
        h=Date:From:To:cc:Subject:From;
        b=JboIWs5qV+zphpmuP3RHi6OJWy2nWglBvfKA2Bupjqx6OiBImgP7lYERWhfwRIlPm
         7RafZlFpHH0NHaJFwhr86Mva7L0MwwpsOr4qOVFmEMWFz+5Q/E4Y2A3tOkZaXTfXGq
         a0s+2T+T/ML/FlknqA6pGOsqNdhZZQK/jE8kqUMU=
Date:   Sun, 22 Nov 2020 22:18:19 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2011222208190.6877@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus


to receive HID subsystem fixes; namely:

=====
- Various functionality / regression fixes for Logitech devices from Hans 
  de Goede
- Fix for (recently added) GPIO support in mcp2221 driver from Lars 
  Povlsen
- Power management handling fix/quirk in i2c-hid driver for certain BIOSes 
  that have strange aproach to power-cycle from Hans de Goede
- a few device ID additions and device-specific quirks
=====

Thanks.

----------------------------------------------------------------
Chris Ye (1):
      HID: add HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE for Gamevice devices

Frank Yang (1):
      HID: cypress: Support Varmilo Keyboards' media hotkeys

Hans de Goede (7):
      HID: ite: Replace ABS_MISC 120/121 events with touchpad on/off keypresses
      HID: i2c-hid: Put ACPI enumerated devices in D3 on shutdown
      HID: logitech-dj: Handle quad/bluetooth keyboards with a builtin trackpad
      HID: logitech-hidpp: Add HIDPP_CONSUMER_VENDOR_KEYS quirk for the Dinovo Edge
      HID: Add Logitech Dinovo Edge battery quirk
      HID: logitech-dj: Fix an error in mse_bluetooth_descriptor
      HID: logitech-dj: Fix Dinovo Mini when paired with a MX5x00 receiver

Harry Cutts (1):
      HID: logitech-hidpp: Add PID for MX Anywhere 2

Jiri Kosina (1):
      HID: add support for Sega Saturn

Lars Povlsen (1):
      HID: mcp2221: Fix GPIO output handling

Martijn van de Streek (1):
      HID: uclogic: Add ID for Trust Flex Design Tablet

Pablo Ceballos (1):
      HID: hid-sensor-hub: Fix issue with devices with no report ID

 drivers/hid/hid-cypress.c          | 44 +++++++++++++++++++++++----
 drivers/hid/hid-ids.h              |  9 ++++++
 drivers/hid/hid-input.c            |  3 ++
 drivers/hid/hid-ite.c              | 61 +++++++++++++++++++++++++++++++++++++-
 drivers/hid/hid-logitech-dj.c      | 22 +++++++++++++-
 drivers/hid/hid-logitech-hidpp.c   | 32 ++++++++++++++++++++
 drivers/hid/hid-mcp2221.c          | 48 ++++++++++++++++++++++++------
 drivers/hid/hid-quirks.c           |  5 ++++
 drivers/hid/hid-sensor-hub.c       |  3 +-
 drivers/hid/hid-uclogic-core.c     |  2 ++
 drivers/hid/hid-uclogic-params.c   |  2 ++
 drivers/hid/i2c-hid/i2c-hid-core.c |  9 ++++++
 12 files changed, 223 insertions(+), 17 deletions(-)

-- 
Jiri Kosina
SUSE Labs

