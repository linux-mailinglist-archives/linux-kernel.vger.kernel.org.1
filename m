Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD980268009
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 17:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgIMPxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 11:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:56518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgIMPxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 11:53:18 -0400
Subject: Re: [GIT PULL] OpenRISC fixes for v5.9-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600012398;
        bh=8reDQSoJ4DMyPgL2xfX7v/jWvSDuIVJ21JeA0lsQIps=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=B/zwhU7i88E6gFeCSPm8BJLgc9JacBOUQnEbRqmAZYTSVHN387Mupat+KFSBdJL8U
         7d0M6sr4KQXqLcf4fbn08Bks1LE1gEwnc44DDBuCOkDW6vXKuZw0qMKeSPX3Wn0RC5
         Zu8zUQ+uFRz60Se+ed9V2yJQiLBfC6brR9nz6nk0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200912084255.GR3562056@lianli.shorne-pla.net>
References: <20200912084255.GR3562056@lianli.shorne-pla.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200912084255.GR3562056@lianli.shorne-pla.net>
X-PR-Tracked-Remote: git://github.com/openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: d877322bc1adcab9850732275670409e8bcca4c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b952e974300be3184049a125e7cba112fe659017
Message-Id: <160001239813.19188.5642085973020190842.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Sep 2020 15:53:18 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Sep 2020 17:42:55 +0900:

> git://github.com/openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b952e974300be3184049a125e7cba112fe659017

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
