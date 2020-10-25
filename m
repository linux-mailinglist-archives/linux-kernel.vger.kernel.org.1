Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA21F298322
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418182AbgJYSfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:35:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1418148AbgJYSfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:35:25 -0400
Subject: Re: [GIT pull] timers/urgent for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603650924;
        bh=jIBxxx/Lcu7r80aGuw2Mi2rfNhTAYcJtdMVS0wrpDOM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MPBaprONwkS05KRB0TugP2nTqRXfWR8dV4naz/xx4Zm+yP6iNPHw91voDD4aYfk42
         RYwIFrTBmhwBsHyiXQxFE24/rdFYHwXPpMasn2vMcTDlE+JtYcFXFlG6HSG/bc/Pj7
         49xGTTrxr9BiRPLtcLjaHAr/gkJBTHlVJxwJeTFY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160363590826.1234.17293019096180328200.tglx@nanos>
References: <160363590465.1234.11586095980767794789.tglx@nanos> <160363590826.1234.17293019096180328200.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160363590826.1234.17293019096180328200.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-10-25
X-PR-Tracked-Commit-Id: a4fd8414659bf470e2146b352574bbd274e54b7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 672f8871261597894d46454b8fa1660d6c952af6
Message-Id: <160365092422.20889.15180692713430027789.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Oct 2020 18:35:24 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Oct 2020 14:25:08 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2020-10-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/672f8871261597894d46454b8fa1660d6c952af6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
