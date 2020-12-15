Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023972DA524
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 02:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbgLOA7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 19:59:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbgLOA7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 19:59:19 -0500
Subject: Re: [GIT PULL] Documentation for 5.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607993915;
        bh=+d7xrwOPNAVjED83bK8UhCp6Iibux1t31cCBlnv2hig=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=gLKUpREKd3wK6dVyC0IqWtFN5XOomsJm1l2cbWPd0fiEUHdqpLcMjDklxqEGy9vLQ
         WyuSDdGLc2GbYXnBGu3F7JMZvZ5taUH0Ru6HzWn/JO1ph24WjWDVeGaRlb6FlXovzs
         R+sWFVhiacm2ITeyuwiY0cYNz5CcrZA7A08o3vjBKGqwLKEHRRfLkLdFL6ZHxk2P1w
         Pj9BdDIDtqt4WID+0saEO+jQDQYOe0M903vw8HAJGJncSJhSMTjt2qMmvq1YqS6ajo
         /l01qLopUaK+q35lD3yXUdydNfv5NO7dDJTp5acttFpeB3bjo5NqqbAmt8AXHri1k7
         Yeh08/wAhzW+g==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20201214132843.5dd09ec3@lwn.net>
References: <20201214132843.5dd09ec3@lwn.net>
X-PR-Tracked-List-Id: <linux-doc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20201214132843.5dd09ec3@lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.11
X-PR-Tracked-Commit-Id: 47e44ed01434e51e2e42b188482d837c01e5d16e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff6135959a9150ad45cb92ca38da270903a74343
Message-Id: <160799391504.14662.9176855098333293438.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Dec 2020 00:58:35 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 14 Dec 2020 13:28:43 -0700:

> git://git.lwn.net/linux.git tags/docs-5.11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff6135959a9150ad45cb92ca38da270903a74343

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
