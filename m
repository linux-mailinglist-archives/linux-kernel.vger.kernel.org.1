Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BB226E940
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 01:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgIQXGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 19:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgIQXGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 19:06:11 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7309FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 16:06:11 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i1so4249173edv.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 16:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=21o8uO6u/9rSY/ugJHmV1CZGXcQtAgS36PEhFnGiU88=;
        b=CNijEukGzsHb5ly+NXVKG9Q4TKhX83o8MqouvW7XiYr7765UkS0CEhGhbkVBYvUj4P
         mMn4Ec0OJ+XxEgSk/eib8lUCuBW/OagkhssVSznv3kbAo34AWVEFBh+l5TiWQoI0l4Jb
         a6r9ofZ34HxrgE3keRZYRWnmrXobMcN2xgtZm6T1TO4mCvQbgQ1HvamnDic94TAp7FHk
         vYmzHSaxttuvtdKxm7IiXCxiSIPM4WO+eK+cKY/5KuO8XypzIZm8eWUx1RcdxouXmBT8
         P4fCZlupE1KPZF/Lqepy4cNIauh3cFaLUTHEdK/okzldy1ujSM/6/UL28TveYgbryRnf
         OB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=21o8uO6u/9rSY/ugJHmV1CZGXcQtAgS36PEhFnGiU88=;
        b=GhuxVjIhL9M9cNJiacH719HKIV7Ig6U555Y4zMB8mOyA3JUr+1ttNIb8S9xfBY+fZs
         8vX765MBJgXeTByTuatMcsiLWilJ+VfciWV9Y04xfHrmPUFovVdzuoNyysPlLBVTArBs
         RoHYaWxRoIsNyPOgeKDCqDBrbjgdFkpLniR6kNILXKBnyVkh+pcZRSNFDZgW18eSAVXr
         E/ejH4l+bDQXlDCJYDMrz+ctagOAmaYoVz2Mc0k1MsrQ7CpaA81bGM8GDyUI6vaj9mzq
         kijZgGrWIIUoJmOkPjwNVOCDPBbhLKqQ9vNn9xP3puqqZ8ZzkpVrdm9JX2wu1t5CBpQL
         tN6g==
X-Gm-Message-State: AOAM530mQqmkI6rB+DeouxzlUU21gxHvyWx+jH6kusjrCCm+P2lfBJ5O
        BEhCkBEpGqAPZ9WG/1ibPaZLcBl4M+Rdvr3URgE=
X-Google-Smtp-Source: ABdhPJwb4AVINCLEyXkYxKOgZXcKWxkVnOShhUUYOwa1QJb4pxVEXJ2EYAWfXjH1ST26ZlDnbD6yyaMj/ZFRajjqwcE=
X-Received: by 2002:a05:6402:1a48:: with SMTP id bf8mr34988244edb.298.1600383969876;
 Thu, 17 Sep 2020 16:06:09 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 18 Sep 2020 09:05:58 +1000
Message-ID: <CAPM=9txcHEa3-tZK3N+SAznbfHU_61UcQ01gq99m6riHzU5OOw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.9-rc6
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

A bunch of small fixes, some of the i915 ones have been out for a
while and got better commit msg explaining some better reasoning
behind them. (hopefully this trend continues). Otherwise there a few
AMD related ones mostly small, one radeon PLL regression fix and a
bunch of small mediatek fixes.

I'm going to be offline for a couple of days in a few hours time, so
if anything is wrong let Daniel know as well.

Dave.

drm-fixes-2020-09-18:
drm fixes for 5.9-rc6

amdgpu:
- Sienna Cichlid fixes
- Navy Flounder fixes
- DC fixes

amdkfd:
- Fix a GPU reset crash
- Fix a memory leak

radeon:
- Revert a PLL fix that broke other boards

i915:
- Avoid exposing a partially constructed context
- Use RCU instead of mutex for context termination list iteration
- Avoid data race reported by KCSAN
- Filter wake_flags passed to default_wake_function

