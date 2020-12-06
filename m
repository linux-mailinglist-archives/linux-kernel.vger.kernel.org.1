Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6474D2D06E7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 20:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgLFTb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 14:31:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:44980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgLFTbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 14:31:24 -0500
Subject: Re: [GIT pull] perf/urgent for v5.10-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607283044;
        bh=c/WloObl+KIQuhruQ68iBSbcZ8qvSPld2kc7mqID8u4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pVmi4etrOd90wyvrLNw8PWGfM9w8BKJpAkVeM+PYQ+ceZcjSXyu+CUJ2PjQuo/5lq
         qMvlG0OzvEFizqqofNSiOxDxEh4Fd/znTYip92mlZ1tcKMIpMAhT+3BQ3pr/uCXhrT
         k4NiMwJpAiddst6xaMcuDyhHfWzZql6z8zDgZBPyPn1v1eFMMWfwbWBe/20QPLD9UR
         yvA/dY/dik+KDwi5Fj+FwK0fSpC531ENWXyIY36nZbuKyLZjP3yUTzpQIgLBUrTnUs
         E0GQ+AIoRto39aGEZLlVQZ9Hst5stSocbxO3/B9RvEqjuu5t14zj6+6m8V5Wy54Vwr
         RElj8UVboUnFA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160726030055.10836.6112093149252426489.tglx@nanos>
References: <160726029814.10836.11636935433736940390.tglx@nanos> <160726030055.10836.6112093149252426489.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160726030055.10836.6112093149252426489.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-12-06
X-PR-Tracked-Commit-Id: fc17db8aa4c53cbd2d5469bb0521ea0f0a6dbb27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f6b28d498ba084dff970ad95796642f804ffcd8
Message-Id: <160728304430.10233.3904211583159198521.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Dec 2020 19:30:44 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 06 Dec 2020 13:11:40 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-12-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f6b28d498ba084dff970ad95796642f804ffcd8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
