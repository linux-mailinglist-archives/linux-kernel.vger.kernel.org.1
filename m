Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9BE2A87E3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbgKEUVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:21:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgKEUVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:21:23 -0500
Subject: Re: [GIT PULL] Fix highmem initialization on arm and xtensa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604607682;
        bh=baWLcp/Kja2XQFpkaWxdk3LyVWDPNxtcpfNfgsTq588=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ptxG/99jT7/w/7qrPB7YKpqkVvlZnQZcYz7luPOu4gSDBK7D4EiICDf/eBK/FM2wB
         DUVXuKYhh5gH9W1Wjn8jt38bXh8ymcApKU+EwqUGOqEZ/akEEosv5uQQZnPyEw45Sj
         j+6qun1ZuJXgNAWM30fUFZts7awXV80PRu+GCuTw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201105125827.GA301837@kernel.org>
References: <20201105125827.GA301837@kernel.org>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20201105125827.GA301837@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/fixes-2020-11-05
X-PR-Tracked-Commit-Id: b9bc36704cca500e2b41be4c5bf615c1d7ddc3ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a092479f3032a0e155448062ba5e36aa61e2c32
Message-Id: <160460768265.18865.7147708976290453069.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Nov 2020 20:21:22 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-xtensa@linux-xtensa.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 Nov 2020 14:58:27 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/fixes-2020-11-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a092479f3032a0e155448062ba5e36aa61e2c32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
