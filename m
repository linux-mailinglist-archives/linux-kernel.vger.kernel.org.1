Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165152A586F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732215AbgKCVvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:51:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:37936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730199AbgKCVvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 16:51:11 -0500
Subject: Re: [GIT PULL] Docs-build warning fixes for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604440270;
        bh=Og6lxizNQCDNp2Hd0PAecoYd+XEuC/t6QNr6YJTh7Io=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=oMCx4yVoPcYXyLLRFEXNRs3JiDV3Vrl9YTswQd/p+VacEzNiUEu2j4gZqnz8WELsC
         8YJ/nJunh+EKzuX41HQG0YMPA4JHsGQATwmiysGTUbdLFOI22k+0SucEU16zTmQgom
         U89Sp7amiJLMnCPebSVSRLuNGIHEKOhHKPGfMzTE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201103124420.46bf5a37@lwn.net>
References: <20201103124420.46bf5a37@lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201103124420.46bf5a37@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git docs-5.10-warnings
X-PR-Tracked-Commit-Id: 6fee9372e0af63f557ad234663d8248f3caefc37
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6b0bd61a73718886c2df16762f0a5dba485fc10
Message-Id: <160444027054.10573.14101545655716938289.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Nov 2020 21:51:10 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 3 Nov 2020 12:44:20 -0700:

> git://git.lwn.net/linux.git docs-5.10-warnings

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6b0bd61a73718886c2df16762f0a5dba485fc10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
