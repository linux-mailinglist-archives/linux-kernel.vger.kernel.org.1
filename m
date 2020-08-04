Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA5C23C1A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 23:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgHDVkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 17:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728279AbgHDVkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:40:11 -0400
Subject: Re: [GIT PULL] Remove uninitialized_var() for v5.9-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596577210;
        bh=tZNmKE87pbgc98XdUNwK0M3RwnVYA69fkMLxyg46YhQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=cqazk21JsxSPZ1y9DIXDpnf2IDUMmHY9DUA98GYgdULVWZjYFPmiOt2/Ku72RQxT5
         suBQidpzJVOByuhcbT8C+otnGtWfHx82o6mwUDZWhhD2mOG9uhuKl6cFULP2DsDOWz
         3eL+4NOV9S8JnzNZz6kTuUF6sepRwYoOXGfoBKkA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202008031209.CB5CC23@keescook>
References: <202008031209.CB5CC23@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202008031209.CB5CC23@keescook>
X-PR-Tracked-Remote: https://lore.kernel.org/linux-next/20200629154305.0067d113@canb.auug.org.au/
 drivers/gpu/drm/drm_edid.c
X-PR-Tracked-Commit-Id: 63a0895d960aa3d3653ef0ecad5bd8579388f14b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99ea1521a097db51f0f04f54cfbd3b0ed119d2f1
Message-Id: <159657721074.17686.9564528912203215935.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 21:40:10 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Bart van Assche <bvanassche@acm.org>,
        Chao Yu <yuchao0@huawei.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jason Yan <yanaijie@huawei.com>, Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 12:16:56 -0700:

> https://lore.kernel.org/linux-next/20200629154305.0067d113@canb.auug.org.au/ drivers/gpu/drm/drm_edid.c

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99ea1521a097db51f0f04f54cfbd3b0ed119d2f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
