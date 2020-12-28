Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8AC2E6C27
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgL1Wzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:55:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729336AbgL1TtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:49:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0F8A1207AF;
        Mon, 28 Dec 2020 19:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609184900;
        bh=Iacp6jlYTZdHlWPZ4yGE1zHNs+RuTfHExojFLuxKQjo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jhVQ+js0i+ERsB2Y52WUOtSrsyDDJGUWP28FXtF20y1YNOPpIGo618RV7KNtHqYl0
         KF7AL+mIZF5/wKI12RmBN1FaiE2T/HMoRxeIgliMAReLndDeKjI7hFT/VapkGTJDOS
         f5kyf9PkhmL2tocKwLn296/GcqaLxyoFQfSfGJzk2Nu1v7mYxtb6jXTNfYFk99IPka
         xt5cmcg6NDG1wnNXWEFK2xbkxtFyraF2EjMmjcEAHQ3Q1ic9JFGqe1BkALQ8dYmmD3
         1JMkPhb/O5bP/ncLCzGA/dHsKXR53oO8DRnSur9yBW51BjVWiZqciVI7hL08x1tkbk
         fQTjfJAFAucLA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 09FD5600D9;
        Mon, 28 Dec 2020 19:48:20 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue changes for v5.11-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X+oat9YaT6+ZKTL5@mtj.duckdns.org>
References: <X+oat9YaT6+ZKTL5@mtj.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X+oat9YaT6+ZKTL5@mtj.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.11
X-PR-Tracked-Commit-Id: 01341fbd0d8d4e717fc1231cdffe00343088ce0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c76e02c59e13ae6c22cc091786d16c01bee23a14
Message-Id: <160918490003.31247.9100916026346560860.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Dec 2020 19:48:20 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Dec 2020 12:49:43 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c76e02c59e13ae6c22cc091786d16c01bee23a14

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
