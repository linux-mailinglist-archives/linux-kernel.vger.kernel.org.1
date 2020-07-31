Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB39233DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 05:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbgGaDpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 23:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731199AbgGaDpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 23:45:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1998C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 20:45:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a26so4259472ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 20:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cds3H26Qt4Xbf0pS+HwjsX5vOPZPhiV8iFrKf+Od2OY=;
        b=QonvG/kmsgdHkQkoy6d5Y1Y9u7ufcN0uWQQXWtKsyiiznQfg5qV5MUERJVPrgbdhHB
         1LumXGZhWuzti5sxoiZ18zM3f95u1A7NEh1ERyt8ScM4jEL6UrM6MP3VHDZx2AssLqap
         bTWReYZWU0oC9uxOiU6jgsRbkyRDEriNJ1JeZld+/08TkPvnbG1081YK5sTYqlUqFQfW
         VY22PpZbts4FHK21VDe3I4mdB2h/U5xT0LriaazkF8+A64Ure+znvkJx8/Y4OuLwnwbL
         ImpQR0KXAEDJ4Mbn2ubokoHQm+yRWbuQTdLYZXf7uFDadW2YmTxq3qDB40lKfgVFtMTl
         4thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cds3H26Qt4Xbf0pS+HwjsX5vOPZPhiV8iFrKf+Od2OY=;
        b=ASa/DP+w3zpFyMJKCTp3vf8TAiDszxEaD8XovzkwXYW5Zs5rcEriCBFV+N8IOBiMZT
         KJLNa0IEL36qRhSPRMQ3ehB7pHGN2+xo7yg213M4CZLRTkPQJh4q86mNxlX76l3uXcJh
         49B7Q43wwkDFjRID2G8Zhh233ypQDIOqP5ZRnMBRvMqfzyveDzUyM3nQFaYAAHmXowW0
         EhBiX0FEZjfGbj+6elqTJ+67SVpARC2bTwcaLr8W30m4p44hyYEXO0grTk+05tsb33rK
         SNx9EgKu3/nob/4WMP1BhSmYsNJXNHldYtzVNoyT73/a3188sWPAFwC2BbUCjwVDxegT
         W0XA==
X-Gm-Message-State: AOAM532AA1V88EBNEgVVFRr4VTR/hpqsaRUn/WTjbh5bg45ZyiF1AxZ3
        pFnAQP+O2kzqgrIEQQ8oLQLUZUfELSMH20gFk6xjEqhi
X-Google-Smtp-Source: ABdhPJzTNEq4SD3AtnBWlloSxhhMF2bQmcFBfou2WUgUWR9i7Rx29UEBZLM2ZOBesPlynB54igS1I1jC3ZlDSLKMJ4s=
X-Received: by 2002:a17:906:b6c3:: with SMTP id ec3mr2078395ejb.101.1596167105043;
 Thu, 30 Jul 2020 20:45:05 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 31 Jul 2020 13:44:54 +1000
Message-ID: <CAPM=9twq8wVE888GW3cQ12Fw=FEwtD-1tXWgMcrrnjdk3NJZfg@mail.gmail.com>
Subject: [git pull] drm fixes for 5.8-rc8 (part 2)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

As mentioned previously this contains the nouveau regression fix,
amdgpu had 3 fixes outstanding as well, one revert, an info leak and
use after free. The use after free is a bit trickier than I'd like,
and I've personally gone over it to confirm I'm happy that it is doing
what it says.

Let me know if any issues with any, happy to respin if necessary.
Dave.

drm-fixes-2020-07-31:
drm fixes for 5.8-rc8 (part 2)

nouveau:
- final modifiers regression fix

amdgpu:
- Revert a fix which caused other regressions
- Fix potential kernel info leak
- Fix a use-after-free bug that was uncovered by another change in 5.7
The following changes since commit a4a2739beb8933a19281bca077fdb852598803ed:

  Merge tag 'drm-misc-fixes-2020-07-28' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2020-07-29
12:46:58 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-07-31

for you to fetch changes up to 887c909dd5d557c203a233ebbe238c18438a680a:

  Merge tag 'amd-drm-fixes-5.8-2020-07-30' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes (2020-07-31
13:04:00 +1000)

----------------------------------------------------------------
drm fixes for 5.8-rc8 (part 2)

nouveau:
- final modifiers regression fix

amdgpu:
- Revert a fix which caused other regressions
- Fix potential kernel info leak
- Fix a use-after-free bug that was uncovered by another change in 5.7

----------------------------------------------------------------
Alex Deucher (1):
      Revert "drm/amdgpu: Fix NULL dereference in dpm sysfs handlers"

Dave Airlie (1):
      Merge tag 'amd-drm-fixes-5.8-2020-07-30' of
git://people.freedesktop.org/~agd5f/linux into drm-fixes

James Jones (1):
      drm/nouveau: Accept 'legacy' format modifiers

Mazin Rezk (1):
      drm/amd/display: Clear dm_state for fast updates

Peilin Ye (1):
      drm/amdgpu: Prevent kernel-infoleak in amdgpu_info_ioctl()

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c           |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c            |  9 ++++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 +++++++++++++++++------
 drivers/gpu/drm/nouveau/nouveau_display.c         | 27 +++++++++++++++--
 4 files changed, 60 insertions(+), 15 deletions(-)
