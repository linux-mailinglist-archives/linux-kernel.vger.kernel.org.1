Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AA32E23AD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 03:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbgLXCaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 21:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbgLXCaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 21:30:10 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4ACC06179C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 18:29:30 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g185so481345wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 18:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=nT2HSJzTV5vzxiNJUEDv/4dgyx9ZY8N5XT+Tfxivf1M=;
        b=k41lcwMlLiH71+UseGEkUcV+yBKKJDdK1WeXOXeCapLrA7yB9RbQ1XIcqvAurpc0wu
         3AtLb/EZgDV//bx5njfPqLXbCU13EToEXhU8/etyUJfKH8roFVmMUtDHOXmF928SN0ek
         mtHU2I8oMjDTb2lphxRn+UYEFIlqp6iWzsf5rC5flx/NzsRl6mUFU6Gp2RBUQk9It9go
         TVRdqRveH37KOu3ty/s3XmFR5xAFW4z6anzc46xb/sA/8Nm/UHpNfAmVNwRwYfkDN2oW
         q7zUhZB7922E3380VCD3v0Avg+IRf968R0ADPJ6rZ7vHxuZaD5UlWJJStn224JNrbeZe
         Anww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=nT2HSJzTV5vzxiNJUEDv/4dgyx9ZY8N5XT+Tfxivf1M=;
        b=Q86+NvCTpQyYZ7WSt5c/zD6tRr4Uvp02KfBVUozVwJXz9/z9jmVrLHbELpP+WZ4591
         qPtdsGc5sURRjqTEwxgwZz08AOnkjkdE6A4d361SYfivU/K7D5FF8gAtdHX5RDiRzRD4
         0kASqcSco6taWkfUoada2TRY2U5M8nIQ08ueip8sIh2WuyZFPeCIhrWyCLSYVxSi1lDz
         67FpbRRSgvBCvBoZy9Gec5xkXPIZwnA95sTL8G79+orElo7twc1gdH4CoBgOPpJH/TC8
         GPTW8zueUa7RIXKAgCptZjRPm7weYOtcRrLylIQ5SCUM/YETTsF8OLoIMmU7MwkdRo5G
         FjBQ==
X-Gm-Message-State: AOAM530XerHtB5yw+pqoaulr177M6yAw4v1RJzcNuefuyPWh0nkuKvm1
        CNZeTMozURQYuL8FQxoRWElDWC/SQNtlksruQWBkmK67aIk=
X-Google-Smtp-Source: ABdhPJyiHjEHFCPD5GZojXbUEJemGnj7eGvdL9RvDqd+Dg6NWZgLhAI4ltwXh3e9KqFgzxvAJmcmwn7uxYNvaGwGrg0=
X-Received: by 2002:a1c:c287:: with SMTP id s129mr2134395wmf.79.1608776968852;
 Wed, 23 Dec 2020 18:29:28 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 24 Dec 2020 12:29:16 +1000
Message-ID: <CAPM=9twrkJdUqTLXXsNygtzkrc4P2iyw4kwU1T83D4_+-gdpDA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.11-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Xmas eve pull request present. Just some fixes that trickled in this
past week. Mostly amdgpu fixes, with a dma-buf/mips build fix and some
misc komeda fixes.

Hope you have a good holiday season,
Dave.

drm-next-2020-12-24:
drm fixes for 5.11-rc1

dma-buf:
- fix build on mips

komeda:
- fix commit tail operation order
- NULL pointer fix
- out of bounds access fix

ttm:
- remove an unused function

amdgpu:
- Vangogh SMU fixes
- Arcturus gfx9 fixes
- Misc display fixes
- Sienna Cichlid SMU update
- Fix S3 display memory leak
- Fix regression caused by DP sub-connector support

amdkfd:
- Properly require pcie atomics for gfx10
The following changes since commit 4efd7faba5e0687ae9143b7e6a19547ede20a7dd=
:

  Merge tag 'drm-intel-next-fixes-2020-12-18' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2020-12-18
16:22:10 +0100)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-12-24

for you to fetch changes up to 5b2fc08c455bbf749489254a81baeffdf4c0a693:

  Merge tag 'amd-drm-fixes-5.11-2020-12-23' of
git://people.freedesktop.org/~agd5f/linux into drm-next (2020-12-24
10:31:16 +1000)

----------------------------------------------------------------
drm fixes for 5.11-rc1

dma-buf:
- fix build on mips

komeda:
- fix commit tail operation order
- NULL pointer fix
- out of bounds access fix

ttm:
- remove an unused function

