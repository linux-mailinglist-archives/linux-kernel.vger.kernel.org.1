Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6C425E30B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 22:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgIDUtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 16:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbgIDUtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:49:35 -0400
Subject: Re: [GIT PULL] sound fixes for 5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599252575;
        bh=sh/PGD9yAui+7bjvovM6LGbZOsKJ2Z4iG/dOjLGzmfI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mZZIbJKZ/zHuHmoxr5HKbIHVcby1PWZFSOl8VVUakMBvIwxCIAiXsvsR/e37YpSjp
         DdxlSdFSfbkwClPUt9nA3dXzjdV7UPfGeq56MtWzWkPKmUxzdNWWop6GoVGIRC5cA1
         /ehgYuywTK/voMQQhsrzABhmX7G2QoOYCEjEiCrs=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <s5hh7se3rky.wl-tiwai@suse.de>
References: <s5hh7se3rky.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <s5hh7se3rky.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.9-rc4
X-PR-Tracked-Commit-Id: 6a6660d049f88b89fd9a4b9db3581b245f7782fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86edf52e7c7201fabfba39ae694a5206d48e77af
Message-Id: <159925257499.25529.12116996528820046311.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Sep 2020 20:49:34 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 04 Sep 2020 09:54:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-5.9-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86edf52e7c7201fabfba39ae694a5206d48e77af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
