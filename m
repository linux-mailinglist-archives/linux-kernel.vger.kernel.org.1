Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E4D2FFF41
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 10:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbhAVJdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 04:33:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727310AbhAVJKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611306481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ddpi9v07wV/AhLbJYSpwqzGNlmkQGjXAyksWXeHHSp0=;
        b=iMVPWaVGD78lDsSZMl5Js0Ivr9h0vpvEFjsMEVyaEwaCso8Gr6OHuv3xjIFHxPBba2dlCt
        IkS5pRm4SexxX51KkN92vbBPZ7+w09+v4kMu+tiYkU1St8EaJwG6Nckoe7gASffVu0I7Kl
        2zb6hJ2E2gHjestTv7ISr6z7k2jTFt8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-5-FGnahaMPiBKI21Fw3_oA-1; Fri, 22 Jan 2021 04:03:02 -0500
X-MC-Unique: 5-FGnahaMPiBKI21Fw3_oA-1
Received: by mail-ed1-f72.google.com with SMTP id m16so2586664edd.21
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 01:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Ddpi9v07wV/AhLbJYSpwqzGNlmkQGjXAyksWXeHHSp0=;
        b=bu6aHBtsrJAQ4I/qM97bPSx595QWrGph78lvvwTOCurZM110eNyeuamRuiXvtDG5cI
         u21zBRQqGsIhj4+v1BZIKp9rRYCfsGu09Z4yBPuDox6TWHxtNUapRRAQO2iSou+n977p
         HkGqIpy/zAXbIfufOJurxwKB/eOv7lczzr9mFbG7houq1+6gMGN5McqzM11hci3/TM4H
         0aLUyHPgZ2/UQ6BbB7YZuxhS3/JHUP9ac3IbvFR5DlO6HvXlc1bTIRXOMXQ1GWf3elN6
         x5Xcq21MJzLrK51MyPXjWqU5xICRXJTGDxIs81p16Zt9pCKO59bq7IskwbF8MLiWVN/Z
         ZAyQ==
X-Gm-Message-State: AOAM531VRs/oxVsyLhkVrYGbnJ0nZmVrPaNqiYDJxHw7YzwoVQ40ml5H
        0pSh5eWvmbpuNbcLjGoUol4VImL7Nf8HWHmu46bHrpvhgims+BchTGIkUbwc52+PZP0fYeoIac8
        iCpwxsAgmjY0VXa5axwG+E5rB
X-Received: by 2002:a17:906:80c9:: with SMTP id a9mr2204122ejx.78.1611306181172;
        Fri, 22 Jan 2021 01:03:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx507lcD0kpAGAsWq88KhO4fn9FR4WmU2PkF+TMpblJPUWd/iMpnd9vZQafbOfG7+2covQkeg==
X-Received: by 2002:a17:906:80c9:: with SMTP id a9mr2204116ejx.78.1611306181016;
        Fri, 22 Jan 2021 01:03:01 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
        by smtp.gmail.com with ESMTPSA id w18sm3903189ejq.59.2021.01.22.01.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 01:03:00 -0800 (PST)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.11-2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Message-ID: <ac7b0183-fda1-754f-f65c-e390ef147c89@redhat.com>
Date:   Fri, 22 Jan 2021 10:02:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a set of small, straight-forward fixes and some model specific
quirks for platform-drivers-x86 for 5.11.

Regards,

Hans


The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.11-2

for you to fetch changes up to 173aac2fef96972e42d33c0e1189e6f756a0d719:

  platform/x86: thinkpad_acpi: Add P53/73 firmware to fan_quirk_table for dual fan control (2021-01-18 21:42:01 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v5.11-2

A small collection of bug-fixes and model-specific quirks for 5.11.

The following is an automated git shortlog grouped by driver:

amd-pmc:
 -  Fix CONFIG_DEBUG_FS check

hp-wmi:
 -  Don't log a warning on HPWMI_RET_UNKNOWN_COMMAND errors

i2c-multi-instantiate:
 -  Don't create platform device for INT3515 ACPI nodes

ideapad-laptop:
 -  Disable touchpad_switch for ELAN0634

intel-vbtn:
 -  Drop HP Stream x360 Convertible PC 11 from allow-list
 -  Support for tablet mode on Dell Inspiron 7352

platform/surface:
 -  SURFACE_PLATFORMS should depend on ACPI
 -  surface_gpe: Fix non-PM_SLEEP build warnings

thinkpad_acpi:
 -  Add P53/73 firmware to fan_quirk_table for dual fan control
 -  correct palmsensor error checking

tools/power/x86/intel-speed-select:
 -  Set higher of cpuinfo_max_freq or base_frequency
 -  Set scaling_max_freq to base_frequency

touchscreen_dmi:
 -  Add swap-x-y quirk for Goodix touchscreen on Estar Beauty HD tablet

----------------------------------------------------------------
Arnold Gozum (1):
      platform/x86: intel-vbtn: Support for tablet mode on Dell Inspiron 7352

Geert Uytterhoeven (1):
      platform/surface: SURFACE_PLATFORMS should depend on ACPI

Hans de Goede (3):
      platform/x86: touchscreen_dmi: Add swap-x-y quirk for Goodix touchscreen on Estar Beauty HD tablet
      platform/x86: intel-vbtn: Drop HP Stream x360 Convertible PC 11 from allow-list
      platform/x86: hp-wmi: Don't log a warning on HPWMI_RET_UNKNOWN_COMMAND errors

Heikki Krogerus (1):
      platform/x86: i2c-multi-instantiate: Don't create platform device for INT3515 ACPI nodes

Jeannie Stevenson (1):
      platform/x86: thinkpad_acpi: Add P53/73 firmware to fan_quirk_table for dual fan control

Jiaxun Yang (1):
      platform/x86: ideapad-laptop: Disable touchpad_switch for ELAN0634

Mark Pearson (1):
      platform/x86: thinkpad_acpi: correct palmsensor error checking

Randy Dunlap (1):
      platform/surface: surface_gpe: Fix non-PM_SLEEP build warnings

Shyam Sundar S K (1):
      platform/x86: amd-pmc: Fix CONFIG_DEBUG_FS check

Srinivas Pandruvada (2):
      tools/power/x86/intel-speed-select: Set scaling_max_freq to base_frequency
      tools/power/x86/intel-speed-select: Set higher of cpuinfo_max_freq or base_frequency

 drivers/platform/surface/Kconfig                 |  8 +++---
 drivers/platform/surface/surface_gpe.c           |  4 +--
 drivers/platform/x86/amd-pmc.c                   |  2 +-
 drivers/platform/x86/hp-wmi.c                    |  3 ++-
 drivers/platform/x86/i2c-multi-instantiate.c     | 31 +++++++++++++++++------
 drivers/platform/x86/ideapad-laptop.c            | 15 ++++++++++-
 drivers/platform/x86/intel-vbtn.c                | 10 ++++----
 drivers/platform/x86/thinkpad_acpi.c             |  5 ++--
 drivers/platform/x86/touchscreen_dmi.c           | 18 +++++++++++++
 tools/power/x86/intel-speed-select/isst-config.c | 32 ++++++++++++++++++++++++
 10 files changed, 104 insertions(+), 24 deletions(-)

