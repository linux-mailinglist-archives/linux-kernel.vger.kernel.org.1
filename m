Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FB32DB92D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 03:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgLPCdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 21:33:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:47524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725274AbgLPCdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 21:33:05 -0500
Subject: Re: [GIT PULL] hwspinlock updates for v5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608085945;
        bh=0jc66jFzW8IwJy88Jqa5L+zXZrM/HD+s5h8qkcliUdk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JTHicyGlmDuPFbGBi2O0jmLD9eqf4j/MC6i7jkgmIE0f8/6I61ioI0SFXfMg/irBD
         Fn8FZ2CeVYcwRscBYVI6lzm9d/E8UiKxKhgAllM+N1CIVXh5aN9+WthteftXZCrAxR
         HKEpl7fMegaHkaamnQJnntDec5RP5pX3k0AQmRwgyzq/WBcj37+z9TJ+772tjz/A1S
         mzUUwcT2dwXOR+qXy799+ajFREBH26IpHf6b3RGSplx6kSwhD83tjp1yTCEoJjPPBP
         H4FmrH4+FFHbNrcOCzYWlCdyHmA5CZdeTAAP0eWtszrcGH1Fr7suGy2Y0w14NRp/mG
         GECCk9cQYZ3BA==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201215180735.1528535-1-bjorn.andersson@linaro.org>
References: <20201215180735.1528535-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201215180735.1528535-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.11
X-PR-Tracked-Commit-Id: c3e9b463b41b45c4556a13043265097e2184226e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e10f9c89332def4288b33866a1b793ffc94107b
Message-Id: <160808594508.10422.4308407825889022330.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 02:32:25 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Dec 2020 12:07:35 -0600:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/hwlock-v5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e10f9c89332def4288b33866a1b793ffc94107b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
