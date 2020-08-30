Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CB0257006
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 21:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgH3TPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 15:15:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgH3TPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:15:42 -0400
Subject: Re: [GIT pull] sched/urgent for v5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598814936;
        bh=q1UFHPyP+kCv1dh+oXreQM+H7e/SAD0aej8P0B4qn8I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xpFjJG8bdEFIulSY7Sbcqkj3iWCAK02JjOwUDytVU4d+aDVs53L3jM+VRdDh8pB1u
         /VkdCV/jtK5i2QJId2I2QuFk1PxKvnhp+d9MZGtv7ot1T87Cex2eKA9MlJLvY9eIf4
         rvvlrxL7GydqALMbaqLa4KUjhRtimS+g2d0u9xOE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159881061804.27993.16119786735164087221.tglx@nanos>
References: <159881061564.27993.11909051048930389391.tglx@nanos> <159881061804.27993.16119786735164087221.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159881061804.27993.16119786735164087221.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-08-30
X-PR-Tracked-Commit-Id: c94a88f341c9b8f05d8639f62bb5d95936f881cd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0063a82de937433ccfffe123e12b4503b9155c96
Message-Id: <159881493690.11576.11858622863450149032.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Aug 2020 19:15:36 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Aug 2020 18:03:38 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-08-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0063a82de937433ccfffe123e12b4503b9155c96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
