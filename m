Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C67E2619CA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 20:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbgIHS01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 14:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731059AbgIHSTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:19:17 -0400
Subject: Re: [git pull] drm fixes for 5.9-rc5 (special edition)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599589157;
        bh=EA56Y2PAWEn0I+v7dzXzED2ZEgWwWS9lgmkRcjziNUk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=t3dp4ASZT5RXvDNrTn/L0tCilu+KANvKSJxIdpCQUoo38yV3di5aDqCzfUf5m5q+O
         5BhJ+7APv1AdkpgBnxwYzvPfxgx5IICLmpByfffZy9Jd2ELUha1cYVY+UQhosJuU7g
         uXCHr123quIDwgMJA4UA2UIM/6/7wfpHDDV6m72c=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw2tebfrjMEiB5fUy8USZrjq4b_siciDecFfMu8H794gA@mail.gmail.com>
References: <CAPM=9tw2tebfrjMEiB5fUy8USZrjq4b_siciDecFfMu8H794gA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw2tebfrjMEiB5fUy8USZrjq4b_siciDecFfMu8H794gA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-08
X-PR-Tracked-Commit-Id: 20561da3a2e1e0e827ef5510cb0f74bcfd377e41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f6a73c8b715d595977774d48450a734297ab21f
Message-Id: <159958915704.19003.18086198109433271774.pr-tracker-bot@kernel.org>
Date:   Tue, 08 Sep 2020 18:19:17 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 8 Sep 2020 16:22:25 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2020-09-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f6a73c8b715d595977774d48450a734297ab21f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
