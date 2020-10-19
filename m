Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526A1292219
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 07:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgJSFVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 01:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgJSFVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 01:21:53 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED52C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 22:21:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dg9so8835693edb.12
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 22:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=2uPYSGQKvJLYPAzFohIDpVs/fazvOwPDq1JWkZXj1bk=;
        b=eC2j7KaFXxugAEhTp3VeKbXcZaR8HnY4+KUUJxk2fmHajH3HExtf6nQ1S4Um8+F1rL
         jiOD8HQYcV3Zisx/xCxlxImKmB7b2G8Blbz9EBaPzxViFEisz7xHK77OVQ5HC71mXrec
         lt+oB+Apb2+F4N7Urcgg7FIBMswre5b17W3GuH4rXexD+kaAJdk28zLsPk/PZA7AxGHi
         8KdvF3Wpg8IsTD9bTiV776LdJGYfO0/bIZGOehSm+JPEWg4n9vgezAqrX3u28T3GUVkq
         SeX8tRTZpZtxBanzBIAlnQXUqs2nrCVe+GtjAk906FpLUShbFZyqBikd0gz6Qs+2V2An
         yN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=2uPYSGQKvJLYPAzFohIDpVs/fazvOwPDq1JWkZXj1bk=;
        b=aVb6ZJL1XQhfxtDUn2uTIZbmw7guh0wiNhfNCeGx9FD+ErxAnSSujOrRKBeKzRt4T5
         Jj+OU8y5255BbsDwWxdRBf3PV6XLJHqiSgDDItFjaH3Cc3XRELDK49UJA/T94EOC6hFY
         wMW5tT64piUsNWJV1eaHWnpR04Qfyrim2yJRykyHco/RCcrJXsqtXV6jcn3vDmOs/5To
         XeLdWVroMDpYtSfd+mQoKfGXF1EdRBJhVmiMrFiRPcOPndk4eXBi5KMLP71g9eqEZ+sB
         XxkTKgsPdFNp79H++Hzir1P5s0F7vfvz3sHF2JdRxCYrJqor2Jbxu7tuVOdtB3cDCLls
         Qh5w==
X-Gm-Message-State: AOAM531STQiuS7TdCzgmlbIQpjxsYlAZXEf9s/VR1j7CV5M5aM6+O2Jw
        jx3CbxT9ZXBWGiqnjoxT4N9MU8FOgfGfOFHuJiCIzOa5nsQ=
X-Google-Smtp-Source: ABdhPJyg+hdeN9q1sKdaPImjCa9sjqJS6kmZU7T+uBcdCa5GPLPTxLGVZG+LGDvU7zbq9SCmhaqQZNIQkpr3eUpFMjI=
X-Received: by 2002:a50:d987:: with SMTP id w7mr16206740edj.113.1603084911889;
 Sun, 18 Oct 2020 22:21:51 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 19 Oct 2020 15:21:40 +1000
Message-ID: <CAPM=9tyGF24NcUraYx7shazjkZ=c2sukykcxZE-u6L-qekCvbw@mail.gmail.com>
Subject: [git pull] drm fixes for 5.10-rc1
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

Some fixes queued up already for i915 and amdgpu, I've also included
the fix for the clang warning you've seen.

Dave.

drm-next-2020-10-19:
drm fixes for 5.10-rc1

i915:
- Set all unused color plane offsets to ~0xfff again (Ville)
- Fix TGL DKL PHY DP vswing handling (Ville)

amdgpu:
- DCN clang warning fix
- eDP fix
- BACO fix
- Kernel documentation fixes
- SMU7 mclk fix
- VCN1 hw bug workaround

amdkfd:
- kvfree vs kfree fix
The following changes since commit 640eee067d9aae0bb98d8706001976ff1affaf00=
:

  Merge tag 'drm-misc-next-fixes-2020-10-13' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2020-10-14
07:31:53 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-10-19

for you to fetch changes up to 40b99050455b9a6cb8faf15dcd41888312184720:

  Merge tag 'drm-intel-next-fixes-2020-10-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next (2020-10-19
09:21:59 +1000)

----------------------------------------------------------------
drm fixes for 5.10-rc1

i915:
- Set all unused color plane offsets to ~0xfff again (Ville)
- Fix TGL DKL PHY DP vswing handling (Ville)

amdgpu:
- DCN clang warning fix
- eDP fix
- BACO fix
- Kernel documentation fixes
- SMU7 mclk fix
- VCN1 hw bug workaround

amdkfd:
- kvfree vs kfree fix

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/swsmu: init the baco mutex in early_init

Dave Airlie (2):
      Merge tag 'amd-drm-fixes-5.10-2020-10-14' of
git://people.freedesktop.org/~agd5f/linux into drm-next
      Merge tag 'drm-intel-next-fixes-2020-10-15' of
git://anongit.freedesktop.org/drm/drm-intel into drm-next

Eryk Brol (1):
      drm/amd/display: Fix incorrect dsc force enable logic

Evan Quan (1):
      drm/amd/pm: increase mclk switch threshold to 200 us

Kent Russell (1):
      drm/amdkfd: Use kvfree in destroy_crat_image

Mauro Carvalho Chehab (2):
      drm/amd/display: kernel-doc: document force_timing_sync
      docs: amdgpu: fix a warning when building the documentation

Rodrigo Siqueira (1):
      drm/amd/display: Fix module load hangs when connected to an eDP

Veerabadhran G (1):
      drm/amdgpu: vcn and jpeg ring synchronization

Ville Syrj=C3=A4l=C3=A4 (2):
      drm/i915: Fix TGL DKL PHY DP vswing handling
      drm/i915: Set all unused color plane offsets to ~0xfff again

 Documentation/gpu/amdgpu.rst                       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c            |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h            |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c             | 24 +++++++++++++++++-=
-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c              | 28 ++++++++++++++++++=
----
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.h              |  3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c              |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |  2 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           | 10 ++++----
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |  2 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c          |  7 +++---
 drivers/gpu/drm/i915/display/intel_ddi.c           |  2 +-
 drivers/gpu/drm/i915/display/intel_display.c       | 17 ++++---------
 14 files changed, 72 insertions(+), 34 deletions(-)
