Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3433D2DF1C3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 22:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgLSVIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 16:08:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:49688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbgLSVH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 16:07:58 -0500
Subject: Re: [GIT PULL] pcmcia updates for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608412001;
        bh=RYx00+oPwHYezqOu1ekhS6AgjaQ+cvhgSMGH2rJ7G9I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pIl0ATwG+he1CVCnVAnwi88i6MbdXohSdq+YMrm13qqf96QfZD2m1k96IX0915iZl
         AQ1CVPrj78sNlTFLHj+beUV2ee6nKCPGfH1eudUOXq0ClNoMrHXFa9xjY3utAFtzR/
         K1MH5Elmj2B7X/8P/PYq7+TnvyE608LDsE2i4NGx/0AsIro1jLJVOv/tm/3LRWQ3Ax
         /x7bPK25vREMrKFohnLlV3cIGQUdrcIK2Hzfm0DDyCCK5zOcilac4TDt3oUkcO8xiZ
         cnBqIbGZ2JC+bDHUxmvQUm16WDrdqaVlTYQ73MbNd3lVFXsp6rExvTw5AC4PL9Q0iL
         G/rpBil8AR6Pg==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <X92pTkP2CWpp/RyQ@light.dominikbrodowski.net>
References: <X92pTkP2CWpp/RyQ@light.dominikbrodowski.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <X92pTkP2CWpp/RyQ@light.dominikbrodowski.net>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next
X-PR-Tracked-Commit-Id: 70d3a462fc244b0580268cc8e6c47ae4463db68a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 651283d57eb4107f4a81af282064e597e2f9b181
Message-Id: <160841200164.20285.12463578681903827358.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Dec 2020 21:06:41 +0000
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Dec 2020 08:18:38 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git pcmcia-next

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/651283d57eb4107f4a81af282064e597e2f9b181

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
