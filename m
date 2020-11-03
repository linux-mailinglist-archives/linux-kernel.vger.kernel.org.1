Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B8B2A4DC1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgKCSAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:00:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:33292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727706AbgKCSAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:00:08 -0500
Subject: Re: [GIT PULL] Documentation fixes for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604426408;
        bh=Rz40gFbIKRRqBXyfBmMwEA3bLGYQr2L/1zeqbCuDfTY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DhKGIaQnJCZ/bFaU3HBd9M9UhpYChMQVlM6CHXK5UgnktCD4nWeZCBREG/v4nARLY
         lhIg5k4NyDoXsi3c554kJCsssqTPtpFzMfcJg3oNSK3pTpPimXu3F1FJloO9DWdywL
         seBMp/aBZFijvyGWeSrdcPuyKDGULldtguspeXm8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201103083006.06d519fc@lwn.net>
References: <20201103083006.06d519fc@lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201103083006.06d519fc@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.10-3
X-PR-Tracked-Commit-Id: 4f3e69060dc9cc8f14ad9e172ada7120dc76445b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce2e33ba4163c66ff89d2c0f2a9a51214a122e27
Message-Id: <160442640855.29492.14125638284787290059.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Nov 2020 18:00:08 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 3 Nov 2020 08:30:06 -0700:

> git://git.lwn.net/linux.git tags/docs-5.10-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce2e33ba4163c66ff89d2c0f2a9a51214a122e27

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
