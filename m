Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1AF22B837
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 22:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgGWUzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 16:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgGWUzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:55:04 -0400
Subject: Re: [GIT PULL] s390 updates for 5.8-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595537703;
        bh=l+Tzk2koYg96Wo1mDSQbKykcCnYS8KhqJ6Ypx5XvssY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=WAy146blJHHWb4XeWaokbIGHGOuD6sVHoq1YnHYmYgvoc374IfP+G0bZvb+IiqA0s
         rdliXvF8DaIRpQzVBd/1zo3lD2J2uyJkFSGj4QLRzUsadj3TZgmbEKWGcTVfHNLAy1
         cr2hCxBN8eY2c9Q7wisjEdqaXwlcVMAE8H4hdm5M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200723192643.GA7038@osiris>
References: <20200723192643.GA7038@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200723192643.GA7038@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-6
X-PR-Tracked-Commit-Id: 0cfa112b33aba4473b00151c75b87818a835702a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f37e99aca03f63aa3f2bd13ceaf769455d12c4b0
Message-Id: <159553770371.17202.7792268161901478887.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Jul 2020 20:55:03 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Jul 2020 21:26:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f37e99aca03f63aa3f2bd13ceaf769455d12c4b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
