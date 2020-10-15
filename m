Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFC328FB73
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 01:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732514AbgJOXIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 19:08:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732395AbgJOXIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 19:08:34 -0400
Subject: Re: [GIT PULL] parisc architecture updates for kernel v5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602803313;
        bh=WqQ0bB+ppe48oqRSyaUgLPUbMiAC3Z+q0QDdxMG8+CA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=1djlJORgOVkKRGJ/P1n31pimVOxCL9aCZTQPWwAZzOBOQqcjfZbHcwA5d4rnH5e1z
         bMApgcP8cdFG9GbDVizXQ3bL+GIF6YscSt+8RpjL7YJ8ZKwnMXUMzC98rCOhV67U/Y
         bezJXlHt2Y1mc52CWvTOBHX+rA5pXonPkU+XotjA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201015072025.GA18655@ls3530.fritz.box>
References: <20201015072025.GA18655@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201015072025.GA18655@ls3530.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.10-1
X-PR-Tracked-Commit-Id: 7ff3f14ddc355bfbc94c766f43b90606b1f79e83
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7286d2a37eb955c5eeec2b042844f1c1b3ff0fe1
Message-Id: <160280331378.7173.14528913365089023034.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 23:08:33 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 09:20:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7286d2a37eb955c5eeec2b042844f1c1b3ff0fe1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
