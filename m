Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EDD2BA01C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 02:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgKTB4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 20:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKTB4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:56:02 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB60C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 17:56:02 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id a186so6164177wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 17:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=N7bVOjtnq28P5S44wsw3TgMqekVGMHXn00P8fDMxIC4=;
        b=nJbQSnSRvJmbF58brY8nQydFNz5q7Xc0cjRR4d9yHKrzBbVpGG+HMv0iqeSUToJY8t
         RFaE2VvxnxUvXxpCjClZH8DD1iK42KNi2mqJhiaQGpdQvN4BsRtbKpkn5VVaXzgfSitN
         HhpC7gCsLNpSxlvE0BDQBrLPL1OvRQO5BkUfbuy7O39IBm13hnkg2V5lV91SZgkuxyP8
         OWMzuvdXE4iNw/96/5FfA52V1nZDfQEMa3CkmoRHXy74pmIomPtXJBBG09nJcP/7tZ1Y
         ZBHJYlOD++AHB2AFzdM00L/i4tnX2TE5lsFZVuRpFER5hxuM+FkgkhnkkxjYYjdQ+HFN
         NMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=N7bVOjtnq28P5S44wsw3TgMqekVGMHXn00P8fDMxIC4=;
        b=cX3jRJRksDBr2+zTq2J/bJkF9kCgyyd2d+LJYjkGN4V79BQLoBjA+elQzEFuVk/MCr
         eFZGSs0wZn9xF0M5oQuN3mDFWIIXREHxXysiN56/+gahImQzgNQ5f96MvdSof9Ncf5p1
         MmA/vn4B82v3YKO675K3rm46poMnlUWbBTB5/mqVoUkrdRK4tH20Ctziid+S6rfZUSaK
         AjvfPA8vWoLBxrbUbn6vRWzzSNN5ZEQwEZavk6eXSor88eCfJAWMSXXbJ7DBEhTH/7ES
         TiXFcVzGyChZ3vshlOsPJ4zZ/pn2US7lv5flS/OFZr1owo0nN0ycoO4/22bJuViaOdmv
         0JZA==
X-Gm-Message-State: AOAM532+8Q3dew4gTkaZgizqYb+JwfdNKFBSdfepp6MAW6Stc/g+RUk4
        huqRc6fkNiIUI6ExT/GQtFShHDOsVdqKTdUz7Xo=
X-Google-Smtp-Source: ABdhPJzMoLSeMddNFM3wPdaXLjfvh9morVSoLGdAV0EYh5k+EfzJqMadNZ9qAx5MgizbpdGpkN3rwhkiD9baNdn3ebw=
X-Received: by 2002:a1c:a185:: with SMTP id k127mr7166478wme.23.1605837360948;
 Thu, 19 Nov 2020 17:56:00 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 20 Nov 2020 11:55:49 +1000
Message-ID: <CAPM=9twCYAR-+-fYi-HwbhZOtqYkjVO3aVqX2oAPsFA+GgJarw@mail.gmail.com>
Subject: [git pull] drm fixes for v5.10-rc5
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

Weekly fixes pull. This contains some fixes for sun4i/dw-hdmi probing,
then amdgpu enables arcturus hw without experimental flag and two
other fixes and a group of i915 fixes.

It also has a backported from next fix for the warn on reported in
ast/drm_gem_vram_helper code in the rc1 pull request thread. The rc4
PR has a thread which initially looked to be the same problem, but I'm
going to chase that up next week a bit more as I don't think the
bisect landed anywhere useful.

Dave.

drm-fixes-2020-11-20-2:
drm fixes for v5.10-rc5

core:
- vram helper TTM regression fix

amdgpu:
- Pageflip fix for navi1x with 5 or 6 displays
- Remove experimental flag for Arcturus
- Fix regression in atomic commit tail rework

i915:
- Fix tgl power gating issue
- Memory leak fixes
- Selftest fixes
- Display bpc fix
- Fix TGL MOCS for PTE tracking

dw-hdmi:
- probing fix

