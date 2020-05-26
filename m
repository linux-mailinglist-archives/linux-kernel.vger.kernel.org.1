Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5521DED73
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 18:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgEVQkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 12:40:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgEVQkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:40:03 -0400
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.7-5 tag
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590165602;
        bh=MjBa/l6oia2TyL/IpwVT69wtKveoOnkRp2gZw5hhoSc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wsT1Xh0RVq3Ungpv9NgofE+QKQxqgi0Kya+FuX71VLTv7K6P/qa3Ybv7ZG7bonzk6
         eOr2f8iQPzHD+naGtxUpTz+IDtI3yFVb42zl8/DXzASTI/p897xxYZon9kvRqxT4Lc
         +ZuNSxw9ejgOmXE/68pfZMUz8J67CtDNo7fquHqc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sgfsf4hs.fsf@mpe.ellerman.id.au>
References: <87sgfsf4hs.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sgfsf4hs.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git
 tags/powerpc-5.7-5
X-PR-Tracked-Commit-Id: 8659a0e0efdd975c73355dbc033f79ba3b31e82c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8347bbf19f265c1bd254ca148f27caa71e77d61
Message-Id: <159016560267.11923.6208335789291315259.pr-tracker-bot@kernel.org>
Date:   Fri, 22 May 2020 16:40:02 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 May 2020 00:06:55 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.7-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8347bbf19f265c1bd254ca148f27caa71e77d61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
