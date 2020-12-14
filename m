Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C8A2DA0E4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 20:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502822AbgLNTww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 14:52:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:44198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502623AbgLNTwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 14:52:07 -0500
Subject: Re: [git pull] drm for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607975486;
        bh=cvCK1zaCLrUynKDt3lpIT052KJV5cXh7x5aTW82+QCw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=OqDvYLLpTItmaDBBHCY497UkXybsxAdW0fsS2ty61R7mr9jcTln40X9ZSCkXLsRUw
         QGzS29EFhCIDy1gjPgdkT/hJBTEJLd4ShhfPDqEDsrli0hfZFB78lX4j7cOZkmDamn
         cic5QPzdeHXogWfwNCAQGMpsuXK0ZA88TMHPBi5MRgnrGQ2C0uppMivm/J3EBQgiZ2
         SMuCqaHiJTTGN27tCgW7mt/HxgaUCxCb2nVXPzlnvToUIJTG/Vz9lVHHuTCMOE38yz
         c6sXpvji9FHBm4U2DKSd6NIcDc/u4UBxodt1IeGHdT4XwNpwXgitsp/JxNjaoaCAfb
         zKUHpF9u80nNQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyNrbap4FG6qstkC5YTznqVebD=ye+4+Z+t42yQnL325A@mail.gmail.com>
References: <CAPM=9tyNrbap4FG6qstkC5YTznqVebD=ye+4+Z+t42yQnL325A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tyNrbap4FG6qstkC5YTznqVebD=ye+4+Z+t42yQnL325A@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-12-11
X-PR-Tracked-Commit-Id: b10733527bfd864605c33ab2e9a886eec317ec39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1d36dffa5d887715dacca0f717f4519b7be5e498
Message-Id: <160797548655.21325.12381698437384627490.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Dec 2020 19:51:26 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Dec 2020 13:52:21 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2020-12-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1d36dffa5d887715dacca0f717f4519b7be5e498

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
