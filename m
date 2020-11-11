Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8156B2AF261
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgKKNkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:40:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727148AbgKKNjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:39:33 -0500
Subject: Re: [git pull] coredump/exit race fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605101973;
        bh=CpucPYE53hQA2uOmKOlKJKGwrkEv2Z4cEcsyb0uWkKw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=dQh5dDJSnsXxi2DkU81kifPBSxHVj5Xvy0SX9Z+l46ziV91pOGm5b/6lfOs4CeoFE
         SUVr4w/JdKc68kClCHzO5lzP8BQl3EVdJF5Ir/oc7sOUCgj1MblQSTHzIsPAOx3k+J
         eJfOxyf6vbtQ63E2PaqGL1fmIoafl3fFt71NB2Ic=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201110182804.GA705344@ZenIV.linux.org.uk>
References: <20201110182804.GA705344@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201110182804.GA705344@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
X-PR-Tracked-Commit-Id: 77f6ab8b7768cf5e6bdd0e72499270a0671506ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eccc876724927ff3b9ff91f36f7b6b159e948f0c
Message-Id: <160510197331.25708.16566527194936169543.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Nov 2020 13:39:33 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 10 Nov 2020 18:28:04 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eccc876724927ff3b9ff91f36f7b6b159e948f0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
