Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B182D6CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389228AbgLKBEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbgLKBDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:03:55 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8202CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:03:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id cw27so7604333edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JqZruslsHjpa4eJlIAlthpxG4wQdLwUtXP9Ew+6KXH0=;
        b=Lw19MdtvQu2zmLAzMsJvesNgy6J7GAP53BleHH76EKDjvmE+azlg8AaN+C5ySc3vS5
         uLfBASKzMDthhSUvd3nE6oMYBBZiaX80KOYqLOEdwP66xnGj6XeqtKof9DA46wLGo2Z0
         lwlThQLdpnDksS2w9lb1VnaYBu1nyPkhgva6qMDSkBPnl+TrqnRnzLbytTWSsRTfijiH
         xShM1ddMazQ6l/9RtpWp2Qc/ptNMxm8DBJ3zn2zYkglFSWlc+WQYDUBJUb46jAoZtM6A
         tO0hlzhGpYgq0Ex9McCvIvsOWXl5RBRt4KAGZ0SlJ0rXNrQOPbtvs4FdPoWZwz0xm/6l
         mpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JqZruslsHjpa4eJlIAlthpxG4wQdLwUtXP9Ew+6KXH0=;
        b=YqhQ26nhxI2705UmnTl5MzwVOq46Oiwj8TTx46ugNKmXI/MVzak+jgUg6gb7W45ECn
         mYHQeDErE6Q7y0XAPF5pBHRdkxlEA7FKiJF02KVqRDwWeR4rTbUNsWMB0GpY89+YuPmK
         +o+NT63+Zbt9Ycz4Xi8Xw5igFS6MHYZE1pWA8wOTuXQuYNrAFZnM5cPhWjqCxbBo23pk
         2scfB75WBEDIlSu42Fbct5JqYuxX5vHTy7bHRhQStkGmw1oqzBeXdFVVRINguE7gDLVS
         0G9j7QY8FlxyZ/m5eZS52MId7jE5IhCk6MAOTtOCJUV8ZMgArlbZ5Z6d+LganAmUZ/rq
         M8Bg==
X-Gm-Message-State: AOAM532764xWHPFJF5fzziJc50uv0LQt14EC5EvDfPmr63NZHsfwA6uW
        iPHUIdsuyn9SbHb+CwxYVQ2HwXFXatrMKAGbSgI=
X-Google-Smtp-Source: ABdhPJxZUB5LIsBWgjwwzSyo2a9ZiQaWfhgHHGiGFRFIbzlBb9AAwaX0oz46/wTMvjv1RjuWns2t6mDjoqFJ7TT89uM=
X-Received: by 2002:a05:6402:20a:: with SMTP id t10mr9277445edv.119.1607648593056;
 Thu, 10 Dec 2020 17:03:13 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 11 Dec 2020 11:03:01 +1000
Message-ID: <CAPM=9txOVY0jehFoHQwb=4PCr+a9Bg_x9u_7484uPYg62UsLog@mail.gmail.com>
Subject: [git pull] drm fixes for 5.10 final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Last week of fixes, just amdgpu and i915 collections. We had a i915
regression reported by HJ Lu reported this morning, and this contains
a fix for that he has tested.

There are a fair few other fixes, but they are spread across the two
drivers, and all fairly self contained.

I'm going to send you out drm-next for next week in a few hours as I'm
going on holidays until next Friday, I likely won't be checking email
too closely, but Daniel should be available for any emergency.

Dave.

drm-fixes-2020-12-11:
drm fixes for 5.10 final

amdgpu:
- Fan fix for CI asics
- Fix a warning in possible_crtcs
- Build fix for when debugfs is disabled
- Display overflow fix
- Display watermark fixes for Renoir
- SDMA 5.2 fix
- Stolen vga memory regression fix
- Power profile fixes
- Fix a regression from removal of GEM and PRIME callbacks

amdkfd:
- Fix a memory leak in dmabuf import

