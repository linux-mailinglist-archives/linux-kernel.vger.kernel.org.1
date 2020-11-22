Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C122BFC88
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 23:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgKVWkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 17:40:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbgKVWkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 17:40:12 -0500
Subject: Re: [GIT PULL] HID fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606084811;
        bh=tn/+HKQAx/z9gI7LcESYi6HgTbee8ZgOJd79pGwU7yc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=fYJsT/4Ingo+RiarriXtLUNcgLZowaMZijEownPwCaM9mp7rMWInez6ryF1BUBGCV
         /CnYgoZ49T9MNx7VkufzSYVWqotTS1gH+VKgizWzWtDsFfhjKVuZJYMoH/KXkXMOsv
         prp1uZDuYVfcn3XxkMeWQca8tngLhbMSzEGZgqO8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2011222208190.6877@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2011222208190.6877@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2011222208190.6877@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: b4c00e7976636f33a4f67eab436a11666c8afd60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d5530d82efc8631beff20480b1168b1c44294fe1
Message-Id: <160608481162.4020.11372303734552374900.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Nov 2020 22:40:11 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 22 Nov 2020 22:18:19 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d5530d82efc8631beff20480b1168b1c44294fe1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
