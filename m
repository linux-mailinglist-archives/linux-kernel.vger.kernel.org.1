Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C2B2DC7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgLPURN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:17:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbgLPURM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:17:12 -0500
Subject: Re: [GIT PULL] xen: branch for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608149792;
        bh=WmvOvSHb+S4MEfDf4FDvtuOcycVfyBfLfxYt/7dEbqE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sbTo8Pu/8B6VP/I4Q+uo+QgmEF37N3agNCMau5MSMHQEmJziEF+dKx4UNeyUmiOCV
         n6YAtpOMungGOeyPit3YKcMbQVmgPgwqsX4YMy3AQFa5Pp+2eT3xf9sfxkvfot69LY
         vhg8kwpqwS+a2puZcXn0K0oigK0c9LZMGFiFY2yTo55SjnKZmwA4JqIEz8FnLWgHGz
         Y34krmmS4Y166UqNGYsOozBQX6wOfizY4RSVSfT4f1nfDlAOJTCIpHYmHtHYNo5I7n
         6aEqAJAk+69iud3uhDPmecICoHN/YuM3aDUjCjr2IvcNR0PM/J21htvoll5C22YCRa
         z3q3KzcUXrlNw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201215122606.6874-1-jgross@suse.com>
References: <20201215122606.6874-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20201215122606.6874-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc1-tag
X-PR-Tracked-Commit-Id: 1c728719a4da6e654afb9cc047164755072ed7c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7acfd4274e26e05a4f12ad31bf331fef11ebc6a3
Message-Id: <160814979215.31129.10861518322757012100.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 20:16:32 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 13:26:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7acfd4274e26e05a4f12ad31bf331fef11ebc6a3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