mediatek:
- Fix scrolling of panel
- Remove duplicated include
- Use CPU when fail to get cmdq event
- Add missing put_device() call
The following changes since commit 856deb866d16e29bd65952e0289066f6078af773=
:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-18

for you to fetch changes up to 1f08fde70075784d28d1687d0e75871e81cc1173:

  Merge tag 'mediatek-drm-fixes-5.9' of
https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux
into drm-fixes (2020-09-18 08:52:06 +1000)

----------------------------------------------------------------
drm fixes for 5.9-rc6

amdgpu:
- Sienna Cichlid fixes
- Navy Flounder fixes
- DC fixes

amdkfd:
- Fix a GPU reset crash
- Fix a memory leak

radeon:
- Revert a PLL fix that broke other boards

i915:
- Avoid exposing a partially constructed context
- Use RCU instead of mutex for context termination list iteration
- Avoid data race reported by KCSAN
- Filter wake_flags passed to default_wake_function

mediatek:
- Fix scrolling of panel
- Remove duplicated include
- Use CPU when fail to get cmdq event
- Add missing put_device() call

----------------------------------------------------------------
Andrey Grodzovsky (1):
      drm/amdgpu: Include sienna_cichlid in USBC PD FW support.

Bhawanpreet Lakha (2):
      drm/amd/display: Don't use DRM_ERROR() for DTM add topology
      drm/amd/display: Don't log hdcp module warnings in dmesg

Chris Wilson (4):
      drm/i915/gem: Delay tracking the GEM context until it is registered
      drm/i915/gem: Reduce context termination list iteration guard to RCU
      drm/i915: Be wary of data races when reading the active execlists
      drm/i915: Filter wake_flags passed to default_wake_function

Christian K=C3=B6nig (1):
      drm/radeon: revert "Prefer lower feedback dividers"

Chun-Kuang Hu (1):
      drm/mediatek: Use CPU when fail to get cmdq event

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-5.9-2020-09-17' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2020-09-17' of
ssh://git.freedesktop.org/git/drm/drm-intel into drm-fixes
      Merge tag 'mediatek-drm-fixes-5.9' of
https://git.kernel.org/.../chunkuang.hu/linux into drm-fixes

Dennis Li (2):
      drm/kfd: fix a system crash issue during GPU recovery
      drm/amdkfd: fix a memory leak issue

Jiansong Chen (2):
      drm/amd/pm: support runtime pptable update for sienna_cichlid etc.
      drm/amdgpu: declare ta firmware for navy_flounder

Jitao Shi (1):
      drm/mediatek: dsi: Fix scrolling of panel with small hfp or hbp

Jun Lei (1):
      drm/amd/display: update nv1x stutter latencies

Michel D=C3=A4nzer (1):
      drm/amdgpu/dc: Require primary plane to be enabled whenever the CRTC =
is

Wang Hai (1):
      drm/mediatek: Remove duplicated include

Yu Kuai (4):
      drm/mediatek: Add missing put_device() call in mtk_ddp_comp_init()
      drm/mediatek: Add exception handing in mtk_drm_probe() if
component init fail
      drm/mediatek: Add missing put_device() call in mtk_drm_kms_init()
      drm/mediatek: Add missing put_device() call in mtk_hdmi_dt_parse_pdat=
a()

 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c             |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 32 +++++----------
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  4 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_log.h    |  2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp_psp.c    |  2 +-
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 12 ++++--
 drivers/gpu/drm/i915/gem/i915_gem_context.c        | 48 ++++++++++++++----=
----
 drivers/gpu/drm/i915/gt/intel_lrc.c                | 15 +++++--
 drivers/gpu/drm/i915/i915_request.c                | 25 ++++++++++-
 drivers/gpu/drm/i915/i915_sw_fence.c               | 10 +++--
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c            | 20 +++++----
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  1 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             | 19 ++++++---
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |  9 ++--
 drivers/gpu/drm/mediatek/mtk_hdmi.c                | 26 ++++++++----
 drivers/gpu/drm/radeon/radeon_display.c            |  2 +-
 18 files changed, 149 insertions(+), 86 deletions(-)
