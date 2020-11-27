Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909BD2C60FD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgK0Ih3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgK0Ih1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:37:27 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEFBC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 00:37:27 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p8so4675744wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 00:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=NDd+7z81kqxX5piqbpfyRlic4o5pYUfJiTr8VIVMAwk=;
        b=duqrO+slaSekFQIaVaefH/GoN5TBOwJkWFY6MwVBII6vbLTsHCcgeV8NS66cATVKBG
         oScI8Og3cU2ukfP+0zzIf4Z2ENggjAHUF9ixd0TZs0CVJqwdb1g75VExz7pVw9Mht5oF
         n0KU+Ze0fBIUXhJBffiRLgVKl7x3Qj4jIlDI3BJxONZFuczgqHK6tV4AZ2fF/I7S6nqT
         nq4KNCWegjenqIkEDPuqe+v7qMFkURj8O+thUgl5uoJA27vJOrTZUz4oZv4bCX5JFyKd
         XLzFsZKMeicljQ9trblr222HA6ug7sHvXvMXXzKhHAc/xyear/EFBUvKXlZjqEq702gP
         RqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=NDd+7z81kqxX5piqbpfyRlic4o5pYUfJiTr8VIVMAwk=;
        b=sARlSPzeA1NmphtK+uyWU0fYHWMYLMvqWl/Tb0lKjHBvYxFQKh3jo95UX51AeS7aJE
         Q3vRexT4enFysR6SJpb9wM0qXnxYxc7L3aeiowCHtbPkbBHmfUD1gFCEpL7+YR7VnCuL
         +J3x5ga60TO19lTJhho/QFd/7uXlZJ1doq0Kyk9mhExmVX8GN+uZU8+QBiMg6pTG5mmk
         FArwJP0qsJuQcmGcA9sKOaEbgRpzZAp/E6lHPg8SGa6s0xhq4zBxhLgC7k7ry7anj+1K
         HCNJQlfYbGdbzIM9IgGGlbunHWAGGORCu/ffm/DhxGA0sNrxvFG72TNMBFqOtLrV22le
         kH3g==
X-Gm-Message-State: AOAM530VBeoM5As1Lm4/K3yuFhLmaZd08mfecBnBqg951YTMMzz6s27K
        StIthYlu/+CC1Oy4+XqO/wXcvneNbY+OwFmrAOU=
X-Google-Smtp-Source: ABdhPJz0kKRrGagcl+ZuMZe7LxLu6jAumaDMp8wDkK9v5db2bkJAjMVfaZStb7FyftH259YqBWhjutzTNfO1Qb8E9Zs=
X-Received: by 2002:adf:f9c6:: with SMTP id w6mr8856515wrr.273.1606466245972;
 Fri, 27 Nov 2020 00:37:25 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 27 Nov 2020 18:37:15 +1000
Message-ID: <CAPM=9twQYg5nf=wGOMm=i=++dZswSvpkV2txDnBYFmj=SRDx9A@mail.gmail.com>
Subject: [git pull] drm fixes for 5.10-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Bit of a delay as fd.o anongit was acting up a bit today, hopefully it
stays up this time. Unfortunately this has a bit of thanksgiving
stuffing in it, as it a bit larger (at least the vc4 patches) than I
like at this point in time.

The main thing is it has a bunch of regressions fixes for reports in
the last  couple of weeks, ast, nouveau and the amdgpu ttm init fix,
along with the usual selection of amdgpu and i915 fixes.

The vc4 fixes are a few but they are fixes and the nastiest one is a
fix for when you have a 2.4Ghz Wifi and a HDMI signal with a clock in
that range and there isn't enough shielding and interference happen
between the two, the fix adjusts the mode clock to try and avoid the
wifi channels in that case.

Hopefully you can merge this between turkey slices, and next week
should be quieter.

Dave.

drm-fixes-2020-11-27-1:
drm fixes for 5.10-rc6

ast:
- LUT loading regression fix

nouveau:
- relocations regression fix

amdgpu:
- ttm init oops fix
- Runtime pm fix
- SI UVD suspend/resume fix
- HDCP fix for headless cards
- Sienna Cichlid golden register update

i915:
- Fix Perf/OA workaround register corruption (Lionel)
- Correct a comment statement in GVT (Yan)
- Fix GT enable/disable iterrupts, including a race condition that
prevented GPU to go idle (Chris)
- Free stale request on destroying the virtual engine (Chris)

exynos:
- config dependency fix

mediatek:
- unused var removal
- horizonal front/back porch formula fix

vc4:
- wifi and hdmi interference fix
- mode rejection fixes
- use after free fix
- cleanup some code
The following changes since commit 418baf2c28f3473039f2f7377760bd8f6897ae18:

  Linux 5.10-rc5 (2020-11-22 15:36:08 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-11-27-1

for you to fetch changes up to 9595930db4bb91433607441a5f26d90e9c6e34eb:

  Merge tag 'drm-misc-fixes-2020-11-26' of
ssh://git.freedesktop.org/git/drm/drm-misc into drm-fixes (2020-11-27
09:39:51 +1000)

