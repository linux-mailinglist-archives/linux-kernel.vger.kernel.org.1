Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC6C279BBF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 20:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgIZSDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 14:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIZSDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 14:03:49 -0400
Subject: Re: [GIT PULL] s390 updates for 5.9-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601143428;
        bh=3v0yKJBkaLDyEwbWC9bNvYuE5Kd671T/cBTtvHeAiRM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Av4U+0u+bkNhWzminbq/VaeWlqIrZyVEYgR8NZhO2ddFjhtFPfP3u37w+zImZv7Qh
         MXVu+Oaw8EX6RZl8f/mAiVe4v6BlklFtYFWMbdnLwJ7kAge1uAcvOoTh+Y5nnwvqst
         Yd2bGWn8YR8v+B1AuSr3ISJqQSuwJ5/9qqVDWY8A=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01601111002-ext-0188@work.hours>
References: <your-ad-here.call-01601111002-ext-0188@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01601111002-ext-0188@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-7
X-PR-Tracked-Commit-Id: f7e80983f0cf470bb82036e73bff4d5a7daf8fc2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eeddbe6841cde5524b0b1d01f6e060be564453bf
Message-Id: <160114342871.10659.10166910111191784371.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Sep 2020 18:03:48 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Sep 2020 11:03:22 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.9-7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eeddbe6841cde5524b0b1d01f6e060be564453bf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
