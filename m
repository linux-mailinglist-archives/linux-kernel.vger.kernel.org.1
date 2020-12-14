Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3664F2D9841
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 13:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439441AbgLNMrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 07:47:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60482 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731521AbgLNMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 07:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607949964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6ggqPRYBF7Q0JcKt3MKlY0PPqFjrmN+MvScHM3hTsNQ=;
        b=WcNmZmoSZTeKcJZNbDRIIz6iTQxIfAGef3ie82FeiPzAyEhkpOF6ZpXcC/p8u1oN3n5YJq
        9rtybg1PJLRUiFp5yRdzYocLxLL8mB8UlVBC9w5ADXv9epmh5ZDMXTu6cbT9oMYOoX/quf
        hrZTl4/Rz5lKYiwGMUX2HuUmST7dyzo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-_pII47xFOZ6r2BziUB1FdQ-1; Mon, 14 Dec 2020 07:43:34 -0500
X-MC-Unique: _pII47xFOZ6r2BziUB1FdQ-1
Received: by mail-ej1-f70.google.com with SMTP id k3so4400785ejr.16
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 04:43:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=6ggqPRYBF7Q0JcKt3MKlY0PPqFjrmN+MvScHM3hTsNQ=;
        b=U1pfpeQNPgdeznaUuwKe08La04Lbn5peHJP22ukZVcMtVZJOVSuGmVNd4rrlYxT05m
         W5yC8jNuina7XF+B8aO07kZY5Rvmz/8qmQct/O0Y5yBxE3ceKObGBtP5e+OHfCYZCcUu
         5K9kb2FnGQs53dvPJVPtKboD06C1uz6exw3wh/GCL7aD6ccsrBAX2ONZNGaqc8YthFov
         oI4LhxKCnmvsYhKEb7u5UqizWS/Mklulmp6qNa+kw2QSfqLn9D7NThHpKXBaxMg6ZleF
         zH5ZlhYNJilKdllvgCQxT1gWl++gFtRaq7vi40uTJWOiEvN5XVkChKrWyqq8fKmPxFsp
         lHNw==
X-Gm-Message-State: AOAM531XWCvz1ACQgvBY1tCwlmnMGHcRGqsrm61TNlilj+/DslqMG0Zt
        4NiSO8TlP46JylxuzTAwg9/4VFoYUtMuK9mr/tSy39dZfRwddEcEf8UZUOcnjfVdWbihwVRfzC0
        Z2E/QeoyKrvJWbjgsOvJvC2yxnV0HGgcbB/Ft2TSk3OMi3GHS5IV3qIA8OJfwrt0TZ2nw5MEJ29
        lP
X-Received: by 2002:a50:d646:: with SMTP id c6mr24322735edj.177.1607949812111;
        Mon, 14 Dec 2020 04:43:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykD2umk3VtYtthFtTZud9pF/E5XDcoiEIWuu1lCTks0srUh6VG6mDruYpDTstEYdrDDKoS+g==
X-Received: by 2002:a50:d646:: with SMTP id c6mr24322696edj.177.1607949811741;
        Mon, 14 Dec 2020 04:43:31 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id t19sm11384705ejc.62.2020.12.14.04.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 04:43:30 -0800 (PST)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.11-1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <f70a7a27-de9d-35aa-53d4-91da3677af6d@redhat.com>
Date:   Mon, 14 Dec 2020 13:43:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the main PDx86 PR for v5.11.

Highlights:
- New driver for changing BIOS settings from within Linux on Dell devices,
  this introduces a new generic sysfs API for this. Lenovo is working on
  also supporting this API on their devices
- New Intel PMT telemetry and crashlog drivers
- AMD SoC PMC driver for improved s2idle support
- acpi_thinkpad palm-sensor support
- Support for SW_TABLET_MODE reporting for the acer-wmi and intel-hid drivers
- Preparation work for improving support for Microsoft Surface hardware
- Various fixes / improvements / quirks for panasonic-laptop and others

Regards,

Hans


The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.11-1

