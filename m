Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C522F84EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbhAOS6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:58:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbhAOS6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:58:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 892EE23A5E;
        Fri, 15 Jan 2021 18:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610737080;
        bh=HEkd/F8arFC9JulepHMfJZb64EDMez6vnsE7h9EKwuU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FdS5n/UR3A7iwI+Pv24HsVTxkW2BLJpphlb+ch4MgEZo6Yx4NJJ742uqKSS42VU78
         12QYfjd8vIZN4v5L8b2zUVSGIZd9cN1ns9YAcAoWmwuwSRo4HHGCotb0J3HdCMJojv
         d7KMlBMHkHweqCe4WjkvWT5abXadAt/YwQAataNWMiXKn5zpqojS3pL06rueCk0vnm
         UkbWK60aGkwwKPe1VUdwUzKP9V8aBUi431FLR1LN8CJX1B/P0f1CGCZTzunztAUJjF
         JqnKg+FyQSrNhIztuE+LD0SdBiYnIPPcwG5JirxzvakEZwvJKPcopFwPBZyfHg05Eo
         jhhTzD45DoTOg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 738D76017C;
        Fri, 15 Jan 2021 18:58:00 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v5.11-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210115143153.30040-1-jgross@suse.com>
References: <20210115143153.30040-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20210115143153.30040-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc4-tag
X-PR-Tracked-Commit-Id: 3d7746bea92530e8695258a3cf3ddec7a135edd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcda487c9c2e80ad177cdc34ae2068bbe5dada07
Message-Id: <161073708040.18503.9236409734942120807.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Jan 2021 18:58:00 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Jan 2021 15:31:53 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcda487c9c2e80ad177cdc34ae2068bbe5dada07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
