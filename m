Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A2C2DF1BD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 22:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgLSVHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 16:07:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbgLSVHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 16:07:21 -0500
Subject: Re: [GIT PULL] xen: branch for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608412001;
        bh=f5biQxtgpOle2K8edxfWw3ThimfyDmYI41acGeS0PZE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=joPvXhHC0NDC8iOfyqRBKoyqp76EpSOJ3VbLoTBEL/J/UKgnMTI94v7bdrw4vpwJR
         rjRtKvtbjGHcZZxAAwv/1mKzNV4J4+Bm7/5/zIfOCgO0g2HBdKV1+kYaspNrJ8m4pZ
         HTfNjZle+5/P9p5VyDAxUlr18p1Ikg4P53QgygxDrCq4vYbfOSkesyUDHa9EVuaynS
         irS2323/EMxJOHhgqydtVkRjkFW0PfcrFbtPoc4j2mm1rJgIXbGPMX0weU17/Wahnd
         bcfldX1GVDT9wSJRVykcSp/52i9W6V0G5SxLQ3y0ik5S/Mxjcibucfq9MvFbjbxX1C
         VJY/HMXlQ35fg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201219063136.5828-1-jgross@suse.com>
References: <20201219063136.5828-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201219063136.5828-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc1b-tag
X-PR-Tracked-Commit-Id: 6190c0ccaf5dfee845df9c9cd8ad9fdc5856bb41
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3872f516aab34e3adeb7eda43b29c1ecd852cee1
Message-Id: <160841200137.20285.209923367667109463.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Dec 2020 21:06:41 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Dec 2020 07:31:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.11-rc1b-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3872f516aab34e3adeb7eda43b29c1ecd852cee1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
