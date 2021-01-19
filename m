Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3A02FB7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404771AbhASL0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:26:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30102 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405370AbhASLO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611054809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fz4rENRfenqt/93UzmqK2J3GDJ6WaTjfXlAjeXIC7tQ=;
        b=EErn5Sy3+T8+DcYEhzjWdjGXhPoPfrFjC0wjDX19qfXUK9h1x3WQM3Rea0oCvc/oOCFelv
        wa0KWzFqObk98g/tMvrED+TcG0e+eFZkaQF9jjgtkaYiAFJVjXO7xAPhdGceaI+Jb3muHX
        aRmEcUvZUJCHCHQ23BPjv/dnmFh5MQc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-ws3FSK8FOSeLPdf46zwNQg-1; Tue, 19 Jan 2021 06:13:27 -0500
X-MC-Unique: ws3FSK8FOSeLPdf46zwNQg-1
Received: by mail-wr1-f69.google.com with SMTP id j5so9731431wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 03:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Fz4rENRfenqt/93UzmqK2J3GDJ6WaTjfXlAjeXIC7tQ=;
        b=NqNuRSTCpxotfMd28JThvYTFXb0tMONrIe+Lk5aXNNI4Mvjp8f57WV2bCoYlOkJZmB
         spAq/yBkV8ILuTpiYE8iq95t0KnbI89+P3uAS2yeG3jmMhVCjpfKSWs5+Fbo0FNrZkho
         ks0NRlTl7HGpWawElQKNH3SBmvpiiq8IzP7+KJvAtRtK5b8r8AeffwpO5LCAFdTBe9Pr
         iMD1ZhoQjyxjYJDYoUCL8wD6zouyh0RYifhvAFxHyUSz/Wx9IpEVsLYyzQEmss07Ia/x
         9m8+fL9VHTjxAqyH7RYDH3JbJQ6PjRBFkvtKwluqsskJesT43aBQmeweCzMx8GCzyEW1
         E52g==
X-Gm-Message-State: AOAM530qSp4NUaWTgKG9WnmyzK0nUfWlMU5HixdTECsnp5VSgUVC9Iri
        i29kdOrAf41ZJihGAp3oA7AwpcWhrc3sHQWihkvyiPUuzH5Gl+BmrfNvWIrmBXNKUFMyDVbAdIe
        innzUA41eDMLFh1qt9oVo24mt6MZIFBFVHsHQ+CYCWzpggpQrXiuagtJ/b7UMno8f7JWk1/axkV
        k=
X-Received: by 2002:a5d:6888:: with SMTP id h8mr3907897wru.268.1611054804594;
        Tue, 19 Jan 2021 03:13:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxsE8Tn529zOWb1xbJI4s9gY8XIonAMhkKEgxAumwsJmFjjcZ/PmdGsb8zkaqNoNbxrKpW6g==
X-Received: by 2002:a5d:6888:: with SMTP id h8mr3907872wru.268.1611054804393;
        Tue, 19 Jan 2021 03:13:24 -0800 (PST)
Received: from x1.bristot.me (host-79-46-192-171.retail.telecomitalia.it. [79.46.192.171])
        by smtp.gmail.com with ESMTPSA id u83sm3922867wmu.12.2021.01.19.03.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 03:13:23 -0800 (PST)
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: BUG: sleeping function called from invalid context at
 kernel/stop_machine.c:135
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <ffe8b460-4bc5-4a6b-bd66-4bb56e0f33d3@redhat.com>
Date:   Tue, 19 Jan 2021 12:13:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

Are you aware of this issue:
----- %< -----
[   88.307857] BUG: sleeping function called from invalid context at kernel/stop_machine.c:135
[   88.308796] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 801, name: sh
[   88.309785] 6 locks held by sh/801:
[   88.310265]  #0: ffff9f008c575460 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x58/0xd0
[   88.310906]  #1: ffff9f008e9dd088 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write+0xa5/0x1c0
[   88.311672]  #2: ffff9f0092164a88 (kn->active#195){.+.+}-{0:0}, at: kernfs_fop_write+0xad/0x1c0
[   88.312456]  #3: ffffffffbac68310 (cpu_hotplug_lock){++++}-{0:0}, at: sched_partition_write+0x72/0x2f0
[   88.313280]  #4: ffffffffbae37090 (&cpuset_rwsem){++++}-{0:0}, at: sched_partition_write+0x7e/0x2f0
[   88.314095]  #5: ffffffffbad89140 (rcu_read_lock){....}-{1:3}, at: update_sibling_cpumasks+0x5/0x140
[   88.314806] Preemption disabled at:
[   88.314810] [<ffffffffb900454d>] preempt_schedule_thunk+0x16/0x18
[   88.315815] CPU: 1 PID: 801 Comm: sh Not tainted 5.10.0-rc5+ #10
[   88.316203] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
[   88.316714] Call Trace:
[   88.316875]  dump_stack+0x8b/0xb0
[   88.317087]  ___might_sleep.cold+0x102/0x116
[   88.317354]  stop_one_cpu+0x82/0xa0
[   88.317578]  ? set_cpus_allowed_ptr+0x10/0x10
[   88.317858]  __set_cpus_allowed_ptr+0x1e6/0x1f0
[   88.318144]  update_tasks_cpumask+0x25/0x50
[   88.318415]  update_cpumasks_hier+0x257/0x840
[   88.318687]  update_sibling_cpumasks+0x96/0x140
[   88.318968]  update_prstate+0x1a0/0x1f0
[   88.319210]  sched_partition_write+0x9f/0x2f0
[   88.319482]  kernfs_fop_write+0xdc/0x1c0
[   88.319730]  vfs_write+0xea/0x3b0
[   88.319943]  ksys_write+0x58/0xd0
[   88.320156]  do_syscall_64+0x33/0x40
[   88.320382]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   88.320692] RIP: 0033:0x7fbbd79be537
[   88.320915] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04
		     25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3
		     48 83 ec 28 48 89 54 24 18 48 89 74 24
[   88.322028] RSP: 002b:00007ffd44cc8398 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   88.322479] RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fbbd79be537
[   88.322910] RDX: 0000000000000005 RSI: 0000558ae69200a0 RDI: 0000000000000001
[   88.323342] RBP: 0000558ae69200a0 R08: 000000000000000a R09: 0000000000000004
[   88.323775] R10: 0000558ae6921ba0 R11: 0000000000000246 R12: 0000000000000005
[   88.325046] R13: 00007fbbd7a90500 R14: 0000000000000005 R15: 00007fbbd7a90700
----- >% -----

it happens when I run this (from Dietmar):
----- %< -----
cd /sys/fs/cgroup/

echo $$ > cgroup.procs

echo +cpuset > cgroup.subtree_control
chrt -d --sched-period 1000000000 --sched-runtime 100000000 0 sleep 500 &
PID1=$!
chrt -d --sched-period 1000000000 --sched-runtime 100000000 0 sleep 500 &
PID2=$!

sleep 3

mkdir A
echo 0 > ./A/cpuset.mems
echo 0 > ./A/cpuset.cpus

echo $PID2 > ./A/cgroup.procs
echo root > ./A/cpuset.cpus.partition
echo $PID2 > ./A/cgroup.procs

cat /proc/$PID1/status | grep Cpus_allowed_list | awk '{print $2}'

cat /proc/$PID2/status | grep Cpus_allowed_list | awk '{print $2}'
----- >% -----

with this kernel config:
https://bristot.me/lkml/20200119/config.txt

on Fedora 32 (x86 64 vm).

full dmesg here:
https://bristot.me/lkml/20200119/dmesg.txt

-- Daniel

