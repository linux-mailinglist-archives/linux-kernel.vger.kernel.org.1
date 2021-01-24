Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B70B301E7B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 20:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbhAXTgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 14:36:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:41658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbhAXTeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 14:34:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C1ACB22D57;
        Sun, 24 Jan 2021 19:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611516830;
        bh=S84S7731eSGK44mhuIMGdapTddMor8cdZetG4mx9b9M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tlGuHZhHTk9s7V9XM2M3Su+eNYmKXIyWvGZkVcKfUfizmHqC/hWhDgorOlIIqoTJW
         uV0g/AWNl4naZxNkOeFeGD0Wrkvy5zRBM4POoO3eCTBCp3ry8aN6IiL3VjEDK0lhks
         8C4ngS8ySvsEjzNZqj87ZTnU1S/ILmPIMBEcDkBXDhbm1jhw3IMm126Om36K+c3/Xo
         mUUE9LMIoWt3VYEKqYP7U54Fs1vIr4IZti58w9wBxyrNw4YMuXvR7xQ9WzvyoohtE6
         0A7SoGvOLvr40q9nb8gRgrqvYvB1d6x7k9mM8eqhwHtqH/wl23h0PuBY5XtX3qG1yQ
         PqJxXDiqubyDg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id B9CF5652F4;
        Sun, 24 Jan 2021 19:33:50 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YA1vIhUuD4wEYzSj@kroah.com>
References: <YA1vIhUuD4wEYzSj@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YA1vIhUuD4wEYzSj@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.11-rc5
X-PR-Tracked-Commit-Id: 31b081066e9c8f4a931a3d20dc0c6ca63c595c44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fdbc80bdc4365078a0f7d65631171cb80e3ffd6e
Message-Id: <161151683075.23923.17573076600403798231.pr-tracker-bot@kernel.org>
Date:   Sun, 24 Jan 2021 19:33:50 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 24 Jan 2021 13:59:14 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.11-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fdbc80bdc4365078a0f7d65631171cb80e3ffd6e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
