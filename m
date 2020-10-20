Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608B82940C0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 18:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394814AbgJTQqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 12:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733221AbgJTQqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 12:46:00 -0400
Subject: Re: [GIT PULL] xen: branch for v5.10-rc1b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603212359;
        bh=0uoEpXADZJVCdJfgfoNUy1KQNOLib6qZkZ6gL0UTJug=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Kdw5wA9Blt4AX6Kc2sijE5AWBlZsMrLIoyB2x2qWPqIZgiumNhIKctaOPMn5/WSAq
         UMKLBS4qoVnPfV1EQ6XXq6o/Xc5hCrZijXA4OLaxsCO2W0cKqjt9kESt4HWtIXbQcQ
         kies03Bh2QTUPO5FGGuFuCnfFhsMrsIzELIdq5nE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201020120956.29708-1-jgross@suse.com>
References: <20201020120956.29708-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20201020120956.29708-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.10b-rc1b-tag
X-PR-Tracked-Commit-Id: 5f7f77400ab5b357b5fdb7122c3442239672186c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a5bb973fa0353d25dbe854694c71bb58eb4cf78
Message-Id: <160321235968.11581.17952625512231850079.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Oct 2020 16:45:59 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Oct 2020 14:09:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.10b-rc1b-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a5bb973fa0353d25dbe854694c71bb58eb4cf78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
