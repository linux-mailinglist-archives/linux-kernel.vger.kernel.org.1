Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127A128F779
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 19:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390099AbgJORMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:12:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:39866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389725AbgJORMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:12:19 -0400
Subject: Re: [GIT PULL] USB/PHY/Thunderbolt driver patches for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602781939;
        bh=moLxfQWZqrg0WVpmA5CYTrF72RWsuHGYQHL572zXvB8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ryTH7+OkJSmHEn7e9KnZAb8rDkHnwnXzIzwdSGVCZ+/p+6jHbNxW3DOnV1bC6pBK9
         sIoMso9rgVZju7vQA3XeDkc+ZjfMQ95QozP9FW6pJ0VL8JhovMtufrWqcGtLd2WFVm
         dZG+gGqDPmjiNnHGX0om46jjSxyUxedtf4qoEoOE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201015122822.GA4021571@kroah.com>
References: <20201015122822.GA4021571@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201015122822.GA4021571@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc1
X-PR-Tracked-Commit-Id: 93578a25d4e21603518daf27a5f9caa4bf79de68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6dbef7307629cce855aa6b482b60cbf7777ed88
Message-Id: <160278193916.2218.6582757755071506480.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 17:12:19 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 14:28:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6dbef7307629cce855aa6b482b60cbf7777ed88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
