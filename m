Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A942297DF3
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 20:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763705AbgJXSLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 14:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1763698AbgJXSLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 14:11:17 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.10-2 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603563077;
        bh=TQvZZn2WExax2gHBjgbdZqtWQZeWDJ9CoCzpr9KDJyo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ELm6skJ7/IoHeOwMARJ612feLj1zaEuwQFAN5IK/POFMl50ofumkFEL638+plmXBg
         z5JgjH6VgLPAX43BbFsFD+61iJNHndibLT+jV08DMv1aBJ6MlAkk+37wepDtZkYG1d
         zeT0NQc4NarYteDLCuWQtpd7W5mniK1SaRISmbhc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871rhnyk2a.fsf@mpe.ellerman.id.au>
References: <871rhnyk2a.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <871rhnyk2a.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.10-2
X-PR-Tracked-Commit-Id: 4ff753feab021242144818b9a3ba011238218145
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6f96e75ae121ead54da3f58c545d68184079f90
Message-Id: <160356307768.29626.9113382553912344023.pr-tracker-bot@kernel.org>
Date:   Sat, 24 Oct 2020 18:11:17 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, mikey@neuling.org,
        srikar@linux.vnet.ibm.com, aneesh.kumar@linux.ibm.com,
        linux-kernel@vger.kernel.org, hegdevasant@linux.vnet.ibm.com,
        ganeshgr@linux.ibm.com, jniethe5@gmail.com, oohall@gmail.com,
        linuxppc-dev@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 24 Oct 2020 21:50:21 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.10-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6f96e75ae121ead54da3f58c545d68184079f90

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
