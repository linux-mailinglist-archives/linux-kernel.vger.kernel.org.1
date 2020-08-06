Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 387CD23E2A1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 21:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHFTzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 15:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgHFTzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:55:08 -0400
Subject: Re: [GIT PULL] integrity subsystem updates for v5.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596743708;
        bh=nDtQYhFLOrRpWOch2EwzSOuetKRrRRm8fO352OH5Hb8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=t4fqPfJsjCxhyR7dWfz3B6GwrjD6HLf+a+bCjI2H6kaSPkCuD5z9UDZbM5fqGRQsA
         qcgsVt2YXI2II9bxSMnek6g4qN3nJetdczoEJGgUSxULmQ091Pc/BbuqBTC9OwXTz2
         aRY285Ye0kTGEotW7bv7lHME+RIck1fZyabsHiu0=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4400d951e18528297e3e63524ff0ff63d48efda1.camel@linux.ibm.com>
References: <4400d951e18528297e3e63524ff0ff63d48efda1.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4400d951e18528297e3e63524ff0ff63d48efda1.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.9
X-PR-Tracked-Commit-Id: 3db0d0c276a752af39beb5ca7424cb659aa005bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cec929370763c475111b1eb307df6759b6733e7
Message-Id: <159674370780.25191.7642507410920795718.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Aug 2020 19:55:07 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 05 Aug 2020 11:32:19 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v5.9

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cec929370763c475111b1eb307df6759b6733e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
