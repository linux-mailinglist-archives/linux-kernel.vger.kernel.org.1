Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584AF2FDC8E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 23:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbhATWWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 17:22:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731299AbhATVwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:52:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611179404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=q5Tk07cOyzSuWC8UtiKXVVn3bXHByT7HLLQP4dV6lj4=;
        b=Rtuztq4h/0BD3Kym2vK7mDyZWj540prF5sBqr/BCkSPNixSHcoDbgOlbqe240ytYPV59XI
        a24SG31Qyx+icy2Dpsk4gHoty2GFTfvzuvvt+8ayxBJCHi9ZrOMSIX2OQ8tFWDYV6v1qyS
        noRN4sBwtLjP/eOm+AxBEVQUM9aiJxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-Y9rzyxF8MWeuZg_DsNGdJw-1; Wed, 20 Jan 2021 16:50:02 -0500
X-MC-Unique: Y9rzyxF8MWeuZg_DsNGdJw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22A5015725;
        Wed, 20 Jan 2021 21:50:01 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-1.ams2.redhat.com [10.36.114.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 610CE61F38;
        Wed, 20 Jan 2021 21:49:58 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH v4 0/5] MFD/ASoC: Add support for Intel Bay Trail boards with WM5102 codec
Date:   Wed, 20 Jan 2021 22:49:52 +0100
Message-Id: <20210120214957.140232-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is v4 of my series to add support for Intel Bay Trail based devices
which use a WM5102 codec for audio output/input.

This was developed and tested on a Lenovo Yoga Tablet 1051L.

The MFD and ASoC parts do not have any build-time dependencies
on each other. But the follow-up jack-detect series does have
patches depending on each-other and on this series. So IMHO it
would be best if this entire series would be merged through the
MFD tree to make merging the follow-up series easier.

Mark, if that is ok with you (and you are happy with the ASoC
changes) can you please Ack this ?

Changes in v4:
- Add a comment to the irq-flags override explaining that theoretically
  DSDTs using IRQF_TRIGGER_FALLING could be correct on boards where the
  IRQ controller does not support active low level interrupts

Changes in v3:
- Fix compilation error when CONFIG_ACPI is not set

Changes in v2:
- Split my WM5102 work into 2 series, one series adding basic support
  for Bay Trail boards with a WM5102 codec and a second series with
  the jack-detect work
- Various other minor code tweaks

Hans de Goede (4):
  mfd: arizona: Add MODULE_SOFTDEP("pre: arizona_ldo1")
  mfd: arizona: Replace arizona_of_get_type() with
    device_get_match_data()
  mfd: arizona: Add support for ACPI enumeration of WM5102 connected
    over SPI
  ASoC: Intel: Add DMI quirk table to soc_intel_is_byt_cr()

Pierre-Louis Bossart (1):
  ASoC: Intel: bytcr_wm5102: Add machine driver for BYT/WM5102

 drivers/mfd/arizona-core.c                    |  11 -
 drivers/mfd/arizona-i2c.c                     |  11 +-
 drivers/mfd/arizona-spi.c                     | 138 +++++-
 drivers/mfd/arizona.h                         |   9 -
 sound/soc/intel/boards/Kconfig                |  12 +
 sound/soc/intel/boards/Makefile               |   2 +
 sound/soc/intel/boards/bytcr_wm5102.c         | 465 ++++++++++++++++++
 .../intel/common/soc-acpi-intel-byt-match.c   |  16 +
 sound/soc/intel/common/soc-intel-quirks.h     |  25 +
 9 files changed, 661 insertions(+), 28 deletions(-)
 create mode 100644 sound/soc/intel/boards/bytcr_wm5102.c

Regards,

Hans

