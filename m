Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6AF2CE5B0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgLDC03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgLDC03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:26:29 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D252EC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 18:25:48 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a16so6521580ejj.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 18:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DO2xSdkoTjdlOhwLjGKycx0I0ttwZPhfw3VO7/8AxUA=;
        b=T3vNnr3UXhvrIChk0P38SJ3aAvOvz0eQDMiiVV+GIXFjTMAzrKc4tO5BXpjrBgIzfW
         WNX7zd/BKiPLKBqewKGcftbjZWlMuY67tn1k/k3K2i3MydW7q7pccI8S/KpjibgEaNLk
         GghIgPNcQPwk219BSK+zCXam5MktY/mvYhwtfMiFTUzK83sYYLOGWg709JIF34TCS70X
         NimUpEB73ECkfD1EK1MR6YioSqAduEkCYESIiX/P9qFQcspKFNXf8XSGApPUmxpbqLo6
         2tnc0BAFhMNuxzIeO589xCPudZNcYrWaVw6VOTaC5tmjwfOI+2T69qxcIy+OiWaw5oKB
         CFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=DO2xSdkoTjdlOhwLjGKycx0I0ttwZPhfw3VO7/8AxUA=;
        b=Sw+6jmNr8phmv1Tlw+YEYV/ma4zG8u97rGYpHv9kHWUn6DiEQKGgTYTZslSpMeCK31
         7MhVZXTHpcYj6Dd3AkWwC6uAVD2DKpoZOHXHUfmL/DqLYZp0K9me395hECKC7PrDHplx
         iixstEK2z3RCW6ENyztGJILGzB7FjXEi0MJaeTvXmHzgYQ1OJI30MbfBL2TnptvP8YNZ
         mlmpZjXEucz8qW+IvIBpa4WLMmfhD+5GY3GqtP/lP+JWQ4bLpbD538/A2kMlfLOdpm5C
         gp/5qj076TqkhF/ZjeoPJbIm227Tb+d4GTFIfcHE6lPNGc9qQdnxjR6pena5eBos8PJQ
         r40g==
X-Gm-Message-State: AOAM5332cuTYEjC7SBhlcHv241OCEijXq/47kyEo8UIH/3gu6KmQlz8/
        d76+9sAGbFCpRscytYPzyl7IF7GV1ZarMAlC1sY=
X-Google-Smtp-Source: ABdhPJxfOuXVdtTktLmenafSzfpdzVFlPqbHBlDMCs8mMrp368IyGcVhDWmU2Mq9POYlvQlShTUQzW2pjb32zWEYx7w=
X-Received: by 2002:a17:906:8152:: with SMTP id z18mr5346134ejw.317.1607048746941;
 Thu, 03 Dec 2020 18:25:46 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 4 Dec 2020 12:25:35 +1000
Message-ID: <CAPM=9twdEoUbczSb9v0vAFD7w1qfB8-89tP-xjAEq5P=uBezCw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.10-rc7
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

This week's regular fixes. i915 has fixes for a few races,
use-after-free, gpu hangs,
tegra just has some minor fixes that I didn't see much point in
hanging on to. The
nouveau fix is for all pre-nv50 cards and was reported a few times.
Otherwise it's
just some amdgpu, and a few misc fixes.

Regards,
Dave.

drm-fixes-2020-12-04:
drm fixes for 5.10-rc7

amdgpu:
- SMU11 manual fan fix
- Renoir display clock fix
- VCN3 dynamic powergating fix

i915:
- Program mocs:63 for cache eviction on gen9
- Protect context lifetime with RCU
- Split the breadcrumb spinlock between global and contexts
- Retain default context state across shrinking
- Limit frequency drop to RPe on parking
- Return earlier from intel_modeset_init() without display
- Defer initial modeset until after GGTT is initialized

nouveau:
- pre-nv50 regression fix

rockchip:
- uninitialised LVDS property fix

omap:
- bridge fix

panel:
- race fix

mxsfb:
- fence sync fix
- modifiers fix

tegra:
- idr init fix
- sor fixes
- output/of cleanup fix
The following changes since commit b65054597872ce3aefbc6a666385eabdf9e288da=
:

  Linux 5.10-rc6 (2020-11-29 15:50:50 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-12-04

for you to fetch changes up to de9b485d1dc993f1fb579b5d15a8176284627f4a:

  Merge tag 'drm-misc-fixes-2020-12-03' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2020-12-04
11:53:50 +1000)

----------------------------------------------------------------
drm fixes for 5.10-rc7

amdgpu:
- SMU11 manual fan fix
- Renoir display clock fix
- VCN3 dynamic powergating fix

