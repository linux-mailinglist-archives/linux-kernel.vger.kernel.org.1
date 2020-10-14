Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A8B28E576
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389454AbgJNRhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389389AbgJNRhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:13 -0400
Subject: Re: [GIT PULL] xen: branch for v5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602697032;
        bh=RBvyCIyAboxCfBbfrdgU7EznUEpAYdunpTXFg4FrMQs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lLWGVM2ZT+yC10c9FJmlitO3uH2CPiX9rsMfq2mXJ8JPU7MNmOxBtUFWX0NfSI56C
         YQg9P6PoZjlE3bYvS1li5cFIUVSbHdAvqDm5EzYoOj/fpnV8WfmEJgmuTpqNrqQPGY
         OjrcL/roJUSgiFALGhrwkF4D4qDl1y032ZOVPSU4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201014053917.19251-1-jgross@suse.com>
References: <20201014053917.19251-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201014053917.19251-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.10b-rc1-tag
X-PR-Tracked-Commit-Id: 32118f97f41d26a2447118fa956715cb4bd1bdac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a09b1d78505eb9fe27597a5174c61a7c66253fe8
Message-Id: <160269703278.25844.16425875472592967815.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 17:37:12 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Oct 2020 07:39:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.10b-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a09b1d78505eb9fe27597a5174c61a7c66253fe8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
