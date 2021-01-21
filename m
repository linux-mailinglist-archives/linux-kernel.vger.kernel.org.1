Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9AE2FF52D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbhAUTy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 14:54:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727569AbhAUTuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:50:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6AA5123A58;
        Thu, 21 Jan 2021 19:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611258518;
        bh=J2ATdw+uiIusvUMEx7ZgGrwYUhgWTs7sTNfNknsUVI8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hY045zOpicrwb1EV2Oi06wW803OVbY2CP+yXlLswGDS2x9NbpJLVZsVaUg2ssXjn8
         IboiWx4eX246BaY/hGxtnbWNzy5DTTi1YzKC1Y7fhOJX4PMNzckIUbanTYzGhLrngY
         YGbcLWgQCQCsFAlc+l7cb+I8+jiQNXuK6jGUSge8M8oKDLYZO2/fXgrCUrCKDu1ucl
         9+ryY0n7x09RAeRzQNa49Bbur5yuCTAs9hmyf+5HBRNvg2Ds4Mvk7ZaN6uGcyMU8zq
         WUXmCVk/wrDHB4olEk3/+lcWA0qKR1RVKRO8SbvQv2twAqgFljNWVTlsfHy0+ZlJwC
         h1CCnSLuJs7cg==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 65B3860192;
        Thu, 21 Jan 2021 19:48:38 +0000 (UTC)
Subject: Re: [GIT PULL] printk regression fixes for 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YAml8WLMo3mVSoKR@alley>
References: <YAml8WLMo3mVSoKR@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YAml8WLMo3mVSoKR@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.11-printk-rework-fixup
X-PR-Tracked-Commit-Id: 535b6a122c6b43af5772ca39cbff7056749aae74
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2561bbbe2e959c966e21ee23de91b9bd4bbf98af
Message-Id: <161125851840.32181.7244068242510984876.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Jan 2021 19:48:38 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Jan 2021 17:04:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-5.11-printk-rework-fixup

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2561bbbe2e959c966e21ee23de91b9bd4bbf98af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
