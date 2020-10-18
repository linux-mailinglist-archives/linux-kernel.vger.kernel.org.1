Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6829D292056
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 23:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgJRVuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 17:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgJRVuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 17:50:52 -0400
Subject: Re: [GIT PULL] Mailbox changes for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603057851;
        bh=9gUbgEAss35wMpssWr+zaVA6L9jIZo7ukYCix8JXTz0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ypQ7OoNg6+Mz7ONKTWgdHlUkB6Oml42eoLJb4w1P3ykyQ08/vTPtRm6ifvzm967N3
         Rbl/Nzh34vzaxbfmzKKVocI2eytkO57BhkTy8mkGT+ZIn/Ix6NAZ552XYLKz35fp8u
         OzZzRt+ZTz0MQ7NWQ/50ajnQwto69oQqs2aDHW4U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY2hRBr7Uz9qtF9SUGzcUW6NNak0988v=0m0316erAYBTQ@mail.gmail.com>
References: <CABb+yY2hRBr7Uz9qtF9SUGzcUW6NNak0988v=0m0316erAYBTQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CABb+yY2hRBr7Uz9qtF9SUGzcUW6NNak0988v=0m0316erAYBTQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.10
X-PR-Tracked-Commit-Id: c7dacf5b0f32957b24ef29df1207dc2cd8307743
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 373014bb517e0bb291714fe1e232fb606d54931b
Message-Id: <160305785183.15396.17013585197044556890.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Oct 2020 21:50:51 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Oct 2020 13:22:33 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/373014bb517e0bb291714fe1e232fb606d54931b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
