Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5859A28E575
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389489AbgJNRhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:37:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389366AbgJNRhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:12 -0400
Subject: Re: [GIT PULL] x86/seves for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602697032;
        bh=+5xy8J7hmox+Nrsyb9/sOEtWpkAOGdKGD6K2rI3cTIc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yYqlkBs1hSePjNvx0HmU3FNONP8NmZA9lOkUEL5HbGZFuM6YStYm4/SiXIymY7pKW
         iRYiQ248rUd41eJhY2MhlzFe78t8XsUwFLKRI/a3dQxRl9IhjCzvRSpLYn7cvjXlj7
         k6Z0zCbbs/Tn5SD7nR1JtcvLNRKetbmLwaoZ8DX0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201013110819.GC32151@zn.tnic>
References: <20201013110819.GC32151@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201013110819.GC32151@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_seves_for_v5.10
X-PR-Tracked-Commit-Id: 0ddfb1cf3b6b07c97cff16ea69931d986f9622ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da9803dfd3955bd2f9909d55e23f188ad76dbe58
Message-Id: <160269703197.25844.17347940062968027008.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Oct 2020 17:37:11 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?utf-8?B?SsO2cmcgUsO2ZGVs?= <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Oct 2020 13:08:19 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_seves_for_v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da9803dfd3955bd2f9909d55e23f188ad76dbe58

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
