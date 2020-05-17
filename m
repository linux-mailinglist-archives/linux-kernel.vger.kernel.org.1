Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFFB1D6CC3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 May 2020 22:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgEQUPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 May 2020 16:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgEQUPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:15:03 -0400
Subject: Re: [GIT PULL] USB driver fixes for 5.7-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589746503;
        bh=8mPt4wJ4k2Dem1PmleitEdPEIWW6/Cfq4iHD7Rvnino=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=FOudaRf/5AhvOBRZDFfuz9X0eP71Gtavp5uwsA7WVgZm3sTP7GbclDwT+hW0idbcB
         oMS736IOKwo0rpFyqX4ycYZATVELDWegzD34/xFzXts6PkvnFqUuPFfEXS5afozoG+
         s8cTccmWZfZnLVk1aSsxB6TVbLMKWu2A6PNeYQHE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200517094041.GA3392057@kroah.com>
References: <20200517094041.GA3392057@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200517094041.GA3392057@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.7-rc6
X-PR-Tracked-Commit-Id: 15753588bcd4bbffae1cca33c8ced5722477fe1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fb27bc034df1e2c7930f606928b65aca652fed6a
Message-Id: <158974650321.31612.15350563902135460206.pr-tracker-bot@kernel.org>
Date:   Sun, 17 May 2020 20:15:03 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 May 2020 11:40:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fb27bc034df1e2c7930f606928b65aca652fed6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
