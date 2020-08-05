Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E43723C2E1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 03:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgHEBFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 21:05:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgHEBFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:05:08 -0400
Subject: Re: [GIT PULL] uuid update for 5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596589507;
        bh=uwX22/UTZ4garRiwRVMyn8Gko1SVHmcHfUHlKvyKjVs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=StTuQx+ErNFy7nGMLOOylcWzLg9x2LDDW0knsqqYjQ0oVdX5kbeWSqVBK/5jdkn9j
         trNTgejHKjmyNuS0zTzUVACweg7shaYlW4HpWoCkIDGIIwoXdNjszz+EwWoIjisbs4
         OkUL8Op+PDgu6T80XEKrZnTHCr/sSDstE5+z0cdo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803140432.GA751849@infradead.org>
References: <20200803140432.GA751849@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803140432.GA751849@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/uuid.git
 tags/uuid-for-5.9
X-PR-Tracked-Commit-Id: 3c8387d234f75887a2d78972ab0f764fe9f756e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9fa867d2acbca6c4cd317ab75c0e94e1703af2b0
Message-Id: <159658950777.28431.5630407975177528690.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 01:05:07 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 16:04:32 +0200:

> git://git.infradead.org/users/hch/uuid.git tags/uuid-for-5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9fa867d2acbca6c4cd317ab75c0e94e1703af2b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
