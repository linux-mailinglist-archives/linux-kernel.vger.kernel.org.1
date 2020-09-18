Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A892270487
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIRTEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgIRTEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:04:10 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.9-5 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600455850;
        bh=+r1SlampjTuOecYW4MBncC9/nK7G1GM8vszuuKHgM0Q=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=D/lyjQOAeifHfyjmBXR68vjkRrolJRYbeYavkRQyR1xLALJ/hafiSaVYxtu0X4Gy8
         hkqObbLulgXvbIRsVJNJD3CwaMyKVNwIPkR2rakKlQlWlAftUuHqLsIo6wCz/UT80A
         rpg4ouK3sUeJgJCraD7aVrc150FlJZ4ACsmGrI6Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <877dsr6ztr.fsf@mpe.ellerman.id.au>
References: <877dsr6ztr.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <877dsr6ztr.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.9-5
X-PR-Tracked-Commit-Id: 0460534b532e5518c657c7d6492b9337d975eaa3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a55d36f715b01a00c1ad7127a73044c6f1c9668
Message-Id: <160045585052.18461.10646782124562223911.pr-tracker-bot@kernel.org>
Date:   Fri, 18 Sep 2020 19:04:10 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ego@linux.vnet.ibm.com, aik@ozlabs.ru, aneesh.kumar@linux.ibm.com,
        linux-kernel@vger.kernel.org, vaibhav@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 18 Sep 2020 22:20:48 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.9-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a55d36f715b01a00c1ad7127a73044c6f1c9668

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
