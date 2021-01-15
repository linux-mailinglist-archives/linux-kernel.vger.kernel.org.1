Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCA72F71D1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 05:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbhAOE45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 23:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbhAOE45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 23:56:57 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0E3C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 20:56:16 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id l9so5805280ejx.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 20:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mxwbkeVE3TgRsWHUczpony1YcNS7sLgn9lbDauIHtGc=;
        b=TmnfiBZSVRmLTMNpRC4dLHAnf4NQzSh0Gg9aReKgB3BLaTU2keXxdfFKXtIY3UmaVH
         g5ouY/5co7B4m3HNJdCrRD7DhoJstjlqY/3+x+Ahwqoj70WFL+1IoQAZZ2TpiTn0fMvi
         9oTB8GeShvWyO+aG8IUQh7RlCKhU65G/2d9TP3kTWPDFmxSZRz4ruCkCXayZHQrtvQ/P
         lbWfF9txdZaH5RScrfngamCGQBqhFIQm8Cw5Q28Gu5VKTV/GgOK4+lvImhbqXwXrCOp0
         OvMVI1OA7hKOI/cOazMopEm3gostPW5+2Bz19XpjlX4cE+ViAIgBFsWEJmFxweOdZU6j
         2COw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mxwbkeVE3TgRsWHUczpony1YcNS7sLgn9lbDauIHtGc=;
        b=F57GJ+ZYZFJc/rIsCbKWploWroH25sY4OEVM2abDByWhKAKIF6bUzf1ezw/iw/z7Zd
         8bObud7S8e11T7/tmlRAABiNRBk7na9bDtTru20Fp2k4mb004VVm9Vs07QWqmjcm1Poh
         9h2CeBfzrpiLCzZtI9AVmjyrSumZ+eD8VdRx3xQEbV79yDig7nFhWx61/Ha8CVDAjg4g
         5BgxRVuxSMiVsTuhRHsLscvFcN3j7qTVlFCLJNuMlEFe7KmloaseuvyqddDsmkRlYh2L
         1JdNLoXWVZPSZo0Adkhzs1ttvFL8s5l4KuJTHvmoEJFB8CphJXkeQXh8ijjhk1GTXxF/
         LeVw==
X-Gm-Message-State: AOAM532KmjmYGC7afxgW6kV0n84bDpZWuJ2TXSPOkK84CFQ0z3Twgv9D
        WdmAmJiBq2AcyIkPayhssNLszukFykYUJws8B6s=
X-Google-Smtp-Source: ABdhPJyTBylAV36nGjc4nKUA4yCSvn1UGW1Yyt5iV/ifkbmWkXmd/e7GVLv5ClN5CRbaUWXl/i61psRzuRPCPw72ntk=
X-Received: by 2002:a17:906:30c4:: with SMTP id b4mr7466243ejb.456.1610686575540;
 Thu, 14 Jan 2021 20:56:15 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 15 Jan 2021 14:56:04 +1000
Message-ID: <CAPM=9twv04YWugPc1h87PHBd=QY7sLykCt=tNyM+6gnoAaXOSQ@mail.gmail.com>
Subject: [git pull] drm nouveau ampere modesetting support
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ben Skeggs <skeggsb@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

As mentioned in the previous pull, Ben has requested if we can include
Ampere modesetting support under fixes, it's for new GPUs and
shouldn't affect existing hardware. It's a bit bigger than just adding
a PCI ID, and I'm fine if you think we should hold it off until later.

Dave.

topic/nouveau-ampere-modeset-2021-01-15:
drm nouveau ampere display support.

This is a pull request to add display support for new Ampere hardware.

It has no effect on older GPUs.
The following changes since commit c8f6364f35f32786dd40336cfa35b9166d91b8ab:

  Merge branch '04.00-ampere-lite-fixes' of
git://github.com/skeggsb/linux into drm-fixes (2021-01-15 13:26:44
+1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm
tags/topic/nouveau-ampere-modeset-2021-01-15

for you to fetch changes up to 584265dfec70e78ce2085b82ed389f27e06fbca0:

  Merge branch '04.01-ampere-lite' of git://github.com/skeggsb/linux
into topic/nouveau-ampere-modeset (2021-01-15 14:48:18 +1000)

----------------------------------------------------------------
drm nouveau ampere display support.

