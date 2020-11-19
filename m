Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793772B9B61
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 20:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgKSTRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 14:17:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:36570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727807AbgKSTRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 14:17:52 -0500
Subject: Re: [GIT PULL] regulator fixes for v5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605813472;
        bh=OSpr/zqsuDCTfr87MHibYsY+ZrzyjcNbZKvKIzQ6kmE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=lEiy8BtJg94bte1AWqZGxYqqX6aFQoxQsJ58T4Myqfd6PN9EJ9SGlWX/2nIP5G0G3
         drg2T6dflxF7DdDmxwVlqWa5dgF0UbxXBPjVlXJ3U5jUlWvQpC8gvLdu3qNzZH/0qr
         G7EnhwQUJkFeVEMqQkiwblZZb34QU0q1Lybm2Mgk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201119174529.A5A5921D7A@mail.kernel.org>
References: <20201119174529.A5A5921D7A@mail.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201119174529.A5A5921D7A@mail.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.10-rc4
X-PR-Tracked-Commit-Id: 2ba546ebe0ce2af47833d8912ced9b4a579f13cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d748287a28de8955e1756a454e81ab1a73d45ecf
Message-Id: <160581347223.16071.3714911050573588378.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Nov 2020 19:17:52 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Nov 2020 17:45:08 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.10-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d748287a28de8955e1756a454e81ab1a73d45ecf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
