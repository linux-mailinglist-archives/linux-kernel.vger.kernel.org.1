Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840F520A2EE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 18:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406137AbgFYQaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 12:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:57618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403859AbgFYQaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:30:19 -0400
Subject: Re: [GIT PULL] s390 updates for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593102619;
        bh=9A9rVMBkFqjj5fohiV8K130QBeXQtO0I949mWPf36RY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DXJge5MJ2vTfdxT+frjnRKm57WU/TDicKmTF+jF47Uza0IMywMp5U5OW7GEgDxaov
         vQJHaDlpOGTrErwKm2dZFs+NaJS/7ebXvU6D1I4FfKshHS1qGNO+xbzazNi+JDTAmE
         X3Fe95TcZW10NDA5wpLFDMGzheCFlVRvy7zJeLZk=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200625120327.GA7638@osiris>
References: <20200625120327.GA7638@osiris>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200625120327.GA7638@osiris>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-3
X-PR-Tracked-Commit-Id: 827c4913923e0b441ba07ba4cc41e01181102303
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 908f7d12d3ba51dfe0449b9723199b423f97ca9a
Message-Id: <159310261924.15384.1981897420466320692.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Jun 2020 16:30:19 +0000
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Jun 2020 14:03:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.8-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/908f7d12d3ba51dfe0449b9723199b423f97ca9a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
