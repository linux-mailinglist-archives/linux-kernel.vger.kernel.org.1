Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124C62FF92E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 01:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbhAVABu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 19:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbhAVABq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 19:01:46 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD932C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 16:01:02 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id w1so5117252ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 16:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FKS/bK9Sc/kB/Per2slomt2ErmCbwU2Q7apg5wkkqYM=;
        b=rYbx5rF3ZHjjkdaD0U+uhAgckvNl4jRnZZ6mMPYRdZI2+KQpQjsGdsiDMtbMLiq3RI
         C0H2y1Qrv1954G/lMoDlZpaGieQTy0NrKes7sOjKW8QjGOZbpVL4MWGuudf+L3rwJ8dc
         cbegNMzW8zrOxzkeby1TETGJZVehNGJTl3jdk1Qze5fpcNHBXa2oa/ygzPYAT6/wqZrZ
         0Vn27farTikITGueWo5J7AKYmobfxPbUYWvxzsESUOFEg6b/vNCZTdE1jewr1jSckQHT
         6d5MWYTLP7hoAyS4sdowLNvmsCYyLihdbEH8uHeXGgvRXpSP6es236FybQyA4zk2AFhk
         ec1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=FKS/bK9Sc/kB/Per2slomt2ErmCbwU2Q7apg5wkkqYM=;
        b=FwIIWIn3RLGBwCPPZGYPZYpX6owlID6bJXkLgSXpBgNelEfLXqA3RE6s+wqLlZ1XtQ
         3igSpLkJogBnnM25u8+YR1kxgC06aVD6I4zRLLVQ0IPjahJecfrr24AbTb1p9Vu8iAUV
         AXbwZ3qunviQ6whdKraj6aoog+jQqEtjTJJSHzRbRaI1fpGpxMGknAEDBJCosowEiDLk
         V6dE3p9jxcRLntoFvXkppI2QpInSbfI3FOrXRiGLT66FHwLA56tAs5KhtUGFXOGXDiuj
         BByr9xZkZQIkK4ohK4+LzT5G3tfC55BUcIiY8jJmiAWC9EjHpIBj0ce0f1r16MnHjMdE
         iUJg==
X-Gm-Message-State: AOAM531qphTdZfHpJjOgxneR4Ij1NxfFq2jIYqESU4klXeqmFXhEFkfc
        9A4yNE8ld1XARsXogniDfljaAm9f5qhtb/Oh6F4=
X-Google-Smtp-Source: ABdhPJwoYb3nl8XRBeS/CCRtrNLCwirvmVQKKcOWBENPn4yH/UXfAfgnVCbLsTFZ3TU4brgZZCuFH4mInhEfuclMXPk=
X-Received: by 2002:a17:907:7292:: with SMTP id dt18mr1293567ejc.317.1611273661542;
 Thu, 21 Jan 2021 16:01:01 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 22 Jan 2021 10:00:50 +1000
Message-ID: <CAPM=9txc42qTPjmjChm3Z9itOp7-O=YivoG0oa8DsRMFriF4bA@mail.gmail.com>
Subject: [git pull] drm fixes for 5.11-rc5
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

Regular fixes pull, nothing too major in here, just some core fixes,
one vc4, bunch of i915 and a bunch of amdgpu.

Dave.

drm-fixes-2021-01-22:
drm fixes for 5.11-rc5

core:
- atomic: Release state on error
- syncobj: Fix use-after-free
- ttm: Don't use GFP_TRANSHUGE_LIGTH
- vram-helper: Fix memory leak in vmap

vc4:
- Unify driver naming for PCM

i915:
- HDCP fixes
- PMU wakeref fix
- Fix HWSP validity race
- Fix DP protocol converter accidental 4:4:4->4:2:0 conversion for RGB

amdgpu:
- Green Sardine fixes
- Vangogh fixes
- Renoir fixes
- Misc display fixes
The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31=
:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2021-01-22

for you to fetch changes up to 06ee38dc2aab3b5a09feb74128cf7326a490b788:

  Merge tag 'amd-drm-fixes-5.11-2021-01-21' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes (2021-01-22
09:43:21 +1000)

----------------------------------------------------------------
drm fixes for 5.11-rc5

