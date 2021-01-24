Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D255E301E7A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 20:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbhAXTf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 14:35:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbhAXTea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 14:34:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8676822D58;
        Sun, 24 Jan 2021 19:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611516830;
        bh=vCrPTtmTxUpSSrSNPQCsWoAFtwQhhhciz7hfnh6WTCY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YmPeEKzJGXMvNiySvEPktRIqFpBj41Lm/O+pNzas/5T+CZWnNR99MpuLJVso0eHoh
         ASFgHtN9L2hxqNvRFVhwiHmF8B8klHHQyK5JBAj8hVclss1IeG1Tl9/ZZB0nzi+d6/
         wxmpq1sUU2hTqxueweiDcw5v3L/LsXP7lzXwqcH0HIYuXj+sArO1tgWH69XFbTKl6/
         kpH3cHhTX1qnxeGRQZSIN55OGngNcebEHA7F6TUUX1ADOvsdjhJKpJygSz0cgKsJV5
         dtuMqNNAbGQYpP7rWPoq3sJIqkEeXCW8L19gFVFhLJxDIWNUIauabOdRzwbjzIvnj9
         xVFcGzS8MIyOQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 82883652E1;
        Sun, 24 Jan 2021 19:33:50 +0000 (UTC)
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YA1u24kUPB+B7gKY@kroah.com>
References: <YA1u24kUPB+B7gKY@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YA1u24kUPB+B7gKY@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.11-rc5
X-PR-Tracked-Commit-Id: a1bfb0ccf94dc79223d0db0d50237d3b3898f0b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 832bceefa08ef830388c175911fe17e6ef0125b9
Message-Id: <161151683052.23923.9315923694767541434.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jan 2021 19:33:50 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Jan 2021 13:58:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/832bceefa08ef830388c175911fe17e6ef0125b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
