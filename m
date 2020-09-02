Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0767725B516
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 22:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgIBUIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 16:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgIBUIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:08:13 -0400
Subject: Re: [GIT PULL] HID fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599077293;
        bh=x/Eqam7FLsOGvFK3XV0zW7WK+szCdtBm8lM671y/CUM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PPxTgRZVjgX/E5E7Ae8RyNzqgmoKHOYjk9ZTyhFNv+tGCWTFkuPvfhLWy1sIS2mfC
         Q6Qa4EU1nnOUJE1ijNbeGhFZPatZdqe05R+Fn7lpYwWGTbn0KTuW96sjMdw+V9+jAi
         u440OLQF3W5Id+/VHAH3B8q2OPY1MIxbenHoIG7M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2009022051130.4671@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2009022051130.4671@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2009022051130.4671@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 35556bed836f8dc07ac55f69c8d17dce3e7f0e25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fc3abb53250a90ba2150eebd182137c136f4d25a
Message-Id: <159907729308.15646.11991662179378143026.pr-tracker-bot@kernel.org>
Date:   Wed, 02 Sep 2020 20:08:13 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 2 Sep 2020 20:58:13 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fc3abb53250a90ba2150eebd182137c136f4d25a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
