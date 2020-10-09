Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB636288155
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 06:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbgJIE3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 00:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJIE3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 00:29:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1E4C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 21:29:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lw21so11179963ejb.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 21:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=HDOEMZJ1iJUDawkzsd6EJs2p6R7I3avbJFeF5Kk04rI=;
        b=E1fxnykXu5SuBbCy7jL9XNrfSWR/aHJa/kUXc7duEbL8II561wlxMxkMqfskOaXPaD
         mAo/vP7AUxf17/jUTX8Ydau/JtP5smxgnxpY3IUmSDPFUnbHGk07yfQWagJByHg8un4G
         RL8oC38HIq/NiU1nK669pKz3rfm+GlXUga6npM7bZMyu4voKZqZGxe65JW4qP6W0i3Tb
         CbbgnnaWrlqcbZkCYcZ3KKKxpDVPDmYL9Wy40Q3Nk3Jzu47h8zHHcYI4pHNRs8mI6iuh
         GKtUH3wLemdLUG3xbdDP5wgRoV2XqB4NVQbDat3oMyHKvNQR5nt6eiq+t5ZZ4dvRxSAn
         611A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HDOEMZJ1iJUDawkzsd6EJs2p6R7I3avbJFeF5Kk04rI=;
        b=AJCPExEmP37CaW3Q2SyNNJkyP0NsU27l6OpTvqZlh8P4JPkvmzgJQvp7cLkGc7qQyi
         hTLytcfV53Rzt3MpJHDYoPNo97BBGTBzoykjcNIbJQlLwsYpEGN+zFHjg3z4YzBWcE7G
         sIhjsQhrNm8ak04LiQOiF3SAQuQm+nFc3Ux1qf1YAIM9ignFqNcK9i5hQR0mF2wVxoqg
         VdwnJ5NCHy7oHeNdtMjTH/y93B31R3q3f4exVaPiNFdNcnu2YodRx2MeP67BCEyoiSn9
         UIwcAr4+lE3FQC17rehHeDZxwYHoUA/EcxVYnZH8riDJqa9YoYLZEC1RrzLTH9ejeIh8
         I2Og==
X-Gm-Message-State: AOAM5334u+R9nWSfofn/KupfFEc0O3xxpNP5BE0vh8YLTY/EOpoj0ZXz
        Y+ZO8Y1DbmED7DWOh3d0piKsSrBObHsbv7cg+OAhBrR3pqw=
X-Google-Smtp-Source: ABdhPJy4V9ovDJkkp+I+JIwk2btygwFc179EQv+3NzkavRWXfk6broysUpKrBqF97YRL4lUy+Owj/I4LkDx6y+gG+As=
X-Received: by 2002:a17:906:38c9:: with SMTP id r9mr12922751ejd.9.1602217767821;
 Thu, 08 Oct 2020 21:29:27 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 9 Oct 2020 14:29:16 +1000
Message-ID: <CAPM=9tywYP9zfkWJ6ad-+Eg51WgD0efM+CUc_wCmE-jmHEGTYA@mail.gmail.com>
Subject: [git pull] drm amdgpu fixes for 5.9 final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Fixes trickling in this week, Alex had a final fix for the newest GPU
they introduced in rc1, along with one build regression and one
crasher fix.

Cross my fingers that's it for 5.9.

Dave.

drm-fixes-2020-10-09:
drm amdgpu fixes for 5.9 final

amdgpu:
- Fix a crash on renoir if you override the IP discovery parameter
- Fix the build on ARC platforms
- Display fix for Sienna Cichlid
The following changes since commit d10285a25e29f13353bbf7760be8980048c1ef2f:

  drm/nouveau/mem: guard against NULL pointer access in mem_del
(2020-10-07 15:33:09 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-10-09

for you to fetch changes up to dded93ffbb8c4a578adf13b54cd62519908a23f8:

  Merge tag 'amd-drm-fixes-5.9-2020-10-08' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2020-10-09
13:02:49 +1000)

----------------------------------------------------------------
drm amdgpu fixes for 5.9 final

amdgpu:
- Fix a crash on renoir if you override the IP discovery parameter
- Fix the build on ARC platforms
- Display fix for Sienna Cichlid

----------------------------------------------------------------
Alex Deucher (1):
      drm/amdgpu/swsmu: fix ARC build errors

Dave Airlie (1):
      Merge tag 'amd-drm-fixes-5.9-2020-10-08' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

Dirk Gouders (1):
      drm/amdgpu: fix NULL pointer dereference for Renoir

Yongqiang Sun (1):
      drm/amd/display: Change ABM config init interface

 drivers/gpu/drm/amd/amdgpu/soc15.c                    | 10 +++++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c     |  2 +-
 .../gpu/drm/amd/display/modules/power/power_helpers.c | 19 +++++++++++++++----
 .../gpu/drm/amd/display/modules/power/power_helpers.h |  4 +++-
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c            | 14 ++++++++++++--
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c    | 14 ++++++++++++--
 6 files changed, 48 insertions(+), 15 deletions(-)
