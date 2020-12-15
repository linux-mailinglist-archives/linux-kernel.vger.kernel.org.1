Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314122DA66E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 03:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgLOCtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 21:49:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgLOCsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 21:48:31 -0500
Subject: Re: [GIT pull] sched/core for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608000471;
        bh=1vUJwMcDMnCoWmzodaSxOqBj4FRYhA4Zi0tFcHUAhWM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=EBIFbmoxwIOG/N/ijJYEzpHjAOcOD+kra3KSeDe/Bx9d9w3jik2/mjJdw0O/Pco/2
         FQovmRTxrgvXbgcA9B2QrTMdi6t9+363O9dreBOfyd6nIDK+dxdZRxBD2CV/z2/qXh
         dg5cWfREac8je46jVXDt9/THhKtQol+RSFCQ/D7MawdhrhKFeQGq36lTeJO3P+mXXu
         giDQaSr99R5hXr5zWx2p4OLyqxsKy4BbucPfubDXSPWyS5z/IDUjNIrwQqxnFa9kYg
         KEqKqgBxHds6VeW/yF1M+VHzKhBckLxDaBUe/LxDXNvZmn4OEny6aoaEj2+Fs0x40E
         tmQGuqZjYOE6Q==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160797733789.10793.18065892325435860673.tglx@nanos>
References: <160797732939.10793.9152151866806316627.tglx@nanos> <160797733789.10793.18065892325435860673.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160797733789.10793.18065892325435860673.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2020-12-14
X-PR-Tracked-Commit-Id: 5b78f2dc315354c05300795064f587366a02c6ff
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: adb35e8dc98ba9bda99ff79ac6a05b8fcde2a762
Message-Id: <160800047084.6499.16690395975758946045.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 02:47:50 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 20:22:17 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2020-12-14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/adb35e8dc98ba9bda99ff79ac6a05b8fcde2a762

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
