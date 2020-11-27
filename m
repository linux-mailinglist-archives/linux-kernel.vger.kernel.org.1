Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FCE2C6209
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 10:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgK0Jl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 04:41:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729179AbgK0JlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 04:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606470082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IMBFuW1kwZcIfsQ9CTbuIBKuzaXOT1XTMro+WzbTZV8=;
        b=NN//e77+7T4dcW6bT9JkWg0JeJbtcgY311+oNoisXflluXwn0d4yCEPeaMvb6eI+3RdeGT
        u8rh7NQgfkqAffR9N7M3i7mzLmitTV7JhMrQeTy8sx0bZiO+rRfuuFTxjOmxCOaoHPaDyM
        3yIqb2b+tuXEIuWZE7MmdmE9mCqqUvE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-DWFR2m8MPNCDIQWdpaqcGg-1; Fri, 27 Nov 2020 04:41:20 -0500
X-MC-Unique: DWFR2m8MPNCDIQWdpaqcGg-1
Received: by mail-ej1-f72.google.com with SMTP id q2so1798512ejj.16
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 01:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=IMBFuW1kwZcIfsQ9CTbuIBKuzaXOT1XTMro+WzbTZV8=;
        b=M6MHwBxyU4tDLELbIAAtYPm0uD+6mlICyP6cg43j+McgAl87QNUoTFwxeezU94TKou
         Vo7S0mH4DCS8qc0RSw/4eY7JRdMaovNRhpoiXpqLMOQ9KqjVN9vrpZTT9XTyjKRW5gQR
         q/jo4umosK1CWPr4H0Hc50sz0HIrNlazvI+VwDLxC2avedrvxxrxDgkgvliKu6SRoYBn
         DW1tJUzDwAwyS/NZtbtiqA16L3/ORMVejhAy/2jHRx3+Ru6PyGrD+7poo6gBswf46vn0
         XRYrQSefaVLaBP7FrzMzPrmp+t8YgAslYJp2S5W2xZmHNFgOZbhZ2Gg/r4Q3n7ELy8jR
         iOFQ==
X-Gm-Message-State: AOAM530XW8rrNkmVm+2o71q92jhshuJbYuEfJeTu/S5GtN2YsbwoA81q
        6S5o1+QoH/fR03w1GtYvGTjhgYtp6SsO15/JjxN3R3pSAW8uhutNTBfA0uwbeh3bw1NtTXmu53O
        UdiSL4/RhQE3PbvixovUGksWq
X-Received: by 2002:a17:906:2e55:: with SMTP id r21mr7093041eji.46.1606470079273;
        Fri, 27 Nov 2020 01:41:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1xcarjDCPCwzOKQRTlgF7I4yVz7qP0linSSpUxXJJBapznj0WdjI5PL2RriCwJz+eTWeiRg==
X-Received: by 2002:a17:906:2e55:: with SMTP id r21mr7093026eji.46.1606470079062;
        Fri, 27 Nov 2020 01:41:19 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id a3sm2514842edf.23.2020.11.27.01.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 01:41:18 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.10-2
Message-ID: <7fadb4fc-4e7f-e335-4c90-c09ee6aafeac@redhat.com>
Date:   Fri, 27 Nov 2020 10:41:17 +0100
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

Here is a set of small, straight-forward fixes for platform-drivers-x86 for 5.10:
 - thinkpad_acpi fixes: 2 bug-fixes and 3 model specific quirks
 - fixes for misc. other drivers: 2 bug-fixes and 3 model specific quirks

Regards,

Hans


The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.10-2

for you to fetch changes up to c9aa128080cbce92f8715a9328f88d8ca3134279:

  platform/x86: touchscreen_dmi: Add info for the Irbis TW118 tablet (2020-11-26 15:49:16 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v5.10-2

Highlights:
 - thinkpad_acpi fixes: 2 bug-fixes and 3 model specific quirks
 - fixes for misc. other drivers: 2 bug-fixes and 3 model specific quirks

The following is an automated git shortlog grouped by driver:

acer-wmi:
 -  add automatic keyboard background light toggle key as KEY_LIGHTS_TOGGLE

intel-vbtn:
 -  Support for tablet mode on HP Pavilion 13 x360 PC

thinkpad_acpi:
 -  Whitelist P15 firmware for dual fan control
 -  Send tablet mode switch at wakeup time
 -  Add BAT1 is primary battery quirk for Thinkpad Yoga 11e 4th gen
 -  Do not report SW_TABLET_MODE on Yoga 11e
 -  add P1 gen3 second fan support

toshiba_acpi:
 -  Fix the wrong variable assignment

touchscreen_dmi:
 -  Add info for the Irbis TW118 tablet
 -  Add info for the Predia Basic tablet

----------------------------------------------------------------
Benjamin Berg (1):
      platform/x86: thinkpad_acpi: Send tablet mode switch at wakeup time

Hans de Goede (4):
      platform/x86: thinkpad_acpi: Do not report SW_TABLET_MODE on Yoga 11e
      platform/x86: thinkpad_acpi: Add BAT1 is primary battery quirk for Thinkpad Yoga 11e 4th gen
      platform/x86: touchscreen_dmi: Add info for the Predia Basic tablet
      platform/x86: touchscreen_dmi: Add info for the Irbis TW118 tablet

Iakov 'Jake' Kirilenko (1):
      platform/x86: thinkpad_acpi: add P1 gen3 second fan support

Kaixu Xia (1):
      platform/x86: toshiba_acpi: Fix the wrong variable assignment

Matthias Maier (1):
      platform/x86: thinkpad_acpi: Whitelist P15 firmware for dual fan control

Max Verevkin (1):
      platform/x86: intel-vbtn: Support for tablet mode on HP Pavilion 13 x360 PC

Timo Witte (1):
      platform/x86: acer-wmi: add automatic keyboard background light toggle key as KEY_LIGHTS_TOGGLE

 drivers/platform/x86/acer-wmi.c        |  1 +
 drivers/platform/x86/intel-vbtn.c      |  6 ++++
 drivers/platform/x86/thinkpad_acpi.c   | 13 ++++++++-
 drivers/platform/x86/toshiba_acpi.c    |  3 +-
 drivers/platform/x86/touchscreen_dmi.c | 50 ++++++++++++++++++++++++++++++++++
 5 files changed, 70 insertions(+), 3 deletions(-)

