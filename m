Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F48123ABE4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 19:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgHCRzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 13:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:52332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728627AbgHCRzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 13:55:08 -0400
Subject: Re: [GIT PULL] Crypto Update for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596477306;
        bh=/S6sqi5du8sJcXL9oxKwqLtIS1tSebSkTHVVE1mxF4Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mjR0dPJv1XdUmZMskpFMS/VEPpaELrqJOB38UHC9M+6mma4D0rumf9G3C+Zuzmoaj
         jVhSX7UETk4fffaaVEIcO1rs8YQEWM8Z29hEmEM++KE9bMjv/eXwvVOF6TWkA6u1di
         3ixPdvEZ0Y/D4frqOZY1JQRVwbdpxIOuYfHuALsA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803044024.GA6429@gondor.apana.org.au>
References: <20200803044024.GA6429@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803044024.GA6429@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: 3cbfe80737c18ac6e635421ab676716a393d3074
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ab5c60b79ab6cc50b39bbb21b2f9fb55af900b84
Message-Id: <159647730637.19506.10955731022601276417.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Aug 2020 17:55:06 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 14:40:24 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ab5c60b79ab6cc50b39bbb21b2f9fb55af900b84

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
