Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 817812D3192
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbgLHR6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:58:17 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:26380
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730875AbgLHR6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:58:17 -0500
X-IronPort-AV: E=Sophos;i="5.78,403,1599516000"; 
   d="scan'208";a="366950524"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 18:57:33 +0100
Date:   Tue, 8 Dec 2020 18:57:33 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     linux-kernel@vger.kernel.org
cc:     nicolas.palix@univ-grenoble-alpes.fr, torvalds@linux-foundation.org
Subject: Re: problem booting 5.10
In-Reply-To: <alpine.DEB.2.22.394.2012081813310.2680@hadrien>
Message-ID: <alpine.DEB.2.22.394.2012081856320.16458@hadrien>
References: <alpine.DEB.2.22.394.2012081813310.2680@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Dec 2020, Julia Lawall wrote:

> Hello,
>
> We have not succeeded to boot 5.10 on our Intel(R) Xeon(R) CPU E7-8870 v4 @
> 2.10GHz server.  Previous versions (eg 4.19 - 5.9) boot fine.  We have
> tried various rcs.  The backtrace for rc7 is shown below.

Some more information, from earlier in the boot attempt, is here:

Begin: Running /scripts/local-block ... done.
[   51.355655][    T7] scsi 0:0:14:0: Direct-Access     ATA      ST2000LM015-2E81 SDM1 PQ: 0 ANSI: 6
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
Begin: Running /scripts/local-block ... done.
done.
Gave up waiting for root file system device.  Common problems:
 - Boot args (cat /proc/cmdline)
   - Check rootdelay= (did the system wait long enough?)
 - Missing modules (cat /proc/modules; ls /dev)
ALERT!  UUID=754fa6b1-bb34-449a-9b95-41897013bded does not exist.
Dropping to a shell!
BusyBox v1.30.1 (Debian 1:1.30.1-4) built-in shell (ash)
Enter 'help' for a list of built-in commands.
(initramfs) [   64.082455][    T7] scsi 0:0:23:0: Direct-Access
SEAGATE  DL2400MM0159     ST58 PQ: 0 ANSI: 6


