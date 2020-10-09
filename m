Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1B0288FA1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 19:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389968AbgJIRLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 13:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389944AbgJIRLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 13:11:48 -0400
Subject: Re: [git pull] drm amdgpu fixes for 5.9 final
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602263507;
        bh=F/i6jcEMVheHhV2g/MiFOZs19NUbp70BJescDmB98nc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L0TTzB4efUgTS92IKG5CimM+r40l6rwZ9qWzehreYOqafIgPHym+jJtM3CuAtnJVF
         frcigvidiTkS8tct3X4pptaDDNVzImNVby+BNgrqq6U1PwxpeKUptr3jIM2bg13vS2
         tdWrd87nuaIaiTmtqUOpL4o4cyeiwVSW8gd+r5zk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tywYP9zfkWJ6ad-+Eg51WgD0efM+CUc_wCmE-jmHEGTYA@mail.gmail.com>
References: <CAPM=9tywYP9zfkWJ6ad-+Eg51WgD0efM+CUc_wCmE-jmHEGTYA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tywYP9zfkWJ6ad-+Eg51WgD0efM+CUc_wCmE-jmHEGTYA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-10-09
X-PR-Tracked-Commit-Id: dded93ffbb8c4a578adf13b54cd62519908a23f8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd330b1bc2f5840d68cbfa61c60573b4250bf14f
Message-Id: <160226350788.18917.18285141729643002456.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Oct 2020 17:11:47 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Oct 2020 14:29:16 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-10-09

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd330b1bc2f5840d68cbfa61c60573b4250bf14f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