amdgpu:
- Vangogh SMU fixes
- Arcturus gfx9 fixes
- Misc display fixes
- Sienna Cichlid SMU update
- Fix S3 display memory leak
- Fix regression caused by DP sub-connector support

amdkfd:
- Properly require pcie atomics for gfx10

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu: fix vbios reservation handling on SR-IOV
      drm/amdgpu: only set DP subconnector type on DP and eDP connectors
      drm/amdgpu: Fix a copy-pasta comment

Aric Cyr (1):
      drm/amd/display: Multi-display underflow observed

Arnd Bergmann (1):
      drm/ttm: fix unused function warning

Carsten Haitzler (3):
      drm/komeda: Remove useless variable assignment
      drm/komeda: Handle NULL pointer access code path in error case
      drm/komeda: Fix bit check to import to value of proper type

Christian K=C3=B6nig (1):
      drm/qxl: don't allocate a dma_address array

Dave Airlie (2):
      Merge tag 'drm-misc-next-fixes-2020-12-22' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next
      Merge tag 'amd-drm-fixes-5.11-2020-12-23' of
git://people.freedesktop.org/~agd5f/linux into drm-next

Eryk Brol (1):
      drm/amd/display: Remove unnecessary NULL check

Evan Quan (1):
      drm/amd/pm: bump Sienna Cichlid smu_driver_if version to match latest=
 pmfw

Harish Kasiviswanathan (1):
      drm/amdkfd: PCIe atomics required for gfx10

Hawking Zhang (3):
      drm/amdgpu: check number of gfx ring before init cp gfx
      drm/amdgpu: remove unnecessary asic type check
      drm/amdgpu: check gfx pipe availability before toggling its interrupt=
s

Jake Wang (2):
      drm/amd/display: updated wm table for Renoir
      drm/amd/display: always program DPPDTO unless not safe to lower

James Qian Wang (1):
      drm/komeda: Correct the sequence of hw_done() and flip_done()

John Stultz (1):
      dma-buf: cma_heap: Include linux/vmalloc.h to fix build failures on M=
IPS

Josip Pavic (1):
      drm/amd/display: add getter routine to retrieve mpcc mux

Martin Tsai (2):
      drm/amd/display: Modify the hdcp device count check condition
      drm/amd/display: To modify the condition in indicating branch device

Michael Strauss (1):
      drm/amd/display: Update RN/VGH active display count workaround

Qingqing Zhuo (1):
      drm/amd/display: handler not correctly checked at remove_irq_handler

Rizvi (1):
      drm/amd/display: gradually ramp ABM intensity

Stylon Wang (1):
      drm/amd/display: Fix memory leaks in S3 resume

Sung Lee (1):
      drm/amd/display: Acquire DSC during split stream for ODM only if top_=
pipe

Wesley Chalmers (1):
      drm/amd/display: Interfaces for hubp blank and soft reset

Xiaomeng Hou (1):
      drm/amd/pm: check pmfw version before issuing RlcPowerNotify message

Yongqiang Sun (2):
      drm/amd/display: change SMU repsonse timeout to 2s.
      drm/amd/display: [FW Promotion] Release 0.0.47

 drivers/dma-buf/heaps/cma_heap.c                   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     | 10 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |  3 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c              | 21 ++++++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c              | 11 +++----
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            | 12 ++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  5 +--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  |  5 ++-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  | 36 +++++++++---------=
----
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c        |  2 +-
 .../drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c |  9 +-----
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 20 ------------
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  8 +----
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c  | 18 +++++++++++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h  |  4 +++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c   | 12 ++++++++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.h   |  1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c  |  2 ++
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 12 ++++++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c   |  1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c  |  2 ++
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c   |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h       |  2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h        |  4 +++
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  4 +--
 .../drm/amd/display/modules/hdcp/hdcp1_execution.c |  8 +++--
 .../drm/amd/display/modules/hdcp/hdcp2_execution.c |  7 +++--
 .../drm/amd/display/modules/power/power_helpers.c  | 35 +++++++++++++++---=
---
 .../drm/amd/display/modules/power/power_helpers.h  |  1 +
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h             |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c   |  9 ++++--
 drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |  1 -
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c    |  4 +--
 .../gpu/drm/arm/display/komeda/komeda_pipeline.c   |  3 +-
 .../drm/arm/display/komeda/komeda_pipeline_state.c |  4 +--
 drivers/gpu/drm/ttm/ttm_pool.c                     | 29 +++++++++--------
 38 files changed, 182 insertions(+), 132 deletions(-)
