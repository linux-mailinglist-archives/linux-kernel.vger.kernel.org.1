Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F84823C4E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 07:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgHEFFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 01:05:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgHEFFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 01:05:09 -0400
Subject: Re: [GIT pull] core/entry for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596603909;
        bh=OjRX/AkOYwHI3PVaNPRom5kqGEHWfam0Bnk0kuLcvUw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Kt00RcocfRxZrvR2qeaR10+shB9bwYxEwlW9Gnb8QKE9hr5KWGro8tBaPcy2EQvhI
         vduQIIcs8lwLYxqF66iycaC6oxEJTeOsdi222QLRldWOOeSHOpjFTGGziOiOqzfvdx
         kOvBICHG56MP87gHP3J5dkCpKQX3LrbUIxXa+gDQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <159652931338.11821.6870342948950391828.tglx@nanos.tec.linutronix.de>
References: <159652931338.11821.6870342948950391828.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <159652931338.11821.6870342948950391828.tglx@nanos.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
 core-entry-2020-08-04
X-PR-Tracked-Commit-Id: 3135f5b73592988af0eb1b11ccbb72a8667be201
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d25c8be67481aaaa060782d7e8b84bc0d0355922
Message-Id: <159660390902.15119.9927779829664318147.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Aug 2020 05:05:09 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 04 Aug 2020 08:21:53 -0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-entry-2020-08-04

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d25c8be67481aaaa060782d7e8b84bc0d0355922

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
