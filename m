Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 655D819CD03
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 00:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390386AbgDBWpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 18:45:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390377AbgDBWpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 18:45:19 -0400
Subject: Re: [GIT PULL] percpu changes for v5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585867518;
        bh=U14+pK0ZahfEXG7mVWOawz+6ch3oyKENn31jd1A19Qc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Ikoyj9qZGJBJDtlxaTOndzwrj8U+wYIeoQ5Y/qUot8UtBpIjpM8rVFKLtiMJUibSn
         JXoGsphx4CnT5479emtlXA50GatipKWKhnOvZs4GITajiz+jhrXkxwQv//1Jv14pE9
         AO/4MaNtXZCRfAnufa2DJQereH9xUY6Yh2CHnV8w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200402193403.GA8781@dennisz-mbp.dhcp.thefacebook.com>
References: <20200402193403.GA8781@dennisz-mbp.dhcp.thefacebook.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200402193403.GA8781@dennisz-mbp.dhcp.thefacebook.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.7
X-PR-Tracked-Commit-Id: bfacd38f8d5b1f12b80aaacae2c15e1ffe11f06e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac438771ccb4479528594c7e19f2c39cf1814a86
Message-Id: <158586751871.2810.10621679902949395531.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Apr 2020 22:45:18 +0000
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Apr 2020 14:34:03 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac438771ccb4479528594c7e19f2c39cf1814a86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
