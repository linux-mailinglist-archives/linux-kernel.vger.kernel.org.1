Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E41D42DA311
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438014AbgLNWF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:05:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:53936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407390AbgLNWEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:04:08 -0500
Subject: Re: [GIT PULL] x86/cache for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607983365;
        bh=8V66PVfzg8IvQD8yKZB0xOyvbO+fQOlnf19FB2bYZiY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ZVdA3Heq6rFgLSeD3eWXddDALrGhFSE5v8zfkkxxUi3mt2vAR4jCWlC0ExrR4/ZeQ
         /O1TVbzziqMNLSL6KUGvolwhKsMVOUx65ahqDIHG1gJSkWIn48t2U+3v1zXC6abZjM
         u8Ohvb8unitlWp5GTcDit7qY+ZTpZzkWqK5NyYheYHIGhFi37QBSgXU/9+ugbaPok+
         hOtLKL9KBlQNw6gflelfJnNi8/qa8CCLvlITIjZ8Z6888DHGfVnyZw5srxXEAgXhxG
         r3QpIs0WVG9hqkastuJ58PIJ9o1uwr9qP2n0dH5TFUJXTCEWkDNw46o0MB31ygia1C
         xfEsHEEHUAnNg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214153520.GJ26358@zn.tnic>
References: <20201214153520.GJ26358@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214153520.GJ26358@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v5.11
X-PR-Tracked-Commit-Id: 19eb86a72df50adcf554f234469bb5b7209b7640
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ba27ae36b416a1507e783dbee4bb521fd6bb519
Message-Id: <160798336561.30284.4656036245403353192.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Dec 2020 22:02:45 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 16:35:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ba27ae36b416a1507e783dbee4bb521fd6bb519

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
