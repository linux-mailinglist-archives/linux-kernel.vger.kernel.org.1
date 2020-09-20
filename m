Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BF027186C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 00:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgITWkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 18:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgITWkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 18:40:21 -0400
Subject: Re: [GIT PULL] efi/urgent for v5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600641621;
        bh=jOuLWp0HIOxQRxK1lx89ATszVYvCpI8YV89yKwLKnUs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FKzGlbly0G9SWzLsYb4eB5OHoiZ7Qcyk9QeSdn9u4KyxhaYbRtc7KUQcGaEDZ2b5P
         itIK+XJgjRAD1O9TJyRFfjMZWqgF8aEq0b/9mUpPEuuwouT85cnKliGFcVTeBlg8Fu
         qP9v7j+OQVrnDdzcVf5i07jQSLJahIxRkXniQvXM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200920193312.GD13044@zn.tnic>
References: <20200920193312.GD13044@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200920193312.GD13044@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-urgent-for-v5.9-rc5
X-PR-Tracked-Commit-Id: 46908326c6b801201f1e46f5ed0db6e85bef74ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5674d81c21d47e12c2def2df7360ef2dbca108e6
Message-Id: <160064162131.32524.12895524873003610783.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Sep 2020 22:40:21 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Sep 2020 21:33:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi-urgent-for-v5.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5674d81c21d47e12c2def2df7360ef2dbca108e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
