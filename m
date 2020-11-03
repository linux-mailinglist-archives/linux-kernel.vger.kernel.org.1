Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813E72A4DC3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgKCSAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:00:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729188AbgKCSAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:00:13 -0500
Subject: Re: [GIT PULL] x86/seves fixes for v5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604426412;
        bh=XUmPTNQMd4YDw/hWth7oomsVi/EUjgGRoEgqth43SBI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JlgExDysBshSz9vXIcMGKhk0tYdKD9dO6d//j66b65sdelL9KFS0uOikpxX28qMw0
         xKqeKXTC4qq00C0ouYgia7zqcPucTG9E1Dn3CKlxbUDlNRmBwdGkOPHNwleQD6iKhE
         38sWQNpbci2JbvScBpd1CxuyR4g75OLKBF+lBwzg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201103100012.GA7825@zn.tnic>
References: <20201103100012.GA7825@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201103100012.GA7825@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_seves_for_v5.10_rc3
X-PR-Tracked-Commit-Id: 2411cd82112397bfb9d8f0f19cd46c3d71e0ce67
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 43c834186c185abc53b41ee985330501ccfc4f7b
Message-Id: <160442641265.29492.1134715779233368102.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Nov 2020 18:00:12 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 3 Nov 2020 11:00:12 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_seves_for_v5.10_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/43c834186c185abc53b41ee985330501ccfc4f7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
