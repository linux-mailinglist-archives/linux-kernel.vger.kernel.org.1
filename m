Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B91C32AACCA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgKHS3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:29:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:58256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728689AbgKHS3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:29:34 -0500
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.10-3 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604860174;
        bh=q042H9vYLIGiOFHGYdTtbN+D6qVoNyzg2oZF/S8p5vk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LjFYfZu0iKgxbgbNGJpLbnBEPFDq0H9Lp64br4TN3qhwoWjUQqh8upj1+4iJ2vyES
         gBdWXUtcmozkbkm37JPeLBIipUKC3jvU8j5WH9iCG3m9vSn2X14GG1Jy/aKkRYPPLh
         K7oINNJrQhE/z/7ahisTWS9cUJs/9bOz1OWhlnBI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87361kta6k.fsf@mpe.ellerman.id.au>
References: <87361kta6k.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87361kta6k.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.10-3
X-PR-Tracked-Commit-Id: 3fb4a8fa28b740709bdd3229b80279957f4d37ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e942d75281398a8aef4f751753eff26a2a53f081
Message-Id: <160486017413.13369.14318977500004170529.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Nov 2020 18:29:34 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, paulmck@kernel.org,
        cai@redhat.com, cheloha@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 08 Nov 2020 21:28:03 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.10-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e942d75281398a8aef4f751753eff26a2a53f081

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
