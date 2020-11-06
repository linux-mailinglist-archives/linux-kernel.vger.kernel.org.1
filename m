Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64762A9F48
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgKFVmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:42:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:58736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728154AbgKFVmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:42:50 -0500
Received: from localhost (173-25-40-8.client.mchsi.com [173.25.40.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7251020735;
        Fri,  6 Nov 2020 21:42:49 +0000 (UTC)
From:   Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 4.14.204-rt98
Date:   Fri, 06 Nov 2020 21:41:48 -0000
Message-ID: <160469890812.314563.5874191588287229798@puck.lan>
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.204-rt98 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: a732a33d9a454d33d99df2eb900c33039b23d5e2

Or to build 4.14.204-rt98 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.204.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.204-rt98.patch.xz


You can also build from 4.14.202-rt97 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.202-rt97-rt98.patch.xz

Enjoy!
Clark

