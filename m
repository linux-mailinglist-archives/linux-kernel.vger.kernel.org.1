Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0A621F7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 18:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgGNQ6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 12:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgGNQ6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:58:19 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24ADD22571;
        Tue, 14 Jul 2020 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594745899;
        bh=vCNTULi6O+1BLjxJ2PVfqm+Hj9JXikuIYiaXPY+f9wc=;
        h=Subject:From:To:Date:From;
        b=sYMSRaDTcAgM0oAGCodUPAkDHDoErHGIztFelNcN1+llcuGxDKdx9Qo2yncyQGJgI
         zPSVDKGViTRyqnC9J96WBOT2xWj6yLw+91rcdQtCJzR/BUwT6pKGeqBHMy9B8UTMkX
         85yZpN5GSD5d8cGmqa487avUEASAjv/6CK8OmESY=
Message-ID: <82932b48972f38fccf9920e2ec75b555c2b2494a.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.132-rt59
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
Date:   Tue, 14 Jul 2020 11:58:17 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.132-rt59 stable release.

This release is just an update to the new stable 4.19.132
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 1eebf4069aa37e54330cce9a42608517ea6996fe

Or to build 4.19.132-rt59 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.132.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.132-rt59.patch.xz

Enjoy!

   Tom

