Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D54723C1A8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 23:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgHDVkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 17:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbgHDVkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:40:13 -0400
Subject: Re: [GIT PULL] Audit patches for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596577213;
        bh=l9nysqAe3RW0WBGN/XslLwmu3wXplDKMJOTROewsoW0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Skz0b8rvAJ5cg/Hu4eyjpMHt4ZhMBBqF0uMEsz0okuLwRgYhUSaUZoGf/BYvwmH4G
         osB0xVGKgWYJawGv/IuXvp7CcWyBhkz40Ef2PhxyTu2vPn03iDuqzTNTTmWKHhpQWP
         ktGD1vIpwL2YSaM8u2n9ei1/v+5+cKyK7vjo6hBo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhRP3yN4dvrEe5_iAgVDnLNeedLOLXeb_zaE9OmBW_qSQw@mail.gmail.com>
References: <CAHC9VhRP3yN4dvrEe5_iAgVDnLNeedLOLXeb_zaE9OmBW_qSQw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhRP3yN4dvrEe5_iAgVDnLNeedLOLXeb_zaE9OmBW_qSQw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
 tags/audit-pr-20200803
X-PR-Tracked-Commit-Id: b43870c74f3fdf0cd06bf5f1b7a5ed70a2cd4ed2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd76a74d940ae3d6b8b2395cd12914630c7e1739
Message-Id: <159657721331.17686.16655075394963794217.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 21:40:13 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 21:00:01 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20200803

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd76a74d940ae3d6b8b2395cd12914630c7e1739

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
