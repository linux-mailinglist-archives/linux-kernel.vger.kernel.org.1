Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7003A2DC9BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 00:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbgLPX47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 18:56:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:34138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727789AbgLPX46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 18:56:58 -0500
Subject: Re: [GIT PULL] HID for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608162978;
        bh=ECT0t1e2lSctFzb/Ip6WxNYcbJx95WSga+tMrHSDKeE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UsdKI9Pbg144e8WaC3ZbBsI8N8u3/DtwQ2pgEt7xS23mnO6gTcCBNeQE6y/QLW4Gp
         Pp+3Suty5kpmBHIkmxV7P9r78xrrk8kpmaCHMGpx2iek6vQXZH1OtrTf8Z3Vzzv22k
         udCY/UVM6pHio6IrZKkzO8cMeihVVw4hRDbWnrJZQXFh3Nmnde49EUHFCKAjYWu672
         7q5FrzCJmcrKsxXKH9W2TWZBw/Ve80Tb2Bfw+7Lkcxg/Lva8nQ4Yl5CC6rCN3Ful1h
         z74jOWk9P+/POQ3lBnPCdRL/w0f/JmZxj5y9mkgkr6IFGnTqB320S5WhTpP6iVLGRV
         A/PSKSLt/LbQQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2012161150240.25826@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2012161150240.25826@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2012161150240.25826@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 85a694738f6e7ad36918a3fa0569701b102d06c2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: de925e2fbb44eed8a2a7ce166b485fed5eae01aa
Message-Id: <160816297826.13963.13145601274017629837.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Dec 2020 23:56:18 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 16 Dec 2020 11:50:30 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/de925e2fbb44eed8a2a7ce166b485fed5eae01aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