i915:
- rc7 regression fix for modesetting
- vdsc/dp slice fixes
- gen9 mocs entries fix
- preemption timeout fix
- unsigned compare against 0 fix
- selftest fix
- submission error propogating fix
- request flow suspend fix
The following changes since commit 0477e92881850d44910a7e94fc2c46f96faa131f:

  Linux 5.10-rc7 (2020-12-06 14:25:12 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-12-11

for you to fetch changes up to b1f195fc49812359296a901e26cc7c0b761d8a70:

  drm/i915/display: Go softly softly on initial modeset failure
(2020-12-11 09:54:30 +1000)

----------------------------------------------------------------
drm fixes for 5.10 final

amdgpu:
- Fan fix for CI asics
- Fix a warning in possible_crtcs
- Build fix for when debugfs is disabled
- Display overflow fix
- Display watermark fixes for Renoir
- SDMA 5.2 fix
- Stolen vga memory regression fix
- Power profile fixes
- Fix a regression from removal of GEM and PRIME callbacks

amdkfd:
- Fix a memory leak in dmabuf import

i915:
- rc7 regression fix for modesetting
- vdsc/dp slice fixes
- gen9 mocs entries fix
- preemption timeout fix
- unsigned compare against 0 fix
- selftest fix
- submission error propogatig fix
- request flow suspend fix

----------------------------------------------------------------
Alex Deucher (3):
      drm/amdgpu/powerplay: parse fan table for CI asics
      drm/amdgpu/disply: set num_crtc earlier
      drm/amdgpu: fix size calculation with stolen vga memory

Andrey Grodzovsky (1):
      drm/amdgpu: Initialise drm_gem_object_funcs for imported BOs

Arnd Bergmann (1):
      drm/amdgpu: fix debugfs creation/removal, again

Changfeng (1):
      drm/amd/pm: update smu10.h WORKLOAD_PPLIB setting for raven

Chris Park (1):
      drm/amd/display: Prevent bandwidth overflow

Chris Wilson (5):
      drm/i915/gem: Propagate error from cancelled submit due to context closure
      drm/i915/gt: Ignore repeated attempts to suspend request flow across reset
      drm/i915/gt: Cancel the preemption timeout on responding to it
      drm/i915/gt: Declare gen9 has 64 mocs entries!
      drm/i915/display: Go softly softly on initial modeset failure

Colin Ian King (1):
      drm/i915: fix size_t greater or equal to zero comparison

Dan Carpenter (1):
      drm/i915/gem: Check the correct variable in selftest

Dave Airlie (2):
      Merge tag 'amd-drm-fixes-5.10-2020-12-09' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2020-12-09' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes

Evan Quan (1):
      drm/amd/pm: typo fix (CUSTOM -> COMPUTE)

Felix Kuehling (1):
      drm/amdkfd: Fix leak in dmabuf import

Manasi Navare (1):
      drm/i915/display/dp: Compute the correct slice count for VDSC on DP

Stanley.Yang (1):
      drm/amdgpu: fix sdma instance fw version and feature version init

Sung Lee (1):
      drm/amd/display: Add wm table for Renoir

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c        |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            |  41 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c            |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c            |  13 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h            |   6 --
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c             |   2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c           |   2 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   9 +-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |  93 ++++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c      |   7 +-
 drivers/gpu/drm/amd/pm/inc/smu10.h                 |  14 ++-
 .../drm/amd/pm/powerplay/hwmgr/processpptables.c   | 103 ++++++++++++++++++++-
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c   |   9 +-
 .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |   2 +-
 drivers/gpu/drm/i915/display/intel_display.c       |   2 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c     |   7 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                |   7 +-
 drivers/gpu/drm/i915/gt/intel_mocs.c               |   7 +-
 drivers/gpu/drm/i915/gt/shmem_utils.c              |   2 +-
 drivers/gpu/drm/i915/selftests/i915_gem.c          |   4 +-
 21 files changed, 269 insertions(+), 74 deletions(-)
