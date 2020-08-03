Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB03F23AFF7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 00:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgHCWKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 18:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728863AbgHCWKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:10:04 -0400
Subject: Re: [GIT PULL] core/debugobjects change for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596492604;
        bh=6DxNHt0sSSREeLIJ0GHfC8mBbpUB0xg3v0j2k3T5sVY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=x+/jp1+V6jJegDaTvirWEaKT0DamPcDFGuZ3cQVbAiGqcjYLbt7p4Auc4LZcC5anW
         hXmu0DewyZUD1B1gwY63Ef/EkSu09GwdBAGHdHsT4jXslMR8QTE35oeT7PgbekhgGk
         105NkKfGXkh37VmPMSrPgYRfgz52tH0xQEDMFvt8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803110944.GA258423@gmail.com>
References: <20200803110944.GA258423@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803110944.GA258423@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-debugobjects-2020-08-03
X-PR-Tracked-Commit-Id: 0f85c4805184765ff35e0079b3241ee8f25d1b2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8e69391d046a6acaa6a4cf72f9952ecd77d3085
Message-Id: <159649260437.26696.12173340323965174452.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 22:10:04 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 13:09:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8e69391d046a6acaa6a4cf72f9952ecd77d3085

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
