Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8892DA31F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731377AbgLNWO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:14:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407533AbgLNWEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:04:08 -0500
Subject: Re: [GIT PULL] x86/CPU for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607983364;
        bh=U5SXFC9WH+hyOqvOL8hqD587S/LgLhW1kiwFHf7TKQA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=PzQV2vzyYZDp+0OkAktO3BviFoLzcJZPxGsYD3INpVBWIoFO1nLvV1J+TmOZewV3L
         2gpziv18uJalCIwMxXuUdm9+U1XS6MA/qjMaOc+6NgTc1hl5u5Q56LEvE7/7JkVWDv
         +iAw++bJEaOANHXpgjolT41w4fCLPmXLWUcFhBoHwW7009pM+dbfDfirG2byWRzq33
         miVD1PLqk9BfArzTlQa2MCF03A2dpsF1jGoEJGdzUsnAtTSUgZPvQoicBLYuiBNJ8r
         FqHOOBlEOcvp7tAXfWpIXrdRGdBiiKn5Y/Xi2IFVvYBomqfr0pmEB6Kp0R9yzcIePo
         0b8PoNrm4iA4Q==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214121444.GG26358@zn.tnic>
References: <20201214121444.GG26358@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214121444.GG26358@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.11
X-PR-Tracked-Commit-Id: 262bd5724afdefd4c48a260d6100e78cc43ee06b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d712978dcdd9c4fb2c4e4ef7700ee755184f11d
Message-Id: <160798336453.30284.9318252604384703135.pr-tracker-bot@kernel.org>
Date:   Mon, 14 Dec 2020 22:02:44 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 13:14:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d712978dcdd9c4fb2c4e4ef7700ee755184f11d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
