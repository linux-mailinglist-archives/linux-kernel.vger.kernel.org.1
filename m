Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA85281046
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 12:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbgJBKGM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Oct 2020 06:06:12 -0400
Received: from mx3.uni-regensburg.de ([194.94.157.148]:40426 "EHLO
        mx3.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBKGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 06:06:12 -0400
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 06:06:11 EDT
Received: from mx3.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id AB9F96000054
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 12:00:05 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx3.uni-regensburg.de (Postfix) with ESMTP id 90528600004D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 12:00:05 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Fri, 02 Oct 2020 12:00:05 +0200
Message-Id: <5F76FA24020000A10003BB47@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.2.1 
Date:   Fri, 02 Oct 2020 12:00:04 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <linux-kernel@vger.kernel.org>
Subject: FYI: PoC: Running 100000 processes in 5.3.18 (SLES15 SP2)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Just in case someone is interested: As a Proof-of-Concept I started 100 thousand processes on a big machine (72 cores). It worked!
However starting those too more than 30 minutes, and top needs more than 30 minutes to refresh ist display. Still, interactive input via SSH works nice, but any file-system access seems quite slow (my test processes just use CPU; the do no t do any I/O).

Kernel messages while the processes were created:
kernel: [65648.247688] perf: interrupt took too long (2516 > 2500), lowering kernel.perf_event_max_sample_rate to 79250
kernel: [65997.263218] perf: interrupt took too long (3146 > 3145), lowering kernel.perf_event_max_sample_rate to 63500
kernel: [66790.221057] perf: interrupt took too long (3938 > 3932), lowering kernel.perf_event_max_sample_rate to 50750
kernel: [69884.371426] perf: interrupt took too long (4925 > 4922), lowering kernel.perf_event_max_sample_rate to 40500

Last top output (more than 30 late):
top - 11:16:19 up 19:19,  3 users,  load average: 64164.56, 62997.24, 55597.09
Tasks: 101432 total, 60249 running, 41183 sleeping,   0 stopped,   0 zombie
%Cpu(s): 98.0 us,  2.0 sy,  0.0 ni,  0.0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
MiB Mem : 772127.6+total, 755924.2+free, 14253.01+used, 1950.363 buff/cache
MiB Swap: 773120.0+total, 772958.1+free,  161.816 used. 754248.8+avail Mem
...

That's a load, isn't it? ;-)

 # cat /proc/uptime
72084.21 9356423.41
# cat /proc/loadavg
64188.31 64188.81 63636.08 64228/102328 134935

Regards,
Ulrich




