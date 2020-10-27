Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3605729CB57
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373859AbgJ0Vg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:36:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505925AbgJ0Vg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:36:28 -0400
Subject: Re: [GIT PULL] orphan-handling fixes for v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603834587;
        bh=9pjMDjozHR/I5n/qsQiHwulBlCPUDrYak3FWj1boAOE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=J7f5njh7AA7K/dpI1xUjs6IeG9dnXYN0iio0gsnEU+nK2obeXPqJyDPZCskFnhdWq
         SlewmY21ypo5vZxpF0sCx0VUnyV4wOllAbfe+hyE/UWPXcq92G4+fBd+obb5VJk5N6
         Hi2Lem33sXNn6jMAnaXFxbJEaTc4/B0lFTS3z8gg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202010271151.0FC20740A@keescook>
References: <202010271151.0FC20740A@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202010271151.0FC20740A@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/orphan-handling-v5.10-rc2
X-PR-Tracked-Commit-Id: c39866f268f89868df17724cd2262d121552d8c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c2ab803e565f994b897573f6f2f6520eef41159
Message-Id: <160383458792.19529.18086124371754547283.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Oct 2020 21:36:27 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Oct 2020 11:52:30 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/orphan-handling-v5.10-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c2ab803e565f994b897573f6f2f6520eef41159

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
