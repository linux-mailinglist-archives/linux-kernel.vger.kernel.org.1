Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291A9290DBE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405853AbgJPWbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:31:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404707AbgJPWbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:31:35 -0400
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602887494;
        bh=L2n4i6g2/UVSn7TIQcFjubhZvWUdZF9XUvufZ72SAnA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mOP6Ke1iLEU0PtBOBXQLGheH5EjViT/L+oxpmnI05CHFx1M34wExXBHaxZ8eHj8Gx
         TT871ftHOtn+X0ONUHKkE0RDDQPswdIxY3n/RF+q17oXjREO18mj8kQ23AM1YmBWG5
         D1ruw0BeNdEgu1XaBocbxjCf9bdHqmVt4++FwQSk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201015225508.GA2465821@google.com>
References: <20201015225508.GA2465821@google.com>
X-PR-Tracked-List-Id: <linux-f2fs-devel.lists.sourceforge.net>
X-PR-Tracked-Message-Id: <20201015225508.GA2465821@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.10-rc1
X-PR-Tracked-Commit-Id: 788e96d1d39949fc91457a816f4bda0d374c257b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a3dadedc82e340f8292f64e7bfa964c525009c0
Message-Id: <160288749475.30401.5365560149755404936.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Oct 2020 22:31:34 +0000
To:     jaegeuk@kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 15:55:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a3dadedc82e340f8292f64e7bfa964c525009c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
