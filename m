Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559681EB1CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 00:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgFAWkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 18:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbgFAWkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 18:40:04 -0400
Subject: Re: [GIT PULL] m68k updates for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591051204;
        bh=4oyywQeOl2lZNG5Z3hlKXjgww1kiiqzbIkZd6wrEy2k=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=HUSwNlnZ4auU2hJs1D2z085+8ToQuK2mY3E6qVRJjpKGhZvD5T0QGZzGvMZyBOFMV
         cUOqkUILJ3W0D5/IuTVceM3CKnOAsdKIshMGu0qWay07mlJAvexqUIqz7xuf8RYX7P
         haQCDmz9WC/6K6mhqPsgIA/1y9gpz1Z3sDT+UMns=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601125937.19759-1-geert@linux-m68k.org>
References: <20200601125937.19759-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601125937.19759-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git
 tags/m68k-for-v5.8-tag1
X-PR-Tracked-Commit-Id: 3381df0954199458fa3993db72fb427f0ed1e43b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3ee3723b40d55f473b8c82c60ed0e67f1f9ec6b9
Message-Id: <159105120450.7127.7823873842565842991.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 22:40:04 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  1 Jun 2020 14:59:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v5.8-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3ee3723b40d55f473b8c82c60ed0e67f1f9ec6b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
