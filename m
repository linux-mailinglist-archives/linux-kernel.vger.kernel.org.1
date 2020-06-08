Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F31B1F20A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 22:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgFHU2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 16:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgFHU2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:28:11 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EF5E20760;
        Mon,  8 Jun 2020 20:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591648091;
        bh=EznNTO5PbJab9zTOmtP5YflhMXLcS0sU54SCVTVarKY=;
        h=Subject:From:To:Date:From;
        b=HTe3mNrYpA1KVzfd/GDHlBgklKFQ2wDp5Aa/a6mLbyFSYBE+4SaXPYNBV71FjBre9
         C0aJfB0T0WPz7NsreNseqvSIGFwsxM1rlUbCOJVJipSF0y8s488xa2fH3JXmOLaxxD
         PB/idKpV9Upq+QUlVA3EiBh2T1qLf8z3482WZ7WI=
Message-ID: <67ca385e3ee60021263bccd57979b3bf7c46db75.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.127-rt54
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
Date:   Mon, 08 Jun 2020 15:28:09 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.127-rt54 stable release.

This release is just an update to the new stable 4.19.127
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 3a54ad0822834676190bf232cab9088843758d89

Or to build 4.19.127-rt54 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.127.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.127-rt54.patch.xz

Enjoy!

   Tom

