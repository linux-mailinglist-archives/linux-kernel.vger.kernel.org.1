Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F651EDA0F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 02:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgFDAkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 20:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:42278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgFDAkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:40:07 -0400
Subject: Re: [git pull] uaccess comedi compat
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591231207;
        bh=4A/Y77ldlhorBhFLx/InIGAQjVNif68g4+o79CFctVI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YatkLY9YmLEBrDi+i0aGM0mHY2dbRc+h77Gt8qAcIWFiVYzflMeTroBBtfNKU1+yi
         oJW8jDEFBrVyfmOAFUrunOQrgLDjklEMtm7IaZgoc5uf9YZi9BiugDESuSKu8XYsZX
         D/aIKXQOFf6cXzHLtfcLHPdhtaC0i87r6BOhfGis=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20200603193127.GZ23230@ZenIV.linux.org.uk>
References: <20200603193127.GZ23230@ZenIV.linux.org.uk>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20200603193127.GZ23230@ZenIV.linux.org.uk>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.comedi
X-PR-Tracked-Commit-Id: bac42fb21259783cb748ae54227a5e755340a396
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e63f6ce7ed2c4ff83ba30ad9ccad422289a6c63
Message-Id: <159123120749.4554.5394403198787278653.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Jun 2020 00:40:07 +0000
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Ian Abbott <abbotti@mev.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Jun 2020 20:31:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git uaccess.comedi

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e63f6ce7ed2c4ff83ba30ad9ccad422289a6c63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
