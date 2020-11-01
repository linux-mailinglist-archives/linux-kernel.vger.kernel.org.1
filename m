Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE38A2A211C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 20:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgKAT1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 14:27:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:47894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgKAT1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 14:27:03 -0500
Subject: Re: [GIT pull] smp/urgent for v5.10-rc2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604258822;
        bh=7U4u68M/biZNMfeEedvx0az3ORjTQlqilXcKu7ksCao=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=a/1frNEqaYobQhdwBq3qh8FWsNY981nYy9DIsalkped/1/qwY9fHxv2u9sTTgimwU
         yW72HGFKNK8PKzXzHfIelRsj2dCWvn0Hp4KWpkHdx2KdF+wcIqmjue4EaUZeKyMU/X
         iYBFtba+Szz0HxTcSefCefX3ff+oj5VaYr4hT93s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160423896257.5667.16765311760968430798.tglx@nanos>
References: <160423896136.5667.9743580255833470691.tglx@nanos> <160423896257.5667.16765311760968430798.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160423896257.5667.16765311760968430798.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2020-11-01
X-PR-Tracked-Commit-Id: 4230e2deaa484b385aa01d598b2aea8e7f2660a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82423b46fc9ec699a0ede9e025a8414658cdcf48
Message-Id: <160425882258.14673.8179782179533959561.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Nov 2020 19:27:02 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 01 Nov 2020 13:56:02 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2020-11-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82423b46fc9ec699a0ede9e025a8414658cdcf48

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
