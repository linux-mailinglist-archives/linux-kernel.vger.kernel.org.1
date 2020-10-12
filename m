Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A48B28BF99
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390946AbgJLSVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390901AbgJLSVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:06 -0400
Subject: Re: [GIT PULL] x86/fpu updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602526865;
        bh=UzCQ65x1t9SPv133wet8Xt+9lRsuj2BWqdj0fiZY600=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=do93MutYc6lygWLPYB0oyVBj4Ip6i+74vyvAcqT8FI2ztAuPriVfHSj530C75qiVK
         EljRoNp3v8mc50RNz8UeHikbB6nFgIPdCgEGVZZPk31PW9HCcCkFJxDxGkqmCHon0h
         qjP04fjlazc0JyMDBwi6tatYjxox6ePhi8iUP3rI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012105009.GH25311@zn.tnic>
References: <20201012105009.GH25311@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012105009.GH25311@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_v5.10
X-PR-Tracked-Commit-Id: 1ef5423a55c2ac6f1361811efe75b6e46d1023ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0d445f70c5d746eb3aa28c4d80619e624e49b4b
Message-Id: <160252686547.3643.9359758660287783891.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 18:21:05 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 12:50:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_fpu_for_v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0d445f70c5d746eb3aa28c4d80619e624e49b4b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
