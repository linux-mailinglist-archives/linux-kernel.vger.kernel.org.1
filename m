Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F8D1AE3FB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 19:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgDQRpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 13:45:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbgDQRp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:45:26 -0400
Subject: Re: [GIT PULL] arm64 fixes for 5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587145525;
        bh=qQZ4VmgPb13B1MumQjGBjJ+Nq7/wGRSP2jRWCGe7/W8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gVVbOLKPUkNvT1wBw3uHK1AeJUe3BEXF9mgmfRuiNvHnI8ZTs+cM8nRRTnzvEV47f
         Vr3L591BPOSTypIvxYLW3AR6nJlE3gBO9JT1wMh5uzpyRX2jCXH3u4P3/Y81MY3YgB
         N2yNkM6eJgXLEk29Xt5TXEBKpyhrpmIOvDMbk6Vg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200417170403.GA15479@gaia>
References: <20200417170403.GA15479@gaia>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200417170403.GA15479@gaia>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: c9a4ef66450145a356a626c833d3d7b1668b3ded
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95988fbc7c314ef6b1e174dbb9b87a34283208da
Message-Id: <158714552563.1625.16210298337980327660.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Apr 2020 17:45:25 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Apr 2020 18:04:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95988fbc7c314ef6b1e174dbb9b87a34283208da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
