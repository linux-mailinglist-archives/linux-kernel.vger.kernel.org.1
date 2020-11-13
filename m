Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E9C2B136B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgKMAoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:44:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgKMAoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:44:02 -0500
Subject: Re: [GIT PULL] GFS2 fixes for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605228242;
        bh=p5W6PXKZz2rv4UwbAE6XHgky5O6y4BAkkLrtmMAwB/w=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lZePOXx/ybhWc3iQLXO1ZN0LUY7bZbNn99dpu2QvAuXVT3n6xPLEXN2yymcI79DXS
         dYPhM1nVa1Db2qCyDA4JdYp+EcRsHvQYDtNYGzKUXar/g4AcpJJtHbUY99D9IGJhD+
         PRtHvsLy53SkpzTmqksPTxFyeO8DR+MqcV+/zV0I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201112222346.2227664-1-agruenba@redhat.com>
References: <20201112222346.2227664-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201112222346.2227664-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.10-rc3-fixes
X-PR-Tracked-Commit-Id: 4e79e3f08e576acd51dffb4520037188703238b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20ca21dfccb6dd6ae4d1d22b91c3c7514f4a712c
Message-Id: <160522824238.10618.2247890705828753217.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Nov 2020 00:44:02 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 12 Nov 2020 23:23:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v5.10-rc3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20ca21dfccb6dd6ae4d1d22b91c3c7514f4a712c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
