Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB692C4A4E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 23:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732739AbgKYWB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 17:01:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730523AbgKYWB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 17:01:28 -0500
Received: from tzanussi-mobl (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6597D21534;
        Wed, 25 Nov 2020 22:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606341687;
        bh=sBUkv6qi786L57OCh59C1dmrXOqI08em9hztM77X910=;
        h=Subject:From:To:Date:From;
        b=IX/jf+D0RZ+Z0Nlqw45aaSzeRdSfRDyY8HFDHyYBt6Yo/QBtj+l5/3/w8VbwdhixF
         kNnmiHCWVWyFr5WJyD+i3t1TVE1o8xtLZRXv/WC2EneBE6LrDYbMldSLgbxCwxIVtM
         rsM3wXcCEQHGESulquQ9woWZYHVC8A6et/GQ3EIU=
Message-ID: <b0be96547c5ed5725084d14028ef0e6511b715f2.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.160-rt69
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
Date:   Wed, 25 Nov 2020 16:01:24 -0600
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.160-rt69 stable release.

This release is just an update to the new stable 4.19.160
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: de0586f55c33891d912bd4ce3e9f76163c4c05a3

Or to build 4.19.160-rt69 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.160.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.160-rt69.patch.xz

Enjoy!

   Tom

