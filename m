Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D1429775A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755226AbgJWSxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:53:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755128AbgJWSxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:53:19 -0400
Subject: Re: [GIT PULL] ARC fix for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603479198;
        bh=xhrf1iZgqo7P2NL6XfJZpgOLqh1fytRNaRDNgDz9w3E=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=pQrvfR+wRivIMoGEU+RsCgFh6uFJV3yBLeSnQATSn+oYaf/bAovA0z1XzYiYSl0vh
         wT7h5nfPr5QMZiGw8gG9X13ZqsAijRsgvOFtbd/ovNnzL5lFxhsEGjSIkJ/SBUVbYd
         M5QyOMVlikmemTSfrMKzM0GyYdENeRLWKbVx956E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <cb7b01ac-abf5-b6df-3f15-a7a20533a89f@synopsys.com>
References: <cb7b01ac-abf5-b6df-3f15-a7a20533a89f@synopsys.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <cb7b01ac-abf5-b6df-3f15-a7a20533a89f@synopsys.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.10-rc1-fixes
X-PR-Tracked-Commit-Id: 8c42a5c02bec6c7eccf08957be3c6c8fccf9790b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a14d7649872be966d12bc6c3056bb37c27b94bd
Message-Id: <160347919884.2166.15192264621751801542.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Oct 2020 18:53:18 +0000
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Oct 2020 02:35:33 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.10-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a14d7649872be966d12bc6c3056bb37c27b94bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
