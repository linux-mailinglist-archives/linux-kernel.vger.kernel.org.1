Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBFF28267F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 21:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgJCT62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 15:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgJCT6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 15:58:21 -0400
Subject: Re: [GIT PULL] xen: branch for v5.9-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601755101;
        bh=LcL5cn9XLk5mudrBuslWNR7HhK+P5LDzqeGHvnZrkCQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aMRjThDceaYwrUwlyauhNwGpf6lqCWx+LDH4EH9XF1FOyZKeNrqPzPLDo4VQQdm7/
         UN+V5tmLjyIITJWx4GsS/PEj7k9z7F/i6ZeMaPs9OxITP23XXGVIN4ERGyTQuz1zQQ
         i0jlWil1amaPWZqPwYKbxUlRMCg8KlqdgexfA2Qw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201003073253.1861-1-jgross@suse.com>
References: <20201003073253.1861-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201003073253.1861-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9b-rc8-tag
X-PR-Tracked-Commit-Id: 0891fb39ba67bd7ae023ea0d367297ffff010781
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ee56135b2f5886cb0333d18640043a8f73fa830
Message-Id: <160175510128.27812.2872072780024080723.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Oct 2020 19:58:21 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  3 Oct 2020 09:32:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.9b-rc8-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ee56135b2f5886cb0333d18640043a8f73fa830

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
