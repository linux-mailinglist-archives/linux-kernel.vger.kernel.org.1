Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B13121A3997
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 20:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgDISK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 14:10:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgDISK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:10:28 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.7-2 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586455828;
        bh=BR5zpLn3iIqFuK0MM+6K+hdgjXFllmqjXxS9v8rM6mQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=KgEPBLB4ndUQFXmXEYai5+hxuskI2doF8U8Xs4KDVN3rcrNhGGZJdWfcRW7+1pIRS
         DHm9Kf+y0x2mJr0AApceQiaEyNAhn7gDtZbt1wQHrBq3crwJLvBUrNUY+sw2nNC1Eu
         cVyyJinI8H2THmmWMcHDAoelPbEgmKvgbqJZRSOo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pncgkjdf.fsf@mpe.ellerman.id.au>
References: <87pncgkjdf.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pncgkjdf.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.7-2
X-PR-Tracked-Commit-Id: 6ba4a2d3591039aea1cb45c7c42262d26351a2fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4da01d8333e500e15a674d75885a9dfcfd31e77
Message-Id: <158645582834.26793.6840925047262398976.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Apr 2020 18:10:28 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, aik@ozlabs.ru,
        anju@linux.vnet.ibm.com, dan.carpenter@oracle.com,
        elfring@users.sourceforge.net, ganeshgr@linux.ibm.com,
        geert+renesas@glider.be, geoff@infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        msuchanek@suse.de, npiggin@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 09 Apr 2020 21:07:24 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4da01d8333e500e15a674d75885a9dfcfd31e77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
