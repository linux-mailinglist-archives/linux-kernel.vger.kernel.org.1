Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0069C1AFD50
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgDSTUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 15:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgDSTUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:20:22 -0400
Subject: Re: [GIT pull] core/urgent for 5.7-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587324022;
        bh=5nyYXEpdDKD15gLUQVjfHqVe+HEkWzFq8ZSLOCoOn08=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aIpdw1Q8xJwXoan3NZbChDDBtC0C4yVDzSdn4qPDJ4HCjKKeyVJF8686fODEl0FVQ
         /V2UXdGfai66HGnK9+QB1AQFnnQc30viEfixohH75JjzFG/SVRsz6jD47JGBvSddHD
         mJSf/DHB2tM5/VGL9LvVAdqFehpeu1yd6oJi2I5M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
References: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158730459860.31269.9496277256253823777.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-urgent-2020-04-19
X-PR-Tracked-Commit-Id: 40e7d7bdc19e65a356ca6d692c6e56ec45012737
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e7de581270d26869a4ef47c957c667e57372d79
Message-Id: <158732402254.20624.2708008970229291308.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Apr 2020 19:20:22 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Apr 2020 13:56:38 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2020-04-19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e7de581270d26869a4ef47c957c667e57372d79

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