for you to fetch changes up to 0cd3f561efa9adce840140720e0581355db3e554:

  platform/x86: ISST: Mark mmio_range_devid_0 and mmio_range_devid_1 with static keyword (2020-12-08 16:30:55 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v5.11-1

Highlights:
- New driver for changing BIOS settings from within Linux on Dell devices,
  this introduces a new generic sysfs API for this. Lenovo is working on
  also supporting this API on their devices
- New Intel PMT telemetry and crashlog drivers
- Support for SW_TABLET_MODE reporting for the acer-wmi and intel-hid drivers
- Preparation work for improving support for Microsoft Surface hardware
- Various fixes / improvements / quirks for the panasonic-laptop and others

The following is an automated git shortlog grouped by driver:

ISST:
 -  Mark mmio_range_devid_0 and mmio_range_devid_1 with static keyword
 -  Change PCI device macros
 -  Allow configurable offset range
 -  Check for unaligned mmio address

Intel PMT Crashlog capability driver:
 - Intel PMT Crashlog capability driver

Intel PMT Telemetry capability driver:
 - Intel PMT Telemetry capability driver

Intel PMT class driver:
 - Intel PMT class driver

Introduce support for Systems Management Driver over WMI for Dell Systems:
 - Introduce support for Systems Management Driver over WMI for Dell Systems

MAINTAINERS:
 -  new panasonic-laptop maintainer
 -  rectify DELL WMI SYSMAN DRIVERS section

Merge tag 'ib-mfd-x86-v5.11' into review-hans:
 - Merge tag 'ib-mfd-x86-v5.11' into review-hans

PCI:
 -  Add defines for Designated Vendor-Specific Extended Capability

Revert "platform/x86:
 -  wmi: Destroy on cleanup rather than unregister"

acer-wireless:
 -  send an EV_SYN/SYN_REPORT between state changes

acer-wmi:
 -  Add ACER_CAP_KBD_DOCK quirk for the Aspire Switch 10E SW3-016
 -  add automatic keyboard background light toggle key as KEY_LIGHTS_TOGGLE
 -  Add support for SW_TABLET_MODE on Switch devices
 -  Add ACER_CAP_SET_FUNCTION_MODE capability flag
 -  Add new force_caps module parameter
 -  Cleanup accelerometer device handling
 -  Cleanup ACER_CAP_FOO defines
 -  Drop no-op set_quirks call from find_quirks

amd-pmc:
 -  Add AMD platform support for S2Idle

asus-wmi:
 -  Add userspace notification for performance mode change
 -  Add support for SW_TABLET_MODE on UX360

dell-smbios-base:
 -  Fix error return code in dell_smbios_init

dell-wmi-sysman:
 -  work around for BIOS bug
 -  fix init_bios_attributes() error handling

docs:
 -  ABI: sysfs-class-firmware-attributes: solve some warnings

i2c-multi-instantiate:
 -  Use device_get_match_data() to get driver data
 -  Simplify with dev_err_probe()
 -  Drop redundant ACPI_PTR()

intel-hid:
 -  add Rocket Lake ACPI device ID
 -  Do not create SW_TABLET_MODE input-dev when a KIOX010A ACPI dev is present
 -  Add alternative method to enable switches
 -  Add support for SW_TABLET_MODE
 -  fix _DSM function index handling

intel-vbtn:
 -  Fix SW_TABLET_MODE always reporting 1 on some HP x360 models
 -  Allow switch events on Acer Switch Alpha 12
 -  Support for tablet mode on HP Pavilion 13 x360 PC

intel_pmc_core:
 -  Assign boolean values to a bool variable

mfd:
 -  Intel Platform Monitoring Technology support

mlx-platform:
 -  Fix item counter assignment for MSN2700/ComEx system
 -  Fix item counter assignment for MSN2700, MSN24xx systems
 -  remove an unused variable
 -  Remove PSU EEPROM from MSN274x platform configuration
 -  Remove PSU EEPROM from default platform configuration

panasonic-laptop:
 -  Add sysfs attributes for firmware brightness registers
 -  Add support for battery charging threshold (eco mode)
 -  Resolve hotkey double trigger bug
 -  Add write support to mute
 -  Fix sticky key init bug
 -  Fix naming of platform files for consistency with other modules
 -  Split MODULE_AUTHOR() by one author per macro call
 -  Replace ACPI prints with pr_*() macros
 -  Add support for optical driver power in Y and W series

platform:
 -  Add Surface platform directory

platform/mellanox:
 -  mlxbf-pmc: Add Mellanox BlueField PMC driver

platform/surface:
 -  gpe: Add support for 15" Intel version of Surface Laptop 3
 -  Add Driver to set up lid GPEs on MS Surface device
 -  Move Surface Pro 3 Button driver to platform/surface
 -  Move Surface 3 Power OpRegion driver to platform/surface
 -  Move Surface 3 Button driver to platform/surface
 -  Move Surface 3 WMI driver to platform/surface

platform/x86/dell-wmi-sysman:
 -  Make some symbols static
 -  Make wmi_sysman_kobj_sysfs_ops static

pmt:
 -  Fix a potential Oops on error in probe

remove unneeded break:
 - remove unneeded break

thinkpad_acpi:
 -  remove trailing semicolon in macro definition
 -  Whitelist P15 firmware for dual fan control
 -  Add palm sensor support
 -  Send tablet mode switch at wakeup time
 -  Add BAT1 is primary battery quirk for Thinkpad Yoga 11e 4th gen
 -  Do not report SW_TABLET_MODE on Yoga 11e
 -  add P1 gen3 second fan support

tools/power/x86/intel-speed-select:
 -  Update version for v5.11
 -  Account for missing sysfs for die_id
 -  Read TRL from mailbox

toshiba_acpi:
 -  Fix the wrong variable assignment

touchscreen_dmi:
 -  Add info for the Irbis TW118 tablet
 -  Add info for the Predia Basic tablet

x86/platform:
 -  classmate-laptop: add WiFi media button

----------------------------------------------------------------
Alex Hung (1):
      platform/x86: intel-hid: add Rocket Lake ACPI device ID

Alexander Duyck (3):
      platform/x86: Intel PMT class driver
      platform/x86: Intel PMT Telemetry capability driver
      platform/x86: Intel PMT Crashlog capability driver

Andy Shevchenko (3):
      platform/x86: i2c-multi-instantiate: Drop redundant ACPI_PTR()
      platform/x86: i2c-multi-instantiate: Simplify with dev_err_probe()
      platform/x86: i2c-multi-instantiate: Use device_get_match_data() to get driver data

Arnd Bergmann (1):
      platform/x86: mlx-platform: remove an unused variable

Benjamin Berg (1):
      platform/x86: thinkpad_acpi: Send tablet mode switch at wakeup time

Carlo Caione (1):
      x86/platform: classmate-laptop: add WiFi media button

Carlos Garnacho (1):
      platform/x86: intel-vbtn: Allow switch events on Acer Switch Alpha 12

Dan Carpenter (2):
      platform/x86: dell-wmi-sysman: fix init_bios_attributes() error handling
      platform/x86: pmt: Fix a potential Oops on error in probe

Daniel Drake (1):
      acer-wireless: send an EV_SYN/SYN_REPORT between state changes

David E. Box (2):
      PCI: Add defines for Designated Vendor-Specific Extended Capability
      mfd: Intel Platform Monitoring Technology support

Divya Bharathi (2):
      platform/x86: Introduce support for Systems Management Driver over WMI for Dell Systems
      platform/x86: dell-wmi-sysman: work around for BIOS bug

Elia Devito (2):
      platform/x86: intel-hid: Add support for SW_TABLET_MODE
      platform/x86: intel-hid: Add alternative method to enable switches

Hans de Goede (14):
      platform/x86: touchscreen_dmi: Add info for the Predia Basic tablet
      platform/x86: acer-wmi: Drop no-op set_quirks call from find_quirks
      platform/x86: acer-wmi: Cleanup ACER_CAP_FOO defines
      platform/x86: acer-wmi: Cleanup accelerometer device handling
      platform/x86: acer-wmi: Add new force_caps module parameter
      platform/x86: acer-wmi: Add ACER_CAP_SET_FUNCTION_MODE capability flag
      platform/x86: acer-wmi: Add support for SW_TABLET_MODE on Switch devices
      Merge tag 'ib-mfd-x86-v5.11' into review-hans
      platform/x86: thinkpad_acpi: Do not report SW_TABLET_MODE on Yoga 11e
      platform/x86: thinkpad_acpi: Add BAT1 is primary battery quirk for Thinkpad Yoga 11e 4th gen
      platform/x86: acer-wmi: Add ACER_CAP_KBD_DOCK quirk for the Aspire Switch 10E SW3-016
      platform/x86: touchscreen_dmi: Add info for the Irbis TW118 tablet
      platform/x86: intel-vbtn: Fix SW_TABLET_MODE always reporting 1 on some HP x360 models
      platform/x86: intel-hid: Do not create SW_TABLET_MODE input-dev when a KIOX010A ACPI dev is present

Iakov 'Jake' Kirilenko (1):
      platform/x86: thinkpad_acpi: add P1 gen3 second fan support

Kaixu Xia (2):
      platform/x86: intel_pmc_core: Assign boolean values to a bool variable
      platform/x86: toshiba_acpi: Fix the wrong variable assignment

Kenneth Chan (10):
      platform/x86: panasonic-laptop: Add support for optical driver power in Y and W series
      platform/x86: panasonic-laptop: Replace ACPI prints with pr_*() macros
      platform/x86: panasonic-laptop: Split MODULE_AUTHOR() by one author per macro call
      platform/x86: panasonic-laptop: Fix naming of platform files for consistency with other modules
      platform/x86: panasonic-laptop: Fix sticky key init bug
      platform/x86: panasonic-laptop: Add write support to mute
      platform/x86: panasonic-laptop: Resolve hotkey double trigger bug
      platform/x86: panasonic-laptop: Add support for battery charging threshold (eco mode)
      platform/x86: panasonic-laptop: Add sysfs attributes for firmware brightness registers
      MAINTAINERS: new panasonic-laptop maintainer

Lukas Bulwahn (1):
      MAINTAINERS: rectify DELL WMI SYSMAN DRIVERS section

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Add palm sensor support

Matthias Maier (1):
      platform/x86: thinkpad_acpi: Whitelist P15 firmware for dual fan control

Mauro Carvalho Chehab (1):
      docs: ABI: sysfs-class-firmware-attributes: solve some warnings

Max Verevkin (1):
      platform/x86: intel-vbtn: Support for tablet mode on HP Pavilion 13 x360 PC

Maximilian Luz (7):
      platform: Add Surface platform directory
      platform/surface: Move Surface 3 WMI driver to platform/surface
      platform/surface: Move Surface 3 Button driver to platform/surface
      platform/surface: Move Surface 3 Power OpRegion driver to platform/surface
      platform/surface: Move Surface Pro 3 Button driver to platform/surface
      platform/surface: Add Driver to set up lid GPEs on MS Surface device
      platform/surface: gpe: Add support for 15" Intel version of Surface Laptop 3

Qinglang Miao (1):
      platform/x86: dell-smbios-base: Fix error return code in dell_smbios_init

Samuel Čavoj (1):
      platform/x86: asus-wmi: Add support for SW_TABLET_MODE on UX360

Shravan Kumar Ramani (1):
      platform/mellanox: mlxbf-pmc: Add Mellanox BlueField PMC driver

Shyam Sundar S K (1):
      platform/x86: amd-pmc: Add AMD platform support for S2Idle

Srinivas Pandruvada (6):
      platform/x86: ISST: Check for unaligned mmio address
      platform/x86: ISST: Allow configurable offset range
      platform/x86: ISST: Change PCI device macros
      tools/power/x86/intel-speed-select: Read TRL from mailbox
      tools/power/x86/intel-speed-select: Account for missing sysfs for die_id
      tools/power/x86/intel-speed-select: Update version for v5.11

Timo Witte (1):
      platform/x86: acer-wmi: add automatic keyboard background light toggle key as KEY_LIGHTS_TOGGLE

Tom Rix (2):
      platform/x86: remove unneeded break
      platform/x86: thinkpad_acpi: remove trailing semicolon in macro definition

Vadim Pasternak (4):
      platform/x86: mlx-platform: Remove PSU EEPROM from default platform configuration
      platform/x86: mlx-platform: Remove PSU EEPROM from MSN274x platform configuration
      platform/x86: mlx-platform: Fix item counter assignment for MSN2700, MSN24xx systems
      platform/x86: mlx-platform: Fix item counter assignment for MSN2700/ComEx system

Vasiliy Kupriakov (1):
      platform/x86: asus-wmi: Add userspace notification for performance mode change

Yongxin Liu (1):
      Revert "platform/x86: wmi: Destroy on cleanup rather than unregister"

Zhen Gong (1):
      platform/x86: intel-hid: fix _DSM function index handling

Zou Wei (3):
      platform/x86/dell-wmi-sysman: Make wmi_sysman_kobj_sysfs_ops static
      platform/x86/dell-wmi-sysman: Make some symbols static
      platform/x86: ISST: Mark mmio_range_devid_0 and mmio_range_devid_1 with static keyword

 .../ABI/testing/sysfs-class-firmware-attributes    |  258 ++++
 Documentation/ABI/testing/sysfs-class-intel_pmt    |  119 ++
 MAINTAINERS                                        |   40 +-
 drivers/mfd/Kconfig                                |   10 +
 drivers/mfd/Makefile                               |    1 +
 drivers/mfd/intel_pmt.c                            |  223 +++
 drivers/platform/Kconfig                           |    2 +
 drivers/platform/Makefile                          |    1 +
 drivers/platform/mellanox/Kconfig                  |   10 +
 drivers/platform/mellanox/Makefile                 |    1 +
 drivers/platform/mellanox/mlxbf-pmc.c              | 1478 ++++++++++++++++++++
 drivers/platform/surface/Kconfig                   |   59 +
 drivers/platform/surface/Makefile                  |   11 +
 drivers/platform/{x86 => surface}/surface3-wmi.c   |    0
 .../platform/{x86 => surface}/surface3_button.c    |    0
 drivers/platform/{x86 => surface}/surface3_power.c |    0
 drivers/platform/surface/surface_gpe.c             |  321 +++++
 .../platform/{x86 => surface}/surfacepro3_button.c |    0
 drivers/platform/x86/Kconfig                       |   91 +-
 drivers/platform/x86/Makefile                      |   13 +-
 drivers/platform/x86/acer-wireless.c               |    1 +
 drivers/platform/x86/acer-wmi.c                    |  176 ++-
 drivers/platform/x86/amd-pmc.c                     |  286 ++++
 drivers/platform/x86/asus-nb-wmi.c                 |   15 +
 drivers/platform/x86/asus-wmi.c                    |   48 +
 drivers/platform/x86/asus-wmi.h                    |    1 +
 drivers/platform/x86/classmate-laptop.c            |    2 +
 drivers/platform/x86/dell-smbios-base.c            |    1 +
 drivers/platform/x86/dell-wmi-sysman/Makefile      |    8 +
 .../x86/dell-wmi-sysman/biosattr-interface.c       |  186 +++
 .../platform/x86/dell-wmi-sysman/dell-wmi-sysman.h |  191 +++
 .../platform/x86/dell-wmi-sysman/enum-attributes.c |  189 +++
 .../platform/x86/dell-wmi-sysman/int-attributes.c  |  179 +++
 .../x86/dell-wmi-sysman/passobj-attributes.c       |  187 +++
 .../x86/dell-wmi-sysman/passwordattr-interface.c   |  153 ++
 .../x86/dell-wmi-sysman/string-attributes.c        |  159 +++
 drivers/platform/x86/dell-wmi-sysman/sysman.c      |  627 +++++++++
 drivers/platform/x86/i2c-multi-instantiate.c       |   14 +-
 drivers/platform/x86/intel-hid.c                   |  140 +-
 drivers/platform/x86/intel-vbtn.c                  |   24 +-
 drivers/platform/x86/intel_pmc_core.c              |    2 +-
 drivers/platform/x86/intel_pmt_class.c             |  298 ++++
 drivers/platform/x86/intel_pmt_class.h             |   52 +
 drivers/platform/x86/intel_pmt_crashlog.c          |  328 +++++
 drivers/platform/x86/intel_pmt_telemetry.c         |  160 +++
 .../x86/intel_speed_select_if/isst_if_common.h     |    8 +-
 .../x86/intel_speed_select_if/isst_if_mbox_pci.c   |    4 +-
 .../x86/intel_speed_select_if/isst_if_mmio.c       |   49 +-
 drivers/platform/x86/mlx-platform.c                |   33 +-
 drivers/platform/x86/panasonic-laptop.c            |  509 ++++++-
 drivers/platform/x86/sony-laptop.c                 |    3 -
 drivers/platform/x86/thinkpad_acpi.c               |  177 ++-
 drivers/platform/x86/toshiba_acpi.c                |    3 +-
 drivers/platform/x86/touchscreen_dmi.c             |   50 +
 drivers/platform/x86/wmi.c                         |    7 +-
 include/linux/platform_data/x86/asus-wmi.h         |    1 +
 include/uapi/linux/pci_regs.h                      |    5 +
 tools/power/x86/intel-speed-select/isst-config.c   |    8 +-
 tools/power/x86/intel-speed-select/isst-core.c     |    2 +-
 tools/power/x86/intel-speed-select/isst.h          |    1 +
 60 files changed, 6665 insertions(+), 260 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-firmware-attributes
 create mode 100644 Documentation/ABI/testing/sysfs-class-intel_pmt
 create mode 100644 drivers/mfd/intel_pmt.c
 create mode 100644 drivers/platform/mellanox/mlxbf-pmc.c
 create mode 100644 drivers/platform/surface/Kconfig
 create mode 100644 drivers/platform/surface/Makefile
 rename drivers/platform/{x86 => surface}/surface3-wmi.c (100%)
 rename drivers/platform/{x86 => surface}/surface3_button.c (100%)
 rename drivers/platform/{x86 => surface}/surface3_power.c (100%)
 create mode 100644 drivers/platform/surface/surface_gpe.c
 rename drivers/platform/{x86 => surface}/surfacepro3_button.c (100%)
 create mode 100644 drivers/platform/x86/amd-pmc.c
 create mode 100644 drivers/platform/x86/dell-wmi-sysman/Makefile
 create mode 100644 drivers/platform/x86/dell-wmi-sysman/biosattr-interface.c
 create mode 100644 drivers/platform/x86/dell-wmi-sysman/dell-wmi-sysman.h
 create mode 100644 drivers/platform/x86/dell-wmi-sysman/enum-attributes.c
 create mode 100644 drivers/platform/x86/dell-wmi-sysman/int-attributes.c
 create mode 100644 drivers/platform/x86/dell-wmi-sysman/passobj-attributes.c
 create mode 100644 drivers/platform/x86/dell-wmi-sysman/passwordattr-interface.c
 create mode 100644 drivers/platform/x86/dell-wmi-sysman/string-attributes.c
 create mode 100644 drivers/platform/x86/dell-wmi-sysman/sysman.c
 create mode 100644 drivers/platform/x86/intel_pmt_class.c
 create mode 100644 drivers/platform/x86/intel_pmt_class.h
 create mode 100644 drivers/platform/x86/intel_pmt_crashlog.c
 create mode 100644 drivers/platform/x86/intel_pmt_telemetry.c

