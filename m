Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93AC51A5F91
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 19:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgDLRfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 13:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727220AbgDLRfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 13:35:05 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Apr 2020 13:35:05 EDT
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356FCC0A3BF0;
        Sun, 12 Apr 2020 10:25:26 -0700 (PDT)
Subject: Re: [GIT PULL] cifs/smb3 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586712326;
        bh=ohO0P5nLBtKBjvqG+Z8tpBKciqQpsgdnbu1u9jzTAp8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Y1pAAUKYmucoJaREmnTSRmuBbdvdLrWgWRvBNbN2M6Llb1sChg3SgmDB7KEtP30Sq
         xzNP1TTkPcAoQq+i15N6G9cgJ21NteRu9g5tLfH1pV8rOmveF9RyAeRD4h79Tdwxbo
         RM8W7MNNTO234fhSEhpu29Ms7jI0brM5IJQlX8RY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mu1iahVN8nRxPs1Pxu0m+XuMo+ePaKQph-xsbKuTfgbZQ@mail.gmail.com>
References: <CAH2r5mu1iahVN8nRxPs1Pxu0m+XuMo+ePaKQph-xsbKuTfgbZQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mu1iahVN8nRxPs1Pxu0m+XuMo+ePaKQph-xsbKuTfgbZQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.7-rc-smb3-fixes-part2
X-PR-Tracked-Commit-Id: 4e8aea30f7751ce7c4b158aa0c04e7744d281cc3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4119bf9f1d093b495f5fe3fcb32bde3156d2ba6e
Message-Id: <158671232595.12917.5055201253501396529.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Apr 2020 17:25:25 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 11 Apr 2020 21:26:01 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.7-rc-smb3-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4119bf9f1d093b495f5fe3fcb32bde3156d2ba6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
