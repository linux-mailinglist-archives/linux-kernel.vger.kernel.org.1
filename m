Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E291C4617
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 20:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgEDSib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 14:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgEDSi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:38:29 -0400
Subject: Re: [GIT PULL] flexible-array member convertion patches for 5.7-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588617305;
        bh=nRHEfvrq7ZtIc3RuL2stcihYnzmJEmMWQ4GvcE3xcTA=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uny3XfekuNDqRavi8Ydu9hav4KWfRshibvMpO0TqNQNlqmU+NxqHlTvg9pxBEU2gr
         BOA+uMwnCh37qXyDu7wcRDSxJ24gEZmUAb/1CPvI7tWEUeCjHXMatzj3Q30j4DOs40
         jOcAZAM/9UHtlda0qXW7PP9XNqp1qYrXjMqReu6U=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200504174449.GA15934@embeddedor>
References: <20200504174449.GA15934@embeddedor>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200504174449.GA15934@embeddedor>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
 tags/flexible-array-member-5.7-rc5
X-PR-Tracked-Commit-Id: 1e6e9d0f4859ec698d55381ea26f4136eff3afe1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67f852ef92274116c9487cb312e58105d0e8d3e7
Message-Id: <158861730564.3296.11820027358571633839.pr-tracker-bot@kernel.org>
Date:   Mon, 04 May 2020 18:35:05 +0000
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 4 May 2020 12:44:49 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-member-5.7-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67f852ef92274116c9487cb312e58105d0e8d3e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