>
> thanks,
> julia
>
>
> [  253.207171][  T979] INFO: task kworker/u321:2:1278 blocked for more than 120 seconds.
> [  253.224089][  T979]       Tainted: G            E     5.10.0-rc7 #3
> [  253.239209][  T979] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  253.256990][  T979] task:kworker/u321:2  state:D stack:    0 pid: 1278 ppid:     2 flags:0x00004000
> [  253.275552][  T979] Workqueue: events_unbound async_run_entry_fn
> [  253.290687][  T979] Call Trace:
> [  253.302491][  T979]  __schedule+0x31e/0x890
> [  253.315353][  T979]  schedule+0x3c/0xa0
> [  253.327688][  T979]  schedule_timeout+0x274/0x310
> [  253.340908][  T979]  ? find_held_lock+0x34/0xa0
> [  253.353841][  T979]  ? sched_clock+0x5/0x10
> [  253.366406][  T979]  ? sched_clock_cpu+0xc/0xb0
> [  253.379283][  T979]  wait_for_completion+0x8a/0xf0
> [  253.392327][  T979]  scsi_complete_async_scans+0x107/0x170
> [  253.406115][  T979]  __scsi_add_device+0xf7/0x130
> [  253.418974][  T979]  ata_scsi_scan_host+0x98/0x1c0
> [  253.431948][  T979]  async_run_entry_fn+0x39/0x160
> [  253.444853][  T979]  process_one_work+0x24c/0x490
> [  253.457590][  T979]  worker_thread+0x30/0x370
> [  253.469876][  T979]  ? process_one_work+0x490/0x490
> [  253.482581][  T979]  kthread+0x11c/0x140
> [  253.493936][  T979]  ? kthread_park+0x80/0x80
> [  253.505640][  T979]  ret_from_fork+0x22/0x30
> [  253.517054][  T979] INFO: task kworker/u321:3:1279 blocked for more than 121 seconds.
> [  253.532420][  T979]       Tainted: G            E     5.10.0-rc7 #3
> [  253.545890][  T979] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  253.561996][  T979] task:kworker/u321:3  state:D stack:    0 pid: 1279 ppid:     2 flags:0x00004000
> [  253.578786][  T979] Workqueue: events_unbound async_run_entry_fn
> [  253.592174][  T979] Call Trace:
> [  253.602320][  T979]  __schedule+0x31e/0x890
> [  253.613668][  T979]  schedule+0x3c/0xa0
> [  253.624618][  T979]  async_synchronize_cookie_domain+0xad/0x140
> [  253.637935][  T979]  ? finish_wait+0x80/0x80
> [  253.649351][  T979]  async_port_probe+0x48/0x50
> [  253.660958][  T979]  async_run_entry_fn+0x39/0x160
> [  253.672754][  T979]  process_one_work+0x24c/0x490
> [  253.684404][  T979]  worker_thread+0x30/0x370
> [  253.695640][  T979]  ? process_one_work+0x490/0x490
> [  253.707479][  T979]  kthread+0x11c/0x140
> [  253.718188][  T979]  ? kthread_park+0x80/0x80
> [  253.729340][  T979]  ret_from_fork+0x22/0x30
> [  253.740271][  T979] INFO: task kworker/u321:4:1280 blocked for more than 121 seconds.
> [  253.755320][  T979]       Tainted: G            E     5.10.0-rc7 #3
> [  253.768593][  T979] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  253.784592][  T979] task:kworker/u321:4  state:D stack:    0 pid: 1280 ppid:     2 flags:0x00004000
> [  253.801345][  T979] Workqueue: events_unbound async_run_entry_fn
> [  253.814590][  T979] Call Trace:
> [  253.824577][  T979]  __schedule+0x31e/0x890
> [  253.835612][  T979]  schedule+0x3c/0xa0
> [  253.846144][  T979]  async_synchronize_cookie_domain+0xad/0x140
> [  253.858998][  T979]  ? finish_wait+0x80/0x80
> [  253.869835][  T979]  async_port_probe+0x48/0x50
> [  253.880860][  T979]  async_run_entry_fn+0x39/0x160
> [  253.892125][  T979]  process_one_work+0x24c/0x490
> [  253.903287][  T979]  worker_thread+0x30/0x370
> [  253.914079][  T979]  ? process_one_work+0x490/0x490
> [  253.925492][  T979]  kthread+0x11c/0x140
> [  253.935804][  T979]  ? kthread_park+0x80/0x80
> [  253.946640][  T979]  ret_from_fork+0x22/0x30
> [  253.957399][  T979] INFO: task kworker/u321:5:1281 blocked for more than 121 seconds.
> [  253.972326][  T979]       Tainted: G            E     5.10.0-rc7 #3
> [  253.985522][  T979] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  254.001429][  T979] task:kworker/u321:5  state:D stack:    0 pid: 1281 ppid:     2 flags:0x00004000
> [  254.018078][  T979] Workqueue: events_unbound async_run_entry_fn
> [  254.031368][  T979] Call Trace:
> [  254.041398][  T979]  __schedule+0x31e/0x890
> [  254.052602][  T979]  schedule+0x3c/0xa0
> [  254.063412][  T979]  async_synchronize_cookie_domain+0xad/0x140
> [  254.076681][  T979]  ? finish_wait+0x80/0x80
> [  254.088045][  T979]  async_port_probe+0x48/0x50
> [  254.099730][  T979]  async_run_entry_fn+0x39/0x160
> [  254.111617][  T979]  process_one_work+0x24c/0x490
> [  254.123299][  T979]  worker_thread+0x30/0x370
> [  254.134468][  T979]  ? process_one_work+0x490/0x490
> [  254.146103][  T979]  kthread+0x11c/0x140
> [  254.156522][  T979]  ? kthread_park+0x80/0x80
> [  254.167377][  T979]  ret_from_fork+0x22/0x30
> [  254.178152][  T979]
> [  254.178152][  T979] Showing all locks held in the system:
> [  254.198537][  T979] 3 locks held by kworker/u321:0/7:
> [  254.210141][  T979]  #0: ffff888100051d48 ((wq_completion)events_unbound){....}-{0:0}, at: process_one_work+0x1c7/0x490
> [  254.228569][  T979]  #1: ffffc900000e7e70 ((work_completion)(&entry->work)){....}-{0:0}, at: process_one_work+0x1c7/0x490
> [  254.247359][  T979]  #2: ffff88811f7a00f0 (&shost->scan_mutex){....}-{3:3}, at: scsi_scan_host_selected+0x75/0x110
> [  254.265687][  T979] 1 lock held by khungtaskd/979:
> [  254.277739][  T979]  #0: ffffffff824d26c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x15/0x101
> [  254.295573][  T979] 3 locks held by kworker/u321:2/1278:
> [  254.308530][  T979]  #0: ffff888100051d48 ((wq_completion)events_unbound){....}-{0:0}, at: process_one_work+0x1c7/0x490
> [  254.328017][  T979]  #1: ffffc9000f7c3e70 ((work_completion)(&entry->work)){....}-{0:0}, at: process_one_work+0x1c7/0x490
> [  254.347871][  T979]  #2: ffff8881211bf0f0 (&shost->scan_mutex){....}-{3:3}, at: __scsi_add_device+0xaf/0x130
> [  254.366520][  T979] 2 locks held by kworker/u321:3/1279:
> [  254.380038][  T979]  #0: ffff888100051d48 ((wq_completion)events_unbound){....}-{0:0}, at: process_one_work+0x1c7/0x490
> [  254.399946][  T979]  #1: ffffc9000f7cbe70 ((work_completion)(&entry->work)){....}-{0:0}, at: process_one_work+0x1c7/0x490
> [  254.420063][  T979] 2 locks held by kworker/u321:4/1280:
> [  254.433768][  T979]  #0: ffff888100051d48 ((wq_completion)events_unbound){....}-{0:0}, at: process_one_work+0x1c7/0x490
> [  254.453888][  T979]  #1: ffffc9000f7d3e70 ((work_completion)(&entry->work)){....}-{0:0}, at: process_one_work+0x1c7/0x490
> [  254.474411][  T979] 2 locks held by kworker/u321:5/1281:
> [  254.488640][  T979]  #0: ffff888100051d48 ((wq_completion)events_unbound){....}-{0:0}, at: process_one_work+0x1c7/0x490
> [  254.509333][  T979]  #1: ffffc9000f7dbe70 ((work_completion)(&entry->work)){....}-{0:0}, at: process_one_work+0x1c7/0x490
> [  254.530378][  T979]
> [  254.541498][  T979] =============================================
> [  254.541498][  T979]
>
