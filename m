Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8A7282680
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 21:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgJCT6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 15:58:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbgJCT6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 15:58:21 -0400
Subject: Re: [GIT PULL] USB/PHY driver fixes for 5.9-rc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601755101;
        bh=xboIxHc+c7bMyv+2wudtxAMOk+K+ts0p/PJ9jjHJc8I=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TOp4/BfYW7MgoxpQEbHnjrk8m/Ugxgg/F+0QVHx8deCoWRC6vmEywryyNqkJD8lYg
         2Y0ruLuCfu0O9DcArDYfbAhE8zLwvnQi92LRr9woUGjuArHKKyJixCgXuRBYkjkINn
         ulHFH6Ai7DGcNV9P5VClf3MTs6z0catJA8FAs3gk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201003142651.GA794077@kroah.com>
References: <20201003142651.GA794077@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201003142651.GA794077@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc8
X-PR-Tracked-Commit-Id: 25b9e4b31ed5724b1f37a8a46fd50c6bafa6745c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f056638517aa8ecc8b9f132a690cc6d08fa8e88
Message-Id: <160175510147.27812.3467876034657084866.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Oct 2020 19:58:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 3 Oct 2020 16:26:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.9-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f056638517aa8ecc8b9f132a690cc6d08fa8e88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
