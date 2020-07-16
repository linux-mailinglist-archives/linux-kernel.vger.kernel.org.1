Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6A1222B79
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 21:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgGPTFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 15:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:60182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729515AbgGPTFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:05:05 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594926305;
        bh=RbnJO1HagmHvBdwuoXR4jzETilrR4obwKMVI7IEFDy8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=rXs2L+9ugikaTzce/LUXpvPk7kZPbITxYIVF1CHBX7y8xSG4UP0MEX9xdVDCaI5u+
         PvSyQxciF9X7A6jwApUojl24Y5+7ZRnNgYhsY2PHIlkDAiMf9CHtj4PlGGu8keZvHa
         xvr1dncUv0aPz/jxNAhUTihvXxxIMPemA4PelDAE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200716153024.GA2379109@kroah.com>
References: <20200716153024.GA2379109@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200716153024.GA2379109@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 tags/char-misc-5.8-rc6
X-PR-Tracked-Commit-Id: 897c44f0bae574c5fb318c759b060bebf9dd6013
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3e543a4d30014d45b6bb5d2095554be02153cefc
Message-Id: <159492630529.21154.14886571427891113116.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Jul 2020 19:05:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Jul 2020 17:30:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3e543a4d30014d45b6bb5d2095554be02153cefc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
