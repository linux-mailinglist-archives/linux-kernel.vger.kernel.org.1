Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751A42DBCC8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgLPIiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 03:38:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgLPIiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:38:14 -0500
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.11-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608107854;
        bh=qCJ/qeHc5VZFFpCQHo5GzzD6W9CRofp4vn5jKnkYhGc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aD7cITFnspnB6UkBoSS26B1Z3gvP12kGFXbHQbRtidJC5zrHW1z/3aigNO17m1v0G
         3XNZngbqQiraR0vX3e/9fdCcmLFkB328yqS5PkaQzsWP3dkghb2u1iFSTD1yFXTkGy
         4RLzvWgynpQ6ntf/+B471VLo50Yn2hsoqo6KnwCV+T60VX4ibcaWeiRUhSuOzUKnea
         w5xlEnMQHYTKDBXhUJCLJTVlQdZYTsebDwWTg/jFFMN05/UEZwydn1j6HJn2zJrWp1
         pbE42EgdMwS/DeG+mEs0nCpZJtgTTlKH+9DKb86uvi6KDoFmq/fRgTN5wjdS1mHLyF
         ztDFgpAclDlIA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214142200.GA1062@embeddedor>
References: <20201214142200.GA1062@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214142200.GA1062@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.11-rc1
X-PR-Tracked-Commit-Id: 36f9ff9e03de89691274a6aec45aa079bd3ae405
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e60366d56c630e32befce7ef05c569e04391ca3
Message-Id: <160810785416.17072.14796579979006055568.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 08:37:34 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 08:22:00 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/fallthrough-fixes-clang-5.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e60366d56c630e32befce7ef05c569e04391ca3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
