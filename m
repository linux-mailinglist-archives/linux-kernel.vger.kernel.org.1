Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF64215CE3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 19:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgGFRUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 13:20:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbgGFRUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:20:05 -0400
Subject: Re: [GIT PULL] s390 updates for 5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594056005;
        bh=TAcaiC9HAg4zsFhqleVIFXRCXuX/BfEGTEuJsk6DBso=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=kjj3drK7PwbYbJpRX7XWcTjz559jjuk7Oqb7YggHDsG3tJO6Iaejobfgb+Y1QYcGr
         xM8j4weNG013XDtlirC2UQaJfdPHRMCEa2dEnXVeBrVNsgvKjxS/sRJSe4ENpNxeeJ
         6sUyyypFwA8yx8M9zvqbF7G1ywzDQ9uQVPJqz4QQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200706154417.GH4707@osiris>
References: <20200706154417.GH4707@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200706154417.GH4707@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-4
X-PR-Tracked-Commit-Id: 075ebfe19fa3fa8838d2afdde5e87c86b7953b1e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c82ec00dd00c7a2b02d4b42cf59ae87592cb75f
Message-Id: <159405600526.28251.15078784772412494474.pr-tracker-bot@kernel.org>
Date:   Mon, 06 Jul 2020 17:20:05 +0000
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Jul 2020 17:44:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c82ec00dd00c7a2b02d4b42cf59ae87592cb75f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