This is a pull request to add display support for new Ampere hardware.

It has no effect on older GPUs.

----------------------------------------------------------------
Ben Skeggs (15):
      drm/nouveau/core: recognise GA10[024]
      drm/nouveau/pci/ga10[024]: initial support
      drm/nouveau/bios/ga10[024]: initial support
      drm/nouveau/devinit/ga10[024]: initial support
      drm/nouveau/mc/ga10[024]: initial support
      drm/nouveau/privring/ga10[024]: initial support
      drm/nouveau/imem/ga10[024]: initial support
      drm/nouveau/fb/ga10[024]: initial support
      drm/nouveau/timer/ga10[024]: initial support
      drm/nouveau/mmu/ga10[024]: initial support
      drm/nouveau/bar/ga10[024]: initial support
      drm/nouveau/gpio/ga10[024]: initial support
      drm/nouveau/i2c/ga10[024]: initial support
      drm/nouveau/dmaobj/ga10[24]: initial support
      drm/nouveau/disp/ga10[24]: initial support

Dave Airlie (1):
      Merge branch '04.01-ampere-lite' of
git://github.com/skeggsb/linux into topic/nouveau-ampere-modeset

 drivers/gpu/drm/nouveau/dispnv50/Kbuild            |   1 +
 drivers/gpu/drm/nouveau/dispnv50/core.c            |   1 +
 drivers/gpu/drm/nouveau/dispnv50/curs.c            |   1 +
 drivers/gpu/drm/nouveau/dispnv50/wimm.c            |   1 +
 drivers/gpu/drm/nouveau/dispnv50/wndw.c            |   1 +
 drivers/gpu/drm/nouveau/dispnv50/wndw.h            |   8 ++
 drivers/gpu/drm/nouveau/dispnv50/wndwc57e.c        |  10 +-
 drivers/gpu/drm/nouveau/dispnv50/wndwc67e.c        | 106 ++++++++++++++++
 drivers/gpu/drm/nouveau/include/nvif/cl0080.h      |   1 +
 drivers/gpu/drm/nouveau/include/nvif/class.h       |   5 +
 drivers/gpu/drm/nouveau/include/nvkm/core/device.h |   1 +
 drivers/gpu/drm/nouveau/include/nvkm/engine/disp.h |   1 +
 .../gpu/drm/nouveau/include/nvkm/subdev/devinit.h  |   1 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/fb.h   |   2 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/gpio.h |   1 +
 drivers/gpu/drm/nouveau/include/nvkm/subdev/mc.h   |   1 +
 drivers/gpu/drm/nouveau/nouveau_backlight.c        |   1 +
 drivers/gpu/drm/nouveau/nvif/disp.c                |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c  |  75 ++++++++++-
 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c  |   1 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/Kbuild    |   3 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c      |  33 ++++-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c   |  46 +++++++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h     |   4 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.h    |   2 +
 .../gpu/drm/nouveau/nvkm/engine/disp/rootga102.c   |  52 ++++++++
 .../gpu/drm/nouveau/nvkm/engine/disp/rootnv50.h    |   1 +
 .../gpu/drm/nouveau/nvkm/engine/disp/sorga102.c    | 140 +++++++++++++++++++++
 .../gpu/drm/nouveau/nvkm/engine/disp/sortu102.c    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/tu102.c   |   2 +-
 .../gpu/drm/nouveau/nvkm/subdev/bios/shadowramin.c |   3 +
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/Kbuild |   1 +
 .../gpu/drm/nouveau/nvkm/subdev/devinit/ga100.c    |  76 +++++++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/priv.h |   1 +
 .../gpu/drm/nouveau/nvkm/subdev/devinit/tu102.c    |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/Kbuild      |   3 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ga100.c     |  40 ++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ga102.c     |  40 ++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/gv100.c     |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/priv.h      |   2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ram.h       |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramga102.c  |  40 ++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/gpio/Kbuild    |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gpio/ga102.c   | 118 +++++++++++++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/Kbuild      |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mc/ga100.c     |  74 +++++++++++
 46 files changed, 892 insertions(+), 18 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/wndwc67e.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/ga102.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/rootga102.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/disp/sorga102.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/ga100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ga100.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ga102.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramga102.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/gpio/ga102.c
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/subdev/mc/ga100.c
