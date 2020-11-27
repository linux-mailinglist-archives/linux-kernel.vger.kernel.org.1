Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA752C6D85
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 00:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgK0XLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 18:11:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731761AbgK0UHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 15:07:51 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.10-4 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606504791;
        bh=h68Lr1H/1qqNs5nStKe8J/yiTz0SMFs27L3RiWvJkA0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oFEL9yoHkuXPmM6X06yYW5KXRwGyegZ3nAHP42XxUpKY83j/YXiuT9vUUEYQHxXrE
         hq67h6tpsDGp13t39UwD4uzdGtBsG4zZPz1YJTImnE2WffWfYorcLdo+uytXqSxf5b
         zuu7OuG66XT6rpOIsO9hL2Pzvg/YkwWDmba14RpM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877dq7x91s.fsf@mpe.ellerman.id.au>
References: <877dq7x91s.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <877dq7x91s.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.10-4
X-PR-Tracked-Commit-Id: b6b79dd53082db11070b4368d85dd6699ff0b063
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95e1c7b1dd4a91451040ff0f41c5b5173503a38e
Message-Id: <160650479188.7570.124440902242648321.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Nov 2020 19:19:51 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@csgroup.eu, clg@kaod.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        npiggin@gmail.com, oss@buserror.net, sfr@canb.auug.org.au
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Nov 2020 23:45:35 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.10-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95e1c7b1dd4a91451040ff0f41c5b5173503a38e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
