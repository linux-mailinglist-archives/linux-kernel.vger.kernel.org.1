Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCDD1F8537
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 22:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgFMUua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 16:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbgFMUu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 16:50:28 -0400
Subject: Re: [GIT PULL] CIFS/SMB3 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592081427;
        bh=pZy3NKi/Zid94nxI6/nuBO96E0lRMJGpZ3i2pJHozbg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rxNN659KbKBUW+woZPwHA4mCYl+a1WhiWbFGhCqQvWW3gwaNxysO4Y22WZMN4KuOB
         3r4MvoVMsCxdKI2Tmk5pwED5kHeLLN+HQ55q87ko2RMVISQ9ddQPkTRo8cV16S8Ujt
         qAb7vNzFgSU4g5M4TPqlgneT+NCfKY8qFf4eeoZA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msmGMLzqcLvr4M_qUKQRqeozPe_SZZs7eZtwpRr1wp1Qg@mail.gmail.com>
References: <CAH2r5msmGMLzqcLvr4M_qUKQRqeozPe_SZZs7eZtwpRr1wp1Qg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msmGMLzqcLvr4M_qUKQRqeozPe_SZZs7eZtwpRr1wp1Qg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.8-rc-smb3-fixes-part2
X-PR-Tracked-Commit-Id: a7a519a4926214ba4161bc30109f4a8d69defb8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f82e7b57b5fc48199e2f26ffafe2f96f7338ad3d
Message-Id: <159208142767.26377.11798638344498243697.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jun 2020 20:50:27 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 13 Jun 2020 15:37:46 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.8-rc-smb3-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f82e7b57b5fc48199e2f26ffafe2f96f7338ad3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
