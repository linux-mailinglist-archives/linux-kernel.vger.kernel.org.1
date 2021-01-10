Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1613F2F099F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 21:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbhAJUIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 15:08:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:46860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbhAJUIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 15:08:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 9E6A722A84;
        Sun, 10 Jan 2021 20:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610309243;
        bh=l3BYfZ9T4jh8uGFh0LOO19KGji5xf/gQwKY/slc5NCU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ldkVfRSq4T0s2vxKCgDLSjSweL8wzlAgdolv7kLoOtcT0Xkm5K6zzcwNehYBYnqmO
         hgr9IKYaviPJHGWvO76Bxe8pub+v0jWiLrge204srobYl5SNWEciYjXYMGwtDhgT1O
         zeDbUfRUvjdhy0+HRANOg2VQavypIKzuuNWm5bsds/1B4zfmNm+XCrgpNZxLKMvFUg
         VrGgSnq22J9dH9y3Fz1XsHrVWMfD05Vl1AqO9lyl/eTYZYDGmfNWJSTICnQLfmvZfj
         tJIgjK6hPvYufPgI6QkxRrWoHkbeiAbgb1jrPTxwX643C6ftDae0U7kuU7v4AJNR4w
         fJmD+z1W7Sz9g==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 93F9760141;
        Sun, 10 Jan 2021 20:07:23 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.11-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y2h1j6k9.fsf@mpe.ellerman.id.au>
References: <87y2h1j6k9.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y2h1j6k9.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-3
X-PR-Tracked-Commit-Id: 3ce47d95b7346dcafd9bed3556a8d072cb2b8571
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3cd1a16cc8829776523fcd114299373be4e5187
Message-Id: <161030924359.466.12818097113991379322.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Jan 2021 20:07:23 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, natechancellor@gmail.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Jan 2021 23:54:30 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3cd1a16cc8829776523fcd114299373be4e5187

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
