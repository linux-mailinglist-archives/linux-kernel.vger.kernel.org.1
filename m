Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DB02DB9BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 04:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgLPDou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 22:44:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgLPDou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:44:50 -0500
Subject: Re: [GIT PULL] dlm updates for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608090250;
        bh=7IH/LmHuAFn26Jw4lmclIvaowmxX7YT6oPVESz3yca8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EuYS11NIwcIjhd4RPkaB6eXZi+7eaMmlas4y2FOxp1aTvnhF76rzkdSHAa9nXaRQM
         dr/CP++ru4LOeD1j0AiY4oulvOmmt4hpYbcTjSkb5lR+N7jZb3vKBKNUND2uAIln92
         rVO9KcD3hOvJ3iDESyUseXgJZM/W+bU3Kk3u5Fnh0YQbBqma9i/1fY1X1ABCJxiKdw
         ujA2KqtDAUqTMTeC+iJbtDqxm2cs/Aj0p5xytAduDqWdbWK+vBoJmlJ8yIIKHgK5V5
         27bRtlBlAMlGt9nt+CkWIeS199sLtApMpEeAWlxwvlQpT0URT0geNMTWgQ9NT5POK8
         SAHfWHHk8Az2Q==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214175429.GB9687@redhat.com>
References: <20201214175429.GB9687@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214175429.GB9687@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.11
X-PR-Tracked-Commit-Id: 4f19d071f9bee1bb2040ae73436314a5ec9ede44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a7a4301ddafa8445684c6c9cad2382bd42e7c4a
Message-Id: <160809025020.9893.8061810315464612359.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 03:44:10 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 11:54:29 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a7a4301ddafa8445684c6c9cad2382bd42e7c4a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
