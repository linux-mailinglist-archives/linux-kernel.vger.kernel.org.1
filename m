Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD98420E66B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 00:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgF2VrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 17:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgF2Sfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:44 -0400
Subject: Re: [GIT PULL] Crypto Fixes for 5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593450914;
        bh=Sf3fgStsrUyF1JZW9gNQ9fUsCF7HtLMfWRNqJtTJmaA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=V6P5V5YEAio5SN5KUVGZa+DAnvllREp7oNvQPH+NCFl8fgTZHq9LjCdp9YiA9rgcK
         K+JZJ7tuMWbBYZ0i3RJQXGcpc3W2Aj7wysKN/qhphDV15heN1wmAE+geGzQog6127H
         8KLNggj2diWH5zUqPHjx4Ak6UWofeG9kp9fYBD5s=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200629021627.GA13792@gondor.apana.org.au>
References: <20190916084901.GA20338@gondor.apana.org.au>
 <20190923050515.GA6980@gondor.apana.org.au>
 <20191202062017.ge4rz72ki3vczhgb@gondor.apana.org.au>
 <20191214084749.jt5ekav5o5pd2dcp@gondor.apana.org.au>
 <20200115150812.mo2eycc53lbsgvue@gondor.apana.org.au>
 <20200213033231.xjwt6uf54nu26qm5@gondor.apana.org.au>
 <20200408061513.GA23636@gondor.apana.org.au>
 <20200611040544.GA27603@gondor.apana.org.au>
 <20200621082303.GA30729@gondor.apana.org.au>
 <20200629021627.GA13792@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200629021627.GA13792@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus
X-PR-Tracked-Commit-Id: e04ec0de61c1eb9693179093e83ab8ca68a30d08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cfa46dadd203eef88cc70131df7a81ebc34b8ff
Message-Id: <159345091425.2382.6853137988813099953.pr-tracker-bot@kernel.org>
Date:   Mon, 29 Jun 2020 17:15:14 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 29 Jun 2020 12:16:27 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cfa46dadd203eef88cc70131df7a81ebc34b8ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
