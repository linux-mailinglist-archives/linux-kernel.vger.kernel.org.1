Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A692B378A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 19:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgKOSAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 13:00:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727245AbgKOSAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 13:00:13 -0500
Subject: Re: [GIT PULL] percpu fix for v5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605463212;
        bh=fEHsmrxC8XKirytfGUWvxdSR+bmMfAPKFZIcrEsbpvw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=tGYkRFlD2KIPL96ZkrQwNtB4pGJoP0aKoLZYsaaNfFMVXUjAdRtBl6SOsIbVjZ5cs
         Qbc9atly0zx3Ow9uPs4N8SxrX/7cM3mIaX0OcNTezeknEJNE6z0BlPBcoeO0I91u1o
         thpq8TLgk3NdGr7XvGvl5zuF+DxJyzXpO1GZsxwU=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201114213624.GA1126012@google.com>
References: <20201114213624.GA1126012@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201114213624.GA1126012@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.10-fixes
X-PR-Tracked-Commit-Id: 61cf93d3e14a29288e4d5522aecb6e58268eec62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a50cf15906d4d0ad1d6bb32e9eeeb282899a8180
Message-Id: <160546321281.32406.18218020054925716126.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Nov 2020 18:00:12 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 14 Nov 2020 21:36:24 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.10-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a50cf15906d4d0ad1d6bb32e9eeeb282899a8180

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
