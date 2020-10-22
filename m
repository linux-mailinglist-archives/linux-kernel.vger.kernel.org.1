Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47482965F4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 22:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371617AbgJVUZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 16:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502627AbgJVUZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 16:25:21 -0400
Subject: Re: [GIT PULL] Modules updates for v5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603398321;
        bh=vbJ7fh29GarDMgTDCYwEHEpc1ERmAGcdcLMnEmyXw4g=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=zur9XMehRL8zbbECV6W3KB4pxtrRjBgBXgmFyg0uul5Ld6TTLGtW3E6cFkRKofAcX
         uivKbZbcRKYzzdlc/ktzZehlSlR3XnxrUjvO7/vAM+4sP62ewqfn/nrQacOAF+m9MJ
         +8HYlMcmCjHhGj25KplQKkGs1fxBYhjDLzZOGU3M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201022124246.GA8608@linux-8ccs>
References: <20201022124246.GA8608@linux-8ccs>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201022124246.GA8608@linux-8ccs>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.10
X-PR-Tracked-Commit-Id: fdf09ab887829cd1b671e45d9549f8ec1ffda0fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b71482060e1e6962720dbca1dff702580fa0748
Message-Id: <160339832120.30214.14590816804767697691.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Oct 2020 20:25:21 +0000
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 22 Oct 2020 14:42:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git tags/modules-for-v5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b71482060e1e6962720dbca1dff702580fa0748

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
