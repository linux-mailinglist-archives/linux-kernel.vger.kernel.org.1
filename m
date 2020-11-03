Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3132A504E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 20:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgKCToW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 14:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgKCToW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 14:44:22 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CB2C0613D1;
        Tue,  3 Nov 2020 11:44:22 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 34BED2E7;
        Tue,  3 Nov 2020 19:44:21 +0000 (UTC)
Date:   Tue, 3 Nov 2020 12:44:20 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Subject: [GIT PULL] Docs-build warning fixes for 5.10-rc3
Message-ID: <20201103124420.46bf5a37@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
e051955977b7e26124aa8c8398278145f85f94e8:

  documentation: arm: sunxi: add Allwinner H6 documents (2020-10-28 11:19:24 -0600)

are available in the Git repository at:

  git://git.lwn.net/linux.git docs-5.10-warnings

for you to fetch changes up to 6fee9372e0af63f557ad234663d8248f3caefc37:

  Merge branch 'mauro-warnings' into docs-next (2020-10-28 11:42:55 -0600)

----------------------------------------------------------------
This pull contains a series of warning fixes from Mauro; once applied, the
number of warnings from the once-noisy docs build process is nearly zero.
Getting to this point has required a lot of work; once there, hopefully we
can keep things that way.

I have packaged this as a separate pull because it does a fair amount of
reaching outside of Documentation/.  The changes are all in comments and in
code placement.  It's all been in linux-next since last week.

----------------------------------------------------------------
Jonathan Corbet (1):
      Merge branch 'mauro-warnings' into docs-next

Mauro Carvalho Chehab (24):
      scripts: kernel-doc: use :c:union when needed
      sphinx: conf.py: properly handle Sphinx 4.0
      docs: hwmon: adm1266.rst: fix a broken reference
      docs: admin-guide: net.rst: add a missing blank line
      docs: kasan.rst: add two missing blank lines
      docs: net: statistics.rst: remove a duplicated kernel-doc
      docs: hwmon: mp2975.rst: address some html build warnings
      docs: userspace-api: add iommu.rst to the index file
      blk-mq: docs: add kernel-doc description for a new struct member
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
      gpu: docs: amdgpu.rst: get rid of wrong kernel-doc markups
      drm: amdgpu_dm: fix a typo
      selftests: kselftest_harness.h: fix kernel-doc markups
      amdgpu: fix a few kernel-doc markup issues
      docs: SafeSetID: fix a warning

 Documentation/admin-guide/LSM/SafeSetID.rst        |   2 +-
 Documentation/admin-guide/sysctl/net.rst           |   1 +
 Documentation/conf.py                              |   2 +-
 Documentation/dev-tools/kasan.rst                  |   2 +
 .../devicetree/bindings/clock/hi6220-clock.txt     |   2 +-
 Documentation/filesystems/api-summary.rst          |   3 -
 Documentation/gpu/amdgpu.rst                       |   7 --
 Documentation/hwmon/adm1266.rst                    |   2 +-
 Documentation/hwmon/index.rst                      |   1 +
 Documentation/hwmon/mp2975.rst                     |  14 ++-
 Documentation/locking/lockdep-design.rst           |  51 ++++----
 Documentation/networking/devlink/ice.rst           |   1 +
 Documentation/networking/statistics.rst            |   3 +-
 Documentation/userspace-api/index.rst              |   1 +
 MAINTAINERS                                        |   9 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c  |   2 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c  |   2 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-trng.c  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  36 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c       |   7 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   6 +-
 drivers/infiniband/ulp/srpt/ib_srpt.h              |   1 +
 .../bindings/net/wireless/silabs,wfx.yaml          |   2 +-
 include/linux/blk-mq.h                             |   2 +
 include/linux/pagemap.h                            |   8 +-
 include/linux/phy.h                                |  40 +------
 include/linux/refcount.h                           | 130 ++++++++++-----------
 scripts/kernel-doc                                 |   6 +-
 tools/testing/selftests/kselftest_harness.h        |  44 +++----
 31 files changed, 196 insertions(+), 201 deletions(-)
