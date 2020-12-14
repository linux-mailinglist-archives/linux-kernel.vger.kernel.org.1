Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA74D2DA317
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440379AbgLNWOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:14:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407362AbgLNWEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:04:08 -0500
Subject: Re: [GIT PULL] x86/build for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607983365;
        bh=BFC+Y2wYzAZ8vVzDpFAh5sc3OJfuA0IXc/exR5bVMf4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=L6b3v6d1x7RA8mDXzlGBS78+Cuut7F66b2NByjntvj8+pMZbXedrJeBzdrhHqfmye
         HiDOEoHnuj7vqQlLgAyolpfzoLSt/uC+Xx6ad6al666mu3kZvxFf7Z8o/cExegBB++
         dPJVJic2yIn4y5ukibq3r+R8orXNOVSTYZiF/iD3Rykhe4g1Oj+AESEvOk6bhPLdym
         nnNNt1F7PlzzLsZ+205GLKrjb6hZRaX0h4qC8ushLQcbfogsz0z45lL/6/aq6TZFQz
         7v0OTx3TXAuZ+B1WJ/Jg7vvwPzuXf+jzcpNwUOqL43CmQIvdTjZuGpnH3POy8hm5cJ
         kbPqqHqnBApFw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214154138.GK26358@zn.tnic>
References: <20201214154138.GK26358@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214154138.GK26358@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.11
X-PR-Tracked-Commit-Id: 2838307b019dfec0c309c4e8e589658736cff4c9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 84292fffc2468125632a21c09533a89426ea212e
Message-Id: <160798336587.30284.2796881809464728959.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Dec 2020 22:02:45 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 16:41:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/84292fffc2468125632a21c09533a89426ea212e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
