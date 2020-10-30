Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53892A0FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 21:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgJ3Uk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 16:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgJ3Uk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 16:40:57 -0400
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA56F221EB;
        Fri, 30 Oct 2020 20:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604090456;
        bh=Sa9VRUTEHu+15xrWULIVK8j7RyyrSCl5o1mGMyLnIb8=;
        h=Subject:From:To:Date:From;
        b=euAHw3cGweQy+7ErVf/nzVpl6RRF/kioWqetY3+3a3zqhBJLfknRa/3EseMbyBWOe
         XEBmcdb9VYojmnFcuaQLuXLW5PQAWiEhZnD5nJ055bFmW5zcdml//VM7ObgZPjTKfj
         xNY+AtKTHIdNylUUOdn1sZFrU35CZURo7D8Kgo/0=
Message-ID: <8b7c646265f08e215b56b8f28d9c3715b8873765.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.152-rt65
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Date:   Fri, 30 Oct 2020 15:40:54 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.152-rt65 stable release.

This release is just an update to the new stable 4.19.152
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 007d95624000d3baa5c70c0710c3f52683929f02

Or to build 4.19.152-rt65 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.152.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.152-rt65.patch.xz

Enjoy!

   Tom

