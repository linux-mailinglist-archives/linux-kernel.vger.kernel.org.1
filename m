Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 159531F206E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 22:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgFHUFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 16:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbgFHUFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:05:25 -0400
Subject: Re: [GIT PULL] rpmsg updates for v5.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591646725;
        bh=qNznkMvTDeK9huF7Jpwu0P4DSnqTVtGEO2Gct3OTSUw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=qeu9pqCqmmWZn3e9UMovBndbh9CWFFi1bqgMo1k0t/w1guXOb1TDVSdj+pS1TRBWb
         Kw8AiMNtGaKA7b3MRmmguU5ru06YgqBubfsZdZxkfyBRp3gpCBS1TLAJtvM+MxUw+6
         D151YnnzHSl6WSiELYGaVxTSFPh3g0GhkpSTFUn8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200608182856.2302518-1-bjorn.andersson@linaro.org>
References: <20200608182856.2302518-1-bjorn.andersson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200608182856.2302518-1-bjorn.andersson@linaro.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git
 tags/rpmsg-v5.8
X-PR-Tracked-Commit-Id: 4f05fc33bebdc7d69259c412dd21d09751827dbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d26a42a9614083413e778832a6efbdf0038c3bff
Message-Id: <159164672511.26583.12607767880488664875.pr-tracker-bot@kernel.org>
Date:   Mon, 08 Jun 2020 20:05:25 +0000
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Wang Wenhu <wenhu.wang@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  8 Jun 2020 11:28:56 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git tags/rpmsg-v5.8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d26a42a9614083413e778832a6efbdf0038c3bff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
