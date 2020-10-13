Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E65028CE1A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbgJMMQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:41124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgJMMO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:14:57 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 034AA22258;
        Tue, 13 Oct 2020 12:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602591295;
        bh=nMXTOlO8MmNlVI621kGGK0owv+NaepaGR3buXWsc9hY=;
        h=From:To:Cc:Subject:Date:From;
        b=ZDO/Aj1h/8cOxyLV9QLrtOUfPLbg39QUyR/VGVFdQ1J82x24z1AKekkT1+QzbNcQJ
         wLxx4C/wH/D7SDvP7OPBoohYZxW+CVjxSMaNCfJaa5+SkVfPUNgwdPi1BR/p1e85nl
         GTjJQfXXiWDvsWYPmwkEPqTIkNCYPJQ//2yC3M5E=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kSJCe-006Cnp-L4; Tue, 13 Oct 2020 14:14:52 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Chen-Yu Tsai <wens@csie.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Guenter Roeck <linux@roeck-us.net>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Will Deacon <will@kernel.org>, Wolfram Sang <wsa@kernel.org>
Subject: [PATCH v2 00/24] Documentation build fixes against next-20201013
Date:   Tue, 13 Oct 2020 14:14:27 +0200
Message-Id: <cover.1602590106.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on the top of my previous series:

	https://lore.kernel.org/lkml/cover.1602589096.git.mchehab+huawei@kernel.org/

plus linux-next.

It contains the patches I sent before with documentation fixes
for Kernel 5.10, plus 3 new fixes for stuff that got merged today
at linux-next.

My plan is to do a late pull request by the end of the merge window
with the patches from this tree that weren't merged directly
via some other trees.

-

After both series applied, the only warnings with Sphinx 2.4.4
are those:

../include/kunit/test.h:282: warning: Function parameter or member '__suites' not described in 'kunit_test_suites_for_module'
../include/kunit/test.h:282: warning: Excess function parameter 'suites_list' description in 'kunit_test_suites_for_module'
../include/kunit/test.h:314: warning: Excess function parameter 'suites' description in 'kunit_test_suites'

.../Documentation/core-api/counters.rst:46: WARNING: undefined label: test counters module (if the link has no caption the label must precede a section header)
.../Documentation/core-api/counters.rst:49: WARNING: undefined label: selftest for counters (if the link has no caption the label must precede a section header)
.../Documentation/core-api/counters.rst:62: WARNING: undefined label: atomic_ops (if the link has no caption the label must precede a section header)

Those require some care from the authors in order to
properly address them.

Hopefully, this will all be sorted until the end of the merge window.


Mauro Carvalho Chehab (24):
  docs: hwmon: adm1266.rst: fix a broken reference
  tools: docs: memory-model: fix references for some files
  docs: SafeSetID: fix a warning
  docs: lockdep-design: fix some warning issues
  docs: admin-guide: net.rst: add a missing blank line
  blk-mq: docs: add kernel-doc description for a new struct member
  drm: amdgpu: kernel-doc: update some adev parameters
  drm: kernel-doc: document drm_dp_set_subconnector_property() params
  docs: kasan.rst: add two missing blank lines
  mm: pagemap.h: fix two kernel-doc markups
  drm/dp: fix kernel-doc warnings at drm_dp_helper.c
  drm/dp: fix a kernel-doc issue at drm_edid.c
  docs: i2c: index.rst: add slave-testunit-backend.rst
  docs: conf.py: disable automarkup for Sphinx 3.x
  docs: net: statistics.rst: remove a duplicated kernel-doc
  seqlock: fix two kernel-doc warnings
  docs: hwmon: mp2975.rst: address some html build warnings
  docs: userspace-api: add iommu.rst to the index file
  net: phy: remove kernel-doc duplication
  MAINTAINERS: fix broken doc refs due to yaml conversion
  crypto: sun8x-ce*: update entries to its documentation
  ice: docs fix a devlink info that broke a table
  RDMA: add a missing kernel-doc parameter markup
  counters: docs: add a missing include

 Documentation/admin-guide/LSM/SafeSetID.rst   |  2 +-
 .../admin-guide/hw-vuln/l1d_flush.rst         |  3 +-
 Documentation/admin-guide/sysctl/net.rst      |  1 +
 Documentation/conf.py                         |  3 +-
 Documentation/core-api/counters.rst           |  1 +
 Documentation/core-api/index.rst              |  1 +
 Documentation/dev-tools/kasan.rst             |  2 +
 .../bindings/clock/hi6220-clock.txt           |  2 +-
 Documentation/hwmon/adm1266.rst               |  2 +-
 Documentation/hwmon/index.rst                 |  1 +
 Documentation/hwmon/mp2975.rst                | 14 +++-
 Documentation/i2c/index.rst                   |  1 +
 Documentation/locking/lockdep-design.rst      | 69 +++++++++++--------
 Documentation/networking/devlink/ice.rst      |  1 +
 Documentation/networking/statistics.rst       |  3 +-
 Documentation/userspace-api/index.rst         |  1 +
 MAINTAINERS                                   |  9 ++-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-hash.c |  2 +-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-prng.c |  2 +-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-trng.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c   |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c  |  5 +-
 drivers/gpu/drm/drm_dp_helper.c               | 12 +++-
 drivers/gpu/drm/drm_edid.c                    |  2 +-
 drivers/infiniband/core/device.c              |  5 +-
 .../bindings/net/wireless/silabs,wfx.yaml     |  2 +-
 include/linux/blk-mq.h                        |  2 +
 include/linux/pagemap.h                       |  8 +--
 include/linux/phy.h                           | 40 ++---------
 include/linux/seqlock.h                       |  2 +-
 tools/memory-model/Documentation/README       |  2 +-
 tools/memory-model/Documentation/ordering.txt |  2 +-
 33 files changed, 113 insertions(+), 99 deletions(-)

-- 
2.26.2


