Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AD923B1D9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 02:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgHDAuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 20:50:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbgHDAuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:50:06 -0400
Subject: Re: [GIT PULL] x86/build changes for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596502206;
        bh=vEshlGCTFZKKAPKHc0UI5dJcXTjENmlNK8xfhsEPJlk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=N3H7wPdyIQW8LAni7IAAW4iSIezW4Y2PLFjH/+QTtADmZ3juKFnH3RKR9zilqDxbU
         R6Z50i1511y/R21xQqiejGVUzhg9/s6/+Dh7f13qioRphJOkWtErs0a1+Qx60UlDEu
         PJmrAEvcr/6HiMnDk3OUH5zZ78aN0Q76ksV4Rd/8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200803171015.GA882680@gmail.com>
References: <20200803171015.GA882680@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200803171015.GA882680@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 x86-build-2020-08-03
X-PR-Tracked-Commit-Id: 1d0e12fd3a848199f973d42677cde423b76cafaf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ff9b20b47bf12f4b87596cd549aa8b98917ba5a
Message-Id: <159650220588.17631.3247571948535719587.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Aug 2020 00:50:05 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Aug 2020 19:10:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2020-08-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ff9b20b47bf12f4b87596cd549aa8b98917ba5a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
