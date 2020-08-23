Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FF124EF4E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 20:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgHWSjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 14:39:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgHWSjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 14:39:23 -0400
Subject: Re: [GIT pull] perf/urgent for v5.9-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598207963;
        bh=wUEzJlCj0tzuAwLBp+VHZU4GT6SbFkLT9+6d6UJLMvU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VnEKrDrHk8tRXBETFf+BbfeDftbNCtT5Qf1tW6hskgYrqYV35H8kW4SeVxeWzg/11
         hu353z9M0mQikCGIwue7Zqteg2oHWcBC2kfjfCD4FENqKwT3mc5q7/ldeJZQyiZTG3
         gGXCPkuiHaTIRsG/Q/Bx8KPeV+87Eb+ZlGgxpvUc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159817113641.5783.13356693197176111647.tglx@nanos>
References: <159817113401.5783.14776307451257171431.tglx@nanos> <159817113641.5783.13356693197176111647.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159817113641.5783.13356693197176111647.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-08-23
X-PR-Tracked-Commit-Id: 24633d901ea44fe99bc9a2d01a3881fa097b78b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cea05c192b07b82a770816fc9d06031403cea164
Message-Id: <159820796316.12134.11093397585934051637.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Aug 2020 18:39:23 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Aug 2020 08:25:36 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-08-23

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cea05c192b07b82a770816fc9d06031403cea164

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
