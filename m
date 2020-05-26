Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527DC1CCD51
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 21:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgEJTpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 15:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:56820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbgEJTpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 15:45:04 -0400
Subject: Re: [GIT pull] locking/urgent for 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589139904;
        bh=Id/ugM+QT+tQrCsFalhWAkMnp0aSBKR5cvkyoKyhzm8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=AgfIV46Zwx8gLduslW2vm/Fod2xWhE/vNAmJBzKKMraJ9Bub/NuEfP/484WysMGB4
         cv76duAyYdEMJIpCpPgYvgrarJdD0YzNi2WZFJYSJT2XUKdZRupJIpvhh8NKOBPOeF
         vjNqXYso71UK8smC+sTyh2kf9oCqG19K3jem4wFE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158911175703.19109.2236997977254447943.tglx@nanos.tec.linutronix.de>
References: <158911175703.19109.2236997977254447943.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158911175703.19109.2236997977254447943.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 locking-urgent-2020-05-10
X-PR-Tracked-Commit-Id: 8101b5a1531f3390b3a69fa7934c70a8fd6566ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bd2049f87107906e4f8dc443ff307c44951d5768
Message-Id: <158913990435.3456.10380440597945739763.pr-tracker-bot@kernel.org>
Date:   Sun, 10 May 2020 19:45:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 May 2020 11:55:57 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-urgent-2020-05-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bd2049f87107906e4f8dc443ff307c44951d5768

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
