Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C963287C64
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgJHTUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:20:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgJHTUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:20:45 -0400
Subject: Re: [GIT PULL] xen: branch for v5.9-rc9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602184844;
        bh=QKVreTOtOfv+UqyeLrweLlXPIWls8Uj8qpGVUvUyd6M=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=r83oyq+sD2C9B6GiqlVxUhMtlPEL0uJbZBF6cHRxmtQ6KkwackHEu4wJ5tTsTxjte
         PeNdnKbY93WfqSfWqOSyGfwFt8dS4iLvvRnSE9wnsLaph8VBREichGxONHUkZMH7Z7
         KqZuIWrdD6V8J5lj2M58M1NHeEvfj4wJ6Jx88Bhc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201007063804.21597-1-jgross@suse.com>
References: <20201007063804.21597-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20201007063804.21597-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9b-rc9-tag
X-PR-Tracked-Commit-Id: 5a0677110b73dd3e1766f89159701bfe8ac06808
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86f0a5fb1b98e993fd43899d6640c7b9eec5000a
Message-Id: <160218484456.22350.13183729801289360481.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Oct 2020 19:20:44 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  7 Oct 2020 08:38:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9b-rc9-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86f0a5fb1b98e993fd43899d6640c7b9eec5000a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
