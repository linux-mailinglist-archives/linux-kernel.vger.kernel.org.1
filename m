Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5002D2DC75B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 20:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgLPTps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 14:45:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgLPTpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:45:47 -0500
Subject: Re: [GIT PULL] pstore updates for v5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608147895;
        bh=iD3G2Fav2x5blpCBQfqST4Sn7DtJBd6pUdLjj1/Amd0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hzRxQLbKONIMkqlXoo6XDjc2eticrpa8uG9+I4T9mKc2ZBaEK/hruxIvMOXWzTjtp
         BSbNtPiudHXxn6sxw+sEKbViMtLTdcHWeVh13v78bxPvmJVt5NPWKnmmaZwzR41JdT
         guOrZzVezAmdtag2Dpc0n6jmxqS/eS9x+VIV0fS2fsQb+0AY8Om9bfVTxH9Wy4Mogl
         YOfD0hN8gOZeUzCEp0PFSrGL1DcWPoDxIeg6kaX+EWOxGgQ1Qt46I+3CqBDviU+TGh
         ZY7zZyGF6tHvas7Ps9aXjxY1xMrl1lHTzGvfUI/r9bL1Emr9rZVKqUcsuxeKBVVQvK
         2ZqO1rXwE6gNQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202012151219.126DB90@keescook>
References: <202012151219.126DB90@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202012151219.126DB90@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.11-rc1
X-PR-Tracked-Commit-Id: 26fecbf7602dd69b649914e61526bd67c557fece
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ba1d41a55e4d07c7b27ee2f6e7cf5b5348849261
Message-Id: <160814789530.14944.8758552216435069142.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 19:44:55 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Vasile-Laurentiu Stanimir 
        <vasile-laurentiu.stanimir@windriver.com>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 12:19:50 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ba1d41a55e4d07c7b27ee2f6e7cf5b5348849261

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
