Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AE82B15E5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 07:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgKMGlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 01:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgKMGlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 01:41:17 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2582FC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 22:41:17 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id o20so9432681eds.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 22:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=uUcn5XFlvNkAjTSpkJz/s0lX/G6tQphALps3Cv2iGtk=;
        b=uwRJkMUQYoe6XY3hGmrs02O5Jp3p5Q0AKTRhZwq9zT3nCiBzaCh/qJwQalSMV2vHiL
         qPt8FbMqVjVeXECVOEKrpe1z+URqPuyNf36unS/SCohtjwPmt4iWhiw4UxkFidLL1I+O
         IUge1RlM21z6V8LfJIb71z7eMQdtcHbGGOzkni96/ohh9Pq+Lf0MVc4O3EKdHEjMT7eD
         sZ/8mgug89hSgBXM/h9RFbK58sizNmfz1Rf64z1gFuQfGd3rB0IMGO/uKuy7U4PRTUOQ
         TXTnqo/6EG4jp9tLvpTmkalSdpNKsRp8wi83NgipNnjfilOS5Hb2b6Ex3m6WYlEg99b1
         4jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uUcn5XFlvNkAjTSpkJz/s0lX/G6tQphALps3Cv2iGtk=;
        b=jPOP3wWZjUYOJHrlkbviKzueUYWIXYcBQdvfdrgTuu0r5CLP5WIHVKcoHxVoocOS9/
         61P1Ur6xuPsixNk8q4SnM3ViDmH3pXhgiKABfpyb4nkM8vTELgi79cd2UZ5Wgw1FMUim
         iWnsRuvh77N79xNH8FdP7VjzEsmUxSsQxnNFG0VSdL6+XuIXC02O35lZq/l6/Iv1RGAF
         UFCZoARXiLNbYVXDSDOORACojtWCIuq7FpZ/YFQOS3VFzT8Mtprv2wdJCqTiDkPpyM+d
         I4F+pMemZwTStvzLoXyPGd7r3U/+QaWQnEqBFXp/D5XAzxr/d5FVyIGtX6PF5mihqF4m
         S47A==
X-Gm-Message-State: AOAM530kiSw0noliQ0Ii6RSgNeRs5DbmmnleWK56H8LyQY7noOncRVl9
        741TFcqA23XFFS/71Sz9ss5qLFfIY2h5ow5HoJEhytg9CJzyg9DL
X-Google-Smtp-Source: ABdhPJyeyA0ZcobWLrGNDaKdL20+g200WcTZaE8tsxLmnXENE14OExFJAIOODLKbba+NXdjeM+n+AjH2cftQ9IlyD0U=
X-Received: by 2002:a50:cc86:: with SMTP id q6mr1111642edi.78.1605249675863;
 Thu, 12 Nov 2020 22:41:15 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 13 Nov 2020 16:41:04 +1000
Message-ID: <CAPM=9txkA3-XwKMbxzZT6ZWq5jneJXYWneABHi02AxGnpvrPtA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.10-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Nearly didn't send you a PR this week at all, but a few things
trickled in over the day, not a huge amount here, some i915, amdgpu
and a bunch of misc fixes. I have a couple of nouveau fixes
outstanding due to the PR having the wrong base, I'll figure it out
next week.

Dave.

drm-fixes-2020-11-13:
drm fixes for 5.10-rc4

amdgpu:
- Pageflip fix for DCN3
- Declare TA firmware for green sardine
- Headless navi fix

i915:
- Pull phys pread/pwrite implementations to the backend
- Correctly set SFC capability for video engines

bridge:
- cdns Kconfig fix

hyperv_fb:
- fix missing include

gma500:
- oob access fix

mcde:
- unbalanced regulator fix
The following changes since commit f8394f232b1eab649ce2df5c5f15b0e528c92091:

  Linux 5.10-rc3 (2020-11-08 16:10:16 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-11-13

for you to fetch changes up to 41f3ed2cac86ba533ce6a334a2e7fae5c7082946:

  Merge tag 'amd-drm-fixes-5.10-2020-11-12' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2020-11-13
16:05:31 +1000)

----------------------------------------------------------------
drm fixes for 5.10-rc4

amdgpu:
- Pageflip fix for DCN3
- Declare TA firmware for green sardine
- Headless navi fix

i915:
- Pull phys pread/pwrite implementations to the backend
- Correctly set SFC capability for video engines

bridge:
- cdns Kconfig fix

hyperv_fb:
- fix missing include

gma500:
- oob access fix

mcde:
- unbalanced regulator fix

----------------------------------------------------------------
Bhawanpreet Lakha (1):
      drm/amd/display: Add missing pflip irq

Chris Wilson (1):
      drm/i915/gem: Pull phys pread/pwrite implementations to the backend

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2020-11-12' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2020-11-13' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.10-2020-11-12' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Linus Walleij (1):
      drm/mcde: Fix unbalanced regulator

Matthew Auld (1):
      drm/i915/gem: Allow backends to override pread implementation

Nishanth Menon (1):
      drm: bridge: cdns: Kconfig: Switch over dependency to ARCH_K3

Olaf Hering (1):
      video: hyperv_fb: include vmalloc.h

Roman Li (1):
      drm/amdgpu: add ta firmware load for green-sardine

Thomas Zimmermann (1):
      drm/gma500: Fix out-of-bounds access to struct drm_device.vblank[]

Tianci.Yin (1):
      drm/amdgpu: enable DCN for navi10 headless SKU

Venkata Sandeep Dhanalakota (1):
      drm/i915: Correctly set SFC capability for video engines

 drivers/gpu/drm/amd/amdgpu/nv.c                    |  3 +-
 drivers/gpu/drm/amd/amdgpu/psp_v12_0.c             |  1 +
 .../amd/display/dc/irq/dcn30/irq_service_dcn30.c   |  4 +-
 drivers/gpu/drm/bridge/cadence/Kconfig             |  2 +-
 drivers/gpu/drm/gma500/psb_irq.c                   | 34 +++++--------
 drivers/gpu/drm/i915/gem/i915_gem_object_types.h   |  2 +
 drivers/gpu/drm/i915/gem/i915_gem_phys.c           | 55 ++++++++++++++++++++++
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |  3 +-
 drivers/gpu/drm/i915/i915_gem.c                    | 32 +++----------
 drivers/gpu/drm/mcde/mcde_drv.c                    |  8 +++-
 drivers/video/fbdev/hyperv_fb.c                    |  1 +
 11 files changed, 90 insertions(+), 55 deletions(-)
