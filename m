Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1C222E174
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 18:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgGZQvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 12:51:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgGZQvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:51:21 -0400
Received: from localhost (173-25-40-8.client.mchsi.com [173.25.40.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B431206D8;
        Sun, 26 Jul 2020 16:51:20 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.9.231-rt149
Date:   Sun, 26 Jul 2020 16:49:58 -0000
Message-ID: <159578219818.2295221.9568985218739028497@theseus.lan>
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

I'm pleased to announce the 4.9.231-rt149 stable release. Note that since
v4.9-rt is in maintenance mode, this is strictly a merge of the latest
stable updates for 4.9 and there are no changes to the PREEMPT_RT code.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 87b1607f518ea558e96d8862e8b244a41dbe108b

Or to build 4.9.231-rt149 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.231.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.231-rt149.patch.xz


You can also build from 4.9.230-rt148 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/incr/patch-4.9.230-rt148-rt149.patch.xz

Enjoy!
Clark
