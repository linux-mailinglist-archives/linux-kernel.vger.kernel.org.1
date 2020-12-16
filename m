Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAE32DBF03
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 11:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgLPKv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 05:51:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:32998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgLPKv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 05:51:27 -0500
Date:   Wed, 16 Dec 2020 11:50:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608115846;
        bh=8H8SDZko4TK/AdCpgSyNIeAAsleLrzpqEcl3JM2PCro=;
        h=From:To:cc:Subject:From;
        b=RbYpJseU5rQHCaUuLBYazOi4FiTAI9fWJE1ZVMFQugVKV8IKjv8tfgcVFxR+E2f7i
         metPFVAonaqcmf+legzoNPo666BqXii03s35p/JlEWHUXpBc/ozyoydGXBHD+CO+FJ
         hloqrdoEcv4UbvS6ydbFnLqKXIUNLaKa0uCfwAcGk0hie/MWiDS33s2uG4qjpgSPyS
         dJbegFDSObzqgwugVcED0Shth0JDrFvPV8iDfLXV5FAK6KPiRd0i8V/ea/V0jz9eT8
         YUk9LosqUnrcA4AqjHN5h8xsEOudCTx1YYXAny1lVFFO6kunrnTi/rRiYUSmCFuCY3
         dPMGR99yehrgA==
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 5.11
Message-ID: <nycvar.YFH.7.76.2012161150240.25826@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive 5.11 HID subsystem queue. Highlights:

=====
- AMD SFH (Sensor Fusion Hub) support, from Sandeep Singh
- increase of maximum HID report size to 16KB in order to support
  some of the modern devices, from Dean Camera
- control interface support for hidraw, from Dean Camera
- Sony DS4 power and firmware reporting fixes, from Roderick Colenbrander
- support for ghlive PS3/WII u dongles, from Pascal Giard
=====

Thanks.

----------------------------------------------------------------
Coiby Xu (1):
      HID: i2c-hid: show the error when failing to fetch the HID descriptor

Colin Ian King (1):
      SFH: fix error return check for -ERESTARTSYS

Dean Camera (2):
      HID: Increase HID maximum report size to 16KB
      HID: hidraw: Add additional hidraw input/output report ioctls.

Ethan Warth (1):
      HID: mf: add support for 0079:1846 Mayflash/Dragonrise USB Gamecube Adapter

Gustavo A. R. Silva (2):
      HID: usbhid: Fix fall-through warnings for Clang
      HID: input: Fix fall-through warnings for Clang

Hans de Goede (2):
      HID: logitech-hidpp: Add hid_device_id for V470 bluetooth mouse
      HID: ite: Add support for Acer S1002 keyboard-dock

Jing Xiangfeng (1):
      HID: intel-ish-hid: Remove unnecessary assignment to variable rv

Jiri Kosina (2):
      HID: SFH: Add documentation
      HID: elecom: drop stray comment

Julian Sax (1):
      HID: i2c-hid: add Vero K147 to descriptor override

Luke D Jones (1):
      HID: asus: Add support for ASUS N-Key keyboard

Pascal Giard (1):
      HID: sony: support for ghlive ps3/wii u dongles

Rikard Falkeborn (1):
      HID: wacom: Constify attribute_groups

Roderick Colenbrander (3):
      HID: sony: Report more accurate DS4 power status.
      HID: sony: Don't use fw_version/hw_version for sysfs cleanup.
      HID: sony: Workaround for DS4 dongle hotplug kernel crash.

Sandeep Singh (5):
      SFH: Add maintainers and documentation for AMD SFH based on HID framework
      SFH: PCIe driver to add support of AMD sensor fusion hub
      SFH:Transport Driver to add support of AMD Sensor Fusion Hub (SFH)
      SFH: Create HID report to Enable support of AMD sensor fusion Hub (SFH)
      AMD_SFH: Fix for incorrect Sensor index

YOSHIOKA Takuma (2):
      HID: elecom: rewrite report based on model specific parameters
      HID: elecom: add support for EX-G M-XGL20DLBK wireless mouse

dmitry.torokhov@gmail.com (1):
      HID: hid-input: occasionally report stylus battery even if not changed

 Documentation/hid/amd-sfh-hid.rst                  | 145 +++++
 Documentation/hid/hidraw.rst                       |  45 +-
 Documentation/hid/index.rst                        |   1 +
 MAINTAINERS                                        |   8 +
 drivers/hid/Kconfig                                |   3 +
 drivers/hid/Makefile                               |   2 +
 drivers/hid/amd-sfh-hid/Kconfig                    |  18 +
 drivers/hid/amd-sfh-hid/Makefile                   |  13 +
 drivers/hid/amd-sfh-hid/amd_sfh_client.c           | 246 ++++++++
 drivers/hid/amd-sfh-hid/amd_sfh_hid.c              | 174 ++++++
 drivers/hid/amd-sfh-hid/amd_sfh_hid.h              |  67 +++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c             | 152 +++++
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h             |  79 +++
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c  | 224 +++++++
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h  | 107 ++++
 .../hid_descriptor/amd_sfh_hid_report_desc.h       | 645 +++++++++++++++++++++
 drivers/hid/hid-asus.c                             | 123 +++-
 drivers/hid/hid-elecom.c                           |  51 +-
 drivers/hid/hid-ids.h                              |   7 +
 drivers/hid/hid-input.c                            |   6 +-
 drivers/hid/hid-ite.c                              |  13 +-
 drivers/hid/hid-logitech-hidpp.c                   |   2 +
 drivers/hid/hid-mf.c                               |   2 +
 drivers/hid/hid-quirks.c                           |   3 +
 drivers/hid/hid-sony.c                             | 247 ++++++--
 drivers/hid/hidraw.c                               |  24 +-
 drivers/hid/i2c-hid/i2c-hid-core.c                 |   5 +-
 drivers/hid/i2c-hid/i2c-hid-dmi-quirks.c           |   8 +
 drivers/hid/intel-ish-hid/ishtp-hid.c              |   6 +-
 drivers/hid/usbhid/hid-core.c                      |   2 +
 drivers/hid/wacom_sys.c                            |  16 +-
 include/linux/hid.h                                |   3 +-
 include/uapi/linux/hidraw.h                        |   6 +
 samples/hidraw/hid-example.c                       |   2 +-
 34 files changed, 2360 insertions(+), 95 deletions(-)
 create mode 100644 Documentation/hid/amd-sfh-hid.rst
 create mode 100644 drivers/hid/amd-sfh-hid/Kconfig
 create mode 100644 drivers/hid/amd-sfh-hid/Makefile
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_client.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_hid.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_hid.h
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
 create mode 100644 drivers/hid/amd-sfh-hid/amd_sfh_pcie.h
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.c
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
 create mode 100644 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h

-- 
Jiri Kosina
SUSE Labs

