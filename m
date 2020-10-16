Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE86290DBF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406340AbgJPWbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406114AbgJPWbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:31:52 -0400
Subject: Re: [GIT PULL] afs: Fix cell management, add tracepoint, downgrade assert
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602887512;
        bh=11B5arg7VXNs7SIZzwNZ1hBPZg8Dsdf6IAEcwVe2/vs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=I01fq9H6fmnb5u+RLhKBGXlIb6Rhr/25BQd1H3ZS0Shi9bX+TijjrHLsIDlWcGt2w
         0QyRMBD5NYB7kef1UZbF6wV0WVr8CSwYnrv0vSFDp6OMhNsclVHDcVLiJC2TKyba6r
         sA4YMvCHzFw8bD4ClPVTitwBOOa7nTp48kSzY4Rc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1431074.1602859212@warthog.procyon.org.uk>
References: <1431074.1602859212@warthog.procyon.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1431074.1602859212@warthog.procyon.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20201016
X-PR-Tracked-Commit-Id: 7530d3eb3dcf1a30750e8e7f1f88b782b96b72b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fad70111d57e0b728b587eabc6f9f9b5240faa17
Message-Id: <160288751211.30401.17773570038701475678.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Oct 2020 22:31:52 +0000
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, dhowells@redhat.com,
        hdanton@sina.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Oct 2020 15:40:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git tags/afs-fixes-20201016

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fad70111d57e0b728b587eabc6f9f9b5240faa17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
