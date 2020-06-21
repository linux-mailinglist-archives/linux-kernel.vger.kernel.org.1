Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE7D202BB5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 19:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgFURK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 13:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbgFURKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 13:10:23 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.8-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592759423;
        bh=ZKcl+97bymU6K1F3dGsUkV+JSxwqUs7q28xWWYpO+wU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iVYyOFyxHdDHTbhWE3egS6057Pzp4y6FCOLlBED+WpEZNOVs8ri5n4rW8oZfIcB1P
         FzHW5rNfo7kcoOom84dTBzHF277d67ebvn80fO2biC5/OZfl9zwOvsH4JJwf6/G716
         L/8DTQLB3YATYkBzTuYo0dz6ndLbXCLkNo/RnCbY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87366od72u.fsf@mpe.ellerman.id.au>
References: <87366od72u.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87366od72u.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.8-3
X-PR-Tracked-Commit-Id: c0e1c8c22bebecef40097c80c1c74492ff96d081
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75613939084f59c0848b146e54ba463dc494c433
Message-Id: <159275942292.6032.16018775763067134260.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Jun 2020 17:10:22 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, arnd@arndb.de,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        peterz@infradead.org, rppt@linux.ibm.com, will@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 Jun 2020 20:52:25 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.8-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75613939084f59c0848b146e54ba463dc494c433

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
