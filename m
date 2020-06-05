Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70371F0166
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 23:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgFEVPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 17:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728522AbgFEVPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:15:14 -0400
Subject: Re: [GIT PULL] core/core updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591391714;
        bh=dU0Wq4OJrrvt/H1JUTdDjy1T/ezgPD2WslM4RM9FjX0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zEGrYCNE6J2+PcvybP2eg5NQrDyFviKXkvXba+8lbTKzqvZwegSQrKL0wXdo9Q8mq
         x6C46o5gCX4UVAFYxyPtlP6GYSWXRLyddA5i+jRDYwedgAgmQ0d2srYPIoR6tEvtkb
         y1j0MDYggc8M4gZDFaEkZ36tzsaNN5/F23engXC8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200603213452.GG19667@zn.tnic>
References: <20200603213452.GG19667@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200603213452.GG19667@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 tags/core_core_updates_for_5.8
X-PR-Tracked-Commit-Id: 6e0d6ac5f3d9d90271899f6d340872360fe1caee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac7b34218a0021bafd1d4c11c54217b930f516b0
Message-Id: <159139171412.26946.1059343448471381589.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Jun 2020 21:15:14 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Jun 2020 23:34:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/core_core_updates_for_5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac7b34218a0021bafd1d4c11c54217b930f516b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
