Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1ED92FDA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387985AbhATT7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:59:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbhATT7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:59:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id EB38D23440;
        Wed, 20 Jan 2021 19:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611172707;
        bh=8Gt5nD+hiWgiOiVulIE8p1fTb/Qv1s/EF0Jm9eW7lS4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QKA8ghcwZ/GEMcruoZ4DmDvoKa4pMvEo5PiAzIXujhp8h2nkS1SwmmacMEVbkzPIx
         DSgLdlB7g2e4HRkKDbMdl3X5qyHBDthMjqCP+aakujqyjyfEdIHYFi75+yMxiPKWpM
         FBOHELx9eWp1G/1h8mwHMoPdR0J8qnmrf43eaYh6kDtHsN2COmzWIxxLTgUz1duRXA
         xQTZ1K5ON0mBxKDW0KadQ5Eb/QJVzlGaAlqCM58kCHYUsSAvJ3Lrm02rkzlIx+LhO3
         3lZDbVIyVO5R63I4IAONL1zhmaeejnaa2e6uSWV8Gsav9BN2lsozc1pnYQXcaX/hOa
         05WUYeL+t1HnQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id D4B6C604FC;
        Wed, 20 Jan 2021 19:58:26 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210120150157.5289-1-jgross@suse.com>
References: <20210120150157.5289-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210120150157.5289-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc5-tag
X-PR-Tracked-Commit-Id: bd9dcef67ffcae2de49e319fba349df76472fd10
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e4ceed606ba4942f632d097f70696543fe98d8e
Message-Id: <161117270679.2860.10704382342128586934.pr-tracker-bot@kernel.org>
Date:   Wed, 20 Jan 2021 19:58:26 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 20 Jan 2021 16:01:57 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc5-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e4ceed606ba4942f632d097f70696543fe98d8e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
