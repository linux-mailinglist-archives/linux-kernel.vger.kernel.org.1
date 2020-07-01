Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03BA21134B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 21:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGATKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 15:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgGATKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:10:10 -0400
Subject: Re: [GIT PULL] exfat fixes for 5.8-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593630610;
        bh=16U+eh4C6dAVRqZWp+KbWyvSxxEdkRkFHCg02geN3JE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DXnnyVV5Zt8GBRsk6D3rakyduz3iO4IfLePC+ECME6l+Jj3kyFYlKXN5opyBBhSrK
         mUqQy+XM6QGYh7w11/e3Gb2z29Z0naLkacZDcsJdLGzY82hPw5vH+vB/xGdLkjlj+k
         lZcjWPP71CNymjTAYaiI+aep6NY8qU9bWPiWimVA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <002f01d64e8b$586fa220$094ee660$@samsung.com>
References: <CGME20200630030544epcas1p255f59b5d5e2c82219c37fc5b341b1e67@epcas1p2.samsung.com>
 <002f01d64e8b$586fa220$094ee660$@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <002f01d64e8b$586fa220$094ee660$@samsung.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
 tags/exfat-for-5.8-rc4
X-PR-Tracked-Commit-Id: 5267456e953fd8c5abd8e278b1cc6a9f9027ac0a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: edb543cfe5db6148935a383aeef4d0bfd240216c
Message-Id: <159363061047.32760.616296467048631334.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Jul 2020 19:10:10 +0000
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 30 Jun 2020 12:05:44 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-5.8-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/edb543cfe5db6148935a383aeef4d0bfd240216c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
