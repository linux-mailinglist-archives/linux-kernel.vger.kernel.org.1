Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFCF2DB9C1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 04:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgLPDow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 22:44:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:37662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgLPDou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 22:44:50 -0500
Subject: Re: [GIT PULL] jfs updates for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608090250;
        bh=0vMZbc838Z2+PRYqILASr0ORQPRMUSm2pHdwiVFzahc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FkKcgVu0h/c4z7g2OhvHJyzk2XDjaQJfdKu9LxfXL93g4GN4B2WMuNQP7Eqe3xmj2
         jds8Y5WqcCnWWFUoHaeEA9YGhTkwgkHgD6izBUxppIj/zRqgdTyKl0MarBX+xBSw+G
         iDZ6sl+T4/zJN8FepAvQ8/kyLU7Uk/vi0dxYUTbKLN2DkAdrCRFoRtTa2+bNtTWw8A
         L0iPDwB/Fk92fwt/l8njnmHZL2ArdNaTxvDsFIyMZrPe7SpsOez0D0b9kFIrOflf/+
         28P02bTgN0wurIfhC91rn0effcD3T3xJfhM0Oe9tWblhKlin1OMK/J47jdW9cfA1Gz
         VattIVejEhkUQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <819c9249-ee95-7d67-0577-b9b1f7c09832@gmail.com>
References: <819c9249-ee95-7d67-0577-b9b1f7c09832@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <819c9249-ee95-7d67-0577-b9b1f7c09832@gmail.com>
X-PR-Tracked-Remote: git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.11
X-PR-Tracked-Commit-Id: c61b3e4839007668360ed8b87d7da96d2e59fc6c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9867cb1fd510187d8f828540bdb48f78fceb70b3
Message-Id: <160809025049.9893.2284380491965731001.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 03:44:10 +0000
To:     Dave Kleikamp <dkleikamp@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "jfs-discussion@lists.sourceforge.net" 
        <jfs-discussion@lists.sourceforge.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 12:07:50 -0600:

> git://github.com/kleikamp/linux-shaggy.git tags/jfs-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9867cb1fd510187d8f828540bdb48f78fceb70b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
