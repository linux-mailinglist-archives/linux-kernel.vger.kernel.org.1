Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96EA91A163E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 21:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgDGTzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 15:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbgDGTzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:55:03 -0400
Subject: Re: [GIT PULL] parisc architecture fixes for kernel v5.7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586289302;
        bh=r+VImNmnLBQUKy6aPx4G7SRNP8Qk/clSP1tZpxClntI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=f+VShvUrPZxu1C1Ms2KDU5EdVJqfo1DVQFjuvXIE2D7VSZ9q5S+etPphEm0wfuRAK
         BMcRBUWWUrW7lnZUJLcac5lJlye54Y39VAKA9wZDvX1TO3s/jiNG/xKisWu7tlciFI
         I6BUIPq7nie29FcuY0bc7opuFp6UEakT2v6vZ6sE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200406201615.GA23183@ls3530.fritz.box>
References: <20200406201615.GA23183@ls3530.fritz.box>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200406201615.GA23183@ls3530.fritz.box>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git
 parisc-5.7-1
X-PR-Tracked-Commit-Id: 106c90922e1e0cd5fcbb34be8ebbb3e8a8e71909
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f9db97d751870cbffc85f4aa0d8aca8a79432691
Message-Id: <158628930265.3792.541815435181788203.pr-tracker-bot@kernel.org>
Date:   Tue, 07 Apr 2020 19:55:02 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 6 Apr 2020 22:16:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f9db97d751870cbffc85f4aa0d8aca8a79432691

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
