Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E03319EDAE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 21:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgDETpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 15:45:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgDETp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:45:29 -0400
Subject: Re: [GIT pull] perf/urgent for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586115929;
        bh=moizqoc5JI14FvfsokJUuS5iC740fL3t4MLuM7q6hx0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZOVSgZlMpxrv2AcwWErnUTKI3nRtorCYVtSbVHU0EZshvKuFgFhZfmJooBdJd1bIn
         JWp3Q3J/UoHeRvqMZ9Q59zzztSuBxDKvkRfOqF7C2sryL5zkMuP/QpMg/gTANS0z82
         zj5Qvabdvql6sDCToV59n8gkG7AVi7R5C+DuqUfg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158609411109.4266.17403116661607373065.tglx@nanos.tec.linutronix.de>
References: <158609410988.4266.5816311298811487752.tglx@nanos.tec.linutronix.de>
 <158609411109.4266.17403116661607373065.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158609411109.4266.17403116661607373065.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 perf-urgent-2020-04-05
X-PR-Tracked-Commit-Id: 7dc41b9b99cd0037a418ac47e342d56a438df649
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c48b07226bd41f4053aa2024c5e347183c04deb5
Message-Id: <158611592940.11305.3488972537035972176.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Apr 2020 19:45:29 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 05 Apr 2020 13:41:51 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-04-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c48b07226bd41f4053aa2024c5e347183c04deb5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
