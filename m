Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F140D2253DE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 22:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgGSUAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 16:00:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgGSUAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 16:00:04 -0400
Subject: Re: [GIT PULL] USB driver fixes for 5.8-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595188804;
        bh=XSHHctdJjzm7uGuOOu6wyhlio5IM0Ddk19axRNIfP6s=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=uxg7p24Ur36QBkgoayJ0h42GlVAI2qnv0idS5iqEDfDOHB2DqZwDul3akrUeiusfy
         7xl5KpFcQf+XnN7sbZIysybSsDsAqiJ8X0yLXQNGh9huvqZjKIwl/bMIPUyFF1d4Di
         bNOBV85j3iHBNydU8n9iN6WLoMzPgHLKS6txV3jQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200719091447.GA157963@kroah.com>
References: <20200719091447.GA157963@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200719091447.GA157963@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.8-rc6
X-PR-Tracked-Commit-Id: c7300cdf8f683ae00cf74616b5fd14ffac327979
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce20d7bf6e00997496d8d5322b1253584d2a0908
Message-Id: <159518880442.26827.3257229150899500793.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Jul 2020 20:00:04 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 19 Jul 2020 11:14:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.8-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce20d7bf6e00997496d8d5322b1253584d2a0908

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
