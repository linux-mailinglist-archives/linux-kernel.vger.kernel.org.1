Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624C828C19C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391102AbgJLTr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:47:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729253AbgJLTrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:47:04 -0400
Subject: Re: [GIT pull] timers/core for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602532024;
        bh=nYAlFOJUrIOQKbN8/wL6snJiqXPrj6OkGPLnkIXkzco=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=adAZ0Sx32jCSUZFdbKkrJaxLl104XCMFPkid92UGpLRDxmBuwbhm9JEbpt506Yzum
         gMtrnPmYUzJ0sFbLSOIk5eQi9/4enIbmM/0eIOYj499k55IqDj5/PyH2es0VjLY98p
         bf/LSjy+g1TY+6Z/oYNZkT5opF4Egl4o0iV6+zYI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160250758404.26264.2443446427592733269.tglx@nanos>
References: <160250758161.26264.880601562259119308.tglx@nanos> <160250758404.26264.2443446427592733269.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160250758404.26264.2443446427592733269.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2020-10-12
X-PR-Tracked-Commit-Id: 1b80043ed21894eca888157145b955df02887995
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f5f59336a9ae8f683772d6b8cb2d6732b5e567ea
Message-Id: <160253202409.16131.15497841953513650726.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 19:47:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 12:59:44 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2020-10-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f5f59336a9ae8f683772d6b8cb2d6732b5e567ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
