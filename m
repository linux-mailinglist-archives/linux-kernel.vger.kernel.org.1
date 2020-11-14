Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABE12B2DEB
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 16:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgKNPYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 10:24:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgKNPYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 10:24:00 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D8BB2225E;
        Sat, 14 Nov 2020 15:23:59 +0000 (UTC)
Date:   Sat, 14 Nov 2020 10:23:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [ANNOUNCE] 5.4.77-rt43
Message-ID: <20201114102357.3ac152b6@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 5.4.77-rt43 stable release.


This release is just an update to the new stable 5.4.77 version
and no RT specific changes have been made.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.4-rt
  Head SHA1: 05aa79c7e0870c60f6616abcf482f1b4b2c8c5d7


Or to build 5.4.77-rt43 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.4.77.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.4/patch-5.4.77-rt43.patch.xz




Enjoy,

-- Steve

