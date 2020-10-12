Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F1E28C19A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388998AbgJLTrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:47:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388054AbgJLTrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:47:04 -0400
Subject: Re: [GIT pull] x86/irq for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602532024;
        bh=tOnuFIk6Q4Jj0db5CHr8wWknVsSfyI++ptOBeBCDKYU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iFA8OeKzA/cy1YnsA5kdm/B5fa4eyu/NuDVrgHlSO+vKu8PKKJFVwnABG9gOTv2vy
         0lf1JdgoDNjlxfXFGQ79+2xBnlf6NuV0vwetQQdBhEoBAfmHXbd3/V9LieVm7tnk68
         R/fIltF/p9jSTaIFxI+STJoqx3W+zkwBgnxICrUo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160250758525.26264.5041088866604906303.tglx@nanos>
References: <160250758161.26264.880601562259119308.tglx@nanos> <160250758525.26264.5041088866604906303.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160250758525.26264.5041088866604906303.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2020-10-12
X-PR-Tracked-Commit-Id: 981aa1d366bf46bdc1c9259a5ab818a8d522724e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cc7343724eb77ce0752b1097a275f22f6fe47057
Message-Id: <160253202429.16131.15379357255685505520.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 19:47:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 12:59:45 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-irq-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cc7343724eb77ce0752b1097a275f22f6fe47057

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
