Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503922D7E38
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 19:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406064AbgLKShY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 13:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405913AbgLKSfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:35:55 -0500
Subject: Re: [GIT PULL] clk fixes for v5.10-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607711715;
        bh=/OZm+QEPlwOOOmEsuW7hHCVMH19PJDZZRNHByaV75lM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ei3USVG4VUEYWAY+AQDyOhklGfJ4DgrlvrWmaTj/A6AaVFyPPEZXrcHbREqfSNnBD
         l/Vr/NsCeKJCJeowaGPGsxl2tg9uRbgA1qQLoQd0mIGLU7q4T8ps1H3RRdfM1KJcSN
         4137BRWcdlVuPCWj7WAHzoGji0thYs0elVKu5VOBCG6Hyb1LOv3Have5q2GECQpplX
         GikAOcIbhUoGWqMBO7ahNXxf28eRNutjMNMnsDkVUSnLKpE79ePUZHnOl7aAaxGwxe
         7feSdvUYce2CTsViNZKmWDrKq9S2uaprrNvl9YmMdI21yn8X7aDYYbR5TthUqdubhO
         YK/JK1FcMrjFw==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201211071207.3828638-1-sboyd@kernel.org>
References: <20201211071207.3828638-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201211071207.3828638-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: ceabbf94c317c6175dee6e91805fca4a6353745a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1cea11227cb57f1ab0f111b3f6e8a250b85cfdb
Message-Id: <160771171528.31675.3929122448435560181.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Dec 2020 18:35:15 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Dec 2020 23:12:07 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1cea11227cb57f1ab0f111b3f6e8a250b85cfdb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
