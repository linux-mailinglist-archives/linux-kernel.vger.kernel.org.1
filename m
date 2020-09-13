Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C398F26804F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 18:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgIMQes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 12:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgIMQdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 12:33:33 -0400
Subject: Re: [GIT PULL] Staging/IIO driver fixes for 5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600014813;
        bh=UF/1u/Hb44Uy60ai6q8/KrA78xDD1LOyJcvA+7mjIaI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fnVbbiQyUFTJIyaOHkTn2ZZTM8xJ0NscAX39G3ehWt9al9SwBQNuaQH8K49/zKtj/
         44H2RquEF/atDarpEnHxaW+QNTzsL+CpmnlS04a9wmlBTl1mGWPdd8+fHCufsNzcRI
         Rx37KifFSKyeedc+GpXpywz//1MSEphhzo75eNzE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200913083918.GA906881@kroah.com>
References: <20200913083918.GA906881@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200913083918.GA906881@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.9-rc5
X-PR-Tracked-Commit-Id: a139ffa40f0c24b753838b8ef3dcf6ad10eb7854
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6c7247f6258b2dba353c885a1b00d795a380cc85
Message-Id: <160001481310.6953.15482507862553138944.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Sep 2020 16:33:33 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Sep 2020 10:39:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6c7247f6258b2dba353c885a1b00d795a380cc85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
