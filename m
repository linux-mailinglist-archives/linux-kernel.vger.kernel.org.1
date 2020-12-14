Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAC52DA2F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgLNWDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:03:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:53064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728848AbgLNWDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:03:23 -0500
Subject: Re: [GIT PULL] x86/RAS updates for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607983363;
        bh=k0dNiECDgXkAlN0tEdBRbEd/Au0+Qy0HBJtKhTkAt9k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kO1s6q66qsqHU63XCcrW/nqO4+mRgTMWZoWR3UxoWbQjkDFoZY4nn15gxPZtC1QjN
         lKXYXY7pgQrPKxaUpR5Kgp4b7iB2e0Dw4G3LrsVHZBb6C68EDsNLo/kiBaViJVTchI
         sPo902hjPGH/ZnJx3hS+pOVSpFAccrmeNhNtYc3aQr4qNc1zSoS0XACtCzv24agAo6
         E8mTc50afsPH8nh2QtoVcnk4h8SKQpPbNiCqa8QSu+3fIMaG1lTyYmJUnRS5J89o5D
         7dLX0PSl6H7O2rOT95o95tRljGnAHNSs8fxIH58pYglE+M2lqE9GcYzXgO85MVZpSx
         vdGSUZku2AOFA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214111550.GB26358@zn.tnic>
References: <20201214111550.GB26358@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214111550.GB26358@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_updates_for_v5.11
X-PR-Tracked-Commit-Id: e1c06d2366e743475b91045ef0c2ce1bbd028cb6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b34233ce20b6a2f364c3245cd9421ecabddccdc
Message-Id: <160798336329.30284.139540528047915227.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Dec 2020 22:02:43 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 12:15:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_updates_for_v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b34233ce20b6a2f364c3245cd9421ecabddccdc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
