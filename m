Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF3B28FB19
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 00:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbgJOWTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 18:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731783AbgJOWTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 18:19:30 -0400
Subject: Re: [GIT PULL] trivial for 5.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602800369;
        bh=mtLB4P10ZwWV0pleLcR2SLjAUcytl2ykfEmLYayzENE=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=A42fq4h0MdjtiqOmFQRrXiddMkb2zOwEbV/gND6u7btQ+KiSPz3BIYIUiQWZkaZub
         5t1yh1VnNBJCSNYYen2d7wxbTMiY/+AxsGebeuqGFauRYl/pTPnoE0Rk9lUKDiVR8z
         z7/h+VodsGnugXoszoxWgRRvsL/cCmHT0OddzKpg=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2010152055050.18859@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2010152055050.18859@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2010152055050.18859@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git for-linus
X-PR-Tracked-Commit-Id: 2a9b29b289833e42e13fdfb7e082499c1464f25c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbf625990371782370f6eacb3155dc1fe131ddfc
Message-Id: <160280036949.16623.5973538217972035960.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Oct 2020 22:19:29 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Oct 2020 20:56:41 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbf625990371782370f6eacb3155dc1fe131ddfc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
