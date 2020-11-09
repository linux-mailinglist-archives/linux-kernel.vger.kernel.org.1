Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D7E2AC61E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgKIUpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:45:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:58220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgKIUpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:45:43 -0500
Subject: Re: [GIT PULL] erofs fixes for 5.10-rc4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604954743;
        bh=uj9klgc3PjWdBU1rWFimPbEWG5+P6C3Ao8mhNRNXhuQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A7ce3J+SuOjs6Qyi8XoWr2SSLgD8No4Rev7OSspeAUte7AuD/UaU7Jzaam/f/WSYh
         WhbOkgl666/8eVPGZ+pzxF6dCMOAxsr1bBQmRNhz7M6XMLFCSkBsaKCaW44kfLTyoh
         e/tlJ0nua6laJeg/GlaVyKfE2dBFTCcIRzBixdAY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201109144023.GA2232414@xiangao.remote.csb>
References: <20201109144023.GA2232414@xiangao.remote.csb>
X-PR-Tracked-List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <20201109144023.GA2232414@xiangao.remote.csb>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.10-rc4-fixes
X-PR-Tracked-Commit-Id: a30573b3cdc77b8533d004ece1ea7c0146b437a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: df3319a548cdb3f3bcbaf03bbd02822e39a136c6
Message-Id: <160495474299.25406.2199314582052116726.pr-tracker-bot@kernel.org>
Date:   Mon, 09 Nov 2020 20:45:42 +0000
To:     Gao Xiang <hsiangkao@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        nl6720 <nl6720@gmail.com>, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>,
        Vladimir Zapolskiy <vladimir@tuxera.com>,
        Miao Xie <miaoxie@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 9 Nov 2020 22:40:23 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.10-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/df3319a548cdb3f3bcbaf03bbd02822e39a136c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