sun4i:
- probing fix
The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576=
:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-11-20-2

for you to fetch changes up to 6600f9d52213b5c3455481b5c9e61cf5e305c0e6:

  Merge tag 'drm-intel-fixes-2020-11-19' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes (2020-11-20
11:21:54 +1000)

----------------------------------------------------------------
drm fixes for v5.10-rc5

core:
- vram helper TTM regression fix

amdgpu:
- Pageflip fix for navi1x with 5 or 6 displays
- Remove experimental flag for Arcturus
- Fix regression in atomic commit tail rework

i915:
- Fix tgl power gating issue
- Memory leak fixes
- Selftest fixes
- Display bpc fix
- Fix TGL MOCS for PTE tracking

dw-hdmi:
- probing fix

sun4i:
- probing fix

----------------------------------------------------------------
Alex Deucher (2):
      drm/amd/display: Add missing pflip irq for dcn2.0
      drm/amdgpu: remove experimental flag from arcturus

Chris Wilson (2):
      drm/i915/gt: Remember to free the virtual breadcrumbs
      drm/i915/gt: Fixup tgl mocs for PTE tracking

Colin Xu (1):
      drm/i915/gvt: Temporarily disable vfio_edid for BXT/APL

Dave Airlie (3):
      Merge tag 'amd-drm-fixes-5.10-2020-11-18' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2020-11-19' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2020-11-19' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Jonathan Liu (1):
      drm: bridge: dw-hdmi: Avoid resetting force in the detect function

Maxime Ripard (2):
      drm/sun4i: backend: Fix probe failure with multiple backends
      Merge tag 'drm/sun4i-dma-fix-pull-request' of
ssh://gitolite.kernel.org/.../mripard/linux into drm-misc-fixes

Rodrigo Siqueira (1):
      drm/amd/display: Always get CRTC updated constant values inside
commit tail

Rodrigo Vivi (2):
      drm/i915/tgl: Fix Media power gate sequence.
      Merge tag 'gvt-fixes-2020-11-17' of
https://github.com/intel/gvt-linux into drm-intel-fixes

Thomas Zimmermann (1):
      drm/vram-helper: Fix use of top-down placement

Tina Zhang (1):
      drm/i915/gvt: Set ENHANCED_FRAME_CAP bit

Tvrtko Ursulin (1):
      drm/i915: Avoid memory leak with more than 16 workarounds on a list

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Handle max_bpc=3D=3D16

Xiongfeng Wang (2):
      drm/i915/gvt: return error when failing to take the module reference
      drm/sun4i: dw-hdmi: fix error return code in sun8i_dw_hdmi_bind()

Zhang Xiaoxu (2):
      drm/i915/selftests: Fix wrong return value of perf_series_engines()
      drm/i915/selftests: Fix wrong return value of perf_request_latency()

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  8 ++++----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  3 ++-
 .../amd/display/dc/irq/dcn20/irq_service_dcn20.c   |  4 ++--
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |  6 ------
 drivers/gpu/drm/drm_gem_vram_helper.c              |  2 +-
 drivers/gpu/drm/i915/display/intel_display.c       |  3 ++-
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  1 +
 drivers/gpu/drm/i915/gt/intel_mocs.c               |  5 +++--
 drivers/gpu/drm/i915/gt/intel_rc6.c                | 22 +++++++++++++++++-=
----
 drivers/gpu/drm/i915/gt/intel_workarounds.c        |  4 +++-
 drivers/gpu/drm/i915/gvt/display.c                 |  2 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |  4 +++-
 drivers/gpu/drm/i915/gvt/vgpu.c                    |  3 ++-
 drivers/gpu/drm/i915/i915_reg.h                    | 12 +++++-------
 drivers/gpu/drm/i915/intel_pm.c                    | 13 -------------
 drivers/gpu/drm/i915/selftests/i915_request.c      |  8 ++++++--
 drivers/gpu/drm/sun4i/sun4i_backend.c              |  8 +++++++-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c              |  1 +
 18 files changed, 60 insertions(+), 49 deletions(-)
