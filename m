Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C12A28BF9E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391376AbgJLSWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:22:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390874AbgJLSVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:04 -0400
Subject: Re: [GIT PULL] RAS queue for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602526864;
        bh=mnfgWFD6wCluIfmAzTtXAC9+cZTOlVZzPhalAnJ8rE4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HdAit8ne2aVrQ4CgvnOI5GYVGZuRdhZm2gGTBI7QNmZ8YxbGCJLuHTNuwNP3CuD8L
         FQ9dwbQDtHea0zxJ9EPlQ34E/ajJbnL+qttaWRpYdGUzKEFvUmjkDzw1YF362MJ0Mv
         P/+NnYMrHxh3fX97v0D2pmWxXcrrGXr11y8/xK3w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012094520.GB25311@zn.tnic>
References: <20201012094520.GB25311@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012094520.GB25311@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_updates_for_v5.10
X-PR-Tracked-Commit-Id: b3149ffcdb31a8eb854cc442a389ae0b539bf28a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca1b66922a702316734bcd5ea2100e5fb8f3caa3
Message-Id: <160252686426.3643.5390180428609684245.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 18:21:04 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 11:45:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_updates_for_v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca1b66922a702316734bcd5ea2100e5fb8f3caa3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
