Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3D522E1DB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 20:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgGZSF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 14:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726760AbgGZSFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 14:05:05 -0400
Subject: Re: [GIT PULL] USB driver fixes for 5.8-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595786705;
        bh=Y265sKMgoJxMfgoTE1x6RYCX18wyvYp9+QGQu5ljVjE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qFSq8t7yktd+YHMXVioglLN5K8lsqENUMfVHlxVzk8adTN5hCpP/wiG8HOkD9uwBW
         9RU0iaCeU/pCucDMipcuHoXt2pa/aC4NKK0DApmHusjPP1fM9cDM7eF6soza0lFjOW
         0OLhJYk9aMlmC+23MlISvKpF1qoXtcGZSiioFlo8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200726111143.GA1283454@kroah.com>
References: <20200726111143.GA1283454@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200726111143.GA1283454@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.8-rc7
X-PR-Tracked-Commit-Id: 0b987032f8b58ef51cc8a042f46cc0cf1f277172
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17f50e28a858e4bab808733339995133390aae54
Message-Id: <159578670510.6689.6960568851748598718.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Jul 2020 18:05:05 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Jul 2020 13:11:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.8-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17f50e28a858e4bab808733339995133390aae54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
