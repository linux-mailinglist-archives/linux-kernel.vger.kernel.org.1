Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA650296469
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 20:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369561AbgJVSFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 14:05:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368836AbgJVSFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:05:16 -0400
Subject: Re: [git pull] vfs.git set_fs pile
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603389916;
        bh=5nJSfI5YZr1wWJ0wnhHYRH/r2Q8rGz+E8iv6aT0WJhc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=sXOvgUkqWpP4baqLs9EQIS9fvI2iLDDpXdyV2HT/EVwdqNmpvgLJrgcrkjAz1sosE
         hYrzOPtYs1XZpb6/OJ09d4BY6TYtyjxKxWubldYFlV8VUeOEPHjuFoH8gERsLreAZy
         2lqgEXWK/QCjcTxICOA7uGttAepzff0JaiwZUwbM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201022060128.GS3576660@ZenIV.linux.org.uk>
References: <20201022060128.GS3576660@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201022060128.GS3576660@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.set_fs
X-PR-Tracked-Commit-Id: 7b84b665c874f60d84547635341e418f20cbbab2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f56e65dff6ad52395ef45738799b4fb70ff43376
Message-Id: <160338991618.20886.15115879321821147736.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Oct 2020 18:05:16 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Oct 2020 07:01:28 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.set_fs

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f56e65dff6ad52395ef45738799b4fb70ff43376

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
