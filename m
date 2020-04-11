Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7031A539E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 22:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgDKUKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 16:10:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgDKUKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 16:10:24 -0400
Subject: Re: [GIT PULL] dma-mapping fixes for 5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586635824;
        bh=mWgtkEvt7IMZaEJYQN1AEo87Xcb8U1YyKp3EJ0shWuA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=2i3MKRiFWkbsxJsABANc83L2WU2WUXTs+jOdutdLOi8M3nJpFmkUFVxmrbwTWLn4q
         NMR+JLZ/Q4Ze1xhXy3atP7xKibpo6f7pSNuoP97Bj3kF4U2IEj2yly27b5EImx4eck
         m/MTu4lAAqJDacZ2/sS8+CLarLlHG5bIVc0xe7KQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200411082800.GA1807013@infradead.org>
References: <20200411082800.GA1807013@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200411082800.GA1807013@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/dma-mapping.git
 tags/dma-mapping-5.7-1
X-PR-Tracked-Commit-Id: 9bb50ed7470944238ec8e30a94ef096caf9056ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 75e71883979c2c173ef2530a8b90a629f17f3107
Message-Id: <158663582474.1053.17528689947317556174.pr-tracker-bot@kernel.org>
Date:   Sat, 11 Apr 2020 20:10:24 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Apr 2020 10:28:00 +0200:

> git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-5.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/75e71883979c2c173ef2530a8b90a629f17f3107

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
