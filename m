Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8920D28C198
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbgJLTrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbgJLTrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:47:04 -0400
Subject: Re: [GIT pull] core/debugobjects for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602532023;
        bh=RYYsRWnm8yIvNePwqIH0ZZgEXaNlYxQo2SlqCVA9bs0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CtAG/PTEI43VfGnr+brCrJEW4H2R+6+NzP+r4mLnH5visAgBp7MM6B+AcvNDrLqfa
         7kaWzOfRMkjJOhyt3Vi7Qm/I+Fq4/h58DDDzTgpmps1Weu85DBxzVO8EZ3Jg9ZV5gL
         HvgHBokILHiWdyan4PnBmYGyYG1iq4rsPuArI/xI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160250758161.26264.880601562259119308.tglx@nanos>
References: <160250758161.26264.880601562259119308.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160250758161.26264.880601562259119308.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2020-10-12
X-PR-Tracked-Commit-Id: 88451f2cd3cec2abc30debdf129422d2699d1eba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20d49bfcc3d234b461ab42c3c64208b8e496c927
Message-Id: <160253202387.16131.7995717861547263579.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 19:47:03 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 12:59:41 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20d49bfcc3d234b461ab42c3c64208b8e496c927

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
