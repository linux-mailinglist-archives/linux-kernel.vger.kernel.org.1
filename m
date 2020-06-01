Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDACC1EB26C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 01:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgFAXzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 19:55:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgFAXzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:55:07 -0400
Subject: Re: [git pull] uaccess __put_user
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591055707;
        bh=wMohWWxtk3nUHJm/g5SNbewYz66anKtIX8G64dtbEo8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DFijip79Wp/vQmkaPSIa1pjJbomi2YPBr7Zj0STf/9mNywmhUnJZLyfmmN1yqUEAN
         C/3o7LjkH9hZhX4Y+e9yDFypquDXwHeUm+ucUuTgvTdKoH0JYj8JT5fDAFDSltYGBz
         LpUqEvWTQ0WrYWeetK0VRcom4EBVD5pfezgnALSY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200601183001.GD23230@ZenIV.linux.org.uk>
References: <20200601183001.GD23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200601183001.GD23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.__put_user
X-PR-Tracked-Commit-Id: ebe6976d3634a311367f72c2402f148ab9f23920
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fdea5848b3c7fb13a0bfd7f768dcf15b534dafe
Message-Id: <159105570736.29263.8893952471977086222.pr-tracker-bot@kernel.org>
Date:   Mon, 01 Jun 2020 23:55:07 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 1 Jun 2020 19:30:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.__put_user

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fdea5848b3c7fb13a0bfd7f768dcf15b534dafe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
