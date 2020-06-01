Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B8D1EAFB1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 21:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgFATfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 15:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbgFATfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:35:08 -0400
Subject: Re: [GIT PULL] i3c: Changes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591040108;
        bh=cZRPhidNzgL26jD3WIMp1hGTr1qEh2Dg54jftWSYPIM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qKWrlEBlbi0VokRs8dzmb5TfxqMIKwVakCNc02SumBNeB+PIEjmNl0FSPe1wFA/Ri
         O37Az6QmTa4sFfTsxS6Bsy6VTiaPybZnlo/4TcfMZZ1/wn1NcE8tMNbks64973yigL
         G//kM6NkWWALW6GNGtB7Z1rOQq0cp2ckTlK/7a9Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601095423.00ffb5e1@collabora.com>
References: <20200601095423.00ffb5e1@collabora.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601095423.00ffb5e1@collabora.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git i3c/for-5.8
X-PR-Tracked-Commit-Id: b4203ce0556348dcfe29f897d1dbe65102874d89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 729ea4e064202aeec149b034b459501ef0a5060e
Message-Id: <159104010842.18844.6189652777114394861.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 19:35:08 +0000
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 09:54:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git i3c/for-5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/729ea4e064202aeec149b034b459501ef0a5060e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
