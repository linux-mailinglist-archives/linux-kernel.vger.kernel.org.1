Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258612B378D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 19:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgKOSAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 13:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:34428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbgKOSAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 13:00:13 -0500
Subject: Re: [GIT pull] x86/urgent for v5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605463213;
        bh=t01aNBqjhl+T+iGazP8IwfRA15s1/HmaL8SiWYz6BjE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=p7z0s9VxpdK+nvrZqLYbYfkXnAMDmf26ve+Pj3t4kVfXUhJWseoHKKESBFfGryAXw
         LiIEUpqzuksT4iR2uQQn+8FRTbixVFppXkxL/RjQX8x/dU9l3RmW9FCcgmyVeXjlIr
         uAdiQktqy29eOrC0hQotm/qOi8O7AlhdqkQ21Do0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160544524386.25051.9326481900625497800.tglx@nanos>
References: <160544524024.25051.12292089189937197323.tglx@nanos> <160544524386.25051.9326481900625497800.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160544524386.25051.9326481900625497800.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-11-15
X-PR-Tracked-Commit-Id: ff828729be446b86957f7c294068758231cd2183
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 326fd6db6112534738b5229da538bf426d78c851
Message-Id: <160546321362.32406.16184632785016585645.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Nov 2020 18:00:13 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 15 Nov 2020 13:00:43 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-11-15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/326fd6db6112534738b5229da538bf426d78c851

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
