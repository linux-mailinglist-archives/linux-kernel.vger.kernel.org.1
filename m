Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BA929A8D9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896893AbgJ0KCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:02:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896030AbgJ0Jvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:51:42 -0400
Received: from mail.kernel.org (ip5f5ad5af.dynamic.kabel-deutschland.de [95.90.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4305E22384;
        Tue, 27 Oct 2020 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603792301;
        bh=8qfbBBjsbGUNirayPvOgFtrePNUozSrpX+/vB+XlMPk=;
        h=From:To:Cc:Subject:Date:From;
        b=CY9UnEqtR2vzshJ+wvyHrT+PljT3hhb1NIWgcPXNrtpKPosMDWVteyn/vcA3+95eP
         X/T3g7Ktk+N+J3d6KHXI9BWZM1+jtk7+dQFrKaiHFCa/eecocFW/MfE0i02bAczQoM
         dc6ekk813lJNp123CeAKWO0PZYreu8S6uJ08DRMo=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXLdi-003FET-Sd; Tue, 27 Oct 2020 10:51:38 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "Theodore Ts'o" <tytso@mit.edu>, Andrew Lunn <andrew@lunn.ch>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Guenter Roeck <linux@roeck-us.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.com>,
        Jean Delvare <jdelvare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v3 00/32] Documentation build fixes against v5.10-rc1
Date:   Tue, 27 Oct 2020 10:51:04 +0100
Message-Id: <cover.1603791716.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

This series contain the patches from a previous series I sent:

	[PATCH v2 00/24] Documentation build fixes against next-20201013

Plus other patches I sent later, against other versions of linux-next between
20201013 and v5.10-rc1.

It fixes most of the remaining documentation build warnings.

There were some changes from v2, as I changed some patches due to the
feedback received, and added reviewed-by/acked-by to several of them.

After this series, there will be just 3 warnings at include/kunit/test.h, whose
fixes were already applied by Shuah via her tree at linux-next. Hopefully, she
will be sending it upstream anytime toon. So, I dropped the fix from my trees.

The vast majority of patches here are also on my linux-next tree, as my
original plan were to send them upstream by the end of the merge window.
I'll drop from it once they get merged.

As those patches are fixes, I guess it should be ok to get them merged for 
-rc2 or -rc3.

Regards,
Mauro


Mauro Carvalho Chehab (32):
  scripts: kernel-doc: use :c:union when needed
  sphinx: conf.py: properly handle Sphinx 4.0
  docs: hwmon: adm1266.rst: fix a broken reference
  docs: admin-guide: net.rst: add a missing blank line
  docs: kasan.rst: add two missing blank lines
  docs: net: statistics.rst: remove a duplicated kernel-doc
  docs: hwmon: mp2975.rst: address some html build warnings
  docs: userspace-api: add iommu.rst to the index file
  blk-mq: docs: add kernel-doc description for a new struct member
  drm: kernel-doc: document drm_dp_set_subconnector_property() params
  drm/dp: fix kernel-doc warnings at drm_dp_helper.c
  drm/dp: fix a kernel-doc issue at drm_edid.c
  mm: pagemap.h: fix two kernel-doc markups
  net: phy: remove kernel-doc duplication
  crypto: sun8x-ce*: update entries to its documentation
  ice: docs fix a devlink info that broke a table
  MAINTAINERS: fix broken doc refs due to yaml conversion
  docs: lockdep-design: fix some warning issues
  locking/refcount: move kernel-doc markups to the proper place
  IB/srpt: docs: add a description for cq_size member
  docs: fs: api-summary.rst: get rid of kernel-doc include
  drm: amdgpu: kernel-doc: update some adev parameters
  jbd2: fix a kernel-doc markup
  drm: drm_edid: remove a duplicated kernel-doc declaration
  drm: kernel-doc: add description for a new function parameter
  gpu: docs: amdgpu.rst: get rid of wrong kernel-doc markups
  drm: kernel-doc: drm_dp_helper.h: fix a typo
  drm: amdgpu_dm: fix a typo
  selftests: kselftest_harness.h: fix kernel-doc markups
  amdgpu: fix a few kernel-doc markup issues
  drm: drm_print.h: fix kernel-doc markups
  docs: SafeSetID: fix a warning

 Documentation/admin-guide/LSM/SafeSetID.rst   |   2 +-
 Documentation/admin-guide/sysctl/net.rst      |   1 +
 Documentation/conf.py                         |   2 +-
 Documentation/dev-tools/kasan.rst             |   2 +
 .../bindings/clock/hi6220-clock.txt           |   2 +-
 Documentation/filesystems/api-summary.rst     |   3 -
 Documentation/gpu/amdgpu.rst                  |   7 -
 Documentation/hwmon/adm1266.rst               |   2 +-
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/mp2975.rst                |  14 +-
 Documentation/locking/lockdep-design.rst      |  51 +++---
 Documentation/networking/devlink/ice.rst      |   1 +
 Documentation/networking/statistics.rst       |   3 +-
 Documentation/userspace-api/index.rst         |   1 +
 MAINTAINERS                                   |   9 +-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-hash.c |   2 +-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-prng.c |   2 +-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-trng.c |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  36 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |   7 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   6 +-
 drivers/gpu/drm/drm_dp_helper.c               |  12 +-
 drivers/gpu/drm/drm_edid.c                    |   2 +-
 drivers/gpu/drm/drm_prime.c                   |   1 +
 drivers/infiniband/ulp/srpt/ib_srpt.h         |   1 +
 .../bindings/net/wireless/silabs,wfx.yaml     |   2 +-
 include/drm/drm_dp_helper.h                   |   2 +-
 include/drm/drm_edid.h                        |   7 -
 include/drm/drm_print.h                       |  20 ++-
 include/linux/blk-mq.h                        |   2 +
 include/linux/jbd2.h                          |   2 +-
 include/linux/pagemap.h                       |   8 +-
 include/linux/phy.h                           |  40 +----
 include/linux/refcount.h                      | 158 +++++++++---------
 scripts/kernel-doc                            |   6 +-
 tools/testing/selftests/kselftest_harness.h   |  44 ++---
 38 files changed, 242 insertions(+), 229 deletions(-)

-- 
2.26.2


