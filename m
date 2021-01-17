Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F522F9523
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 21:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730251AbhAQUb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 15:31:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729841AbhAQUbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 15:31:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2FD2D21D7F;
        Sun, 17 Jan 2021 20:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610915466;
        bh=wRda/Od136zEOR5r+9Z/a9Z3oldgv76IApzPnuBzupo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PfM2ylZIGRLjAH9vEzQ0usMGD0Bh6Tld7a39BqITE5XAMkl9/rW/aE7/Glqn76Fhv
         biU/QamZbVuDz0kszZuYs61Zt4tjqvkkzA/5xJoMJDJhiDomFHJB0LhNCrkFThOYTH
         8qf2oGNCCYh7NhLYMd+4ByYgPti/c+7Fqrh4AzmJZRhYnVE8KxMo4L333GbmMYbPhl
         cxUSf8XkN9SUx7e07AMu7a06M5klWozWKERR1Q0iHgHMjDlje9x8bNGfk1Nc5hC6V5
         yEMF2GcsXkjTX93guHfS0faplqyo9jE4ZLZn8dVEnL/v55sSmm8jVbIxqWvI7BiESE
         5nKBI+CerbSvA==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 1D523600DA;
        Sun, 17 Jan 2021 20:31:06 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.11-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o8hnn9of.fsf@mpe.ellerman.id.au>
References: <87o8hnn9of.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87o8hnn9of.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-4
X-PR-Tracked-Commit-Id: 41131a5e54ae7ba5a2bb8d7b30d1818b3f5b13d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1339d6355ac42e1bf4fcdfce8bfce61172f8891
Message-Id: <161091546605.25840.15782559954148445248.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Jan 2021 20:31:06 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        arielmarcovitch@gmail.com, schwab@linux-m68k.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Jan 2021 21:24:00 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1339d6355ac42e1bf4fcdfce8bfce61172f8891

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
