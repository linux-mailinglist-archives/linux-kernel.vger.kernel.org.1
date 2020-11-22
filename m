Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4E72BC97F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 22:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgKVVJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 16:09:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbgKVVJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 16:09:11 -0500
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606079351;
        bh=fRsxveNcomQdOx/18t5nqFua+Tn5QjxdgrMuGLlnYYA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lGAwbkGvKE3XNCnCpuSnATQrXFyorN4siXIqAPcWHeEWRSkX6+hKG4HX65cvFrdMp
         9RJPJ08vyQzS6CWErO3gSwRetxDvrm6/z/toUiMvae1kNOqMKZE8T2rysclogI4Bmy
         Ed++y05xcQAJCMiVx3CQ+u20BKeGEooVcmBwV4P8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X7pO0mtUNsMsE9F7@kroah.com>
References: <X7pO0mtUNsMsE9F7@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X7pO0mtUNsMsE9F7@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.10-rc5
X-PR-Tracked-Commit-Id: 2dde2821b57f12fa8601d35d438b5e300fcbbe1d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d27637ece80f25124e0e6871b7b6cb855e1c670c
Message-Id: <160607935141.25428.2616061909480561844.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Nov 2020 21:09:11 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Nov 2020 12:43:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.10-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d27637ece80f25124e0e6871b7b6cb855e1c670c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
