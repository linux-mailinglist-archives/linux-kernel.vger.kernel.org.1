Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E492828BF9D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391372AbgJLSWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390907AbgJLSVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:21:07 -0400
Subject: Re: [GIT PULL] x86/core updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602526866;
        bh=6nSjG34G9g474eqJu/DKYwEJ+pX6CcB2aABfxNnxZPo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=z7sYUhgzClZH3bnM9UAacOzBD/BMB0TBIyjn52eXJZW68zjButm7yGCevmUSZ1/ST
         fldiGR4JlKYIn4LZQlsH3CBqtB1ARpCX0JvksqyhrIZqQy0yKn48a85cWQfziQp9No
         qtzSHdy8Fhtwt6HxX8mYKkgyPVbOhlQDwJBJjqX4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012111154.GL25311@zn.tnic>
References: <20201012111154.GL25311@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012111154.GL25311@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v5.10
X-PR-Tracked-Commit-Id: 238c91115cd05c71447ea071624a4c9fe661f970
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1e6d1d96461eb350a98c1a0fe9fd93ea14a157e8
Message-Id: <160252686606.3643.16194778904037172711.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 18:21:06 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 13:11:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1e6d1d96461eb350a98c1a0fe9fd93ea14a157e8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
