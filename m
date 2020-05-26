Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4271B1AE69C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 22:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbgDQUPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 16:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730573AbgDQUPV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:15:21 -0400
Subject: Re: [GIT PULL] Some documentation fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587154521;
        bh=qsVuuk9kanx5zbog7dG3WKhD02KJipXuuiB2NHImjNw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=wrNnzBYVcBX4pqgdGiGKnd2vuRDQ2fC9WqlM21wKOSvBffwZ3Oz1hmojy05u2vy2i
         MfBhovpqzRvv6EG76xhFDOAJBAdYBLrT0rTsC63sGH2KCX/bZyq2RgDwarRyu/M1g/
         uiUhDjIfABqDO+PpYKmFgzOyBv8jTstauDtVtIgE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200417135411.3730b17c@lwn.net>
References: <20200417135411.3730b17c@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200417135411.3730b17c@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-fixes
X-PR-Tracked-Commit-Id: d98dbbe0d331b1a6dc1ca0b948c99d58cdba580c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90280eaa88ac1a9140dc759941123530d5545bb6
Message-Id: <158715452123.10628.11076374558903392938.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Apr 2020 20:15:21 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Apr 2020 13:54:11 -0600:

> git://git.lwn.net/linux.git tags/docs-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90280eaa88ac1a9140dc759941123530d5545bb6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
