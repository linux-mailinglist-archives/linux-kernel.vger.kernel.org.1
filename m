Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFDE285243
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 21:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgJFTSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 15:18:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbgJFTSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 15:18:35 -0400
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.9-3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602011915;
        bh=wEOrHhKWLItmxKfDpnTfn8HRTlAvbEH8CXnuvYa8GY8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=b6T6uPScNX3q0aG6Skj0dh+3tecj72nQ28ophaTsc+5eWkTPmYW1BICFsfD7GOYoM
         mo+srdTP4nj43Hnngjk8qcs9GozhZnLonOdL4Oul2shp2E3ZIY7yzT77xaP1XSIjqh
         lT0JaHFtvNm8Wp6pwL9lg6OqxqbPB2ZtgS6P6yG8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bbd61184-175c-f1c2-d196-70b73145891b@redhat.com>
References: <bbd61184-175c-f1c2-d196-70b73145891b@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bbd61184-175c-f1c2-d196-70b73145891b@redhat.com>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.9-3
X-PR-Tracked-Commit-Id: 1797d588af15174d4a4e7159dac8c800538e4f8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6ec37e6bb1fa1d6d6ba6bf0e2d93a148c53c8976
Message-Id: <160201191538.29733.4933369922645155472.pr-tracker-bot@kernel.org>
Date:   Tue, 06 Oct 2020 19:18:35 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 6 Oct 2020 14:49:01 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.9-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6ec37e6bb1fa1d6d6ba6bf0e2d93a148c53c8976

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
