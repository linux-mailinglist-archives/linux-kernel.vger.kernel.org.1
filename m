Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7146A1EB26B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 01:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgFAXzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 19:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbgFAXzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:55:07 -0400
Subject: Re: [git pull] uaccess __copy_from_user
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591055706;
        bh=AJjMjQf9K3a8cv4F2ne2S6JFm5oAIj/8TriOPhT6WM4=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=nFVSdzmQCNudgVAHoy9bnPZ7fm0Ler+CeT9IzLAedDkiGIlbkYos6yazLcp1P2QxN
         ZwJusq1ZSKkLLFGy9ewZDlMwAkvshiBgmtrFdC816nKi9ju13sYHXZjn1s9JMdamrR
         7JxLDwLv0L2UpOcxfyB9+GYr6gt9L6u9yI3Rmsk4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601183103.GE23230@ZenIV.linux.org.uk>
References: <20200601183103.GE23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601183103.GE23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git
 uaccess.__copy_from_user
X-PR-Tracked-Commit-Id: ff847781049c37dff9ad4af2bf2d7aad02622f96
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56446efab9ce4961fe0fe6bbc5bc66374b08b9f3
Message-Id: <159105570663.29263.1342266771306328790.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 23:55:06 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 19:31:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.__copy_from_user

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56446efab9ce4961fe0fe6bbc5bc66374b08b9f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
