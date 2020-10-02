Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EC42818EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 19:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388282AbgJBRPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 13:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388143AbgJBRPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 13:15:15 -0400
Subject: Re: [GIT PULL] IIO driver fixes for 5.9-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601658915;
        bh=IQ8+CwZRCHjjb3KBjrwXQHDpQPOvigLbY4fuwdvzX4g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KZBXELYedK0XebXD7f+WQE15RpMIqT9U/uERlqO/cCkEYzFqhUIa/oLRSRqyA+YFh
         bEZX1yc+0etn7sSLqSTce/ozpsfsFBuhFXtrE5UueVt9iIdYjxZo4JSM6hhX0paT0T
         yH63lZBXjMiVqXlmjbBxTPGMk3QK0z3Dn04PIs08=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201002142011.GA3499938@kroah.com>
References: <20201002142011.GA3499938@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201002142011.GA3499938@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.9-rc8
X-PR-Tracked-Commit-Id: 52a035235ed5a1392fc264bd614eb96d1ac97a3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc8ad8fa844aeae64c10f002b97a7c56619f1f57
Message-Id: <160165891532.31225.17534733155112020176.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Oct 2020 17:15:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 2 Oct 2020 16:20:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.9-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc8ad8fa844aeae64c10f002b97a7c56619f1f57

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