----------------------------------------------------------------
drm fixes for 5.10-rc6

ast:
- LUT loading regression fix

nouveau:
- relocations regression fix

amdgpu:
- ttm init oops fix
- Runtime pm fix
- SI UVD suspend/resume fix
- HDCP fix for headless cards
- Sienna Cichlid golden register update

i915:
- Fix Perf/OA workaround register corruption (Lionel)
- Correct a comment statement in GVT (Yan)
- Fix GT enable/disable iterrupts, including a race condition that
prevented GPU to go idle (Chris)
- Free stale request on destroying the virtual engine (Chris)

exynos:
- config dependency fix

mediatek:
- unused var removal
- horizonal front/back porch formula fix

vc4:
- wifi and hdmi interference fix
- mode rejection fixes
- use after free fix
- cleanup some code

----------------------------------------------------------------
CK Hu (1):
      drm/mediatek: dsi: Modify horizontal front/back porch byte formula

Chris Wilson (4):
      drm/i915/gt: Defer enabling the breadcrumb interrupt to after submission
      drm/i915/gt: Track signaled breadcrumbs outside of the breadcrumb spinlock
      drm/i915/gt: Don't cancel the interrupt shadow too early
      drm/i915/gt: Free stale request on destroying the virtual engine

Dave Airlie (5):
      Merge tag 'amd-drm-fixes-5.10-2020-11-25' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2020-11-25' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'exynos-drm-fixes-for-v5.10-rc6' of
git://git.kernel.org/.../daeinki/drm-exynos into drm-fixes
      Merge tag 'mediatek-drm-fixes-5.10' of
https://git.kernel.org/.../chunkuang.hu/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2020-11-26' of
ssh://git.freedesktop.org/git/drm/drm-misc into drm-fixes

Enric Balletbo i Serra (1):
      drm/mediatek: mtk_dpi: Fix unused variable 'mtk_dpi_encoder_funcs'

Kenneth Feng (1):
      drm/amd/amdgpu: fix null pointer in runtime pm

Krzysztof Kozlowski (1):
      drm/exynos: depend on COMMON_CLK to fix compile tests

Likun Gao (1):
      drm/amdgpu: update golden setting for sienna_cichlid

Lionel Landwerlin (1):
      drm/i915/perf: workaround register corruption in OATAILPTR

Matti Hamalainen (1):
      drm/nouveau: fix relocations applying logic and a double-free

Maxime Ripard (11):
      drm/vc4: hdmi: Make sure our clock rate is within limits
      drm/vc4: hdmi: Block odd horizontal timings
      drm/vc4: kms: Switch to drmm_add_action_or_reset
      drm/vc4: kms: Remove useless define
      drm/vc4: kms: Rename NUM_CHANNELS
      drm/vc4: kms: Split the HVS muxing check in a separate function
      drm/vc4: kms: Document the muxing corner cases
      dt-bindings: display: Add a property to deal with WiFi coexistence
      drm/vc4: hdmi: Disable Wifi Frequencies
      drm/vc4: kms: Store the unassigned channel list in the state
      drm/vc4: kms: Don't disable the muxing of an active CRTC

Rodrigo Siqueira (1):
      drm/amd/display: Avoid HDCP initialization in devices without output

Sonny Jiang (2):
      drm/amdgpu: fix SI UVD firmware validate resume fail
      drm/amdgpu: fix a page fault

Thomas Zimmermann (1):
      drm/ast: Reload gamma LUT after changing primary plane's color format

Yan Zhao (1):
      drm/i915/gvt: correct a false comment of flag F_UNALIGN

xinhui pan (1):
      drm/amdgpu: Fix size calculation when init onchip memory

 .../bindings/display/brcm,bcm2711-hdmi.yaml        |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h            |   1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |   2 +
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c              |  20 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 +-
 drivers/gpu/drm/ast/ast_mode.c                     |  17 +-
 drivers/gpu/drm/exynos/Kconfig                     |   3 +-
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c        | 143 +++++++-----
 drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h  |   2 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  60 ++++-
 drivers/gpu/drm/i915/gvt/gvt.h                     |   2 +-
 drivers/gpu/drm/i915/i915_perf.c                   |   9 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   2 +
 drivers/gpu/drm/i915/i915_request.h                |   6 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |   9 -
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |  61 ++----
 drivers/gpu/drm/nouveau/nouveau_gem.c              |   8 +-
 drivers/gpu/drm/vc4/vc4_drv.h                      |   4 +
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  48 ++++
 drivers/gpu/drm/vc4/vc4_hdmi.h                     |  11 +
 drivers/gpu/drm/vc4/vc4_kms.c                      | 244 +++++++++++++++------
 23 files changed, 475 insertions(+), 193 deletions(-)
