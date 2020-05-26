Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D9D1C77CB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 19:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgEFRZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 13:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgEFRZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:25:05 -0400
Subject: Re: [GIT PULL] Crypto Fixes for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588785905;
        bh=fzGRweKFnYuQE7I3wU8pkgj10jd6dGKsb34NwyeKaG4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lEkB+PyhWmv7E6ttaj5djWYiSzNm2PxcyuRLfLR00sGzZDBag9cgZtUg4wJXMTWVH
         9e5bRd2FsQAow+1jPQB9GFm3rk/e/0GcB/n4Qaom2TS3R9ftVhUeQOR2Ha4a+mI6tM
         +x6kKU8nE5j2wPPlLLLyXbpYFmXXd+ce/wx9Bo7M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200506051006.GA6537@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20190923050515.GA6980@gondor.apana.org.au>
 <20191202062017.ge4rz72ki3vczhgb@gondor.apana.org.au>
 <20191214084749.jt5ekav5o5pd2dcp@gondor.apana.org.au>
 <20200115150812.mo2eycc53lbsgvue@gondor.apana.org.au>
 <20200213033231.xjwt6uf54nu26qm5@gondor.apana.org.au>
 <20200408061513.GA23636@gondor.apana.org.au>
 <20200429055420.GA26381@gondor.apana.org.au>
 <20200506051006.GA6537@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200506051006.GA6537@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: a9a8ba90fa5857c2c8a0e32eef2159cec717da11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c40cdb0e93ec166f1fa4fee1eb62d45b5451515
Message-Id: <158878590501.22676.15892210612217775226.pr-tracker-bot@kernel.org>
Date:   Wed, 06 May 2020 17:25:05 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 May 2020 15:10:06 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c40cdb0e93ec166f1fa4fee1eb62d45b5451515

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
