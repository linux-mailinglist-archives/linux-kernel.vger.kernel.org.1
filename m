Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4FE287C67
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgJHTUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:20:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgJHTUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:20:50 -0400
Subject: Re: [GIT PULL] exfat fixes for 5.9-rc9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602184849;
        bh=Pq7gNpOqvD+Sb5Vo9rYgiytHjLoJd5pAMp6mkk22L9c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=xnke/dJ9+nKAwwp/iYU3Tumst1V2So/gNXwvLAGkFXGNZLRc2vfmDEayTM8oTEIxf
         iJmFEP51HbaQw4fY0z/6i7lSe/ESlhUm2wwQalkO51JrzGBCYMicqf367bnwJU3mr9
         lZyOdOom3EiDUxM9YmnhyLSrzsu7YWlp3gI7uOhc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <009901d69c84$e422f280$ac68d780$@samsung.com>
References: <CGME20201007083603epcas1p22050f982bbf149ad060b723d763de1b3@epcas1p2.samsung.com> <009901d69c84$e422f280$ac68d780$@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <009901d69c84$e422f280$ac68d780$@samsung.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.9-rc9
X-PR-Tracked-Commit-Id: 8ff006e57ad3a25f909c456d053aa498b6673a39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b9e3aa2a9bd49860ec5a9129fb522b0addc7d05b
Message-Id: <160218484972.22350.8159228238506958149.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Oct 2020 19:20:49 +0000
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 7 Oct 2020 17:36:03 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.9-rc9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b9e3aa2a9bd49860ec5a9129fb522b0addc7d05b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