core:
- atomic: Release state on error
- syncobj: Fix use-after-free
- ttm: Don't use GFP_TRANSHUGE_LIGTH
- vram-helper: Fix memory leak in vmap

vc4:
- Unify driver naming for PCM

i915:
- HDCP fixes
- PMU wakeref fix
- Fix HWSP validity race
- Fix DP protocol converter accidental 4:4:4->4:2:0 conversion for RGB

amdgpu:
- Green Sardine fixes
- Vangogh fixes
- Renoir fixes
- Misc display fixes

----------------------------------------------------------------
Aaron Liu (1):
      drm/amdgpu: update mmhub mgcg&ls for mmhub_v2_3

Anshuman Gupta (2):
      drm/i915/hdcp: Update CP property in update_pipe
      drm/i915/hdcp: Get conn while content_type changed

Aric Cyr (1):
      drm/amd/display: Allow PSTATE chnage when no displays are enabled

Bing Guo (1):
      drm/amd/display: Change function decide_dp_link_settings to
avoid infinite looping

Chris Wilson (2):
      drm/i915/gt: Prevent use of engine->wa_ctx after error
      drm/i915: Check for rq->hwsp validity after acquiring RCU lock

Christian K=C3=B6nig (1):
      drm/ttm: stop using GFP_TRANSHUGE_LIGHT

Daniel Vetter (1):
      drm/syncobj: Fix use-after-free

Dave Airlie (3):
      Merge tag 'drm-misc-fixes-2021-01-20' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes
      Merge tag 'drm-intel-fixes-2021-01-21' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.11-2021-01-21' of
https://gitlab.freedesktop.org/agd5f/linux into drm-fixes

Huang Rui (1):
      drm/amdgpu: remove gpu info firmware of green sardine

Jake Wang (1):
      drm/amd/display: Update dram_clock_change_latency for DCN2.1

Jinzhou Su (1):
      drm/amdgpu: modify GCR_GENERAL_CNTL for Vangogh

Nicholas Kazlauskas (1):
      drm/amd/display: Use hardware sequencer functions for PG control

Nicolas Saenz Julienne (1):
      drm/vc4: Unify PCM card's driver_name

Pan Bian (1):
      drm/atomic: put state on error path

Prike Liang (1):
      drm/amdgpu/pm: no need GPU status set since
mmnbif_gpu_BIF_DOORBELL_FENCE_CNTL added in FSDL

Sung Lee (1):
      drm/amd/display: DCN2X Find Secondary Pipe properly in MPO + ODM Case

Thomas Zimmermann (1):
      drm/vram-helper: Reuse existing page mappings in vmap

Tvrtko Ursulin (1):
      drm/i915/pmu: Don't grab wakeref when enabling events

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Only enable DFP 4:4:4->4:2:0 conversion when
outputting YCbCr 4:4:4

Vladimir Stempen (1):
      drm/amd/display: Fixed corruptions on HPDRX link loss restore

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c            | 84 ++++++++++++++++--=
----
 .../amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c   |  6 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c   |  7 +-
 .../drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c  | 18 +++--
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c |  9 ++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c  |  7 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_resource.c  |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c    |  2 +-
 drivers/gpu/drm/drm_atomic_helper.c                |  2 +-
 drivers/gpu/drm/drm_gem_vram_helper.c              | 14 +++-
 drivers/gpu/drm/drm_syncobj.c                      |  8 ++-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  2 +-
 drivers/gpu/drm/i915/display/intel_dp.c            |  9 +--
 drivers/gpu/drm/i915/display/intel_dp.h            |  3 +-
 drivers/gpu/drm/i915/display/intel_hdcp.c          |  9 +++
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c        |  9 +--
 drivers/gpu/drm/i915/gt/intel_lrc.c                |  3 +
 drivers/gpu/drm/i915/gt/intel_timeline.c           | 10 ++-
 drivers/gpu/drm/i915/i915_pmu.c                    | 30 ++++----
 drivers/gpu/drm/i915/i915_request.h                | 37 ++++++++--
 drivers/gpu/drm/ttm/ttm_pool.c                     | 11 +--
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  1 +
 24 files changed, 198 insertions(+), 90 deletions(-)
