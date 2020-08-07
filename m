Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4149623F3E4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 22:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHGUkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 16:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgHGUkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:40:22 -0400
Subject: Re: [GIT PULL] seccomp update for v5.9-rc1-fix1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596832821;
        bh=/sW5kVrLaGGHefo7sRth2kncbjjUpwr3aQ0Gx6Bm5Ug=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PLZ/75J3tTvtZCEDJXxez7jpiXV+gB9SZmg8sR5wQ6Y1UwHCvn9FLKIGxSWb3Q8qo
         b+PMsdFzxPT1gS4+s+G2+DMhcnfv/pRV2uC2+EFkdtwgsQwwwdE9qXxOSX4E0lPbKn
         RU7u6KRewbv7DOtfOudj04ZlTukFSxmiVYWAxyto=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202008071245.B375826@keescook>
References: <202008071245.B375826@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202008071245.B375826@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.9-rc1-fix1
X-PR-Tracked-Commit-Id: 16b89f695313d91c99bdaf6898f28a51d0af1b17
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1fa2c0a0c814fbae0eb3e79a510765225570d043
Message-Id: <159683282188.2860.3094503626916145648.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 20:40:21 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Aug 2020 12:46:11 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.9-rc1-fix1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1fa2c0a0c814fbae0eb3e79a510765225570d043

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
