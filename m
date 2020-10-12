Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D49228BF9B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390979AbgJLSVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390902AbgJLSVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:06 -0400
Subject: Re: [GIT PULL] x86/cleanups updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602526865;
        bh=OZfksDeVl8tPsDHvC5fp5jtDE77a5cA1CS8FsE5WktQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yAvqFNMnhg4++wcpXITyeF3NPLiLSmCVLNPP7FKB2wohBJYP9YbgSQzpkdCZL2bPY
         ThwTmxeRxreEit45RKVbD8Gzrz0Sav5T6/Xh7T1aBEr/+E67KdjhsNnNGpX1enPd/U
         l317xrpTO4fdUcjMKntOE2p8LHk2oPLUDswiXoPQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012105411.GI25311@zn.tnic>
References: <20201012105411.GI25311@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012105411.GI25311@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.10
X-PR-Tracked-Commit-Id: 900ffe39fec908e0aa26a30612e43ebc7140db79
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f94ab231136c53ee26b1ddda76b29218018834ff
Message-Id: <160252686568.3643.13416831116230992042.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 18:21:05 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 12:54:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f94ab231136c53ee26b1ddda76b29218018834ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
