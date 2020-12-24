Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CC12E2902
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 23:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbgLXWQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 17:16:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728987AbgLXWQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 17:16:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3486622AAC;
        Thu, 24 Dec 2020 22:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608848121;
        bh=VsEEnkmtCYk88sgAcg3H79H4WZsqdw9ZodwVGVqpg78=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ttp4Jh88H5+tODU8FD1qjhUAzurI/BBRefRfySfHmlM/DjPlb6euOefRJR2bklqmE
         8YyAYa/NK0uTWiunbxgm0XuelzUL5hnjta/e1ypM31siFzwmvLJnIOfqEnmqz4FKLf
         +BYfH39SjTl0kjsEUTbTZGh9t1lHrEJUvJZsG9YsylLG6YpAWaYTGcfxnKdfA6Ce7U
         Mtcq0e/xeyFRlxYLb7JnBr30AD7tGbea/V9XJ1pUXPleFqXGbxlMgtug/TwzMwOoPi
         vvM0Wl6TLwYwU/my9WCg3mm9ivQ8EVScfdadmV17pgYWuPDqsbsq2DBz6w95SJcbxO
         liPTEcQbH73RA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 2F30560159;
        Thu, 24 Dec 2020 22:15:21 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.11-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ft3w6kc9.fsf@mpe.ellerman.id.au>
References: <87ft3w6kc9.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ft3w6kc9.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-2
X-PR-Tracked-Commit-Id: d5c243989fb0cb03c74d7340daca3b819f706ee7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9b3f7f1b841e91f0f0414525fa6edaaa2df33ccb
Message-Id: <160884812118.9963.8876461526933137364.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Dec 2020 22:15:21 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@csgroup.eu, clg@kaod.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Dec 2020 12:53:10 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9b3f7f1b841e91f0f0414525fa6edaaa2df33ccb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
