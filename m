Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DDB1F0802
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 19:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgFFRPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Jun 2020 13:15:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbgFFRPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 13:15:16 -0400
Subject: Re: [GIT PULL] workqueue changes for v5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591463716;
        bh=vsU2301gIDf/OmzajL3nrKOBah/MCVmrV9K45F8uQZ4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ymoADC3PAEHbcnO7W5VzzLIjpEDAXLIvN2zKheAxaWT/WBBVxcgqmkToYhU2ZMRWk
         T5Gjh7c94viNSIo47737KKsV/e8CaujOdnqNGZIntyoauvbdDFG+6sn28OgjGuqEGt
         pzCTFTkTZ1VI8FAwILtFEl5cy5xOo3ZLJPdkv9aE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200605202022.GK31548@mtj.thefacebook.com>
References: <20200605202022.GK31548@mtj.thefacebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200605202022.GK31548@mtj.thefacebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
 for-5.8
X-PR-Tracked-Commit-Id: 10cdb15759540f03d056e2f73fe26377ed7dcfda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe3bc8a988a4d38dc090e77071ff9b8ea266528a
Message-Id: <159146371596.31751.11183902635465176338.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Jun 2020 17:15:15 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 Jun 2020 16:20:22 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe3bc8a988a4d38dc090e77071ff9b8ea266528a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
