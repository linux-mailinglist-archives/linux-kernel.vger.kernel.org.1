Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72968298329
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 19:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418247AbgJYSf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 14:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1418137AbgJYSfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 14:35:23 -0400
Subject: Re: [GIT PULL] xen: branch for v5.10-rc1c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603650922;
        bh=1Yw38DTAm5hqdpgggMPY7fzxqYKarUJDpGy5M517d3Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ghr5L7DXNdFpn0F7DiGFM9GcF46YlKMx8DXuqJhxTw83qEHTjKaxov/IfHeMVJLYj
         A4qzHMUY6trW9sZSs17PjT+scdpvo5QHErMVoSFIJ29uZsArLsVLf0G0dJ7kSNKE26
         oOOiq3QrwMoGmfqx3Z5lqMZo4IThXOrOGclRakxw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201025104141.4698-1-jgross@suse.com>
References: <20201025104141.4698-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201025104141.4698-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.10b-rc1c-tag
X-PR-Tracked-Commit-Id: 1a89c1dc9520b908e7894652ee2b19db9de37b64
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd6aabc7ca39dd28a27fe1ec99e36e941cfb8192
Message-Id: <160365092281.20889.10785325670814123122.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Oct 2020 18:35:22 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Oct 2020 11:41:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.10b-rc1c-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd6aabc7ca39dd28a27fe1ec99e36e941cfb8192

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