i915:
- Program mocs:63 for cache eviction on gen9 (Chris)
- Protect context lifetime with RCU (Chris)
- Split the breadcrumb spinlock between global and contexts (Chris)
- Retain default context state across shrinking (Venkata)
- Limit frequency drop to RPe on parking (Chris)
- Return earlier from intel_modeset_init() without display (Jani)
- Defer initial modeset until after GGTT is initialized (Chris)

nouveau:
- pre-nv50 regression fix

rockchip:
- uninitialised LVDS property fix

omap:
- bridge fix

panel:
- race fix

mxsfb:
- fence sync fix
- modifiers fix

tegra:
- idr init fix
- sor fixes
- output/of cleanup fix

----------------------------------------------------------------
Arunpravin (1):
      drm/amdgpu/pm/smu11: Fix fan set speed bug

Boyuan Zhang (2):
      drm/amdgpu/vcn3.0: stall DPG when WPTR/RPTR reset
      drm/amdgpu/vcn3.0: remove old DPG workaround

Brandon Syu (1):
      drm/amd/display: Init clock value by current vbios CLKs

Chris Wilson (5):
      drm/i915/gt: Program mocs:63 for cache eviction on gen9
      drm/i915/gt: Protect context lifetime with RCU
      drm/i915/gt: Split the breadcrumb spinlock between global and context=
s
      drm/i915/gt: Limit frequency drop to RPe on parking
      drm/i915/display: Defer initial modeset until after GGTT is initialis=
ed

Christian K=C3=B6nig (1):
      drm/nouveau: make sure ret is initialized in nouveau_ttm_io_mem_reser=
ve

Daniel Abrecht (1):
      drm: mxsfb: Implement .format_mod_supported

Dave Airlie (4):
      Merge tag 'drm/tegra/for-5.10-rc7' of
ssh://git.freedesktop.org/git/tegra/linux into drm-fixes
      Merge tag 'drm-intel-fixes-2020-12-03' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'amd-drm-fixes-5.10-2020-12-02' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes
      Merge tag 'drm-misc-fixes-2020-12-03' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Deepak R Varma (1):
      drm/tegra: replace idr_init() by idr_init_base()

Jani Nikula (1):
      drm/i915/display: return earlier from intel_modeset_init() without di=
splay

Jon Hunter (1):
      drm/tegra: sor: Don't warn on probe deferral

Lucas Stach (1):
      drm: mxsfb: fix fence synchronization

Marc Zyngier (1):
      drm/tegra: sor: Ensure regulators are disabled on teardown

Paul Kocialkowski (1):
      drm/rockchip: Avoid uninitialized use of endpoint id in LVDS

Qinglang Miao (1):
      drm/tegra: sor: Disable clocks on error in tegra_sor_init()

Sebastian Reichel (1):
      drm/panel: sony-acx565akm: Fix race condition in probe

Thierry Reding (1):
      drm/tegra: output: Do not put OF node twice

Tomi Valkeinen (1):
      drm/omap: sdi: fix bridge enable/disable

Venkata Ramana Nayana (1):
      drm/i915/gt: Retain default context state across shrinking

 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c              |  25 ++-
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c  |  13 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     |   7 +-
 drivers/gpu/drm/i915/display/intel_display.c       |  24 +--
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c        | 168 +++++++++--------=
----
 drivers/gpu/drm/i915/gt/intel_breadcrumbs_types.h  |   6 +-
 drivers/gpu/drm/i915/gt/intel_context.c            |  15 +-
 drivers/gpu/drm/i915/gt/intel_context_types.h      |  23 ++-
 drivers/gpu/drm/i915/gt/intel_mocs.c               |  14 +-
 drivers/gpu/drm/i915/gt/intel_rps.c                |   4 +
 drivers/gpu/drm/i915/gt/shmem_utils.c              |   7 +-
 drivers/gpu/drm/i915/i915_request.h                |   6 +-
 drivers/gpu/drm/mxsfb/mxsfb_kms.c                  |  11 ++
 drivers/gpu/drm/nouveau/nouveau_bo.c               |   2 +-
 drivers/gpu/drm/omapdrm/dss/sdi.c                  |  10 +-
 drivers/gpu/drm/panel/panel-sony-acx565akm.c       |   2 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |   2 +-
 drivers/gpu/drm/tegra/drm.c                        |   2 +-
 drivers/gpu/drm/tegra/output.c                     |   1 -
 drivers/gpu/drm/tegra/sor.c                        |  76 +++++-----
 20 files changed, 233 insertions(+), 185 deletions(-)
