Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0A1257016
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Aug 2020 21:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgH3TRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Aug 2020 15:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbgH3TPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:15:23 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.9-4 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598814923;
        bh=lRC1r9SXxyMUzcRz2RCgByi874SQG96D/bTFj2piLW4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R40+MLd4ni7Q8HNR3OWmWwoxCOu30W0wKVlOg2wiiVEI0zW1kSBsxBCNG/wxkk7p+
         6aRQxskkP9T55CcOSc88Oj5dY4mJc4aMu9XUat0t9yLXxw7GJRNQJkQAijsgKDjeo9
         car0pgF2CbbB/Au0++5Tv92ConSvT1LyP4bDihBg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877dtg2uaa.fsf@mpe.ellerman.id.au>
References: <877dtg2uaa.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <877dtg2uaa.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.9-4
X-PR-Tracked-Commit-Id: 4a133eb351ccc275683ad49305d0b04dde903733
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8bb5021cc2ee5d5dd129a9f2f5ad2bb76eea297d
Message-Id: <159881492338.11937.9710630889804906438.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Aug 2020 19:15:23 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        atrajeev@linux.vnet.ibm.com, shawn@anastas.io,
        b.zolnierkie@samsung.com, aik@ozlabs.ru, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, npiggin@gmail.com,
        psampat@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Aug 2020 22:27:25 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.9-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8bb5021cc2ee5d5dd129a9f2f5ad2bb76eea297d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
