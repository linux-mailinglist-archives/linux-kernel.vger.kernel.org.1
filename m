Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1097128C56C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 01:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390956AbgJLXuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 19:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389654AbgJLXuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 19:50:06 -0400
Subject: Re: [GIT PULL] Documentation for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602546605;
        bh=PFxcfnuYkMRy4JqihHf8jMqmmBOGezqQ9Vjun9KGwMU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gwlrHcRHejGvb4cjZJgc6Pc+XVtQJQdVB7wqQ6Lz50tkU1HoyASNCzIa939ld3uot
         UG/1KJl7ue130zSarlZ6HEPWiS6zMRVcbnoDbfZpC4HweROFnoHv3IfSiThCm4XYnM
         B0JyD6BfmrE04WPB8q4zpKE1ouNYpjgfBZBcWC7M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201012133042.688ee6a6@lwn.net>
References: <20201012133042.688ee6a6@lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201012133042.688ee6a6@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.10
X-PR-Tracked-Commit-Id: 4fb220da0dd03d3699776220d86ac84b38941c0c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50d228345a03c882dfe11928ab41b42458b3f922
Message-Id: <160254660550.9131.14565875654021588152.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Oct 2020 23:50:05 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Oct 2020 13:30:42 -0600:

> git://git.lwn.net/linux.git tags/docs-5.10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50d228345a03c882dfe11928ab41b42458b3f922

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
