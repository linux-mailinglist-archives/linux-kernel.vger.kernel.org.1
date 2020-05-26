Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8691B6134
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 18:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgDWQpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 12:45:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729717AbgDWQpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:45:19 -0400
Subject: Re: [GIT PULL] exfat fixes for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587660319;
        bh=Tjgrw1RRbyEUPIP96xGbs+qYR7X0hWxPlX9NAHat0UQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=QY84AsYEI1M4ps99ODG8fk65PP1rFPgQX9MuUHH1tUGofk2gTeh0NofJBFG/bZtRa
         744h0DAIs912KzMm0iyYNoZOPYAjVEcCyOj8/25PHpOiuTsh9KUQMv6DtJ6ORoOXpj
         CciWPzZXt7Hn/aMjTyIy2lqXxCS55SjJCLglkmiA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <001c01d61929$6382ac30$2a880490$@samsung.com>
References: <CGME20200423044100epcas1p12ae3c91c4370bae94ce5b33274edec14@epcas1p1.samsung.com>
 <001c01d61929$6382ac30$2a880490$@samsung.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <001c01d61929$6382ac30$2a880490$@samsung.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
 tags/for-5.7-rc3
X-PR-Tracked-Commit-Id: 81df1ad40644b706a1cdbd28a1471f9f0c0ea3e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f8cd037a5f46388c005f7d7ea9b62d515889740
Message-Id: <158766031916.20212.11965653445061773265.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Apr 2020 16:45:19 +0000
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        'LKML' <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Apr 2020 13:41:00 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/for-5.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f8cd037a5f46388c005f7d7ea9b62d515889740

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
