Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6739F2B392E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 21:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgKOUlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 15:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbgKOUls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 15:41:48 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44222C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 12:41:48 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id 23so16576166wrc.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 12:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=J16eMJgIA1LQl6Gsx6rIuI7VHvHv37tOMcNHiYjyD60=;
        b=bVfhhPZQ4KbzE4I+TXENHiX55KfMC1dyrIYwFpDwhX4ErA8b2SRvlqCdQULAitQKY6
         otuoKWNNrFpnI+2wwR46szdnXh99J7SA+9yOp66Yyn9d7VYYzfl2+MGymsijOU+lvS8S
         UBjdU47HWugqs41tVgTNWwYj/SRMb8LqDsIHv0KhsHWYcH4uo1ph6B2OFZKRjjVDdU0Y
         +JRpPgNAmZu1LQTF+v7/mI3j/vBtfIXRY1bEEknM2Atdtv1knZQEEDk8MAzykCoPlYOU
         96hGCO1gzeGNd5KCrQ4IOv3ENXJkBX0iOY33HVhlYqnZSjE2iCFSYSCQDUa773L7gra7
         uF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=J16eMJgIA1LQl6Gsx6rIuI7VHvHv37tOMcNHiYjyD60=;
        b=Sj17h/TP+YUOvyituN5qlYij33Jb4R8L7NBbBXW8P7hRmAIRc8Y7Apm65ob+g1HNGs
         KLdQaR73078bS1Zctw1ErW1xCOIArZ7un0R545tN2xI1iIW2P+j3H+QGiDRu/WzDpL4M
         tXI695LEBuDj1BGfMPymhJwwz2nE0HptZhp4oLjFT5ocaI72yyPiKl62894S2I//D4qD
         eMNveDhxUld3Ak3zcJLDD76XT0VFJQK9GOMfmNqZp2zhepDUWM8xy2GT772ELXuEL5Na
         OkfCF0E7xYB9wu0FI34Ih1k70SwReOAHRYUou36lraUE9fw+acRGF4H4pNl01mhGqOTR
         CAvg==
X-Gm-Message-State: AOAM532ey3rytwfOQ4p4eCm7kMqADEg9vLuy72K8xc/129ahjvPuzg92
        mBwPioP8O85opPrJWZlO8gyIksoNnRnF+LoqNbrsHfIgceDceA==
X-Google-Smtp-Source: ABdhPJw8nnCeD9Pmfm4aONgo1FE+Mmmq29zBtsBn9axv7s85ARTsDI4Mip1atcZ/FCPMMaiF27W/eKujus1iRe4JOLc=
X-Received: by 2002:adf:f9c6:: with SMTP id w6mr15473874wrr.273.1605472906065;
 Sun, 15 Nov 2020 12:41:46 -0800 (PST)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 16 Nov 2020 06:41:34 +1000
Message-ID: <CAPM=9ty9cBzR5tr8g2B7LE9+Hcf4NViHcyDcEHJMVgYmSoub1A@mail.gmail.com>
Subject: [git pull] drm nouveau urgent fixes for 5.10-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <skeggsb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

As mentioned I did have a fixes pull from Ben from after I'd sent you
out stuff, it contains the fix for the regression reported in the rc1
thread along with two others.

Dave.

drm-fixes-2020-11-16:
drm nouveau fixes for 5.10-rc4

nouveau:
- atomic modesetting regression fix
- ttm pre-nv50 fix
- connector NULL ptr deref fix
The following changes since commit 41f3ed2cac86ba533ce6a334a2e7fae5c7082946:

  Merge tag 'amd-drm-fixes-5.10-2020-11-12' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2020-11-13
16:05:31 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-11-16

for you to fetch changes up to 8f598d15ee6577a56d6617d9e4151591db34d8fa:

  Merge branch 'linux-5.10' of git://github.com/skeggsb/linux into
drm-fixes (2020-11-16 06:36:31 +1000)

----------------------------------------------------------------
drm nouveau fixes for 5.10-rc4

nouveau:
- atomic modesetting regression fix
- ttm pre-nv50 fix
- connector NULL ptr deref fix

----------------------------------------------------------------
Alexander Kapshuk (1):
      drm/nouveau/kms: Fix NULL pointer dereference in
nouveau_connector_detect_depth

Ben Skeggs (1):
      drm/nouveau/ttm: avoid using nouveau_drm.ttm.type_vram prior to nv50

Dave Airlie (1):
      Merge branch 'linux-5.10' of git://github.com/skeggsb/linux into drm-fixes

Lyude Paul (1):
      drm/nouveau/kms/nv50-: Use atomic encoder callbacks everywhere

 drivers/gpu/drm/nouveau/dispnv50/disp.c     | 29 ++++++++++++++---------------
 drivers/gpu/drm/nouveau/nouveau_bo.c        |  3 +--
 drivers/gpu/drm/nouveau/nouveau_connector.c | 14 +++++++++-----
 3 files changed, 24 insertions(+), 22 deletions(-)
