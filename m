Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C19D286D32
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 05:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbgJHDgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 23:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbgJHDgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 23:36:14 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F68C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 20:36:12 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id dn5so4321621edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 20:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0yEADBg3rUn/eSIy/c23DF5FgmPZN4bfUDLh04iLxdM=;
        b=EkzFglKMNTKjx5JDT1/eoLA3aOqZA3G1hibiTVij9zD3CQpd25URGQrelwL4WebAqn
         SXgzst5OuQTY4EruPp/n0+v250tMvqg0AOf1k24D9Vl+Pif7o7ovBbkwutbEVyfqhYbv
         bOswqbdZKRAvnxN9N4KE8RV2/IipUdTcRYqbj02VgxVBAFi9NgBvlDQOWWvPdhamoke0
         13icqt46iNmBFXq8jeQjE+qlUTZUbRFc6fPu0y5C4FDz+F6x3wX0usN4QmLTVCKoPcjT
         xle0VNBzXwQtlw3dey2840URtHuxzkZ+/y5iuj/S6oy1RRjbKSbg25+mHuqNqAH7z7cP
         XX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0yEADBg3rUn/eSIy/c23DF5FgmPZN4bfUDLh04iLxdM=;
        b=Rm/CWoMz7uL7yzktc5r8MvTv47eb2kCzNNbWxLcwH7N/2jNc4Z1z4yZnONLvaJB5Xb
         t5YhMdE5tYgeaT96ShfH9YgY16ymZSuj0dnfCBTmQvEY5r0FwaSinaEwsVRTkF9IO2kL
         gPcLaN0ZEA6vibo6YlyFR1q2xYx3mTPzyq9CTOirdhijeGbSGtl2vrrc+BjtzQWMrUXk
         nmY081pPl3zvDpfY39dSpP8vHViywnMA1NYS2ohwvQiXoeptCrmEHrYjiNbOx8HFDkft
         a3b08sLv8L0BNvPRAiVa0tRNtwdqzoGItmUTSCVxmdkR1yFq7vd2ekS9Q9INg5qAxGJJ
         caTQ==
X-Gm-Message-State: AOAM531/ePQUq789SBc5nrzBw/dpC2pumZ8quMRqgd6z9E2Ci7j7Dd01
        +dC1MA0UA+pqeDJdqwnA1imMiVycP/gLgAj8T3yffpcF86k=
X-Google-Smtp-Source: ABdhPJxJlnS5Wp1TkSuQRym3eDGM0qPjoOJ/FYkdp1jniSFznXS6XR8WfyAUx+FNmlQCPmbgn33Jr9NGks2ptr0F2T8=
X-Received: by 2002:a50:e08a:: with SMTP id f10mr6999834edl.220.1602128170440;
 Wed, 07 Oct 2020 20:36:10 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 8 Oct 2020 13:35:59 +1000
Message-ID: <CAPM=9twbVGe96YNPCMMRrXPJhCoLLbhqtN0DjdTJcqo52OoLCA@mail.gmail.com>
Subject: [git pull] drm nouveau fixes for 5.9 final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Karol found two last minute nouveau fixes, they both fix crashes, the
TTM one follows what other drivers do already, and the other is for
bailing on load on unrecognised chipsets.

Thanks,
Dave.

drm-fixes-2020-10-08:
drm nouveau fixes for 5.9 final

nouveau:
- fix crash in TTM alloc fail path
- return error earlier for unknown chipsets
The following changes since commit 86fdf61e71046618f6f499542cee12f2348c523c:

  Merge tag 'drm-misc-fixes-2020-10-01' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2020-10-06
12:38:28 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-10-08

for you to fetch changes up to d10285a25e29f13353bbf7760be8980048c1ef2f:

  drm/nouveau/mem: guard against NULL pointer access in mem_del
(2020-10-07 15:33:09 +1000)

----------------------------------------------------------------
drm nouveau fixes for 5.9 final

nouveau:
- fix crash in TTM alloc fail path
- return error earlier for unknown chipsets

----------------------------------------------------------------
Karol Herbst (2):
      drm/nouveau/device: return error for unknown chipsets
      drm/nouveau/mem: guard against NULL pointer access in mem_del

 drivers/gpu/drm/nouveau/nouveau_mem.c             | 2 ++
 drivers/gpu/drm/nouveau/nvkm/engine/device/base.c | 1 +
 2 files changed, 3 insertions(+)
