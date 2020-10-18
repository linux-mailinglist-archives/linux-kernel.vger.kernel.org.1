Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D670E29187C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 19:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgJRRKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 13:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbgJRRKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 13:10:48 -0400
Subject: Re: [GIT PULL] UBI and UBIFS fixes for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603041048;
        bh=BPBRwZ5kam2+V0pZI/COi1Qkx/EKC8puSwFojWdfmI4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=c/pDSZ6SzBW2scjZroMmirXRcIH06nAy1Z9jyQR3GLTp4kcsTodJ61vnOWO7UfGq1
         vaGb5QX2e3e4Lruk39Lx4E+3Zt2k6OMQmGavVTVuI5GsRi1WElpfBIzFkp3eJ45H2W
         RpgjHeARX/TyyqIBw0AMgDLqG0ZS07GprufFnIUk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1486301546.204164.1602963471897.JavaMail.zimbra@nod.at>
References: <1486301546.204164.1602963471897.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1486301546.204164.1602963471897.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.10-rc1-part2
X-PR-Tracked-Commit-Id: 78c7d49f55d8631b67c09f9bfbe8155211a9ea06
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 429731277dfd4b7940cff206dcde28b771b29210
Message-Id: <160304104849.11245.6099427735521173761.pr-tracker-bot@kernel.org>
Date:   Sun, 18 Oct 2020 17:10:48 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 17 Oct 2020 21:37:51 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.10-rc1-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/429731277dfd4b7940cff206dcde28b771b29210

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
