Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DD62DA6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 04:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgLOD33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 22:29:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgLODIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 22:08:37 -0500
Subject: Re: [GIT pull] x86/apic for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608001676;
        bh=4V04ritHb8/74dt4KGOVorlwzHfnt05iar2WKYAB/CY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=chdmvfe/5WJufn2NpE8GwOGLWrUX3ywi2s5qcPw19TmOiAMfr9sca5zRTRswkKRA2
         0GoUlnU+noF2aVVyWBZKjudTsPLrXBxHrC4Bd1PFjiIHttCm+gc0yV0H7G8ldBT13A
         gHAP5tn2CZfPuilsEPxsLhLP7Rr6sQOiL5yXZp77Ao4x+M6538qKC5WO/Kw1UGwI39
         PSAU7h46lSlyES/MFJeVwYQ7dXsEdRM0Wn4BhwazPHzr74NrIWfpB7dW8KzrHdYkhX
         T+5Wqtki6pjnRtUdNiZb2zg78xqOfXiriDoz6c6u5QJdAZ5ldyHqCjqQ9kwDX67n4B
         VSUDHf6HHnzrA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160797734033.10793.4023884058552218676.tglx@nanos>
References: <160797732939.10793.9152151866806316627.tglx@nanos> <160797734033.10793.4023884058552218676.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160797734033.10793.4023884058552218676.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2020-12-14
X-PR-Tracked-Commit-Id: 058df195c23403f91acc028e39ca2ad599d0af52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 148842c98a24e508aecb929718818fbf4c2a6ff3
Message-Id: <160800167649.18953.8151788647197811582.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 03:07:56 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 20:22:20 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2020-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/148842c98a24e508aecb929718818fbf4c2a6ff3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
