Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA422A87E9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 21:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732296AbgKEUVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 15:21:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:34706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgKEUVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 15:21:25 -0500
Subject: Re: [GIT PULL] GFS2 fixes for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604607685;
        bh=ydXJB0IomFvKG1HWBjocly7MOtiPn+j1ZStA1QWvZhI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vcgO9aQpgvEy2uq4G5cwXoOwMLueo/NZYsqc0yw9O8x7PdbcERzlDEwYwWSJsJ6LS
         uBo/TykEy+IQJw0eErU/s56RpGl8hv+9g8FAoHJ5ntcdEHqTTAl9GP1TvfCLtR6wVm
         sURt6FzUcj6Jd0jc3uvtW5x0b2wMIApy1sNcJEBY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201105102731.1832011-1-agruenba@redhat.com>
References: <20201105102731.1832011-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201105102731.1832011-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.10-rc1-fixes
X-PR-Tracked-Commit-Id: da7d554f7c62d0c17c1ac3cc2586473c2d99f0bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1dd461207b8d1dbeaadf1e0b4e85b833c3a7c1c
Message-Id: <160460768546.18865.16615126821094176947.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Nov 2020 20:21:25 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  5 Nov 2020 11:27:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.10-rc1-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1dd461207b8d1dbeaadf1e0b4e85b833c3a7c1c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
