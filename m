Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B642DA426
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 00:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbgLNXc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 18:32:26 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:44821 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgLNXcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 18:32:21 -0500
X-Originating-IP: 193.27.14.10
Received: from orivej.orivej.org (unknown [193.27.14.10])
        (Authenticated sender: orivej@orivej.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C32A6240003;
        Mon, 14 Dec 2020 23:31:36 +0000 (UTC)
Date:   Mon, 14 Dec 2020 23:31:34 +0000
From:   Orivej Desh <c@orivej.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Behlendorf <behlendorf1@llnl.gov>
Subject: Re: sched: exporting linux-rt migrate_disable for ZFS
Message-ID: <20201214233134.06f12bbb@orivej.orivej.org>
In-Reply-To: <20201214123302.w2bem7tlb664jdvx@linutronix.de>
References: <20201208212841.694b3022@orivej.orivej.org>
        <20201214123302.w2bem7tlb664jdvx@linutronix.de>
X-Mailer: Claws Mail 3.99.0 (GTK+ 3.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [2020-12-14]
> On 2020-12-08 23:58:27 [+0000], Orivej Desh wrote:
> > With sched-Add-migrate_disable.patch first released in v5.9-rc8-rt14 [1]
> > linux-rt defines functions migrate_disable and migrate_enable.
> > They are used in linux headers in various macros and static inline
> > functions, and in particular in kmap_atomic and kunmap_atomic.
> > The latter are needed by ZFS which currently fails to build against
> > 5.9-rt [2] because these functions are exported with EXPORT_SYMBOL_GPL.
> > Could you export them with EXPORT_SYMBOL instead?  
> 
> This is out of my jurisdiction, so just a few notes:
> - v5.9 is out of maintenance. Be careful.

Thanks! I have noticed a bug with usb-storage (using smp_processor_id
in preemptible code) in 5.9.1-rt20 thas has been fixed in 5.10-rt17.

> - We don't export symbols for out-of-tree modules.

The issue is that in the vanilla kernel these two functions are
available as macros that expand into EXPORT_SYMBOL function calls
(kunmap_atomic_high, etc.). If I am not mistaken the kernel is
generally supposed to keep the API made available to non-GPL modules
still available, for example here https://lwn.net/Articles/171838/ :
"When GPL-only exports were first added to the kernel, they went in
with the understanding that only new symbols would be tagged
GPL-only. The current module interface - while always subject to
change - was not to have symbols withdrawn arbitrarily." The current
rt patch has this effect: it makes non-GPL API of the vanilla kernel
GPL-only.
