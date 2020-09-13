Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B291F26804D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 18:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgIMQd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 12:33:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgIMQdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 12:33:31 -0400
Subject: Re: [GIT PULL] Char/Misc driver fixes for 5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600014811;
        bh=T8DWK80lehfBAwE/Z+9WrxWuxgzR8OoNCEQ1DG9L/q0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=e+20IO4hgOVYKashNNKjhAj+b2XRD/Nyjz1XW/zxo9CYvRkcc246gi0jxHrTQfZMP
         jyGhmDl63milEFg0k+oF0TvuSAshrZblQ/6/o692ZnJ9fGxuxv13k0IpjKwHAOheAB
         vt6B40PPHFW1V6jBliB01ntQ9NAL1ZW3TG8ypT9o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200913083832.GA906642@kroah.com>
References: <20200913083832.GA906642@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200913083832.GA906642@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.9-rc5
X-PR-Tracked-Commit-Id: 952e934d7f682a961c92eb9bbd521a4876e201fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a1a4bee5ef277c7dc2906d9268db61478876288
Message-Id: <160001481130.6953.3837955472415725778.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Sep 2020 16:33:31 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 13 Sep 2020 10:38:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.9-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a1a4bee5ef277c7dc2906d9268db61478876288

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
