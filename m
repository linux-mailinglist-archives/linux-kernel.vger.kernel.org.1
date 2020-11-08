Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A172AACCC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgKHS3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:29:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728817AbgKHS3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:29:39 -0500
Subject: Re: [GIT pull] x86/urgent for v5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604860178;
        bh=9TYFCMv4eiLKVQjkHTtc9CEEphvYatjSXUdpp+EPs04=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=m3FWM2p1Quypu64LxcbtI0RqlyGMA5KLcZ5zaS5dPGnHfOdKab6YD4tfKLv3b17sU
         e+p8HjZddX79F2NZmiNrZKEflzUHWgJUag8ermrRJuMnB4YNwosSZbyf7Zp355JINE
         tG/G07kard5RWoPSMzIhGpS3tL5T38bONjJWMg4Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <160484899954.4262.10408036488222363252.tglx@nanos>
References: <160484899473.4262.9790266201913163807.tglx@nanos> <160484899954.4262.10408036488222363252.tglx@nanos>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <160484899954.4262.10408036488222363252.tglx@nanos>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-11-08
X-PR-Tracked-Commit-Id: 801284f9737883a2b2639bd494455a72c82fdedf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40be821d627c61ee5beb51d265af372ab29804e4
Message-Id: <160486017871.13369.2643087958346641807.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Nov 2020 18:29:38 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 08 Nov 2020 15:23:19 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-11-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40be821d627c61ee5beb51d265af372ab29804e4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
