Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B196F23E5E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 04:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHGCja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 22:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgHGCj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:39:27 -0400
Subject: Re: [GIT PULL] CIFS/SMB3 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596767967;
        bh=P556asfZU0fv6PfTTcVU1bTzaYkGV5iaaVAZr7fseew=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v7mK7iRsfnghH1Af6iYwCOJQ7L0xeQ5NCD5tN98XlJApUAnb+MAi4Oqf/Gnp2iNjG
         CqFPfxTIp/07h0nJsvGpl1PFX44WmRxiNzzs07xK/FuIvTP01LsWAkRITTp3wo1c2l
         YJBf+qkh4WKxySMLWt/ceJFJaLrkFzIw8D7/1z4E=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvA7xqmqPMmYRrU+Jc8SbF-YG=GH9OjvR+Upx_q6aH3jA@mail.gmail.com>
References: <CAH2r5mvA7xqmqPMmYRrU+Jc8SbF-YG=GH9OjvR+Upx_q6aH3jA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvA7xqmqPMmYRrU+Jc8SbF-YG=GH9OjvR+Upx_q6aH3jA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.9-rc-smb3-fixes-part1
X-PR-Tracked-Commit-Id: 7efd081582619e7c270d1c0a422385dcaa99fa9f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 327a8d76b1ac2037f87bf041f3bc076407284ffc
Message-Id: <159676796725.23087.18320063482019258045.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 02:39:27 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 17:45:03 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.9-rc-smb3-fixes-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/327a8d76b1ac2037f87bf041f3bc076407284ffc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
