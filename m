Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F5C297759
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755172AbgJWSxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755131AbgJWSxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:53:19 -0400
Subject: Re: [GIT PULL] GFS2 changes for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603479199;
        bh=1ZxuuTWj/DNlJ4AXwYWGGJ2HZldYOtVLHqJG7w+BrXQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YOYZ7tPEEXUGvR4Pm+//K9ZvVi3IDm8rR+M1RbKNuBdJ0YSHpKyxHDSqFVYEPi81U
         hVwmkgX5E4OO+C0JDkQvE2CSNJKwTAb1w1MXZJqWoKSQWo1GD+wnb08j5vIwOTWsGm
         aQXZJE1r6QMu/uggnMFAyxfE1syEvfD9RVE5DyjY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201023154642.1309908-1-agruenba@redhat.com>
References: <20201023154642.1309908-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201023154642.1309908-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.10
X-PR-Tracked-Commit-Id: bedb0f056faa94e953e7b3da5a77d25e0008364b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0adc313c4f20639f7e235b8d6719d96a2024cf91
Message-Id: <160347919915.2166.15547527383595069420.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Oct 2020 18:53:19 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Oct 2020 17:46:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-for-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0adc313c4f20639f7e235b8d6719d96a2024cf91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
