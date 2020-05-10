Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBDA1CCD54
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 21:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbgEJTpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 15:45:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbgEJTpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 15:45:04 -0400
Subject: Re: [GIT pull] objtool/urgent for 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589139904;
        bh=GoGh/nXv/74ThQjoMKuRj+g9vGYesBaDK5bWljvEIZI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BsRgDlsTaoBB+qrj6/Qi5YvoTaa6Ws0AIQgtliJPbpF/IjL4j0e7I+h5gi6oODtA9
         R0wToPoOr82VgVy8pP1b1D8NvpS3GXMBx86r7bEpObiWhbUOyXYPnXTospxKYuWOlD
         qqwEIWM46aD9t18wDGNV3CNTGHvraN0wqse7gars=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <158911175824.19109.2928860984731892266.tglx@nanos.tec.linutronix.de>
References: <158911175703.19109.2236997977254447943.tglx@nanos.tec.linutronix.de>
 <158911175824.19109.2928860984731892266.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <158911175824.19109.2928860984731892266.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 objtool-urgent-2020-05-10
X-PR-Tracked-Commit-Id: 1119d265bc20226c241e5540fc8a246d9e30b272
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b00083219af64970e55c756a8d226c85722bb62
Message-Id: <158913990414.3456.17093510315342814003.pr-tracker-bot@kernel.org>
Date:   Sun, 10 May 2020 19:45:04 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 May 2020 11:55:58 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2020-05-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b00083219af64970e55c756a8d226c85722bb62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
