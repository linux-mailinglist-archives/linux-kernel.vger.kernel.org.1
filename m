Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6FD2DF1BF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 22:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgLSVHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 16:07:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:49556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbgLSVHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 16:07:21 -0500
Subject: Re: [GIT PULL] hsi changes for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608412000;
        bh=2nFm+RN+WTr9Wmv4TxNKV0y2rYiBH4YjmVbf+QhecEw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JgfSEYFG7o63rNj3DXKEWmA9rr5rJAYHkqwoan8i9mxjhCmNDONKoG3YDUk3S4Fie
         UV7RVAttjEfaPeFJuMc132y1AqlrwSCKLBQ8ZTRmb4th4prT1kqL6pSHDbQuuJMOIJ
         61Kbkkd5briT0kDrLEjOmXF6OGF+bsvrIg8Br/RY7vq601Au18rw0X5Gq4XGj7MEzF
         uUcC35N7xmTeK7Iv65J+kYRRyByAvKS9gvSNDNIAN65myQkMUSrImrCgWZV158Ezrx
         d/ICwxtOmscMQCJSv/NSeowrXn/zmNzO+vCNgCfQzFR0CLsilCLC+0h7MmXFvfuNpi
         16SuT4xE+7LbQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201218235910.6tjqvzaxl7kne4cl@earth.universe>
References: <20201218235910.6tjqvzaxl7kne4cl@earth.universe>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201218235910.6tjqvzaxl7kne4cl@earth.universe>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.11
X-PR-Tracked-Commit-Id: 8a77ed6d1fdda752f6b3203391a099f590a9454f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2703b66172fff39122012e42986b44c9c6ad5f1
Message-Id: <160841200081.20285.16960557779881463952.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Dec 2020 21:06:40 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Dec 2020 00:59:10 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2703b66172fff39122012e42986b44c9c6ad5f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
