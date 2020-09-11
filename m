Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7D22676AB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 02:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgILAE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 20:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgILAEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 20:04:13 -0400
Received: from localhost (173-25-40-8.client.mchsi.com [173.25.40.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29A8B21D91;
        Sat, 12 Sep 2020 00:04:13 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.14.197-rt95
Date:   Fri, 11 Sep 2020 23:55:22 -0000
Message-ID: <159986852267.467714.15755814782200263061@theseus.lan>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.197-rt95 stable release.

In addition to the merge of the .196 and .197 stable release tags, this
release contains three RT specific fixes:

eba893980303 net: xfrm: fix compress vs decompress serialization
23d7ce6a6ca9 Bluetooth: Acquire sk_lock.slock without disabling interrupts
c0e17a81059e signal: Prevent double-free of user struct

Note the above sha1's are for the regular merge branch. The rebase branch
commits are:

59e53fae6d31 net: xfrm: fix compress vs decompress serialization
3eb9ffa69d28 Bluetooth: Acquire sk_lock.slock without disabling interrupts
89ac4fb20261 signal: Prevent double-free of user struct

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 4b77f0c11a53ef0ca870f3d7a05d3de62d3dfd0a

Or to build 4.14.197-rt95 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.197.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.197-rt95.patch.xz


You can also build from 4.14.195-rt94 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.195-rt94-rt95.patch.xz

Enjoy!
Clark
