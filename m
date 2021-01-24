Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609D6301E26
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 19:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbhAXSfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 13:35:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbhAXSf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 13:35:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D607022C9F;
        Sun, 24 Jan 2021 18:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611513288;
        bh=OTqw2s1r6dFAnr8ig8yr+Z6sMqsIUR6rmC1qmDx0sxQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uTTxnK4YjXJ6+aetDiNqZWwTU3Uh2vKt75lEiN55TkOZjiw1m3LbCfCLyOWRVlMda
         b6N5xaNMusJBw94UPaLR906ycx5Nae2EV9fxFQ6hFVLjSaMtSrPJvnTxdlpcX47xmZ
         L4QSSvtZ+piPBkJaIGKhKw8icDJBYKNALsB29CnCqkaZdTiqiw6gOXiUtkxHME+NUy
         CIHLwhQCW2ssKLPGrfKxgBxs8k3N3DYFiXbuIuIewI52YrMZbKO85+SVBo30koPvWp
         QN8vnSCNsTO5jNkMFPk+YSjBRuAhcoCm6WuHyKrxVrjfqcoGxnqN5r/4LMwa7kzofH
         Viligt7UqjwXQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id C3097652E1;
        Sun, 24 Jan 2021 18:34:48 +0000 (UTC)
Subject: Re: [GIT PULL] SMB3 Fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msGe3xaKkJwt6MB98Tb2X3HW7HXAbubuet9LKbR+rYcdw@mail.gmail.com>
References: <CAH2r5msGe3xaKkJwt6MB98Tb2X3HW7HXAbubuet9LKbR+rYcdw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msGe3xaKkJwt6MB98Tb2X3HW7HXAbubuet9LKbR+rYcdw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.11-rc4-smb3
X-PR-Tracked-Commit-Id: 214a5ea081e77346e4963dd6d20c5539ff8b6ae6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4dcd3bcc2063ad7bda2e84bd417f2f536e4c14ef
Message-Id: <161151328870.2223.2952941467513012019.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jan 2021 18:34:48 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 Jan 2021 22:44:04 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.11-rc4-smb3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4dcd3bcc2063ad7bda2e84bd417f2f536e4c14ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
