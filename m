Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD856300928
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbhAVRBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:01:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44371 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728816AbhAVQmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611333675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/7UKPF/iPrDvUly06H154sYOiwhMFNqOzLjosIx0PfA=;
        b=E4kfzpIpgUolfeugGLcBG/EYA9I6tytYT/drIkB3YQ55KBEriQBLlQCoUMiA/4/hSgLTQ7
        j2oxD9cKfTu1zP0UwAgHmUqLUYu+6cNC9abNBymufu8smGBQLedPWgHPuM2CRg6695XULj
        2Q1/kWJczm4A8etTJqd2nxJd4z7qWKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-vrtuBj90OoKaXIWhOvgV_g-1; Fri, 22 Jan 2021 11:41:13 -0500
X-MC-Unique: vrtuBj90OoKaXIWhOvgV_g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4FC28005A4;
        Fri, 22 Jan 2021 16:41:11 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-174.ams2.redhat.com [10.36.112.174])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9C8660CE7;
        Fri, 22 Jan 2021 16:41:08 +0000 (UTC)
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
Subject: [PATCH v3 00/13] MFD/extcon/ASoC: Rework arizona codec jack-detect support
Date:   Fri, 22 Jan 2021 17:40:54 +0100
Message-Id: <20210122164107.361939-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is v3 om my series to rework the arizona codec jack-detect support
to use the snd_soc_jack helpers instead of direct extcon reporting.

This is done by reworking the extcon driver into an arizona-jackdet
library and then modifying the codec drivers to use that directly,
replacing the old separate extcon child-devices and extcon-driver.

This brings the arizona-codec jack-detect handling inline with how
all other ASoC codec driver do this. This was developed and tested on
a Lenovo Yoga Tablet 1051L with a WM5102 codec.

There are various interdependencies between the patches in this
series, so IMHO it would be best if this entire series would be merged
through the MFD tree.

Note this series applies on top of my "[PATCH v4 0/5] MFD/ASoC: Add
support for Intel Bay Trail boards with WM5102 codec" series.

Changes in v3:
-Move the bugfix patches to earlier in the series so that they
 apply to drivers/extcon/extcon-arizona.c so that they can be
 cherry-picked into the stable series
-Split runtime_pm_get -> runtime_pm_get_sync changes out into their
 own patch
-Simply move drivers/extcon/extcon-arizona.c to
 sound/soc/codecs/arizona-jack.c instead of first adding arizona-jack.c
 as a copy and then later removing extcon-arizona.c
-Some other small tweaks, see individual patch changelogs

Regards,

Hans


Hans de Goede (13):
  mfd: arizona: Drop arizona-extcon cells
  extcon: arizona: Fix some issues when HPDET IRQ fires after the jack
    has been unplugged
  extcon: arizona: Fix various races on driver unbind
  extcon: arizona: Fix flags parameter to the gpiod_get("wlf,micd-pol")
    call
  extcon: arizona: Always use pm_runtime_get_sync() when we need the
    device to be awake
  ASoC/extcon: arizona: Move arizona jack code to
    sound/soc/codecs/arizona-jack.c
  ASoC: arizona-jack: Move jack-detect variables to struct arizona_priv
  ASoC: arizona-jack: Use arizona->dev for runtime-pm
  ASoC: arizona-jack: convert into a helper library for codec drivers
  ASoC: arizona-jack: Use snd_soc_jack to report jack events
  ASoC: arizona-jack: Cleanup logging
  ASoC: arizona: Make the wm5102, wm5110, wm8997 and wm8998 drivers use
    the new jack library
  ASoC: Intel: bytcr_wm5102: Add jack detect support

 MAINTAINERS                                   |   1 -
 drivers/extcon/Kconfig                        |   8 -
 drivers/extcon/Makefile                       |   1 -
 drivers/mfd/arizona-core.c                    |  20 -
 sound/soc/codecs/Makefile                     |   2 +-
 .../soc/codecs/arizona-jack.c                 | 539 +++++++-----------
 sound/soc/codecs/arizona.h                    |  44 ++
 sound/soc/codecs/wm5102.c                     |  12 +-
 sound/soc/codecs/wm5110.c                     |  12 +-
 sound/soc/codecs/wm8997.c                     |  14 +-
 sound/soc/codecs/wm8998.c                     |   9 +
 sound/soc/intel/boards/bytcr_wm5102.c         |  28 +-
 12 files changed, 307 insertions(+), 383 deletions(-)
 rename drivers/extcon/extcon-arizona.c => sound/soc/codecs/arizona-jack.c (77%)

-- 
2.28.0

