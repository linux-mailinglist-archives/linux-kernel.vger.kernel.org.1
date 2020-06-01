Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613B01EB26D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 01:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgFAXzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 19:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbgFAXzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:55:09 -0400
Subject: Re: [git pull] uaccess access_ok()
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591055708;
        bh=AfhKkaCKN0qXS51dmDp6TWesfPiFgRIOWMn6zibl1sQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Nuw8e+EmY2Rb+BaXS9eVk+MTMf2hrIcR+U4jnQanBMrn/fj3p1bB8zPE6OE7R0Qbd
         eknxIi/QX+BSD3ipH9bVdrqNYote1fhezc06/QaYo2S3xGkj4qwyhBySHVwwY3V7PC
         H/Kt6nxVGbXiJWZPhFIb8n+RqiW0KWDdPJF5a+uc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601182524.GB23230@ZenIV.linux.org.uk>
References: <20200601182524.GB23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601182524.GB23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.access_ok
X-PR-Tracked-Commit-Id: 87c233b8158a20a9c9ab1da96cb5cb1734d9006e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0cd9206878a3b95024602b355b254d142f5ce94
Message-Id: <159105570874.29263.11282703838230810534.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 23:55:08 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 19:25:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.access_ok

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0cd9206878a3b95024602b355b254d142f5ce94

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
