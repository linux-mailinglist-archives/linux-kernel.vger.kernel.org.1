Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8813030C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 01:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbhAZADZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 19:03:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:41086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732428AbhAZACh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 19:02:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B55C122597;
        Tue, 26 Jan 2021 00:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611619316;
        bh=3FJdAKNyHXBWlIAJDz2RBVIegeqPTN4+ctFVeUF+CZs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Jm/Cs8oYGGxzAdJUODjjR8SCN/CaNhYUu9aJzn1KdO156dfVOIPHlIYfrq1FwkSSh
         V0TULK5Drd0MloIE4juqLLeO9X0C2KtqoaNzNkov17Mp8naWoVIm7Xk06pCi6NdjS6
         pPSO8XKF4XWeeXnewtCWabcXA6TdIDLhxWCMi5t/khIyi1kDbJjunXA0CFeMIXrhI0
         pO4n3KlA1pzFOpP7aKDGSznpiNhh08Qcjn1NXuXqmd7cM1DZuzJRuu1aYhClHfPArO
         5JiSksXi+FDu4Iijo5HCLGYlt5vWNNSwSDhSv4z87kQ2kgUq6PiHc5WYim/0mROWjp
         sxO3pFfdUUE5w==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 9C06861E41;
        Tue, 26 Jan 2021 00:01:56 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 5.11
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20210125223619.GA16419@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
 <20200830223304.GA16882@gondor.apana.org.au>
 <20201026011159.GA2428@gondor.apana.org.au>
 <20201227113221.GA28744@gondor.apana.org.au>
 <20210108035450.GA6191@gondor.apana.org.au>
 <20210118051312.GA26120@gondor.apana.org.au> <20210125223619.GA16419@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <20210125223619.GA16419@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 4f6543f28bb05433d87b6de6c21e9c14c35ecf33
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 13391c60da3308ed9980de0168f74cce6c62ac1d
Message-Id: <161161931655.29879.15650772231493474406.pr-tracker-bot@kernel.org>
Date:   Tue, 26 Jan 2021 00:01:56 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 26 Jan 2021 09:36:19 +1100:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/13391c60da3308ed9980de0168f74cce6c62ac1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
