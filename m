Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EDC1D65E8
	for <lists+linux-kernel@lfdr.de>; Sun, 17 May 2020 06:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgEQEpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 00:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgEQEpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 00:45:03 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.7-4 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589690703;
        bh=QZPw0wcsdXmgGidodAVQ8evxzTshnVgcyCo8ZPopWlY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=CTxRUZ/MmhECu1bid0tvCK/DPYt0Ig6QEQ1zVJGMZM046BSRTz0wngRRBMJ+bVfKA
         boL2OpPr8IYucvnCjOCyFKQQXxwFmz393+4uXwFo8rDFCuAvcoGE+4sx124Q/rhXEs
         ghXAsxa/mKA/iyVAF5riKUDHh3ycG5+cOqyk7/PA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87pnb49j0c.fsf@mpe.ellerman.id.au>
References: <87pnb49j0c.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87pnb49j0c.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.7-4
X-PR-Tracked-Commit-Id: 249c9b0cd193d983c3a0b00f3fd3b92333bfeebe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: befc42e5dd4977b63dd3b0c0db05e21d56f13c2e
Message-Id: <158969070340.26561.5881835255663450370.pr-tracker-bot@kernel.org>
Date:   Sun, 17 May 2020 04:45:03 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@c-s.fr, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        nayna@linux.ibm.com, npiggin@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 May 2020 22:11:47 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.7-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/befc42e5dd4977b63dd3b0c0db05e21d56f13c2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
