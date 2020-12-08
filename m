Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC542D3746
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 01:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbgLHX7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 18:59:13 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:53041 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbgLHX7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:59:12 -0500
X-Originating-IP: 193.27.14.10
Received: from orivej.orivej.org (unknown [193.27.14.10])
        (Authenticated sender: orivej@orivej.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 38A451C0003;
        Tue,  8 Dec 2020 23:58:28 +0000 (UTC)
Date:   Tue, 8 Dec 2020 23:58:27 +0000
From:   Orivej Desh <c@orivej.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Behlendorf <behlendorf1@llnl.gov>
Subject: sched: exporting linux-rt migrate_disable for ZFS
Message-ID: <20201208212841.694b3022@orivej.orivej.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 3.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

(If you are receiving this again, that's because I'm sending from
another domain since my message from @gmx.fr was not forwarded to the
lists.)

With sched-Add-migrate_disable.patch first released in v5.9-rc8-rt14 [1]
linux-rt defines functions migrate_disable and migrate_enable.
They are used in linux headers in various macros and static inline
functions, and in particular in kmap_atomic and kunmap_atomic.
The latter are needed by ZFS which currently fails to build against
5.9-rt [2] because these functions are exported with EXPORT_SYMBOL_GPL.
Could you export them with EXPORT_SYMBOL instead?

I have checked that ZFS 2.0.0 builds and works with 5.9.1-rt20 (with
an additional fix [3]) with this patch:

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1812 +1812 @@ void migrate_disable(void)
-EXPORT_SYMBOL_GPL(migrate_disable);
+EXPORT_SYMBOL(migrate_disable);
@@ -1843 +1843 @@ void migrate_enable(void)
-EXPORT_SYMBOL_GPL(migrate_enable);
+EXPORT_SYMBOL(migrate_enable);

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/diff/patches/0009-sched-Add-migrate_disable.patch?h=v5.9-rc8-rt14-patches&id=9a89bfdb3bc77aecdd0ff8cc69b595541c7b50c4
[2] https://github.com/openzfs/zfs/issues/11097#issuecomment-740682245
[3] https://github.com/openzfs/zfs/pull/11309
