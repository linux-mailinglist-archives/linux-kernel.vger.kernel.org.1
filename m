Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B9D28F77F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 19:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390136AbgJORM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 13:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:39970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390108AbgJORMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:12:24 -0400
Subject: Re: [GIT PULL] Char/Misc driver patches for 5.10-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602781943;
        bh=CVI5yQO7wMiSkqoxMPBJHzngAFULVlFeqQNhuGtzQZQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=aLhDfTFt1IEOUAieiiaBFqSxBgZjvtd7lNxDUh9tVU2v96cQkrmbrGeo8mWkq6fn/
         RzDKBc3jjpPJYmtwSgqtxxmGKziBQNn2rRyAjp6++hGKTYw7q8lTvwn5+sUgzLhhxG
         39RfXCnF8w9fbfkK5Inrb4khgHtLIQTFIz2d+Yfk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201015122858.GA4021771@kroah.com>
References: <20201015122858.GA4021771@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201015122858.GA4021771@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.10-rc1
X-PR-Tracked-Commit-Id: f3277cbfba763cd2826396521b9296de67cf1bbc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 726eb70e0d34dc4bc4dada71f52bba8ed638431e
Message-Id: <160278194385.2218.1762945993988107107.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 17:12:23 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 14:28:58 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/726eb70e0d34dc4bc4dada71f52bba8ed638431e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
