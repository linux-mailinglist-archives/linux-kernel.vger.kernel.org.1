Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55EFD2A9EE4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgKFVNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:13:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:47134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgKFVNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:13:22 -0500
Subject: Re: [GIT PULL] ARC fixes for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604697201;
        bh=UPMRt+vvt2YH0HAVnBeYquWn2Dn2BATN5TEbtG9YEVE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PHO0+xjojroF1R2CV3R+Jjq+LFVokcK0RXNhzKFkj6Q8h0QbkZ4TUOTvsSSXuA5Lj
         F/Oh6q8MMW0bQYt9l6iyqF9+ehap+RRzeE9isX0jU4UpKPPy/IseNx0uN/plNsx0Qi
         tP9vCuVYjqH9fCoqGp+LmkSx/oP6TOiRG8zO6qac=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <06d83e19-7850-b6f2-5728-a778392d3e5c@synopsys.com>
References: <06d83e19-7850-b6f2-5728-a778392d3e5c@synopsys.com>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <06d83e19-7850-b6f2-5728-a778392d3e5c@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.10-rc3
X-PR-Tracked-Commit-Id: 3b57533b460c8dc22a432684b7e8d22571f34d2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4257087e8feb2e6f918eb0773eb1c1a697dd2a39
Message-Id: <160469720186.14190.7068841701625678326.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Nov 2020 21:13:21 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 Nov 2020 21:13:08 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.10-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4257087e8feb2e6f918eb0773eb1c1a697dd2a39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
