Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C486529BFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1816694AbgJ0RJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1809632AbgJ0RJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:09:32 -0400
Subject: Re: [GIT PULL] Devicetree fixes for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603818571;
        bh=DwOvll6s6YScAHdWgVYHttAoYjSN6LcahTWz75JipTM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FsgW1OiYmBJR7Pxi1q68tkV/fWwfKr/lxE1DvuNrXP8QdOl/R82ndjOm7q8Huzs5d
         OpWry3rFcNHRr6RAKDlKIh4RJUWMQAU07Blt6X2jmTBIznVKRRt6bqfauW9B5iK41K
         fBRM357wThocfWxLm+J1zCQgCs/jjYwA3MCqTCqY=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201027131551.GA1959093@bogus>
References: <20201027131551.GA1959093@bogus>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201027131551.GA1959093@bogus>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.10-1
X-PR-Tracked-Commit-Id: f84e2c5c528d937564e4a9e3411418e4c914b1fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d09c1d952679411da2772f199643e08c46c31cd
Message-Id: <160381857184.17987.7203080248082639549.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Oct 2020 17:09:31 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Oct 2020 08:15:51 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d09c1d952679411da2772f199643e08c46c31cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
