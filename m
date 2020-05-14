Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67CCD1D3B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 21:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgENTCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 15:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729287AbgENSzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:55:04 -0400
Subject: Re: [GIT PULL] thread fixes v5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482504;
        bh=xxXE1I6+QBWEfouz1QVY8vdxUq4FAM4KAv6r0PXSOM4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=iKVzGIeQdSCiAVV3HcN69y4M1wxtLkCUHN2wlDxRzE0y9TZpDb8rgGfC31pTCyrFc
         XbeeeRXg4eYegxorHT+I5V8d98nzaeWzmIbx32HR3NRe67IPle5I8zH2pQMJwrsNZ+
         S66sfz48pR3ZmcuX/kVVosTsZteYsjzTD7VZLkNE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200514170451.1821723-1-christian.brauner@ubuntu.com>
References: <20200514170451.1821723-1-christian.brauner@ubuntu.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200514170451.1821723-1-christian.brauner@ubuntu.com>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux
 tags/for-linus-2020-05-13
X-PR-Tracked-Commit-Id: 3f2c788a13143620c5471ac96ac4f033fc9ac3f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c1684bb81f173543599f1848c29a2a3b1ee5907
Message-Id: <158948250396.25823.14716230911955912328.pr-tracker-bot@kernel.org>
Date:   Thu, 14 May 2020 18:55:03 +0000
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 May 2020 19:04:51 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-2020-05-13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c1684bb81f173543599f1848c29a2a3b1ee5907

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
