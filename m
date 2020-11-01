Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E68672A211B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 20:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgKAT1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 14:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgKAT1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 14:27:03 -0500
Subject: Re: [GIT pull] x86/urgent for v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604258823;
        bh=6nCv9yExZyz5/+8HeaBNu70YOKJT4AEgsYgO9lhum8k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ho/0Q85tSpl0fJyOzIZTmGWzDtZAIhjMbTeyPmFUDzLmW4smCp0K/iTuOX3ObFexa
         +WSWvLl0pcvcr0obeUtOXEn7u+qbBqvJck9CFcZmi5EtP/GDV+7AUFq9FCZCQbnXs0
         S1vUzG4YjpDfqqkKTq3N3zUzKPtAqPIIqevCoYEk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160423896498.5667.10759421124605297683.tglx@nanos>
References: <160423896136.5667.9743580255833470691.tglx@nanos> <160423896498.5667.10759421124605297683.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160423896498.5667.10759421124605297683.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-11-01
X-PR-Tracked-Commit-Id: cb05143bdf428f280a5d519c82abf196d7871c11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7b56fbd83e261484da43f04090bce07570bd117f
Message-Id: <160425882296.14673.10029462354926319595.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Nov 2020 19:27:02 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 01 Nov 2020 13:56:04 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-11-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7b56fbd83e261484da43f04090bce07570bd117f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
